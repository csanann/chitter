## Chitter: a many-to-many relationship between "posts" and "tags" tables. 

### Extract nouns from the user story:
posts, title, tags, name

#### Infer the Table Name and Columns:
Table: posts
Columns: id (SERIAL), title (text), content (text)
Table: tags
Columns: id (SERIAL), name (text)

#### Decide the column types:
Table: posts
id: SERIAL
title: text
content: text

Table: tags
id: SERIAL
name: text

### Design the Many-to-Many relationship:
Can one tag have many posts? Yes
Can one post have many tags? Yes

### Design the Join Table:
Join table for tables: posts and tags
Join table name: posts_tags

Columns: post_id (int), tag_id (int)

### Write the SQL and tables:
access to the database: psql -h localhost -d chitter
seeds in the sql file: \i tables_seeds.sql
check to see created tables: \dt

-- Drop tables if they exist
-- Create users table
-- Create peeps table
They are in the sql seeds file
 