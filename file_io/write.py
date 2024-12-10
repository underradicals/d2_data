import json
from pathlib import Path


def write_json_void(filename: str | Path, dictionary: dict) -> None:
    with open(filename, "w", encoding="utf-8") as f:
        f.write(json.dumps(dictionary, ensure_ascii=True, indent=2))


def write_json_dict(filename: str | Path, dictionary: dict) -> dict:
    with open(filename, "w", encoding="utf-8") as f:
        f.write(json.dumps(dictionary, ensure_ascii=True, indent=2))
    return dictionary
