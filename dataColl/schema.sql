-- Drop existing objects
DROP TABLE IF EXISTS Organisation;

-- Create tables
CREATE TABLE Organisation (
    -- A DDPO
    Id INT PRIMARY KEY,
    Name TEXT NOT NULL
);
