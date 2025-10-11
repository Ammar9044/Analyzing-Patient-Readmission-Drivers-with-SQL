# Analyzing Patient Readmission Drivers with SQL
The Revolving Door: An Analysis of Hospital Readmissions

---

## About the Dataset & Tools
This project uses a publicly available dataset from Kaggle (find it here), containing 10 years of hospital encounter data (1999–2008) from 130 U.S. hospitals. It includes over 100,000 anonymized records of patients with diabetes, capturing demographics, lab results, medications, length of stay, and outcomes. The dataset’s main goal is to support analysis around early hospital readmission (defined as readmission within 30 days of discharge), a critical issue in diabetes care. With its depth and scale, the dataset offers valuable opportunities to explore patterns in care delivery and patient outcomes.

---

## Key Questions: An SQL-Driven Inquiry

1) Which patient age groups and genders are most frequently readmitted?

1) How do readmission rates compare across different patient races?

3) Impact of Medication on Readmission
   
4) How does the number of medications a patient is prescribed correlate with their readmission risk?

5) How does the length of a patient's hospital stay relate to their likelihood of being readmitted?

6) Which primary diagnoses dominate each age group? 

---

## Data Preparation
Before analysis, I used SQL (via MySQL Workbench) to clean and reshape the dataset. This was especially helpful for:

- Fixing Column Types: Some numeric fields like time_in_hospital were stored as text (VARCHAR). I used the ALTER TABLE function to convert them to INT so they could be used in calculations.
- Performing Table Joins: I merged patient demographics and hospital stay details using a common patient ID to create a unified dataset.
- Creating New Columns: I created new variables that flagged early readmissions, grouped patients by stay duration, and combined demographic attributes into a single label. These additions helped simplify comparisons and surface trends across different patient groups.
- Creating CTE's: To keep my SQL logic organized and readable, I used Common Table Expressions (CTEs) to structure intermediate steps like filtering, flag creation, and ranking.

  ---

# Stories the Data Uncovered

## Understanding Vulnerability and Which Patients Face the Most Risk

<img width="524" height="487" alt="Case Statement " src="https://github.com/user-attachments/assets/c2475fc4-26f5-4887-928d-c703aad345d3" />

<img width="623" height="419" alt="Cleaned_Cte" src="https://github.com/user-attachments/assets/285be722-52f5-469a-80f5-601e0909b619" />

To prepare the dataset for analysis, I used a Common Table Expression (CTE) to create a temporary, cleaned-up version of the patient data. Within this CTE, I engineered two new features using CASE statements to make the data more useful. First, I created an early_readmit_flag which assigns a 1 to patients readmitted within 30 days and a 0 to all others, turning a text field into a numeric flag for easier calculations. Second, I created a stay_duration_bucket to categorize the length of each patient's hospital stay into meaningful groups like 'Short Stay', 'Moderate Stay', and 'Extended Stay'. This process of transforming and organizing the data is a crucial first step that enables more effective and straightforward analysis of key patient attributes.

<img width="464" height="517" alt="222" src="https://github.com/user-attachments/assets/06178ca5-40ed-4a81-a93d-2139a5c5b165" />

<img width="502" height="241" alt="222 result" src="https://github.com/user-attachments/assets/fa135825-9954-436d-9436-e13aee584cd7" />


In this query, I aimed to identify the top 10 patient groups with the highest risk of early readmission. To achieve this, I first created a demographic_group by combining age, gender, and race, allowing for detailed segmentation. Using this new group, I calculated the total number of patients, their average hospital stay, and the early readmission rate for each primary diagnosis. To ensure the results were statistically significant, I used a HAVING clause to filter for only those groups with 50 or more patients. The final output, ordered from highest to lowest readmission rate, pinpoints the specific patient segments and diagnoses that require the most attention, such as Caucasian females aged 20-30 with a primary diagnosis of diabetes (250.13), who have a readmission rate of nearly 39%.

# Key Findings
- Younger and middle-aged women are at higher risk. Patients recorded as female between the ages of 30 and 50, particularly those identified as Caucasian or African American, had the highest early readmission rates. While the average length of hospital stay across all patients was 4.4 days, some of these higher-risk groups were discharged sooner, with 4 out of the top 10 groups falling below the average. This raises important questions about early discharge practices or gaps in post-discharge support for certain patient populations.
- 8 of the 10 highest-risk groups were women While this doesn’t prove causation, it aligns with broader evidence that women’s health concerns may sometimes be under-recognized or undertreated. This raises important questions about how symptoms are evaluated, how care plans are designed, and whether follow-up care adequately supports female patients.
- Older patients showed moderate risk Although older adults (60+) weren’t predominant in the top 10 list, they still showed meaningful early readmission rates, suggesting age-related differences in care strategies also deserve attention.

💙 Care Opportunity: Given that 8 of the 10 highest-risk groups were women, targeted interventions may help reduce early readmissions. 

Examples include:

Enhanced discharge counseling
Proactive follow-up within the first 1–2 weeks
Remote monitoring or check-in programs for high-risk groups

## Patient Groups with the Longest Average Length of Stay

<img width="478" height="225" alt="Len" src="https://github.com/user-attachments/assets/b1541168-f308-45b4-a052-b2934b87ec87" />

Older adults are overrepresented among patients with the longest hospital stays. The top 10 groups with the highest average length of stay were primarily patients aged 60 and above, suggesting that aging populations face more complex and prolonged care journeys. Rehabilitative care plays a central role. A majority of these groups shared diagnosis code V57, typically associated with rehabilitation services. This indicates that long stays are often linked not just to acute illness, but to recovery and transitional care needs. This query investigates the demographic and diagnostic factors associated with the longest hospital stays. By grouping patients based on their demographic profile and primary diagnosis, the analysis calculates the total patient count, the average length of stay, and the early readmission rate for each distinct group. The results are then sorted in descending order by the average stay duration. The output clearly identifies the specific patient segments, such as Caucasian females between 80-90 years old with a primary diagnosis code of 'V57', that experience the lengthiest hospitalizations. This insight is valuable for resource planning and for identifying patient groups that might benefit from specialized care protocols aimed at reducing their time in the hospital.

## Recognizing Ongoing Struggles After Discharge

<img width="470" height="384" alt="repeat" src="https://github.com/user-attachments/assets/2fe83aa2-8513-4140-8e74-a4f78602ee5d" />

<img width="325" height="113" alt="rrr" src="https://github.com/user-attachments/assets/f756425d-64e4-422d-b868-f2183ab9038c" />

This query was designed to determine if a patient’s prior admission history is a strong predictor of early readmission. I created a repeat_flag to segment patients into two groups: 'Single Admission' for those with no prior inpatient visits and 'Repeat Visitor' for those with at least one. After grouping the data, I calculated the early readmission rate for each category. The results are compelling: 'Repeat Visitors' have an early readmission rate of 21.40%, which is more than double the 9.44% rate for patients admitted for the first time. This analysis clearly demonstrates that a patient's history as a repeat visitor is a significant risk factor for being readmitted within 30 days.

## Medications and Readmission Trend


<img width="298" height="199" alt="med 1" src="https://github.com/user-attachments/assets/a5c3b0b5-ad99-46cb-84c6-285ca7e3afd8" />

<img width="232" height="294" alt="med" src="https://github.com/user-attachments/assets/359aa5c6-26df-4ba8-8166-7e923698bc7d" />

This query explores the relationship between the number of medications prescribed to a patient and their likelihood of an early readmission. By grouping patients based on the total count of medications they received, I calculated the average early readmission rate for each distinct count. The results, ordered from highest to lowest rate, reveal a compelling trend. Patients on an extremely high number of medications (such as 72 or 81) have a disproportionately high readmission rate, in some cases reaching 100%. This suggests that the complexity of a patient's medication regimen is a critical risk factor, and patients with a high number of prescriptions may require more intensive follow-up care to prevent readmission.

## How Diabetes Diagnosis Codes Reveal Age-Specific Challenges


<img width="283" height="388" alt="type" src="https://github.com/user-attachments/assets/634a76b9-4f7d-4237-b782-747092cd7522" />

<img width="298" height="302" alt="type 1" src="https://github.com/user-attachments/assets/c592341b-705b-4322-b500-3521e8c63108" />

To understand which health issues are most prevalent across different stages of life, I wrote an advanced SQL query to identify the top three primary diagnoses for each age group. This was a multi-step process: first, I used a Common Table Expression (CTE) to count the frequency of each diagnosis within every age bracket. Then, in a second CTE, I utilized the RANK() window function to assign a rank to each diagnosis based on its frequency, partitioning the data by age so the ranking would restart for each new age group. The final query filters these results to display only the top three ranked diagnoses for each age bracket. This analysis reveals important patterns, such as the prevalence of specific diabetes-related codes (like 250.13 and 250.11) among younger patients, while different conditions become more common in older populations.

## Key Findings and Suggestions (Ending Notes)

- Certain groups of people, like young women with diabetes, are much more likely to return to the hospital.
 Idea: We should give these specific high-risk groups extra help and a special care plan after they leave.

- A person's race isn't the main reason they come back; it's more about the common health problems in their community.
 Idea: We should focus on treating the specific illnesses that are common, no matter who the patient is.

- The more medicines a person takes, the more likely they are to be readmitted to the hospital.
 Idea: A pharmacist should double-check the medicines for anyone taking a lot of them to make their routine simpler and safer.

- A long hospital stay doesn't automatically mean a patient will come back. It usually just means they were very sick in the first place.
 Idea: If a patient has a long stay, we should be extra careful when planning their care for when they go home.

- Younger patients most often have diabetes, while older patients usually have heart or breathing problems.
 Idea: We should create easy-to-understand guides for different age groups about their most common health issues.

---



