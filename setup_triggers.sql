
CREATE OR REPLACE FUNCTION enforce_mandatory_properties()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_TABLE_NAME = 'node_properties' THEN
        IF EXISTS (
            SELECT 1 FROM mandatory_constraints mc
            JOIN nodes n ON mc.entity_label = n.label
            WHERE mc.entity_type = 'node'
              AND mc.property_key = NEW.key
              AND n.node_id = NEW.node_id
              AND NOT EXISTS (
                  SELECT 1 FROM node_properties np
                  WHERE np.node_id = n.node_id AND np.key = mc.property_key
              )
        ) THEN
            RAISE EXCEPTION 'Mandatory property "%" missing for node %', NEW.key, NEW.node_id;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_mandatory_node
BEFORE INSERT OR UPDATE ON node_properties
FOR EACH ROW EXECUTE FUNCTION enforce_mandatory_properties();

CREATE OR REPLACE FUNCTION enforce_exclusive_properties()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM node_properties np
        WHERE np.key = NEW.key
          AND np.value = NEW.value
          AND EXISTS (
              SELECT 1 FROM exclusive_constraints ec
              WHERE ec.property_key = NEW.key
          )
    ) THEN
        RAISE EXCEPTION 'Property "%" must be unique, but duplicate found!', NEW.key;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_exclusive_node
BEFORE INSERT OR UPDATE ON node_properties
FOR EACH ROW EXECUTE FUNCTION enforce_exclusive_properties();

CREATE OR REPLACE FUNCTION enforce_singleton_properties()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM singleton_constraints sc
        WHERE sc.property_key = NEW.key
    ) AND EXISTS (
        SELECT 1 FROM node_properties
        WHERE key = NEW.key
    ) THEN
        RAISE EXCEPTION 'Singleton property "%" may only exist once!', NEW.key;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_singleton_node
BEFORE INSERT ON node_properties
FOR EACH ROW EXECUTE FUNCTION enforce_singleton_properties();
