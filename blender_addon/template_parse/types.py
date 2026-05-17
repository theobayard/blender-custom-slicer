from __future__ import annotations

from dataclasses import dataclass, field


@dataclass(frozen=True)
class GcodeChunk:
    text: str
    source_z: float

    def as_tuple(self) -> tuple[str, float]:
        return self.text, self.source_z


@dataclass(frozen=True)
class SwapMacro:
    text: str
    source_z: float | None = None

    def __contains__(self, item: str) -> bool:
        return item in self.text

    def count(self, sub: str) -> int:
        return self.text.count(sub)

    def splitlines(self) -> list[str]:
        return self.text.splitlines()


@dataclass(frozen=True)
class PurgeIndex:
    maintenance_by_layer: dict[int, GcodeChunk] = field(default_factory=dict)
    other_by_layer: dict[int, GcodeChunk] = field(default_factory=dict)
    z_fallback: dict[float, str] = field(default_factory=dict)
    post_swap_0_to_1: GcodeChunk | None = None
    post_swap_1_to_0: GcodeChunk | None = None
    template_executable_layer_total: int | None = None

    def requires_purge_every_layer(self, num_print_layers: int) -> bool:
        if not self.maintenance_by_layer and not self.other_by_layer:
            return False
        if num_print_layers < 1:
            return False
        merged = {**self.other_by_layer, **self.maintenance_by_layer}
        return all(i in merged for i in range(1, num_print_layers + 1))

    def all_by_layer(self) -> dict[int, GcodeChunk]:
        out = dict(self.other_by_layer)
        out.update(self.maintenance_by_layer)
        return out


@dataclass(frozen=True)
class ParsedTemplate:
    header: str
    swap_0_to_1: SwapMacro
    swap_1_to_0: SwapMacro
    footer: str
    purge_index: PurgeIndex
    object_id: str | None = None

    @property
    def swap_0_to_1_source_z(self) -> float | None:
        return self.swap_0_to_1.source_z

    @property
    def swap_1_to_0_source_z(self) -> float | None:
        return self.swap_1_to_0.source_z

    @property
    def purge_towers_by_layer_1based(self) -> dict[int, tuple[str, float]]:
        return {k: v.as_tuple() for k, v in self.purge_index.all_by_layer().items()}

    @property
    def purge_towers_by_layer_z_fallback(self) -> dict[float, str]:
        return self.purge_index.z_fallback

    @property
    def template_executable_layer_total(self) -> int | None:
        return self.purge_index.template_executable_layer_total

    @property
    def purge_tower_post_swap_0_to_1(self) -> tuple[str, float] | None:
        c = self.purge_index.post_swap_0_to_1
        return c.as_tuple() if c else None

    @property
    def purge_tower_post_swap_1_to_0(self) -> tuple[str, float] | None:
        c = self.purge_index.post_swap_1_to_0
        return c.as_tuple() if c else None

    @classmethod
    def from_test_slices(
        cls,
        *,
        header: str,
        swap_0_to_1: str,
        swap_1_to_0: str,
        footer: str,
        purge_towers_by_layer_1based: dict[int, tuple[str, float]] | None = None,
        purge_towers_by_layer_z_fallback: dict[float, str] | None = None,
        template_executable_layer_total: int | None = None,
        swap_0_to_1_source_z: float | None = None,
        swap_1_to_0_source_z: float | None = None,
        purge_tower_post_swap_0_to_1: tuple[str, float] | None = None,
        purge_tower_post_swap_1_to_0: tuple[str, float] | None = None,
        object_id: str | None = None,
    ) -> ParsedTemplate:
        maintenance: dict[int, GcodeChunk] = {}
        other: dict[int, GcodeChunk] = {}
        for k, (txt, z) in (purge_towers_by_layer_1based or {}).items():
            chunk = GcodeChunk(txt, z)
            if "; CP EMPTY GRID" in txt:
                maintenance[k] = chunk
            else:
                other[k] = chunk
        post_01 = (
            GcodeChunk(*purge_tower_post_swap_0_to_1)
            if purge_tower_post_swap_0_to_1
            else None
        )
        post_10 = (
            GcodeChunk(*purge_tower_post_swap_1_to_0)
            if purge_tower_post_swap_1_to_0
            else None
        )
        return cls(
            header=header,
            swap_0_to_1=SwapMacro(swap_0_to_1, swap_0_to_1_source_z),
            swap_1_to_0=SwapMacro(swap_1_to_0, swap_1_to_0_source_z),
            footer=footer,
            purge_index=PurgeIndex(
                maintenance_by_layer=maintenance,
                other_by_layer=other,
                z_fallback=dict(purge_towers_by_layer_z_fallback or {}),
                post_swap_0_to_1=post_01,
                post_swap_1_to_0=post_10,
                template_executable_layer_total=template_executable_layer_total,
            ),
            object_id=object_id,
        )


class TemplateParseError(ValueError):
    pass
