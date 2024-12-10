from json import loads
from pathlib import Path


def read_file(filename: str | Path) -> dict:
    with open(filename, "r", encoding="utf-8") as file:
        return loads(file.read())
