from pathlib import Path

from d2_data_paths import WORLD_COMPONENT_PATHS, DATA

size_list = []
name_size_list = []
file_size_stats = []

for item in WORLD_COMPONENT_PATHS.iterdir():
    path: Path = item
    size = path.stat().st_size / 1000
    name_size_list.append((path.name, size))
    size_list.append(size)

sorted_size_list = sorted(name_size_list, key=lambda x: x[1], reverse=True)

with open(DATA / "world_components_stats.txt", "w", encoding="utf-8") as f:
    file_size_stats.append(f"{'Filename' : <75}{'Filesize' : ^10}\n")
    file_size_stats.append(
        "----------------------------------------------------------------------------------------\n"
    )
    for name, value in sorted_size_list:
        file_size_stats.append(f"{name : <75}{value:,.2f} KB\n")
    file_size_stats.append(
        "----------------------------------------------------------------------------------------\n"
    )
    file_size_stats.append(f"Average File Size: {sum(size_list) / len(size_list)} KB")

    output = "".join(file_size_stats)
    f.write(output)
    print(output)

if __name__ == "__main__":
    pass
