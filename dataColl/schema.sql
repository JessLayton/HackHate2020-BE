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
    Id INTEGER PRIMARY KEY,
    Name TEXT NOT NULL
);

CREATE TABLE Response(
    ID INTEGER PRIMARY KEY, 
    Year INTEGER,
    Quarter INTEGER,
    FOREIGN KEY (Organisation_ID) REFERENCES Organisation(Id),
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
    Description TEXT
);
CREATE TABLE SupportAgeCategory(
    ID INTEGER PRIMARY KEY,
    Description TEXT
);
CREATE TABLE SexualOrientation(
    ID INTEGER PRIMARY KEY,
    Description TEXT
);
CREATE TABLE Sex(
    ID INTEGER PRIMARY KEY,
    Description TEXT
);
CREATE TABLE CaseRelatedCategory(
    ID INTEGER PRIMARY KEY,
    Description TEXT
);

CREATE TABLE Borough(
    ID INTEGER PRIMARY KEY,
    NAME TEXT
);

CREATE TABLE Organisation(
    ID INTEGER PRIMARY KEY,
    NAME TEXT
);

CREATE TABLE EthnicityTotal(
    FOREIGN KEY (Response_ID) REFERENCES Response(ID),
    FOREIGN KEY(Ethnicity_ID) REFERENCES Ethnicity(ID),
    TOTAL INTEGER
);

CREATE TABLE NoReportReasonTotal(
    FOREIGN KEY (Response_ID) REFERENCES Response(ID),
    FOREIGN KEY (NoReportResponse_ID) REFERENCES NoReportReason(ID),
    TOTAL INTEGER
);

CREATE TABLE GenderTotal(
    FOREIGN KEY(Response_ID) REFERENCES Response(ID),
    FOREIGN KEY(Gender_ID) REFERENCES Gender(ID),
    TOTAL INTEGER

);

CREATE TABLE EnquiryTypeTotal(
    FOREIGN KEY(Response_ID) REFERENCES Response(ID),
    FOREIGN KEY(EnquiryType_ID) REFERENCES EnquiryType(ID),
    TOTAL INTEGER
);

CREATE TABLE SupportTypeTotal(
    FOREIGN KEY(Response_ID) REFERENCES Response(ID),
    FOREIGN KEY (SupportType_ID) REFERENCES SupportType(ID),
    TOTAL INTEGER

);

CREATE TABLE SupportAgeCategoryTotals(
    FOREIGN KEY (Response_ID) REFERENCES Response(ID),
    FOREIGN KEY (SupportAgeCategory_ID) REFERENCES SupportAgeCategory(ID),
    TOTAL INTEGER
);

CREATE TABLE SexualOrientationTotal(
    FOREIGN KEY(Response_ID) REFERENCES Response(ID),
    FOREIGN KEY (SexualOrientation_ID) REFERENCES SexualOrientation(ID),
    TOTAL INTEGER
);

CREATE TABLE SexTotal(
    FOREIGN KEY (Response_ID) REFERENCES Response(ID),
    FOREIGN KEY (Sex_ID) REFERENCES Sex(ID),
    TOTAL INTEGER
);

CREATE TABLE CaseRelatedCategoryTotal(
    FOREIGN KEY (Response_ID) REFERENCES Response(ID),
    FOREIGN KEY (CaseRelatedCategory_ID) REFERENCES CaseRelatedCategory(ID),
    TOTAL INTEGER

);

CREATE TABLE ResponseBorough(
    FOREIGN KEY (Response_ID) REFERENCES Response(ID),
    FOREIGN KEY (Borough_ID) REFERENCES Borough(ID)

);
