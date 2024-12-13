from logging import basicConfig, INFO, info

from requests import HTTPError

from d2_config import conf
from d2_data_paths import MANIFEST_JSON
from d2_http import download
from d2_time import is_older_than_seven_days
from file_io import read_file, write_json_void

basicConfig(
    format="%(levelname)s:%(message)s",
    level=INFO,
    datefmt="%m/%d/%Y %I:%M:%S %p",
)


def get_manifest():

    if not MANIFEST_JSON.exists() or is_older_than_seven_days(MANIFEST_JSON):
        try:
            info(
                "Either File does not exist or is out of reset cycle...Downloading Manifest..."
            )
            json_data = download(
                "https://www.bungie.net/Platform/Destiny2/Manifest", conf.apikey
            )
            write_json_void(MANIFEST_JSON, json_data)
            info("Overwriting Old Manifest...")
            return json_data
        except HTTPError as e:
            raise e
    else:
        if not is_older_than_seven_days(MANIFEST_JSON):
            info("Manifest is already up to date: Returning Cached Manifest...")
            json_data = read_file(MANIFEST_JSON)
            return json_data


if __name__ == "__main__":
    pass
