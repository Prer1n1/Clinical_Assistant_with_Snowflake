USE DATABASE MED_DEMO;
USE SCHEMA CLINICAL;

SELECT 'patients' AS table_name, COUNT(*) AS row_count FROM PATIENTS
UNION ALL SELECT 'encounters', COUNT(*) FROM ENCOUNTERS
UNION ALL SELECT 'diagnoses', COUNT(*) FROM DIAGNOSES
UNION ALL SELECT 'labs', COUNT(*) FROM LABS
UNION ALL SELECT 'notes', COUNT(*) FROM NOTES;


SELECT d.dx_id, d.encounter_id
FROM DIAGNOSES d
LEFT JOIN ENCOUNTERS e ON e.encounter_id = d.encounter_id
WHERE e.encounter_id IS NULL;


SELECT l.lab_id, l.encounter_id
FROM LABS l
LEFT JOIN ENCOUNTERS e ON e.encounter_id = l.encounter_id
WHERE e.encounter_id IS NULL;


SELECT e.encounter_id, e.patient_id
FROM ENCOUNTERS e
LEFT JOIN PATIENTS p ON p.patient_id = e.patient_id
WHERE p.patient_id IS NULL;


SELECT YEAR(ENCOUNTER_DATE) AS ENCOUNTER_YEAR, COUNT(*) AS ENCOUNTER_COUNT
FROM ENCOUNTERS
GROUP BY 1
ORDER BY 1;


SELECT e.encounter_id, d.dx_desc
FROM ENCOUNTERS e
JOIN DIAGNOSES d ON d.encounter_id = e.encounter_id
ORDER BY e.encounter_id;


SELECT result_num, result_unit, TO_VARCHAR(result_date, 'YYYY-Mon-DD') AS result_date
FROM LABS
WHERE lab_name = 'LDL';


SELECT note_id, patient_id, note_text
FROM NOTES
WHERE note_text ILIKE '%pneumonia%';
