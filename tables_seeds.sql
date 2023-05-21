-- Drop tables if they exist
DROP TABLE IF EXISTS peeps_tags;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS peeps;
DROP TABLE IF EXISTS users;


-- Create users table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  name TEXT,
  username TEXT NOT NULL UNIQUE
);


-- Create peeps table
CREATE TABLE peeps (
  id SERIAL PRIMARY KEY,
  message TEXT,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  user_id INTEGER REFERENCES users(id)
);


-- Create tags table
CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);


-- Create peeps_tags table
CREATE TABLE peeps_tags (
  peep_id INTEGER REFERENCES peeps(id),
  tag_id INTEGER REFERENCES tags(id),
  PRIMARY KEY (peep_id, tag_id)
);
