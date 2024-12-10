# Manifest Data

## Breakdown

- [ ] [Download Manifest from Destiny Server](#download-manifest-from-destiny-server)
- [ ] [Extract English MobileJsonContentPaths Url](#extract-english-mobilejsoncontentpaths-url)
- [ ] [Extract English JsonWorldComponentContentPaths Dictionary](#extract-english-jsonworldcomponentcontentpaths-dictionary)
    - [ ] Download All Json Files (Later this will be only the files we will need)
- [ ] [Factor Available Data](#factor-available-data)
    - [ ] [Damage Type Definitions](#damage-type-definitions) (Persist Globally Image Urls, filepaths)
    - [ ] Lore Definitions
    - [ ] Stat Definitions
    - [ ] PlugSet Definitions
    - [ ] Socket Category Definitions
    - [ ] Collectible Definitions
    - [ ] Weapon Inventory Item Definitions (Persist Globally Image Urls, filepaths)
    - [ ] Mod Inventory Item Definitions (Persist Globally Image Urls, filepaths)
    - [ ] Weapon-Stat Definitions
    - [ ] Mod-Stat Definitions
- [ ] Insert Data into Database
    - [ ] Insert Asset Data
    - [ ] Damage Type Definitions
    - [ ] Lore Definitions
    - [ ] Stat Definitions
    - [ ] PlugSet Definitions
    - [ ] Socket Category Definitions
    - [ ] Collectible Definitions
    - [ ] Weapon Inventory Item Definitions
    - [ ] Mod Inventory Item Definitions
    - [ ] Weapon-Stat Definitions
    - [ ] Mod-Stat Definitions

### `Download Manifest from Destiny Server`

- [ ] Download Manifest from Destiny Server
- [ ] Write Manifest to Disk
    - [ ] Format Json Output

### `Extract English MobileJsonContentPaths Url`

- [ ] Read `manifest.json` from disk
- [ ] Transform string to dictionary
- [ ] Return dictionary to local scope
- [ ] Extract MobileJsonContentPaths URL from dictionary
- [ ] Download file (file will have a .content extensions)
- [ ] Write file to disk
- [ ] Open archive and read first file (it only has one file)
- [ ] Write contents to disk with a .db or .sqlite extension
- [ ] clean up files
    - [ ] delete .zip file

### `Extract English JsonWorldComponentContentPaths Dictionary`

- [ ] Read `manifest.json` from disk
- [ ] Transform string to dictionary
- [ ] Return dictionary to local scope
- [ ] Extract `Response.jsonWorldComponentContentPaths.en` (this will be of type dict)
- [ ] Break up dictionary:
    - [ ] Get keys (partial filenames) as one iterable `<partial_filenames>`
    - [ ] Get values (partial urls) as another iterable `<partial_urls>`
- [ ] Use ThreadPoolExecutor
    - [ ] Download content from each url in parallel
        - [ ] The filename will be prepended with `Directory.WORLD_COMPONENT_PATHS / {filename}.json`
        - [ ] The url will be prepended with `https://www.bungie.net{url}`
        - [ ] The function will have signature `(filename: str | Path, url: str) -> None:` So use the iterables from
          above , `<partial_filenames>` and `<partial_urls>` respectively.
    - [ ] Write each file to disk at the predefined location e.g. `Directory.WORLD_COMPONENT_PATHS`

## Factor Available Data

### `Damage Type Definitions`

