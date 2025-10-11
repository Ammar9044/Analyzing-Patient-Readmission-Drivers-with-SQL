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

<img width="524" height="487" alt="Case Statement " src="https://github.com/user-attachments/assets/c2475fc4-26f5-4887-928d-c703aad345d3" />

<img width="623" height="419" alt="Cleaned_Cte" src="https://github.com/user-attachments/assets/285be722-52f5-469a-80f5-601e0909b619" />

To prepare the dataset for analysis, I used a Common Table Expression (CTE) to create a temporary, cleaned-up version of the patient data. Within this CTE, I engineered two new features using CASE statements to make the data more useful. First, I created an early_readmit_flag which assigns a 1 to patients readmitted within 30 days and a 0 to all others, turning a text field into a numeric flag for easier calculations. Second, I created a stay_duration_bucket to categorize the length of each patient's hospital stay into meaningful groups like 'Short Stay', 'Moderate Stay', and 'Extended Stay'. This process of transforming and organizing the data is a crucial first step that enables more effective and straightforward analysis of key patient attributes.

<img width="464" height="517" alt="222" src="https://github.com/user-attachments/assets/06178ca5-40ed-4a81-a93d-2139a5c5b165" />

<img width="502" height="241" alt="222 result" src="https://github.com/user-attachments/assets/fa135825-9954-436d-9436-e13aee584cd7" />


In this query, I aimed to identify the top 10 patient groups with the highest risk of early readmission. To achieve this, I first created a demographic_group by combining age, gender, and race, allowing for detailed segmentation. Using this new group, I calculated the total number of patients, their average hospital stay, and the early readmission rate for each primary diagnosis. To ensure the results were statistically significant, I used a HAVING clause to filter for only those groups with 50 or more patients. The final output, ordered from highest to lowest readmission rate, pinpoints the specific patient segments and diagnoses that require the most attention, such as Caucasian females aged 20-30 with a primary diagnosis of diabetes (250.13), who have a readmission rate of nearly 39%.

