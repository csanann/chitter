--TRUNCATE TABLE users, peeps, tags, peeps_tags RESTART IDENTITY;

-- Insert sample data into users
INSERT INTO users (email, password, name, username)
VALUES
  ('hothot@hotmail.com', 'dada123', 'ken', 'ken8989'),
  ('starjan@hotmail.com', 'atjan1234', 'jan', 'jan2345');


-- Insert sample data into peeps
INSERT INTO peeps (message, timestamp, user_id)
VALUES
  ('My name is Ken YoohaaaYoo.', '2023-05-11 09:09:08', 1),
  ('What a lovely peep.', '2023-05-11 09:08:08', 2),
  ('Freddi cocoo is coming.','2023-05-11 09:07:08', 1),
  ('Hey you!','2023-05-11 09:07:07', 2);


-- Insert sample data into tags
INSERT INTO tags (name)
VALUES
  ('morning'),
  ('greeting');


-- Insert relationships into peeps_tags
INSERT INTO peeps_tags (peep_id, tag_id)
VALUES
  (1, 1),
  (2, 2),
  (3, 1),
  (4, 2);
