
CREATE TABLE nodes (
    node_id SERIAL PRIMARY KEY,
    label TEXT
);

CREATE TABLE node_properties (
    property_id SERIAL PRIMARY KEY,
    node_id INT REFERENCES nodes(node_id),
    key TEXT,
    value TEXT
);

CREATE TABLE edges (
    edge_id SERIAL PRIMARY KEY,
    source_node_id INT REFERENCES nodes(node_id),
    target_node_id INT REFERENCES nodes(node_id),
    label TEXT
);

CREATE TABLE edge_properties (
    property_id SERIAL PRIMARY KEY,
    edge_id INT REFERENCES edges(edge_id),
    key TEXT,
    value TEXT
);

CREATE TABLE mandatory_constraints (
    entity_type TEXT CHECK (entity_type IN ('node', 'edge')),
    entity_label TEXT,
    property_key TEXT
);

CREATE TABLE exclusive_constraints (
    property_key TEXT
);

CREATE TABLE singleton_constraints (
    property_key TEXT
);
