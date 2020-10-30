-- Drop existing objects
Drop TABLE IF EXISTS Response;
DROP TABLE IF EXISTS Ethnicity;
DROP TABLE IF EXISTS NoResponseReason;
DROP TABLE IF EXISTS Gender;
DROP TABLE IF EXISTS EnquiryType;
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
    ID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL
);

CREATE TABLE Response(
    ID INTEGER PRIMARY KEY, 
    Year INTEGER,
    Quarter INTEGER,
    FOREIGN KEY (OrganisationID) REFERENCES Organisation(ID),
    CasesReferredToPolice INTEGER,
    CasesNotReferredToPolice INTEGER,
    HateCrimeReferrals INTEGER,
    FreeTextResponse TEXT,
    CaseStudyEmotionalImpact TEXT,
    CaseStudyPositiveOutcome TEXT
    
);
                                           
CREATE TABLE Ethnicity(
    ID INTEGER PRIMARY KEY,
    Description TEXT
    
);
CREATE TABLE NoReportReason(
    ID INTEGER PRIMARY KEY, 
    Description TEXT

);
CREATE TABLE Gender(
    ID INTEGER PRIMARY KEY,
    Description TEXT
);
CREATE TABLE EnquiryType(
    ID INTEGER PRIMARY KEY, 
    Description TEXT
); 

CREATE TABLE SupportType(
    ID INTEGER PRIMARY KEY,
    Description TEXT -- popultate according to question 6 on survey
);
CREATE TABLE SupportAgeCategory(
    ID INTEGER PRIMARY KEY,-- question 8
    Description TEXT
);
CREATE TABLE SexualOrientation(--bi sexual , other etc
    ID INTEGER PRIMARY KEY,
    Description TEXT
);
CREATE TABLE Sex( --male, female, other
    ID INTEGER PRIMARY KEY,
    Description TEXT
);
CREATE TABLE CaseRelatedCategory(
    ID INTEGER PRIMARY KEY,
    Description TEXT
);

CREATE TABLE Borough(
    ID INTEGER PRIMARY KEY,
    Name TEXT
);

CREATE TABLE Organisation(
    ID INTEGER PRIMARY KEY,
    NAME TEXT
);
                                                                                        --dynamic tables
CREATE TABLE EthnicityTotal(
    FOREIGN KEY (ResponseID) REFERENCES Response(ID),
    FOREIGN KEY(EthnicityID) REFERENCES Ethnicity(ID),
    TOTAL INTEGER
);

CREATE TABLE NoReportReasonTotal(
    FOREIGN KEY (ResponseID) REFERENCES Response(ID),
    FOREIGN KEY (NoReportResponseID) REFERENCES NoReportReason(ID),
    TOTAL INTEGER
);

CREATE TABLE GenderTotal(
    FOREIGN KEY(ResponseID) REFERENCES Response(ID),
    FOREIGN KEY(GenderID) REFERENCES Gender(ID),
    TOTAL INTEGER

);

CREATE TABLE EnquiryTypeTotal(
    FOREIGN KEY(ResponseID) REFERENCES Response(ID),
    FOREIGN KEY(EnquiryTypeID) REFERENCES EnquiryType(ID),
    TOTAL INTEGER
);

CREATE TABLE SupportTypeTotal(
    FOREIGN KEY(ResponseID) REFERENCES Response(ID),
    FOREIGN KEY (SupportTypeID) REFERENCES SupportType(ID),
    TOTAL INTEGER

);

CREATE TABLE SupportAgeCategoryTotals(
    FOREIGN KEY (ResponseID) REFERENCES Response(ID),
    FOREIGN KEY (SupportAgeCategoryID) REFERENCES SupportAgeCategory(ID),
    TOTAL INTEGER
);

CREATE TABLE SexualOrientationTotal(
    FOREIGN KEY(ResponseID) REFERENCES Response(ID),
    FOREIGN KEY (SexualOrientationID) REFERENCES SexualOrientation(ID),
    TOTAL INTEGER
);

CREATE TABLE SexTotal(
    FOREIGN KEY (ResponseID) REFERENCES Response(ID),
    FOREIGN KEY (SexID) REFERENCES Sex(ID),
    TOTAL INTEGER
);

CREATE TABLE CaseRelatedCategoryTotal(
    FOREIGN KEY (ResponseID) REFERENCES Response(ID),
    FOREIGN KEY (CaseRelatedCategoryID) REFERENCES CaseRelatedCategory(ID),
    TOTAL INTEGER

);

CREATE TABLE ResponseBorough(
    FOREIGN KEY (ResponseID) REFERENCES Response(ID),
    FOREIGN KEY (BoroughID) REFERENCES Borough(ID)

);

INSERT INTO Borough(Name) VALUES(
    'Barking and Dagenham'),'Barnet'),'Bexley'),'Brent'),'Bromley'),'Camden'),'Croydon'),'Ealing'),'Enfield'),'Greenwich'),'Hackney'),'Hammersmith and Fulham'),'Haringey'),
    'Harrow'),'Havering'),'Hounslow'),'Islington'),'Kensington and Chelsea'),'Kingston upon Thames'),'Lambeth'),'Lewisham'),'Merton'),'Newham'),'Redbridge'),'Richmond upon Thames'),
    'Southwark'),'Sutton'),'Tower Hamlets'),'Waltham Forest'),'Wandsworth'),'Westminster'),'City of London, the 33rd principal division of Greater London but it is not a London borough.'
);

INSERT INTO SupportAgeCategory(Description) VALUES(
    'Under17'), '18 to 65'), '65 and over'
);

INSERT INTO Ethnicity(Description) VALUES(
    'White - English / Welsh / Scottish / Northern Irish / British'), 'White - Irish'),'White - Gypsy or Irish Traveller'),'Any other White background'),
    'Mixed / Multiple ethnic groups - White and Black Caribbean'),'Mixed / Multiple ethnic groups - White and Black African'),
    'Mixed / Multiple ethnic groups - White and Asian'),'Any other Mixed / Multiple ethnic background'),
    'Asian / Asian British - Indian'),'Asian / Asian British - Pakistani'),'Asian / Asian British - Bangladeshi'),
    'Asian / Asian British - Chinese'),'Any other Asian background'),'Black / African / Caribbean / Black British - African'),
    'Black / African / Caribbean / Black British - Caribbean'),'Any other Black / African / Caribbean background'),'Other ethnic group - Arab'),'Any other ethnic group'
);
INSERT INTO sex(Description) VALUES(
    'Cis Male'),'Cis Female'),'Male'),'Female'),'Hetrosexual'),'Homosexual'),'Bi-Sexual'),'Lesbian'),'Other'
);

INSERT INTO Gender(Description) VALUES(
    'Two spirit'),'Cisgender'),'Transgender'),'Non-Binary'),'Genderqueer'),'Gender Neutral'),'Gender fluid'),'Gender expression'
);

INSERT INTO CaseRelatedCategory(Description) VALUES(
    'COVID - facemasks'),'Neighbour Dispute'),'Friend / Carer'),'In the home'),
    'Domestic Violence'),'Residential / Care Home'),'Verbal'),'Physical'),'In the street'),
    'Public transport'),'Other'
);

INSERT INTO NoReportReason(Description) VALUES(
    'Not enough evidence'),'Client decision - I don''t trust Police'),'Client decision - Police didn''t believe me before'),
    'Client decision - I am afraid to go to the Authorities'),'Client decision - I just want the abuse to stop'),
    'Client decision - I need someone to talk to in confidence without making a report'),'Something else, please state'
);

INSERT INTO EnquiryType(Description) VALUES(  
    'Number of new referrals / enquiries for Disability Hate Crime cases'),'Number of cases reported to Police'),
    'Number of cases supported but not reported to Police'),'Number of self-referrals'),'Number of referrals from Police / Authorities'
);

INSERT INTO SupportType(Description) VALUES(
    'Hate Crime support - support to report / criminal justice system'),'Emotional Support'),
    'General support - issues relating to  harrassment / housing / financial / safeguarding'),'Other'
);