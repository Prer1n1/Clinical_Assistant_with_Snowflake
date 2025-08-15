USE DATABASE MED_DEMO;
USE SCHEMA CLINICAL;


-- Patients
INSERT INTO PATIENTS VALUES
   (1,'MRN-1001','John','Doe','1980-01-15','M'),
   (2,'MRN-1002','Jane','Smith','1990-03-22','F'),
   (3,'MRN-1003','Carlos','Ruiz','1975-07-09','M'),
   (4,'MRN-1004','Asha','Patel','1988-11-05','F'),
   (5,'MRN-1005','Mei','Chen','1969-02-12','F');

-- Encounters
INSERT INTO ENCOUNTERS VALUES
   (101,1,'2024-06-10','Outpatient'),
   (102,1,'2025-01-05','Emergency'),
   (103,2,'2025-03-15','Outpatient'),
   (104,3,'2024-12-10','Inpatient'),
   (105,4,'2025-02-20','Outpatient'),
   (106,5,'2025-05-30','Outpatient');

-- Diagnoses
INSERT INTO DIAGNOSES VALUES
   (1001,101,'J11','Influenza'),
   (1002,102,'I10','Essential (primary) hypertension'),
   (1003,103,'E11.9','Type 2 diabetes mellitus without complications'),
   (1004,104,'J18.9','Pneumonia, unspecified organism'),
   (1005,105,'M54.5','Low back pain'),
   (1006,106,'E78.5','Hyperlipidemia, unspecified');

-- Labs
INSERT INTO LABS VALUES
   (2001,101,'WBC',   8.2,'10^9/L','2024-06-10'),
   (2002,102,'BP_SYS',150, 'mmHg', '2025-01-05'),
   (2003,103,'HbA1c', 7.4,'%',     '2025-03-15'),
   (2004,104,'CRP',   45,  'mg/L', '2024-12-02'),
   (2005,105,'ESR',   10,  'mm/hr','2025-02-20'),
   (2006,106,'LDL',   160, 'mg/dL','2025-05-30');

-- Notes
INSERT INTO NOTES VALUES
   (3001,1,'Reports seasonal flu symptoms last June; improved with rest.'),
   (3002,1,'Elevated blood pressure noted in January; advised home BP monitoring.'),
   (3003,2,'Type 2 diabetes; lifestyle counseling and HbA1c follow-up needed.'),
   (3004,3,'Admitted for pneumonia; responding to antibiotics.'),
   (3005,4,'Chronic low back pain after prolonged sitting; PT recommended.');
