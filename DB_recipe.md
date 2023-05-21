## Chitter Platform Database Design

#### Tables
1. users
2. peeps
3. tags
4. peeps_tags (join table)

#### Decide the column types:
Table name:'users'
- id SERIAL PRIMARY KEY
- email TEXT (NOT NULL, UNIQUE)
- password (NOT NULL)
- name (TEXT)
- username (TEXT (NOT NULL, UNIQUE))

'peeps'
- id SERIAL PRIMARY KEY
- message TEXT
- timestamp TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)
- user_id (INTEGER, Foreign Key REFERENCES users(id))

'tags'
- id SERIAL PRIMARY KEY
- name TEXT (NOT NULL)

'peeps_tags'
- peep_id INTEGER (Foreign Key REFERENCES Peeps(id))
- tag_id INTEGER (Foreign Key REFERENCES tags(id))

#### Table Relationships

1. 'users' to 'peeps'
One-to-many relationship: one user can create multiple peeps, but each peep is associated with only one user.
2. 'peeps' to 'tags' via 'peeps_tags'
Many-to-many relationship: one peep can have multiple tags, and one tag can be associated with multiple peeps.

### Design the Join Table:
Join table for tables: peeps and tags
Join table name: peeps_tags

Columns: peep_id (int), tag_id (int)

### Write the SQL and tables:
access to the database: psql -h localhost -d chitter_test
seeds in the sql file: \i tables_seeds.sql
check to see created tables: \dt

-- Drop tables if they exist
-- Create users table
-- Create peeps table
They are in the sql seeds file
 