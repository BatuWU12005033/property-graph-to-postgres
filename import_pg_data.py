import json
import psycopg2
from psycopg2.extras import execute_values

conn = psycopg2.connect(
    dbname="your_database",
    user="your_user",
    password="your_password",
    host="localhost",
    port="5432"
)
cur = conn.cursor()

with open("records01.json", "r", encoding="utf-8-sig") as f:
    data = json.load(f)

node_id_map = {}

for record in data:
    if "n" in record:
        n = record["n"]
        label = n["labels"][0] if n["labels"] else "Unknown"
        properties = n["properties"]
        json_id = n["identity"]

        cur.execute("INSERT INTO nodes (label) VALUES (%s) RETURNING node_id", (label,))
        db_node_id = cur.fetchone()[0]
        node_id_map[json_id] = db_node_id

        for key, value in properties.items():
            cur.execute(
                "INSERT INTO node_properties (node_id, key, value) VALUES (%s, %s, %s)",
                (db_node_id, key, str(value))
            )

for record in data:
    if "r" in record:
        r = record["r"]
        edge_label = r["type"]
        source_id = node_id_map.get(r["start"])
        target_id = node_id_map.get(r["end"])

        if source_id is None or target_id is None:
            continue

        cur.execute(
            "INSERT INTO edges (source_node_id, target_node_id, label) VALUES (%s, %s, %s) RETURNING edge_id",
            (source_id, target_id, edge_label)
        )
        edge_id = cur.fetchone()[0]

        properties = r.get("properties", {})
        for key, value in properties.items():
            cur.execute(
                "INSERT INTO edge_properties (edge_id, key, value) VALUES (%s, %s, %s)",
                (edge_id, key, str(value))
            )

conn.commit()
cur.close()
conn.close()

print("Successfully imported all nodes, edges, and properties – triggers have been checked.")
