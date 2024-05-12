DROP TABLE COVERED;
DROP TABLE MODIFIED;
DROP TABLE APPOINTMENT;
DROP TABLE BILL;
DROP TABLE PRESCRIPTION;
DROP TABLE RECORD;
DROP TABLE INSURANCE;
DROP TABLE PROVIDER;
DROP TABLE PATIENT;

--Create tables
CREATE TABLE PATIENT
(
    PatientID       NUMBER          NOT NULL    PRIMARY KEY,
    PatientLName    VARCHAR2(50)    NOT NULL,
    PatientFName    VARCHAR2(50)    NOT NULL,
    PatientEmail    VARCHAR2(100)   NOT NULL    UNIQUE,  
    PatientPhone    VARCHAR2(20)    NOT NULL,
    Gender          VARCHAR2(10)    NOT NULL,
    DateOfBirth     DATE            NOT NULL
);

CREATE TABLE INSURANCE
(
    InsuranceID         NUMBER          NOT NULL    PRIMARY KEY,
    InsuranceProvider   VARCHAR2(100)   NOT NULL,  
    PolicyNumber        VARCHAR2(50)    NOT NULL    UNIQUE,
    InsurancePlan       VARCHAR2(100)   NOT NULL,
    InsuranceEndDate    DATE            NOT NULL,
    CoverageDetail      VARCHAR2(255)   NOT NULL,
    PatientID           NUMBER          NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES PATIENT (PatientID)
);

CREATE TABLE PROVIDER
(
    ProviderID      NUMBER          NOT NULL    PRIMARY KEY,
    ProviderEmail   VARCHAR2(100)   NOT NULL, 
    WorkSpecialty   VARCHAR2(100)   NOT NULL,
    ProviderFName   VARCHAR2(50)    NOT NULL,
    ProviderLName   VARCHAR2(50)    NOT NULL
);

CREATE TABLE RECORD
(
    RecordID    NUMBER          NOT NULL    PRIMARY KEY,
    Diagnosis   VARCHAR2(255)   NOT NULL,
    Treatment   VARCHAR2(255)   NOT NULL,
    PatientID   NUMBER          NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES PATIENT (PatientID)
);

CREATE TABLE PRESCRIPTION
(
    PrescriptionID      NUMBER          NOT NULL    PRIMARY KEY,
    Medication          VARCHAR2(150)   NOT NULL,
    Dosage              VARCHAR2(50)    NOT NULL,
    DateIssued          DATE            NOT NULL,
    DateExpired         DATE            NOT NULL,
    Instruction         VARCHAR2(255)   NOT NULL,
    ProviderID          NUMBER          NOT NULL,
    PatientID           NUMBER          NOT NULL,
    FOREIGN KEY (ProviderID) REFERENCES PROVIDER (ProviderID),
    FOREIGN KEY (PatientID) REFERENCES PATIENT (PatientID)
);

CREATE TABLE BILL
(
    BillID          NUMBER          NOT NULL    PRIMARY KEY,
    Description     VARCHAR2(255)   NOT NULL,
    TotalCharge     NUMBER(10,2)    NOT NULL,
    BillDate        DATE            NOT NULL,
    BillDueDate     DATE            NOT NULL,
    PatientID       NUMBER          NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES PATIENT (PatientID)
);

CREATE TABLE APPOINTMENT
(
    AppointmentID       NUMBER          NOT NULL    PRIMARY KEY,
    AppointmentTime     TIMESTAMP       NOT NULL,
    AppointmentDate     DATE            NOT NULL,
    Reason              VARCHAR2(255)   NOT NULL,
    PatientID           NUMBER          NOT NULL,
    ProviderID          NUMBER          NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES PATIENT (PatientID),
    FOREIGN KEY (ProviderID) REFERENCES PROVIDER (ProviderID)
);

CREATE TABLE MODIFIED
(
    ProviderID    NUMBER    NOT NULL,
    RecordID      NUMBER    NOT NULL,
    DateChange    DATE      NOT NULL,
    PRIMARY KEY (ProviderID, RecordID),
    FOREIGN KEY (ProviderID) REFERENCES PROVIDER (ProviderID),
    FOREIGN KEY (RecordID) REFERENCES RECORD (RecordID)
);

CREATE TABLE COVERED
(
    BillID              NUMBER          NOT NULL,
    InsuranceID         NUMBER          NOT NULL,
    CoverageAmount      NUMBER(10,2)    NOT NULL,
    PRIMARY KEY (BillID, InsuranceID),
    FOREIGN KEY (BillID) REFERENCES BILL (BillID),
    FOREIGN KEY (InsuranceID) REFERENCES INSURANCE (InsuranceID)
);


--Insert at least 2 rows
--PATIENT table
INSERT INTO PATIENT (PatientID, PatientLName, PatientFName, PatientEmail, PatientPhone, Gender, DateOfBirth) VALUES 
(1, 'Smith', 'John', 'john.smith@google.com', '123-456-7890', 'Male', TO_DATE('1990-01-01', 'YYYY-MM-DD'));
INSERT INTO PATIENT (PatientID, PatientLName, PatientFName, PatientEmail, PatientPhone, Gender, DateOfBirth) VALUES
(2, 'Johnson', 'Emily', 'emily.johnson@yahoo.com', '987-654-3210', 'Female', TO_DATE('1985-05-15', 'YYYY-MM-DD'));
INSERT INTO PATIENT (PatientID, PatientLName, PatientFName, PatientEmail, PatientPhone, Gender, DateOfBirth) VALUES
(3, 'Williams', 'Michael', 'michael.williams@hotmail.com', '575-565-5565', 'Male', TO_DATE('1978-09-20', 'YYYY-MM-DD'));

--INSURANCE table
INSERT INTO INSURANCE (InsuranceID, InsuranceProvider, PolicyNumber, InsurancePlan, InsuranceEndDate, CoverageDetail, PatientID) VALUES
(1, 'ABC Insurance', 123456, 'Standard Plan', TO_DATE('2025-12-31', 'YYYY-MM-DD'), 'Basic Coverage', 1);
INSERT INTO INSURANCE (InsuranceID, InsuranceProvider, PolicyNumber, InsurancePlan, InsuranceEndDate, CoverageDetail, PatientID) VALUES
(2, 'XYZ Insurance', 987654, 'Premium Plan', TO_DATE('2026-06-30', 'YYYY-MM-DD'), 'Comprehensive Coverage', 2);
INSERT INTO INSURANCE (InsuranceID, InsuranceProvider, PolicyNumber, InsurancePlan, InsuranceEndDate, CoverageDetail, PatientID) VALUES
(3, 'DEF Insurance', 456789, 'Basic Plan', TO_DATE('2025-10-15', 'YYYY-MM-DD'), 'Limited Coverage', 3);

--PROVIDER table
INSERT INTO PROVIDER (ProviderID, ProviderEmail, WorkSpecialty, ProviderFName, ProviderLName) VALUES
(1, 'alice.johnson@clinic.com', 'General Medicine', 'Alice', 'Johnson');
INSERT INTO PROVIDER (ProviderID, ProviderEmail, WorkSpecialty, ProviderFName, ProviderLName) VALUES
(2, 'david.smith@clinic.com', 'Pediatrics', 'David', 'Smith');
INSERT INTO PROVIDER (ProviderID, ProviderEmail, WorkSpecialty, ProviderFName, ProviderLName) VALUES
(3, 'sarah.brown@clinic.com', 'Dermatology', 'Sarah', 'Brown');

--RECORD table
INSERT INTO RECORD (RecordID, Diagnosis, Treatment, PatientID) VALUES
(1, 'Common Cold', 'Rest and hydration', 1);
INSERT INTO RECORD (RecordID, Diagnosis, Treatment, PatientID) VALUES
(2, 'Fractured Arm', 'Cast applied', 2);
INSERT INTO RECORD (RecordID, Diagnosis, Treatment, PatientID) VALUES
(3, 'Skin Rash', 'Prescribed cream', 3);

--PRESCRIPTION table
INSERT INTO PRESCRIPTION (PrescriptionID, Medication, Dosage, DateIssued, DateExpired, Instruction, ProviderID, PatientID) VALUES
(1, 'Paracetamol', '500mg', TO_DATE('2024-04-21', 'YYYY-MM-DD'), TO_DATE('2024-05-21', 'YYYY-MM-DD'), 'Take as needed', 1, 1);
INSERT INTO PRESCRIPTION (PrescriptionID, Medication, Dosage, DateIssued, DateExpired, Instruction, ProviderID, PatientID) VALUES
(2, 'Amoxicillin', '250mg', TO_DATE('2024-04-21', 'YYYY-MM-DD'), TO_DATE('2024-05-21', 'YYYY-MM-DD'), 'Take twice a day', 2, 2);
INSERT INTO PRESCRIPTION (PrescriptionID, Medication, Dosage, DateIssued, DateExpired, Instruction, ProviderID, PatientID) VALUES
(3, 'Hydrocortisone Cream', 'Apply topically', TO_DATE('2024-04-21', 'YYYY-MM-DD'), TO_DATE('2024-05-21', 'YYYY-MM-DD'), 'Apply on affected area', 3, 3);

--BILL table
INSERT INTO BILL (BillID, Description, TotalCharge, BillDate, BillDueDate, PatientID) VALUES
(1, 'Consultation Fee', 100.00, TO_DATE('2024-04-21', 'YYYY-MM-DD'), TO_DATE('2024-05-21', 'YYYY-MM-DD'), 1);
INSERT INTO BILL (BillID, Description, TotalCharge, BillDate, BillDueDate, PatientID) VALUES
(2, 'X-ray Scan', 250.00, TO_DATE('2024-04-21', 'YYYY-MM-DD'), TO_DATE('2024-05-21', 'YYYY-MM-DD'), 2);
INSERT INTO BILL (BillID, Description, TotalCharge, BillDate, BillDueDate, PatientID) VALUES
(3, 'Dermatology Consultation', 150.00, TO_DATE('2024-04-21', 'YYYY-MM-DD'), TO_DATE('2024-05-21', 'YYYY-MM-DD'), 3);

--APPOINTMENT table
INSERT INTO APPOINTMENT (AppointmentID, AppointmentTime, Reason, AppointmentDate, PatientID, ProviderID) VALUES
(1, TIMESTAMP '2024-04-21 09:00:00', 'Annual Checkup', TO_DATE('2024-04-21', 'YYYY-MM-DD'), 1, 1);
INSERT INTO APPOINTMENT (AppointmentID, AppointmentTime, Reason, AppointmentDate, PatientID, ProviderID) VALUES
(2, TIMESTAMP '2024-04-22 10:30:00', 'Follow-up on injury', TO_DATE('2024-04-22', 'YYYY-MM-DD'), 2, 2);
INSERT INTO APPOINTMENT (AppointmentID, AppointmentTime, Reason, AppointmentDate, PatientID, ProviderID) VALUES
(3, TIMESTAMP '2024-04-23 11:00:00', 'Skin examination', TO_DATE('2024-04-23', 'YYYY-MM-DD'), 3, 3);

--MODIFIED table
INSERT INTO MODIFIED (ProviderID, RecordID, DateChange) VALUES (1, 1, SYSDATE);
INSERT INTO MODIFIED (ProviderID, RecordID, DateChange) VALUES (2, 2, SYSDATE);
INSERT INTO MODIFIED (ProviderID, RecordID, DateChange) VALUES (3, 3, SYSDATE);

--COVERED table
INSERT INTO COVERED (BillID, InsuranceID, CoverageAmount) VALUES (1, 1, 80.00);
INSERT INTO COVERED (BillID, InsuranceID, CoverageAmount) VALUES (2, 2, 200.00);
INSERT INTO COVERED (BillID, InsuranceID, CoverageAmount) VALUES (3, 3, 120.00);

--Make insertion permanently
COMMIT;


--2 SELECT QUERIES
-- Query 1: Get the total number of appointments for each healthcare provider
SELECT p.ProviderFName, p.ProviderLName, COUNT(a.AppointmentID) AS TotalAppointments
FROM PROVIDER p LEFT JOIN APPOINTMENT a ON p.ProviderID = a.ProviderID
GROUP BY p.ProviderFName, p.ProviderLName;

-- Query 2: Get the total bill amount, coverage amount, and remaining charged amount for each patient
SELECT p.PatientFName, p.PatientLName, 
       SUM(b.TotalCharge) AS TotalBillAmount, SUM(c.CoverageAmount) AS TotalCoverageAmount,
       (SUM(b.TotalCharge) - SUM(c.CoverageAmount)) AS TotalRemainingCharged
FROM PATIENT p JOIN BILL b ON p.PatientID = b.PatientID
    LEFT JOIN Covered c ON b.BillID = c.BillID
GROUP BY p.PatientFName, p.PatientLName;