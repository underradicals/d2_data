from io import BytesIO
from logging import basicConfig, INFO, info, error

from requests import Session, HTTPError

basicConfig(
    format="%(levelname)s:%(message)s",
    level=INFO,
    datefmt="%m/%d/%Y %I:%M:%S %p",
)

session = Session()


def download(url: str, apikey=None) -> dict:
    with session.get(
        url, stream=True, allow_redirects=True, headers={"x-api-key": apikey}
    ) as response:
        response.raise_for_status()
        info("Downloaded Manifest...")
        manifest_json = response.json()
        if len(manifest_json) == 0:
            error(f"No Manifest Status Code: {response.status_code}")
            raise HTTPError(
                f"Empty Manifest: {url} Status Code: {response.status_code}"
            )
        return manifest_json


def download_stream(url: str, apikey=None) -> BytesIO:
    buffer = BytesIO()
    with session.get(
        url, stream=True, allow_redirects=True, headers={"x-api-key": apikey}
    ) as response:
        response.raise_for_status()
        info("Downloaded Manifest...")
        for chunk in response.iter_content(chunk_size=8192):
            buffer.write(chunk)
        buffer.seek(0)
        if buffer.getbuffer().nbytes == 0:
            error(f"No Manifest Status Code: {response.status_code}")
            raise HTTPError(
                f"Empty Manifest: {url} Status Code: {response.status_code}"
            )
        return buffer
