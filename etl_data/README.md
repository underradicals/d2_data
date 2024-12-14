# Manifest Data

## Breakdown

- [x] [Download Manifest from Destiny Server](#download-manifest-from-destiny-server)
- [x] [Extract English MobileJsonContentPaths Url](#extract-english-mobilejsoncontentpaths-url)
- [x] [Extract English JsonWorldComponentContentPaths Dictionary](#extract-english-jsonworldcomponentcontentpaths-dictionary)
    - [x] Download All Json Files (Later this will be only the files we will need)
- [ ] [Factor Available Data](#factor-available-data)
    - [x] [Damage Type Definitions](#definitions) (Persist Globally Image Urls, filepaths)
    - [x] Lore Definitions
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

- [x] Download Manifest from Destiny Server
- [x] If the file does NOT exist write Manifest to Disk as `manifest.json`
    - [x] Format Json Output
- [x] If file DOES exist, check if the file is older than 7 days
    - [x] If YES: then download manifest and write to disk
    - [x] If NO: Then do nothing, the file does not need to be updated
    - [x] Format Json Output

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

- [x] Read `manifest.json` from disk
- [x] Transform string to dictionary
- [x] Return dictionary to local scope
- [x] Extract `Response.jsonWorldComponentContentPaths.en` (this will be of type dict)
- [x] Break up dictionary:
    - [x] Get keys (partial filenames) as one iterable `<partial_filenames>`
    - [x] Get values (partial urls) as another iterable `<partial_urls>`
- [x] Use ThreadPoolExecutor
    - [x] Download content from each url in parallel
        - [x] The filename will be prepended with `Directory.WORLD_COMPONENT_PATHS / {filename}.json`
        - [x] The url will be prepended with `https://www.bungie.net{url}`
        - [x] The function will have signature `(filename: str | Path, url: str) -> None:` So use the iterables from
          above , `<partial_filenames>` and `<partial_urls>` respectively.
    - [x] Write each file to disk at the predefined location e.g. `Directory.WORLD_COMPONENT_PATHS`

## Factor Available Data

### `Definitions`

- [x] Read DamageTypeDefinition from disk
- [x] Transform into dictionary
- [x] Iterate over dictionary:
    - [x] Destructure into `key, value`
    - [x] Apply each set of transformations to each `value`
- [x] For each value:
    - [x] Append icon url to a global list formatted like so: `f'({value['hash']},"{value['icon']}", "DAMAGE_TYPE"),\n'`
    - [x] Append final shape of transformation to a list as well