import sqlite3

connection = sqlite3.connect("d2data.db", autocommit=True, check_same_thread=False)
connection.execute('PRAGMA journal_mode=WAL;')