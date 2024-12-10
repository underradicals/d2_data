from pathlib import Path


ROOT = Path("D:\\Projects\\d2_data")
DATA = ROOT / "data"
WORLD_COMPONENT_PATHS = DATA / "world_components_paths"
WEAPONS = DATA / "weapons"
ASSETS = DATA / "assets"
ICONS = ASSETS / "icons"
SCREENSHOTS = ASSETS / "screenshots"
WATERMARKS = ASSETS / "watermarks"
MODS = ASSETS / "mods"


MANIFEST_JSON = ROOT / "manifest.json"
SETTINGS_JSON = ROOT / "settings.json"


def create_dir(path: Path):
    path.mkdir(parents=True, exist_ok=True)


def create_dirs() -> None:
    create_dir(DATA)
    create_dir(WORLD_COMPONENT_PATHS)
    create_dir(WEAPONS)
    create_dir(ASSETS)
    create_dir(ICONS)
    create_dir(SCREENSHOTS)
    create_dir(WATERMARKS)
    create_dir(MODS)
