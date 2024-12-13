import sqlite3

from d2_data_paths import TABLES_SQLITE


def create_tables(conn: sqlite3.Connection):
    with open(TABLES_SQLITE, "r", encoding="utf-8") as f:
        conn.executescript(f.read())