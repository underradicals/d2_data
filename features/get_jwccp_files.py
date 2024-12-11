from concurrent.futures import ThreadPoolExecutor
from logging import info, basicConfig, INFO
from pathlib import Path

from d2_config import conf
from d2_data_paths import WORLD_COMPONENT_PATHS
from d2_http import download_stream
from d2_time import is_older_than_seven_days

basicConfig(
    format="%(levelname)s:%(message)s",
    level=INFO,
    datefmt="%m/%d/%Y %I:%M:%S %p",
)


def download_jwccp_file(filename: str | Path, url: str):
    filename_path = WORLD_COMPONENT_PATHS / f"{filename}.json"
    if not filename_path.exists() or is_older_than_seven_days(filename_path):
        buffer = download_stream(f"https://www.bungie.net{url}", conf.apikey)
        with open(filename_path, "wb") as f:
            f.write(buffer.read())
    else:
        info("File exists")


def get_jwccp_files(manifest: dict):
    jwccp = manifest["Response"]["jsonWorldComponentContentPaths"]["en"]
    jwccp_keys = list(jwccp.keys())
    jwccp_values = list(jwccp.values())

    with ThreadPoolExecutor(max_workers=5) as executor:
        executor.map(download_jwccp_file, jwccp_keys, jwccp_values)
