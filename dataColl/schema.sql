-- Drop existing objects
DROP TABLE IF EXISTS Organisation;
DROP TABLE IF EXISTS form_data;
DROP TABLE IF EXISTS enquires;
DROP TABLE IF EXISTS support_provided;
DROP TABLE IF EXISTS cases_not_police_report;
DROP TABLE IF EXISTS support_age;
DROP TABLE IF EXISTS ethnicity;
DROP TABLE IF EXISTS gender;
DROP TABLE IF EXISTS cases_related_to;

-- Create tables
CREATE TABLE Organisation (
    -- A DDPO
    Id INTEGER PRIMARY KEY,
    Name TEXT NOT NULL
);

CREATE TABLE form_data (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    start_date date,
    end_date date,
    name_ddpo TEXT,
    borough_covered TEXT,
    ddpo_short_paragraph TEXT,
    casestudy_highlighting_emotional_impact TEXT,
    casestudy_highlighting_positive_outcome TEXT
);

CREATE TABLE enquires (
    dhc INTEGER,
    police INTEGER,
    not_police INTEGER,
    self_referrals INTEGER,
    police_referrals INTEGER
);

CREATE TABLE support_provided (
    hate_crime INTEGER,
    emotional INTEGER,
    general INTEGER,
    other INTEGER
);

CREATE TABLE cases_not_police_report (
    lack_evidence INTEGER,
    cd_not_trust_police INTEGER,
    cd_police_not_believe INTEGER,
    cd_afraid INTEGER,
    cd_abuse_stop INTEGER,
    cd_talk INTEGER,
    other INTEGER
);

CREATE TABLE support_age (
    under_17 INTEGER,
    eighteen_to_65 INTEGER,
    sixtyfive_plus INTEGER
);

CREATE TABLE ethnicity (
    white_eng_plus INTEGER,
    white_irish INTEGER, 
    white_traveller INTEGER,
    white_other INTEGER,
    mixed_caribbean INTEGER,
    mixed_african INTEGER,
    mixed_asian INTEGER,
    mixed_multiple INTEGER,
    asian_indian INTEGER,
    asian_pakistani INTEGER,
    asian_bang INTEGER,
    asian_chinese INTEGER,
    asian_other INTEGER,
    black_african INTEGER,
    black_caribbean INTEGER,
    black_other INTEGER,
    other_arab INTEGER,
    other INTEGER
);
    
CREATE TABLE gender (
    cis_male INTEGER,
    cis_female INTEGER,
    male INTEGER,
    female INTEGER,
    hetro INTEGER,
    homo INTEGER,
    bi INTEGER,
    lesbian INTEGER,
    other INTEGER
);

CREATE TABLE cases_related_to (
    covid INTEGER,
    neighbour INTEGER,
    friend_carer INTEGER,
    home INTEGER,
    domestic_violence INTEGER,
    care_home INTEGER,
    verbal INTEGER,
    physical INTEGER,
    street INTEGER,
    public_transport INTEGER,
    other INTEGER
);