-- Drop existing objects
Drop TABLE IF EXISTS Response;
DROP TABLE IF EXISTS Ethnicity;
DROP TABLE IF EXISTS NoReportReason;
DROP TABLE IF EXISTS Gender;
DROP TABLE IF EXISTS ReferralType;
DROP TABLE IF EXISTS SupportType;
DROP TABLE IF EXISTS SupportAgeCategory;
DROP TABLE IF EXISTS SexualOrientation;
DROP TABLE IF EXISTS Sex;
DROP TABLE IF EXISTS CaseRelatedCategory;
DROP TABLE IF EXISTS Borough;
DROP TABLE IF EXISTS Organisation;

-- Create tables
CREATE TABLE Organisation (
    -- A DDPO
    Id INTEGER PRIMARY KEY,
    Name TEXT NOT NULL
);

CREATE TABLE Response(
    Id INTEGER PRIMARY KEY, 
    Year INTEGER NOT NULL,
    Quarter INTEGER NOT NULL,
    FOREIGN KEY (OrganisationId) REFERENCES Organisation(Id) NOT NULL,
    CasesReferredToPolice INTEGER,
    CasesNotReferredToPolice INTEGER,
    HateCrimeReferrals INTEGER,
    FreeTextResponse TEXT,
    CaseStudyEmotionalImpact TEXT,
    CaseStudyPositiveOutcome TEXT
    
);
                                           
CREATE TABLE Ethnicity(
    Id INTEGER PRIMARY KEY,
    Description TEXT NOT NULL,
    JSONKey TEXT NOT NULL    
);

CREATE TABLE NoReportReason(
    Id INTEGER PRIMARY KEY, 
    Description TEXT NOT NULL,
    JSONKey TEXT NOT NULL
);

CREATE TABLE Gender(
    Id INTEGER PRIMARY KEY,
    Description TEXT NOT NULL,
    JSONKey TEXT NOT NULL
);

CREATE TABLE ReferralType(
    Id INTEGER PRIMARY KEY, 
    Description TEXT NOT NULL,
    JSONKey TEXT NOT NULL
); 

CREATE TABLE SupportType(
    Id INTEGER PRIMARY KEY,
    Description TEXT NOT NULL,
    JSONKey TEXT NOT NULL -- popultate according to question 6 on survey
);

CREATE TABLE SupportAgeCategory(
    Id INTEGER PRIMARY KEY,-- question 8
    Description TEXT NOT NULL,
    JSONKey TEXT NOT NULL
);

CREATE TABLE SexualOrientation(--bi sexual , other etc
    Id INTEGER PRIMARY KEY,
    Description TEXT NOT NULL,
    JSONKey TEXT NOT NULL
);

CREATE TABLE Sex( --male, female, other
    Id INTEGER PRIMARY KEY,
    Description TEXT NOT NULL,
    JSONKey TEXT NOT NULL
);

CREATE TABLE CaseRelatedCategory(
    Id INTEGER PRIMARY KEY,
    Description TEXT NOT NULL,
    JSONKey TEXT NOT NULL
);

CREATE TABLE Borough(
    Id INTEGER PRIMARY KEY,
    Name TEXT NOT NULL
);

CREATE TABLE Impairment (
    Id INTEGER PRIMARY KEY,
    Description TEXT NOT NULL,
    JSONKey TEXT NOT NULL
);
                                                                                        --dynamic tables
CREATE TABLE EthnicityTotal(
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (EthnicityId) REFERENCES Ethnicity(Id),
    Total INTEGER,
    PRIMARY KEY (ResponseId, EthnicityId)
);

CREATE TABLE NoReportReasonTotal(
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (NoReportReasonId) REFERENCES NoReportReason(Id),
    Total INTEGER,
    PRIMARY KEY (ResponseId, NoReportReasonId)
);

CREATE TABLE GenderTotal(
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (GenderId) REFERENCES Gender(Id),
    Total INTEGER,
    PRIMARY KEY (ResponseId, GenderId)

);

CREATE TABLE ReferralTypeTotal(
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (ReferralTypeId) REFERENCES ReferralType(Id),
    Total INTEGER,
    PRIMARY KEY (ResponseId, ReferralTypeId)
);

CREATE TABLE SupportTypeTotal(
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (SupportTypeId) REFERENCES SupportType(Id),
    Total INTEGER,
    PRIMARY KEY (ResponseId, SupportTypeId)
);

CREATE TABLE SupportAgeCategoryTotal(
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (SupportAgeCategoryId) REFERENCES SupportAgeCategory(Id),
    Total INTEGER,
    PRIMARY KEY (ResponseId, SupportAgeCategoryId)
);

CREATE TABLE SexualOrientationTotal(
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (SexualOrientationId) REFERENCES SexualOrientation(Id),
    Total INTEGER,
    PRIMARY KEY (ResponseId, SexualOrientationId)
);

CREATE TABLE SexTotal(
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (SexId) REFERENCES Sex(Id),
    Total INTEGER,
    PRIMARY KEY (ResponseId, SexId)
);

CREATE TABLE ImpairmentTotal(
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (ImpairmentId) REFERENCES Impairment(Id),
    Total INTEGER,
    PRIMARY KEY (ResponseId, ImpairmentId)
);

CREATE TABLE CaseRelatedCategoryTotal(
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (CaseRelatedCategoryId) REFERENCES CaseRelatedCategory(Id),
    Total INTEGER,
    PRIMARY KEY (ResponseId, CaseRelatedCategoryId)

);

CREATE TABLE ResponseBorough(
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (BoroughId) REFERENCES Borough(Id)
    PRIMARY KEY (ResponseId, BoroughId)
);

INSERT INTO Borough (Name)
VALUES  ('Barking and Dagenham'),
        ('Barnet'),
        ('Bexley'),
        ('Brent'),
        ('Bromley'),
        ('Camden'),
        ('Croydon'),
        ('Ealing'),
        ('Enfield'),
        ('Greenwich'),
        ('Hackney'),
        ('Hammersmith and Fulham'),
        ('Haringey'),
        ('Harrow'),
        ('Havering'),
        ('Hounslow'),
        ('Islington'),
        ('Kensington and Chelsea'),
        ('Kingston upon Thames'),
        ('Lambeth'),
        ('Lewisham'),
        ('Merton'),
        ('Newham'),
        ('Redbridge'),
        ('Richmond upon Thames'),
        ('Southwark'),
        ('Sutton'),
        ('Tower Hamlets'),
        ('Waltham Forest'),
        ('Wandsworth'),
        ('Westminster'),
        ('City of London');

INSERT INTO Ethnicity (Description, JSONKey)
VALUES  ('White British, English, Welsh, Scottish or Northern Irish', 'white_eng_plus'),
        ('White Irish', 'white_irish'),
        ('White Traveller', 'white_traveller'),
        ('White Other', 'white_other'),
        ('Mixed Caribbean', 'mixed_caribbean'),
        ('Mixed African', 'mixed_african'),
        ('Mixed Asian', 'mixed_asian'),
        ('Mixed Multiple', 'mixed_multiple'),
        ('Asian Indian', 'asian_indian'),
        ('Asian Pakistani', 'asian_pakistani'),
        ('Asian Bangladeshi', 'asian_bang'),
        ('Asian Chinese', 'asian_chinese'),
        ('Asian Other', 'asian_other'),
        ('Black African', 'black_african'),
        ('Black Caribbean', 'black_caribbean'),
        ('Black Other', 'black_other'),
        ('Arab', 'other_arab'),
        ('Other', 'other');

INSERT INTO NoReportReason (Description, JSONKey)
VALUES  ('Not enough evidence', 'lack_evidence'),
        ('Client decision -  I do not trust police', 'not_trust_police'),
        ('Client decision - Police did not believe me before', 'police_not_believe'),
        ('Client decision - I am afraid to go to the authorities', 'afraid'),
        ('Client decision - I just want the abuse to stop', 'abuse_stop'),
        ('Client decision - I need someone to talk to confidentially without making a report', 'talk'),
        ('Other', 'other');

INSERT INTO SupportType (Description, JSONKey)
VALUES  ('Hate Crime support - support to report / criminal justice system', 'hate_crime'),
        ('Emotional support', 'emotional'),
        ('General support - issues relating to  harrassment / housing / financial / safeguarding', 'general'),
        ('Other', 'other');

INSERT INTO SupportAgeCategory (Description, JSONKey)
VALUES  ('Under 17', 'under_17'),
        ('18 - 65', 'eighteen_to_65'),
        )'Over 65', 'sixtyfive_plus');

INSERT INTO Gender (Description, JSONKey)
VALUES  ('Same as assigned at birth', 'same'),
        ('Different to assigned at birth', 'different'),
        ('Prefer not to say', 'not_say');

INSERT INTO Sex (Description, JSONKey)
VALUES  ('Male', 'male'),
        ('Female', 'female'),
        ('Other', 'other');

INSERT INTO Orientation (Description, JSONKey)
VALUES  ('Heterosexual', 'heterosexual'),
        ('Homosexual', 'homosexual'),
        ('Bisexual', 'bisexual'),
        ('Other', 'other');

INSERT INTO ReferralType (Description, JSONKey)
VALUES  ('Self-referral', 'self'),
        ('Referral from authorities/police', 'from_authorities');

INSERT INTO Impairment (Description, JSONKey)
VALUES  ('Cognitive', 'cognitive'),
        ('Deaf', 'deaf'),
        ('Deafened/hard of hearing'),
        ('Learning difficulties', 'learning_difficulties'),
        ('Long-term condition(s)', 'long_term'),
        ('Mental health issues', 'mental_health'),
        ('Neuro-diverse', 'neurodiverse'),
        ('Physical', 'physical'),
        ('Sensory', 'sensory'),
        ('Other', 'other');

INSERT INTO CaseRelatedCategory (Description, JSONKey) (
    ('COVID-19/Face masks', 'covid'),
    ('Neighbour dispute', 'neighbour'),
    ('Friend/Carer', 'friend_carer'),
    ('In the home', 'home'),
    ('Domestic Violence', 'domestic_violence'),
    ('Residential/Care home', 'care_home'),
    ('Verbal abuse', 'verbal'),
    ('Physical abuse', 'physical'),
    ('In the street', 'street'),
    ('Public transport', 'public_transport'),
    ('Other', 'other');
