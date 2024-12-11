from features import get_manifest, get_jwccp_files


def main():
    from d2_data_paths import create_dirs

    create_dirs()
    manifest = get_manifest()
    get_jwccp_files(manifest)


if __name__ == "__main__":
    main()
