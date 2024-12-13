import json
from concurrent.futures import ThreadPoolExecutor

from d2_data_contexts import connection, create_tables
from d2_data_paths import DATA
from features import (
    get_manifest,
    get_jwccp_files,
    handle_data_definitions,
    handle_lore_definitions,
)
from store import file_store, sql_image_store


def write_data(d_tuple: tuple[str, dict]):
    filename = d_tuple[0]
    data = d_tuple[1]
    with open(DATA / filename, "w", encoding="utf-8") as f:
        f.write(json.dumps(data, ensure_ascii=False, indent=4))


def write_all_files():
    with ThreadPoolExecutor(max_workers=5) as executor:
        executor.map(write_data, file_store)


def insert_image_urls():
    sql_string = """INSERT INTO image_urls(name, url, type) VALUES\n"""
    for index, item in enumerate(sql_image_store):
        if index == len(sql_image_store) - 1:
            sql_string = sql_string + f"{item};"
        else:
            sql_string = sql_string + f"{item},\n"
    connection.execute(sql_string)


def main():
    from d2_data_paths import create_dirs

    env = "development"
    create_dirs()
    create_tables(connection)
    if env == "production":
        manifest = get_manifest()
        get_jwccp_files(manifest)

        handle_data_definitions()
        handle_lore_definitions()
        write_all_files()
        insert_image_urls()
    else:
        handle_data_definitions()
        handle_lore_definitions()
        write_all_files()
        insert_image_urls()


if __name__ == "__main__":
    main()
