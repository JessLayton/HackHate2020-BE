-- Drop existing objects
DROP TABLE IF EXISTS Organisation;

-- Create tables
CREATE TABLE Organisation (
    -- A DDPO
    Id INTEGER PRIMARY KEY,
    Name TEXT NOT NULL
);
