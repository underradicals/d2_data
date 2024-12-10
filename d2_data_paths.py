from pathlib import Path


class Directory:
    ROOT = Path.cwd()
    DATA = ROOT / "data"
    WORLD_COMPONENT_PATHS = DATA / "world_components_paths"
    WEAPONS = DATA / "weapons"
    ASSETS = DATA / "assets"
    ICONS = ASSETS / "icons"
    SCREENSHOTS = ASSETS / "screenshots"
    WATERMARKS = ASSETS / "watermarks"
    MODS = ASSETS / "mods"


class FilePaths:
    MANIFEST_JSON = Directory.ROOT / "manifest.json"


def create_dir(path: Path):
    path.mkdir(parents=True, exist_ok=True)


def create_dirs() -> None:
    create_dir(Directory.DATA)
    create_dir(Directory.WORLD_COMPONENT_PATHS)
    create_dir(Directory.WEAPONS)
    create_dir(Directory.ASSETS)
    create_dir(Directory.ICONS)
    create_dir(Directory.SCREENSHOTS)
    create_dir(Directory.WATERMARKS)
    create_dir(Directory.MODS)
