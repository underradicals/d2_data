import json
from logging import basicConfig, INFO, error

from d2_data_paths import SETTINGS_JSON

basicConfig(
    format="%(levelname)s:%(message)s",
    level=INFO,
    datefmt="%m/%d/%Y %I:%M:%S %p",
)


def get_config():

    if not SETTINGS_JSON.exists():
        raise FileNotFoundError(SETTINGS_JSON)

    with open(SETTINGS_JSON, "r", encoding="utf-8-sig") as f:
        content = f.read().strip()
        if not content:
            error(f"Configuration file {SETTINGS_JSON} is empty")
            raise ValueError(f"Configuration file {SETTINGS_JSON} is empty")

        try:
            config = json.loads(content)
        except json.decoder.JSONDecodeError:
            error(f"Configuration file {SETTINGS_JSON} is invalid")
            raise ValueError(f"Configuration file {SETTINGS_JSON} is invalid")
    return config


class Config:

    def __init__(self, apikey: str):
        self.apikey = apikey


settings = get_config()

conf = Config(settings["apikey"])


if __name__ == "__main__":
    pass
