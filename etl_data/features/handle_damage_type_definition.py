from typing import Callable

from d2_data_paths import WORLD_COMPONENT_PATHS
from file_io import read_file
from store import sql_image_store, file_store
from transformations import (
    add_name,
    add_icon,
    add_description,
    add_bg_color,
    add_hash,
)


def transform(filename: str, *transformers: Callable[[dict, dict], None]) -> None:
    json_data = read_file(filename)

    data_dict = {}

    for key, value in json_data.items():
        data_dict[key] = {}
        for transformer in transformers:
            transformer(value, data_dict[key])

    for index, tup in enumerate(data_dict.items()):
        key, value = tup
        if value["icon"] is not None:
            sql_image_store.append(
                f'({value['hash']},"{value['icon']}", "DAMAGE_TYPE")'
            )
    file_store.append(("damage_definitions.json", data_dict))


def handle_data_definitions():
    transform(
        WORLD_COMPONENT_PATHS / "DestinyDamageTypeDefinition.json",
        add_name,
        add_icon,
        add_description,
        add_bg_color,
        add_hash,
    )
