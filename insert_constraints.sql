
INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'Person', 'email');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'Person', 'username');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'Person', 'location');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'Person', 'profession');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'Person', 'age');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'Group', 'name');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'Group', 'description');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'Group', 'members');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'Group', 'privacyLevel');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'Message', 'content');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'Message', 'timestamp');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'Message', 'priority');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'Post', 'content');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'Post', 'category');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'Post', 'timestamp');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'Comment', 'content');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'Comment', 'timestamp');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'PhotoAlbum', 'name');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'PhotoAlbum', 'timestamp');

INSERT INTO mandatory_constraints (entity_type, entity_label, property_key)
VALUES ('node', 'PhotoAlbum', 'popularity');

INSERT INTO exclusive_constraints (property_key)
VALUES ('email');

INSERT INTO exclusive_constraints (property_key)
VALUES ('username');

INSERT INTO exclusive_constraints (property_key)
VALUES ('postID');

INSERT INTO exclusive_constraints (property_key)
VALUES ('membershipID');

INSERT INTO singleton_constraints (property_key)
VALUES ('priority');

INSERT INTO singleton_constraints (property_key)
VALUES ('privacyLevel');

INSERT INTO singleton_constraints (property_key)
VALUES ('popularity');
