create or replace semantic view CLINICAL_SEMANTICS
	tables (
		DIAGNOSES,
		ENCOUNTERS primary key (ENCOUNTER_ID),
		LABS,
		PATIENTS primary key (PATIENT_ID)
	)
	relationships (
		DIAGNOSES_TO_ENCOUNTERS as DIAGNOSES(ENCOUNTER_ID) references ENCOUNTERS(ENCOUNTER_ID),
		ENCOUNTERS_TO_PATIENTS as ENCOUNTERS(PATIENT_ID) references PATIENTS(PATIENT_ID),
		LABS_TO_ENCOUNTERS as LABS(ENCOUNTER_ID) references ENCOUNTERS(ENCOUNTER_ID)
	)
	dimensions (
		PUBLIC DIAGNOSES.DX_DESC as DX_DESC with synonyms=('diagnosis_description','condition_description','dx_text','diagnosis_text','medical_condition_description','diagnosis_label') comment='A text description of the patient''s medical diagnosis.',
		PUBLIC DIAGNOSES.DX_ID as DX_ID with synonyms=('diagnosis_id','diagnosis_code','icd_id','medical_condition_id','health_issue_id','disease_id') comment='Unique identifier for a diagnosis.',
		PUBLIC DIAGNOSES.ENCOUNTER_ID as ENCOUNTER_ID with synonyms=('visit_id','patient_visit_number','encounter_number','visit_number','patient_encounter_id','admission_id') comment='Unique identifier for a patient''s visit or encounter.',
		PUBLIC DIAGNOSES.ICD10 as ICD10 with synonyms=('diagnosis_code','icd_code','medical_code','disease_code','classification_code','health_code') comment='Diagnosis Code (ICD-10)',
		PUBLIC ENCOUNTERS.ENCOUNTER_DATE as ENCOUNTER_DATE with synonyms=('admission_date','visit_date','encounter_timestamp','appointment_date','service_date','event_date','procedure_date','treatment_date') comment='Date of patient encounter or visit.',
		PUBLIC ENCOUNTERS.ENCOUNTER_ID as ENCOUNTERS.ENCOUNTER_ID with synonyms=('Encounter_no','Encounter_name'),
		PUBLIC ENCOUNTERS.ENCOUNTER_TYPE as ENCOUNTER_TYPE with synonyms=('visit_type','encounter_category','patient_visit_reason','admission_type','visit_classification','encounter_reason','patient_encounter_category') comment='The type of medical encounter, indicating whether the patient received care on an outpatient basis, in an emergency department, or as an inpatient in a hospital.',
		PUBLIC ENCOUNTERS.PATIENT_ID as PATIENT_ID with synonyms=('patient_number','person_id','individual_id','subject_id','medical_record_number','patient_identifier') comment='Unique identifier for the patient associated with the encounter.',
		PUBLIC LABS.ENCOUNTER_ID as ENCOUNTER_ID with synonyms=('visit_id','patient_visit_id','encounter_number','patient_encounter_number','visit_number') comment='Unique identifier for a patient''s visit or encounter in the laboratory.',
		PUBLIC LABS.LAB_ID as LAB_ID with synonyms=('lab_number','lab_test_id','lab_result_id','test_id','lab_identifier','lab_code') comment='Unique identifier for a laboratory.',
		PUBLIC LABS.LAB_NAME as LAB_NAME with synonyms=('lab_test_name','test_name','lab_test_type','test_type','lab_result_name','test_result_name','lab_type','test_label') comment='Type of laboratory test performed, such as White Blood Cell count, Blood Pressure Systolic, or Hemoglobin A1c.',
		PUBLIC LABS.RESULT_DATE as RESULT_DATE with synonyms=('lab_date','test_date','result_timestamp','sample_date','analysis_date','measurement_date','test_result_date','date_of_result') comment='Date on which the laboratory test result was recorded.',
		PUBLIC LABS.RESULT_NUM as RESULT_NUM with synonyms=('lab_result_value','test_result_number','result_quantity','measurement_value','numeric_result','test_value','result_amount') comment='The RESULT_NUM column represents the numerical value of a laboratory test result, which can be a decimal or integer value, indicating the outcome of a specific lab test or measurement.',
		PUBLIC LABS.RESULT_UNIT as RESULT_UNIT with synonyms=('unit_of_measurement','measurement_unit','unit','lab_unit','test_unit','result_measurement','measurement_type','unit_type') comment='The unit of measurement for the laboratory test result.',
		PUBLIC PATIENTS.FIRST_NAME as FIRST_NAME with synonyms=('given_name','forename','personal_name','christian_name','baptismal_name') comment='The first name of the patient.',
		PUBLIC PATIENTS.LAST_NAME as LAST_NAME with synonyms=('surname','family_name','last_name','full_last_name','surname_name') comment='The patient''s last name.',
		PUBLIC PATIENTS.MRN as MRN with synonyms=('medical_record_number','patient_id_number','patient_identifier','medical_id','patient_number','chart_number') comment='Unique identifier assigned to each patient for medical record-keeping purposes.',
		PUBLIC PATIENTS.SEX as SEX with synonyms=('gender','biological_sex','sex_type','sex_category','sex_identifier') comment='The sex of the patient, either male (M) or female (F).',
		PUBLIC PATIENTS.DOB as DOB with synonyms=('date_of_birth','birth_date','birthdate','birthday','date_of_birth_recorded') comment='Date of Birth of the patient.',
		PUBLIC PATIENTS.PATIENT_ID as PATIENT_ID with synonyms=('patient_number','patient_identifier','medical_record_number','person_id','unique_patient_identifier','patient_key') comment='Unique identifier assigned to each patient in the healthcare system.'
	)
	comment='Use this to answer questions about patients, encounters, diagnoses, labs and notes using the CLINICAL_SEMANTICS semantic view.'
	with extension (CA='{"tables":[{"name":"DIAGNOSES","dimensions":[{"name":"DX_DESC","sample_values":["Influenza","Essential (primary) hypertension","Type 2 diabetes mellitus without complications"]},{"name":"ICD10","sample_values":["J11","I10","E11.9"]},{"name":"DX_ID","sample_values":["1001","1002","1003"]},{"name":"ENCOUNTER_ID","sample_values":["101","102","103"]}]},{"name":"ENCOUNTERS","dimensions":[{"name":"ENCOUNTER_TYPE","sample_values":["Outpatient","Emergency","Inpatient"]},{"name":"ENCOUNTER_ID","unique":true},{"name":"PATIENT_ID","sample_values":["1","2","3"]}],"time_dimensions":[{"name":"ENCOUNTER_DATE","sample_values":["2024-06-10","2025-01-05","2025-03-15"]}]},{"name":"LABS","dimensions":[{"name":"LAB_NAME","sample_values":["WBC","BP_SYS","HbA1c"]},{"name":"RESULT_UNIT","sample_values":["10^9/L","mmHg","%"]},{"name":"LAB_ID","sample_values":["2001","2002","2003"]},{"name":"ENCOUNTER_ID","sample_values":["101","102","103"]},{"name":"RESULT_NUM","sample_values":["8.2","150","7.4"]}],"time_dimensions":[{"name":"RESULT_DATE","sample_values":["2024-06-10","2025-01-05","2025-03-15"]}]},{"name":"PATIENTS","dimensions":[{"name":"FIRST_NAME","sample_values":["John","Jane","Carlos"]},{"name":"LAST_NAME","sample_values":["Doe","Smith","Ruiz"]},{"name":"MRN","sample_values":["MRN-1001","MRN-1002","MRN-1003"]},{"name":"SEX","sample_values":["M","F"]},{"name":"PATIENT_ID","sample_values":["1","2","3"]}],"time_dimensions":[{"name":"DOB","sample_values":["1980-01-15","1990-03-22","1975-07-09"]}]}],"relationships":[{"name":"ENCOUNTERS_to_PATIENTS"},{"name":"DIAGNOSES_to_ENCOUNTERS"},{"name":"LABS_to_ENCOUNTERS"}]}');