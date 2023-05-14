-- Drop tables if they exist
DROP TABLE IF EXISTS peeps_users;
DROP TABLE IF EXISTS peeps;
DROP TABLE IF EXISTS users;

-- Create users table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email text NOT NULL UNIQUE,
  password text NOT NULL,
  name text,
  username text NOT NULL UNIQUE
);

-- Create peeps table
CREATE TABLE peeps (
  id SERIAL PRIMARY KEY,
  message text,
  timestamp timestamp DEFAULT CURRENT_TIMESTAMP,
  user_id int REFERENCES users(id)
);

-- Create peeps_users table for the many-to-many relationship
CREATE TABLE peeps_users (
  peep_id int REFERENCES peeps(id),
  user_id int REFERENCES users(id),
  PRIMARY KEY (peep_id, user_id)
);

TRUNCATE TABLE users, peeps, peeps_users RESTART IDENTITY;

-- Insert sample data
INSERT INTO users (email, password, name, username)
VALUES
  ('hothot@hotmail.com', 'dada123', 'ken', 'ken8989'),
  ('starjan@hotmail.com', 'atjan1234', 'jan', 'jan2345');

INSERT INTO peeps (message, timestamp, user_id)
VALUES
  ('My name is Ken YoohaaaYoo.', '2023-05-11 09:09:08', 1),
  ('What a lovely peep.', '2023-05-11 09:08:08', 2),
  ('Freddi cocoo is coming.','2023-05-11 09:07:08', 1),
  ('Hey you!','2023-05-11 09:07:07', 2);

INSERT INTO peeps_users (peep_id, user_id)
VALUES
  (2, 1);