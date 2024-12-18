CREATE TABLE COUNTY
(
    CountyID            NUMBER          NOT NULL    PRIMARY KEY,
    CountyName          VARCHAR2(100)   NOT NULL    UNIQUE,
    CountyPopulation    NUMBER          NOT NULL
);

CREATE TABLE CITY
(
    CityID          NUMBER          NOT NULL    PRIMARY KEY,
    CityName        VARCHAR2(100)   NOT NULL,
    CityPopulation  NUMBER          NOT NULL,
    CountyID        NUMBER          NOT NULL,
    FOREIGN KEY (CountyID) REFERENCES COUNTY (CountyID)
);

CREATE TABLE ZIPCODE
(
    ZipCodeID   NUMBER NOT NULL PRIMARY KEY,
    ZipCode     NUMBER NOT NULL UNIQUE,
    CityID      NUMBER NOT NULL,
    FOREIGN KEY (CityID) REFERENCES CITY (CityID)
);

CREATE TABLE TEST_CENTER
(
    TestCenterID    NUMBER          NOT NULL    PRIMARY KEY,
    CenterName      VARCHAR2(100)   NOT NULL,
    CenterAddress   VARCHAR2(200)   NOT NULL,
    CenterPhone     VARCHAR2(100)   NOT NULL,
    ZipCodeID       NUMBER          NOT NULL,
    FOREIGN KEY (ZipCodeID) REFERENCES ZIPCODE (ZipCodeID)
);

CREATE TABLE RESIDENT
(
    ResidentID          NUMBER          NOT NULL    PRIMARY KEY,
    SSN                 NUMBER          NOT NULL    UNIQUE,
    FirstName           VARCHAR2(100)   NOT NULL,
    LastName            VARCHAR2(100)   NOT NULL,
    ResidentAddress     VARCHAR2(200)   NOT NULL,
    BirthDate           DATE            NOT NULL,
    ZipCodeID           NUMBER          NOT NULL,
    FOREIGN KEY (ZipCodeID) REFERENCES ZIPCODE (ZipCodeID)
);

CREATE TABLE COMPLETION
(
    TestDate        DATE            NOT NULL,
    TestResult      VARCHAR2(100)   NOT NULL,
    ResidentID      NUMBER          NOT NULL,
    TestCenterID    NUMBER          NOT NULL,
    PRIMARY KEY (TestDate, ResidentID, TestCenterID),
    FOREIGN KEY (ResidentID) REFERENCES RESIDENT (ResidentID),
    FOREIGN KEY (TestCenterID) REFERENCES TEST_CENTER (TestCenterID)
);

CREATE TABLE RESIDENT_PHONE
(
    ResidentPhone   VARCHAR2(100)   NOT NULL,
    ResidentID      NUMBER          NOT NULL,
    PRIMARY KEY (ResidentPhone, ResidentID),
    FOREIGN KEY (ResidentID) REFERENCES RESIDENT (ResidentID)
);