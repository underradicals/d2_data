from typing import Callable

from d2_data_paths import WORLD_COMPONENT_PATHS
from file_io import read_file
from store import file_store
from transformations import (
    add_name,
    add_description,
    add_hash,
)


def transform(filename: str, *transformers: Callable[[dict, dict], None]) -> None:
    json_data = read_file(filename)

    data_dict = {}

    for key, value in json_data.items():
        data_dict[key] = {}
        for transformer in transformers:
            transformer(value, data_dict[key])

    file_store.append(("lore_definitions.json", data_dict))


def handle_lore_definitions():
    transform(
        WORLD_COMPONENT_PATHS / "DestinyLoreDefinition.json",
        add_name,
        add_description,
        add_hash,
    )
