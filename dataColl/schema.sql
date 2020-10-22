-- Drop existing objects
DROP TABLE IF EXISTS Organisation;
DROP TABLE IF EXISTS form_data;

-- Create tables
CREATE TABLE Organisation (
    -- A DDPO
    Id INTEGER PRIMARY KEY,
    Name TEXT NOT NULL
);

CREATE TABLE form_data (
    Id INTEGER PRIMARY KEY,
    start_date date,
    end_date date,
    name_ddpo TEXT,
    borough_covered TEXT
)