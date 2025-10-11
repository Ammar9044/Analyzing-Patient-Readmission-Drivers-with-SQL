# Analyzing Patient Readmission Drivers with SQL
The Revolving Door: An Analysis of Hospital Readmissions

---

## About the Dataset & Tools
This project uses a publicly available dataset from Kaggle (find it here), containing 10 years of hospital encounter data (1999–2008) from 130 U.S. hospitals. It includes over 100,000 anonymized records of patients with diabetes, capturing demographics, lab results, medications, length of stay, and outcomes. The dataset’s main goal is to support analysis around early hospital readmission (defined as readmission within 30 days of discharge), a critical issue in diabetes care. With its depth and scale, the dataset offers valuable opportunities to explore patterns in care delivery and patient outcomes.

---

## Key Questions: An SQL-Driven Inquiry
1. Readmission Analysis by Demographics
- Which patient age groups and genders are most frequently readmitted?
- How do readmission rates compare across different patient races?

2. Impact of Medication on Readmission
   
- How does the number of medications a patient is prescribed correlate with their readmission risk?
- Are patients taking specific medications, such as insulin, more likely to be readmitted?

3. Hospital Stay and Readmission Relationship
   
- How does the length of a patient's hospital stay relate to their likelihood of being readmitted?
- Do patients admitted through the emergency room have a higher readmission rate than those with elective admissions?

  ---

## Data Preparation
Before analysis, I used SQL (via MySQL Workbench) to clean and reshape the dataset. This was especially helpful for:

- Fixing Column Types: Some numeric fields like time_in_hospital were stored as text (VARCHAR). I used the ALTER TABLE function to convert them to INT so they could be used in calculations.
- Performing Table Joins: I merged patient demographics and hospital stay details using a common patient ID to create a unified dataset.
- Creating New Columns: I created new variables that flagged early readmissions, grouped patients by stay duration, and combined demographic attributes into a single label. These additions helped simplify comparisons and surface trends across different patient groups.
- Creating CTE's: To keep my SQL logic organized and readable, I used Common Table Expressions (CTEs) to structure intermediate steps like filtering, flag creation, and ranking.

  ---

# Stories the Data Uncovered



