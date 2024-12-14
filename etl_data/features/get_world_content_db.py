import zipfile

from d2_config import conf
from d2_data_paths import WORLD_CONTENT_ZIP
from d2_http import download_stream


def get_world_content_db(manifest: dict):
    url = (
        f'https://www.bungie.net{manifest["Response"]["mobileWorldContentPaths"]["en"]}'
    )
    buffer = download_stream(url, conf.apikey)
    with open("world_content.zip", "wb") as f:
        f.write(buffer.read())

    with zipfile.ZipFile("world_content.zip", "r") as zip_ref:
        archive_list = zip_ref.namelist()
        name = archive_list[0]
        with open("world_content.db", "wb") as f:
            with zip_ref.open(name, "r") as archive_reader:
                f.write(archive_reader.read())

    WORLD_CONTENT_ZIP.unlink(missing_ok=True)
