from datetime import datetime, timedelta
from pathlib import Path

from d2_data_paths import MANIFEST_JSON


def is_older_than_seven_days(filename: str | Path) -> bool:
    """
    Checks if a file's modification date is older than the seven days.
    :param filename:
    :return: True is file is older than the seven days, False otherwise.
    :raises FileNotFoundError:
    """

    if not MANIFEST_JSON.exists():
        raise FileNotFoundError(f"File {MANIFEST_JSON} not found")

    timestamp = MANIFEST_JSON.stat().st_mtime
    date_from_timestamp = datetime.fromtimestamp(timestamp)

    delta = datetime.now() - timedelta(days=7)
    return date_from_timestamp < delta


if __name__ == "__main__":
    pass
