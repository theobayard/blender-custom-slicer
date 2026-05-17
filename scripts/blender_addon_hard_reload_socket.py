#!/usr/bin/env python3
import json
import os
import socket
import sys

_DEFAULT_HOST = "localhost"
_DEFAULT_PORT = 9876
_TIMEOUT = 120.0
_RECV_BUFFER = 65536

_RELOAD = r"""
import sys
import importlib
import bpy
import addon_utils

module_name = "blender_addon"

def is_enabled(name):
    return any(a.module == name for a in bpy.context.preferences.addons)

was_enabled = is_enabled(module_name)
if was_enabled:
    bpy.ops.preferences.addon_disable(module=module_name)

for key in list(sys.modules.keys()):
    if key == module_name or key.startswith(module_name + "."):
        del sys.modules[key]

importlib.invalidate_caches()
bpy.ops.preferences.addon_enable(module=module_name)

loaded_version = None
loaded_path = None
for mod in addon_utils.modules():
    if mod.__name__ == module_name:
        loaded_version = mod.bl_info.get("version")
        loaded_path = getattr(mod, "__file__", None)
        break

result = {
    "was_enabled": was_enabled,
    "is_enabled_now": is_enabled(module_name),
    "loaded_version": loaded_version,
    "loaded_path": loaded_path,
}
"""


def _send(host: str, port: int) -> dict:
    req = (
        json.dumps(
            {"type": "execute", "code": _RELOAD, "strict_json": False},
            ensure_ascii=False,
        )
        + "\0"
    ).encode("utf-8")
    buf = bytearray()
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
        sock.settimeout(_TIMEOUT)
        sock.connect((host, port))
        sock.sendall(req)
        while True:
            chunk = sock.recv(_RECV_BUFFER)
            if not chunk:
                break
            buf.extend(chunk)
            if b"\0" in buf:
                break
    if not buf:
        raise ConnectionError("empty response from Blender")
    line, _, _ = buf.partition(b"\0")
    return json.loads(line.decode("utf-8"))


def main() -> int:
    host = os.environ.get("BLENDER_MCP_HOST", _DEFAULT_HOST)
    port = int(os.environ.get("BLENDER_MCP_PORT", str(_DEFAULT_PORT)))
    try:
        out = _send(host, port)
    except (ConnectionRefusedError, OSError) as e:
        print(
            f"Cannot reach Blender MCP at {host}:{port} ({e}). "
            "Start Blender with the MCP add-on server running.",
            file=sys.stderr,
        )
        return 1
    except (json.JSONDecodeError, UnicodeDecodeError, ConnectionError) as e:
        print(str(e), file=sys.stderr)
        return 1
    print(json.dumps(out, indent=2, ensure_ascii=False))
    if out.get("status") != "ok":
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
