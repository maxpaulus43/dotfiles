#!/usr/bin/env python3

import sys
import pandas as pd
import sqlite3


def xlsx_to_sqlite(xlsx_file, sqlite_db):
    # Read in the Excel file using pandas
    df = pd.read_excel(xlsx_file)

    # Create a connection to the SQLite database
    conn = sqlite3.connect(sqlite_db)

    # Write the DataFrame to the SQLite database
    df.to_sql("my_table", conn, if_exists="replace", index=False)

    # Commit changes and close the connection
    conn.commit()
    conn.close()


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py <xlsx_file> <sqlite_db>")
        sys.exit(1)

    xlsx_file = sys.argv[1]
    sqlite_db = sys.argv[2]

    try:
        xlsx_to_sqlite(xlsx_file, sqlite_db)
        print("Conversion complete!")
    except Exception as e:
        print(f"Error: {e}")
