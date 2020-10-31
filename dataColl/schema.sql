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
DROP TABLE IF EXISTS Impairment;
Drop TABLE IF EXISTS ResponseBorough;
DROP TABLE IF EXISTS EthnicityTotal;
DROP TABLE IF EXISTS NoReportReasonTotal;
DROP TABLE IF EXISTS GenderTotal;
DROP TABLE IF EXISTS ReferralTypeTotal;
DROP TABLE IF EXISTS SupportTypeTotal;
DROP TABLE IF EXISTS SupportAgeCategoryTotal;
DROP TABLE IF EXISTS SexualOrientationTotal;
DROP TABLE IF EXISTS SexTotal;
DROP TABLE IF EXISTS CaseRelatedCategoryTotal;
DROP TABLE IF EXISTS BoroughTotal;
DROP TABLE IF EXISTS OrganisationTotal;
DROP TABLE IF EXISTS ImpairmentTotal;

-- Create tables
CREATE TABLE Organisation (
    -- A DDPO
    Id INTEGER PRIMARY KEY,
    Name TEXT NOT NULL
);
CREATE TABLE Response (
    Id INTEGER PRIMARY KEY, 
    Year INTEGER NOT NULL,
    Quarter INTEGER NOT NULL,
    OrganisationId INTEGER NOT NULL,
    CasesReferredToPolice INTEGER,
    CasesNotReferredToPolice INTEGER,
    HateCrimeReferrals INTEGER,
    FreeTextResponse TEXT,
    CaseStudyEmotionalImpact TEXT,
    CaseStudyPositiveOutcome TEXT,
    FOREIGN KEY (OrganisationId) REFERENCES Organisation(Id)   
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
    EthnicityId INTEGER,
    ResponseId INTEGER,
    Total INTEGER,
    PRIMARY KEY (ResponseId, EthnicityId),
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (EthnicityId) REFERENCES Ethnicity(Id)
);

CREATE TABLE NoReportReasonTotal(
    ResponseId INTEGER,
    NoReportReasonId INTEGER,
    Total INTEGER,
    PRIMARY KEY (ResponseId, NoReportReasonId),
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (NoReportReasonId) REFERENCES NoReportReason(Id)
);

CREATE TABLE GenderTotal (
    ResponseId INTEGER,
    GenderId INTEGER,
    Total INTEGER,
    PRIMARY KEY (ResponseId, GenderId),
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (GenderId) REFERENCES Gender(Id)
);

CREATE TABLE ReferralTypeTotal(
    ResponseId INTEGER,
    ReferralTypeId INTEGER,
    Total INTEGER,
    PRIMARY KEY (ResponseId, ReferralTypeId),
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (ReferralTypeId) REFERENCES ReferralType(Id)
);

CREATE TABLE SupportTypeTotal(
    ResponseId INTEGER,
    SupportTypeId INTEGER,
    Total INTEGER,
    PRIMARY KEY (ResponseId, SupportTypeId),
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (SupportTypeId) REFERENCES SupportType(Id)
);

CREATE TABLE SupportAgeCategoryTotal(
    ResponseId INTEGER,
    SupportAgeCategoryId INTEGER,
    Total INTEGER,
    PRIMARY KEY (ResponseId, SupportAgeCategoryId),
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (SupportAgeCategoryId) REFERENCES SupportAgeCategory(Id)
);

CREATE TABLE SexualOrientationTotal(
    ResponseId INTEGER,
    SexualOrientationId INTEGER,
    Total INTEGER,
    PRIMARY KEY (ResponseId, SexualOrientationId),
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (SexualOrientationId) REFERENCES SexualOrientation(Id)
);

CREATE TABLE SexTotal(
    ResponseId INTEGER,
    SexId INTEGER,
    Total INTEGER,
    PRIMARY KEY (ResponseId, SexId),
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (SexId) REFERENCES Sex(Id)
);

CREATE TABLE ImpairmentTotal(
    ResponseId INTEGER,
    ImpairmentId INTEGER,
    Total INTEGER,
    PRIMARY KEY (ResponseId, ImpairmentId),
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (ImpairmentId) REFERENCES Impairment(Id)
);

CREATE TABLE CaseRelatedCategoryTotal(
    ResponseId INTEGER,
    CaseRelatedCategoryId INTEGER,
    Total INTEGER,
    PRIMARY KEY (ResponseId, CaseRelatedCategoryId),
    FOREIGN KEY (ResponseId) REFERENCES Response(Id),
    FOREIGN KEY (CaseRelatedCategoryId) REFERENCES CaseRelatedCategory(Id)
);

CREATE TABLE ResponseBorough(
    ResponseId INTEGER,
    BoroughId INTEGER,
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
        ('Over 65', 'sixtyfive_plus');

INSERT INTO Gender (Description, JSONKey)
VALUES  ('Same as assigned at birth', 'same'),
        ('Different to assigned at birth', 'different'),
        ('Prefer not to say', 'not_say');

INSERT INTO Sex (Description, JSONKey)
VALUES  ('Male', 'male'),
        ('Female', 'female'),
        ('Other', 'other');

INSERT INTO SexualOrientation (Description, JSONKey)
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
        ('Deafened/hard of hearing', 'hoh'),
        ('Learning difficulties', 'learning_difficulties'),
        ('Long-term condition(s)', 'long_term'),
        ('Mental health issues', 'mental_health'),
        ('Neuro-diverse', 'neurodiverse'),
        ('Physical', 'physical'),
        ('Sensory', 'sensory'),
        ('Other', 'other');

INSERT INTO CaseRelatedCategory (Description, JSONKey)
VALUES  ('COVID-19/Face masks', 'covid'),
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
