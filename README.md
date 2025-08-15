# Clinical_Assistant_with_Snowflake

This project provisions demo clinical data and an LLM-powered agent that:
- Answers structured questions via **Cortex Analyst** (semantic view)
- Searches free-text clinical notes via **Cortex Search**
- Orchestrates both through a **Snowflake Agent**

## Objects
- DB: `MED_DEMO`, Schema: `CLINICAL`
- Tables: `PATIENTS, ENCOUNTERS, DIAGNOSES, LABS, NOTES`
- Semantic View: `MED_DEMO.CLINICAL.CLINICAL_SEMANTICS`
- Cortex Search Service: `MED_DEMO.CLINICAL.CLINICAL_NOTES_CSS`
- Agent: `CLINICAL_ASSISTANT` (documented in `agents/clinical_assistant.yaml`)

## How to deploy (order)
1. Run `sql/01_setup_schema_and_tables.sql`
2. Run `sql/02_reload_encounters_labs.sql`
3. Create semantic/search objects:
   - `sql/03_semantic_view_clinical_semantics.sql`
   - `sql/04_cortex_search_clinical_notes_css.sql`
4. Recreate the Agent via Snowsight UI using `agents/clinical_assistant.yaml` as a guide.
5. Verify with `sql/10_sample_queries.sql`
