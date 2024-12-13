from d2_data_contexts import connection, create_tables
from features import get_manifest, get_jwccp_files, handle_data_definitions


def main():
    from d2_data_paths import create_dirs

    env = "development"
    create_dirs()
    create_tables(connection)
    if env == "production":
        create_dirs()
        manifest = get_manifest()
        get_jwccp_files(manifest)
    else:
        handle_data_definitions()


if __name__ == "__main__":
    main()
