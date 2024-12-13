def add_hash(input_data: dict, output_data: dict) -> None:
    if "hash" not in input_data:
        output_data["hash"] = None
        return

    output_data["hash"] = input_data["hash"]


def add_name(input_data: dict, output_data: dict) -> None:
    output_data["name"] = input_data["displayProperties"]["name"]


def add_icon(input_data: dict, output_data: dict) -> None:
    if "icon" not in input_data["displayProperties"]:
        output_data["icon"] = None
        return

    output_data["icon"] = input_data["displayProperties"]["icon"]


def add_description(input_data: dict, output_data: dict) -> None:
    if "description" not in input_data["displayProperties"]:
        output_data["description"] = None
        return

    output_data["description"] = input_data["displayProperties"]["description"]


def add_bg_color(input_data: dict, output_data: dict) -> None:
    if "color" not in input_data:
        output_data["color"] = None
        return

    red = input_data["color"]["red"]
    green = input_data["color"]["green"]
    blue = input_data["color"]["blue"]
    alpha = input_data["color"]["alpha"]
    output_data["color"] = f"rgba({red}, {green}, {blue}, {alpha})"
