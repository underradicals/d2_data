import logging
import zipfile
from io import BytesIO
from json import loads, dumps
from pathlib import Path

from requests import Session, HTTPError

logging.basicConfig(
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
    level=logging.INFO,
    datefmt="%m/%d/%Y %I:%M:%S %p",
)


def read_sig(filepath: str | Path) -> dict:
    return {
        "file": filepath,
        "mode": "r",
        "encoding": "utf-8-sig",
    }


def write_sig(filepath: str | Path) -> dict:
    return {
        "file": filepath,
        "mode": "w",
        "encoding": "utf-8-sig",
    }


def write_bytes_sig(filepath: str | Path) -> dict:
    return {
        "file": filepath,
        "mode": "wb",
    }


def rq_get_sig(url: str, apikey: str) -> dict:
    return {
        "url": url,
        "stream": True,
        "allow_redirects": True,
        "headers": {"x-api-key": apikey},
    }


class Settings:
    def __init__(self, settings_dict: dict):
        self.apikey = settings_dict["apikey"]


ROOT = Path("D:\\Projects\\d2_data")
MANIFEST_PATH = ROOT / "manifest.json"
SETTINGS_PATH = ROOT / "settings.json"
DESTINY2_BASE_ADDRESS = "https://www.bungie.net"
MANIFEST_URL = DESTINY2_BASE_ADDRESS + "/Platform/Destiny2/Manifest"
WORLD_CONTENT_ZIP = ROOT / "world_content.zip"
WORLD_CONTENT_DB = ROOT / "world_content.db"
D2_DATA_DB = ROOT / "d2data.db"

session = Session()

D2_DATA_DB.touch()

if SETTINGS_PATH.exists():
    with open(**read_sig(SETTINGS_PATH)) as f:
        settings_json = loads(f.read())
else:
    raise FileNotFoundError("settings.json not found")

settings = Settings(settings_json)

if MANIFEST_PATH.exists():
    with open(**read_sig(MANIFEST_PATH)) as f:
        manifest_data = loads(f.read())
else:
    with open(**write_sig(MANIFEST_PATH)) as f:
        with session.get(**rq_get_sig(MANIFEST_URL, settings.apikey)) as response:
            response.raise_for_status()
            manifest_formatted_text = dumps(
                response.json(), ensure_ascii=False, indent=2
            )
            f.write(manifest_formatted_text)
            manifest_data = response.json()

manifest_response = manifest_data["Response"]
mobileWorldContentPaths_en = manifest_response["mobileWorldContentPaths"]["en"]
jsonWorldComponentContentPaths = manifest_response["jsonWorldComponentContentPaths"][
    "en"
]

MOBILE_WORLD_CONTENT_PATHS = DESTINY2_BASE_ADDRESS + mobileWorldContentPaths_en

buffer = BytesIO()
with session.get(**rq_get_sig(MOBILE_WORLD_CONTENT_PATHS, settings.apikey)) as response:
    response.raise_for_status()
    logging.info("Downloading World Content Database...")
    for chunk in response.iter_content(chunk_size=8192):
        buffer.write(chunk)
    buffer.seek(0)
    if buffer.getbuffer().nbytes == 0:
        logging.error(f"No Manifest Status Code: {response.status_code}")
        raise HTTPError(
            f"Empty Manifest: {MOBILE_WORLD_CONTENT_PATHS} Status Code: {response.status_code}"
        )
    with open(**write_bytes_sig(WORLD_CONTENT_ZIP)) as f:
        f.write(buffer.read())

with zipfile.ZipFile(WORLD_CONTENT_ZIP, "r") as zip_ref:
    archive_list = zip_ref.namelist()
    name = archive_list[0]
    with open(**write_bytes_sig(WORLD_CONTENT_DB)) as f:
        with zip_ref.open(name, "r") as archive_reader:
            f.write(archive_reader.read())

WORLD_CONTENT_ZIP.unlink(missing_ok=True)

if __name__ == "__main__":
    pass
