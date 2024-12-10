from requests import Session

session = Session()


def download(url: str, apikey=None) -> dict:
    with session.get(
        url, stream=True, allow_redirects=True, headers={"x-api-key": apikey}
    ) as response:
        response.raise_for_status()
        return response.json()
