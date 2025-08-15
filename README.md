# Snowflake Clinical Assistant (Cortex Analyst + Cortex Search)

This repo provisions a small clinical dataset and two AI capabilities on Snowflake:
- **Cortex Analyst** via a **Semantic View** for structured Q&A over tables
- **Cortex Search Service** for semantic search over unstructured clinical **NOTES**
- (Optional) a **Snowflake Agent** that orchestrates both

## Objects created
- **Database / Schema**: `MED_DEMO.CLINICAL`
- **Tables**: `PATIENTS`, `ENCOUNTERS`, `DIAGNOSES`, `LABS`, `NOTES`
- **Semantic View**: `CLINICAL_SEMANTICS`
- **Cortex Search Service**: `CLINICAL_NOTES_CSS`
- **Agent** (UI object): `CLINICAL_ASSISTANT` (configured in Snowsight)

## Prerequisites
- Role: `ACCOUNTADMIN` (or equivalent privileges)
- Warehouse: `MED_WH` (or update the scripts to your warehouse)
- Snowflake features enabled in your account/region for Snowflake Intelligence (Cortex Analyst, Cortex Search)

## Deploy — order of execution
Open a Snowsight worksheet and run the files in this order:

1. **Create tables (current schema)**
   - Ensure context:  
     ```sql
     CREATE DATABASE IF NOT EXISTS MED_DEMO;
     CREATE SCHEMA IF NOT EXISTS MED_DEMO.CLINICAL;
     USE DATABASE MED_DEMO;
     USE SCHEMA CLINICAL;
     ```
   - Run:
     - `sql/01_patients_table.sql`
     - `sql/02_encounters_table.sql`
     - `sql/03_diagnoses_table.sql`   <!-- (rename from diagnises if needed) -->
     - `sql/04_labs_table.sql`
     - `sql/05_notes_table.sql`

2. **Seed demo data**
   - `sql/08_seed_data.sql`

3. **Create Semantic View (Cortex Analyst)**
   - `sql/06_semantic_view_clinical_semantics.sql`

4. **Create Cortex Search Service (NOTES)**
   - `sql/07_cortex_search_clinical_notes_css.sql`

5. **Verify**
   - `sql/09_verify_demo.sql`  
   Expect row counts: patients=5, encounters=6, diagnoses=6, labs=6, notes=5

## Recreate the Agent (UI)
1. Snowsight → **AI & ML → Agents** → **Create agent** → “Create this agent for Snowflake Intelligence”.
2. **Name**: `CLINICAL_ASSISTANT` (Display name is up to you)  
   **Warehouse**: `MED_WH`
3. **Tools**  
   - **Cortex Analyst** → Semantic view: `MED_DEMO.CLINICAL.CLINICAL_SEMANTICS`  
   - **Cortex Search** → Service: `MED_DEMO.CLINICAL.CLINICAL_NOTES_CSS`
4. **Instructions**
   - *Response instructions*: “Be concise. Use tables for tabular results. Show SQL when helpful.”
   - *Planning instructions*:  
     “Use Cortex Analyst for structured questions (patients/encounters/diagnoses/labs).  
      Use Cortex Search for free-text note lookups (mentions, phrases).”
5. **Access**: add your role (e.g., `ACCOUNTADMIN`).
6. Save.

## Sample questions
- “How many patients are there?”
- “Encounters by year”
- “Show diagnoses per encounter”
- “Search the notes for pneumonia”
- “Find notes about blood pressure for patient 1”
- “Show LDL results with dates”

## Regeneration / Export
If you customize the semantic view or search service, you can re-export:
```sql
-- Semantic view DDL
SELECT GET_DDL('SEMANTIC_VIEW','MED_DEMO.CLINICAL.CLINICAL_SEMANTICS');

-- Cortex Search service (assemble from SHOW)
SHOW CORTEX SEARCH SERVICES LIKE 'CLINICAL_NOTES_CSS';
WITH s AS (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())))
SELECT 'CREATE OR REPLACE CORTEX SEARCH SERVICE "'||s.database_name||'"."'||s.schema_name||'"."'||s.name||'" '||
       'ON '||s.search_column||' '||
       IFF(s.attribute_columns IS NULL OR s.attribute_columns='','', 'ATTRIBUTES '||s.attribute_columns||' ')||
       'WAREHOUSE = "'||s.warehouse||'" '||
       IFF(s.target_lag IS NULL OR s.target_lag='','', 'TARGET_LAG = '''||s.target_lag||''' ')||
       'AS '||s.definition||';' AS create_sql
FROM s;
