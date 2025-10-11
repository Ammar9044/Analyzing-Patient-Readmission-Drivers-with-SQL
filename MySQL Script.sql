
Create database diabetics;
use diabetics;

CREATE TABLE diabetics_readmission (
    encounter_id BIGINT PRIMARY KEY,
    patient_nbr BIGINT,
    race VARCHAR(50),
    gender VARCHAR(10),
    age VARCHAR(20),
    weight VARCHAR(20),
    admission_type_id INT,
    discharge_disposition_id INT,
    admission_source_id INT,
    time_in_hospital INT,
    payer_code VARCHAR(10),
    medical_specialty VARCHAR(100),
    num_lab_procedures INT,
    num_procedures INT,
    num_medications INT,
    number_outpatient INT,
    number_emergency INT,
    number_inpatient INT,
    diag_1 VARCHAR(10),
    diag_2 VARCHAR(10),
    diag_3 VARCHAR(10),
    number_diagnoses INT,
    max_glu_serum VARCHAR(20),
    A1Cresult VARCHAR(20),
    metformin VARCHAR(20),
    repaglinide VARCHAR(20),
    nateglinide VARCHAR(20),
    chlorpropamide VARCHAR(20),
    glimepiride VARCHAR(20),
    acetohexamide VARCHAR(20),
    glipizide VARCHAR(20),
    glyburide VARCHAR(20),
    tolbutamide VARCHAR(20),
    pioglitazone VARCHAR(20),
    rosiglitazone VARCHAR(20),
    acarbose VARCHAR(20),
    miglitol VARCHAR(20),
    troglitazone VARCHAR(20),
    tolazamide VARCHAR(20),
    examide VARCHAR(20),
    citoglipton VARCHAR(20),
    insulin VARCHAR(20),
    glyburide_metformin VARCHAR(20),
    glipizide_metformin VARCHAR(20),
    glimepiride_pioglitazone VARCHAR(20),
    metformin_rosiglitazone VARCHAR(20),
    metformin_pioglitazone VARCHAR(20),
    `change` VARCHAR(10),
    diabetesMed VARCHAR(10),
    readmitted VARCHAR(10)
);

Select * from diabetics_readmission 
limit 50;

Select min(time_in_hospital) as min_time ,max(time_in_hospital) as max_time 
from diabetics_readmission;



-- Stay Duration Buckets --

WITH cleaned_patient_data AS (
    SELECT
        age,
        gender,
        race,
        readmitted,
        CASE
            WHEN readmitted = '<30' THEN 1
            ELSE 0
        END AS early_readmit_flag,
        diag_1,
        time_in_hospital,
        CASE
            WHEN time_in_hospital BETWEEN 1 AND 3 THEN "Short_Stay" 
			WHEN time_in_hospital BETWEEN 4 AND 7 THEN "Moderate_Stay" 
			WHEN time_in_hospital >= 8 THEN "Extended_Stay" 
            End as stay_duration_bucket
    FROM
        diabetics_readmission
)
SELECT * FROM
    cleaned_patient_data
ORDER BY
    age;
    
    WITH cleaned_patient_data AS (
    SELECT
        age,
        gender,
        race,
        readmitted,
        concat( age, '|', gender, '|', race ) as demographic_group, 
        CASE
            WHEN readmitted = '<30' THEN 1
            ELSE 0
        END AS early_readmit_flag,
        diag_1,
        time_in_hospital,
        CASE
            WHEN time_in_hospital BETWEEN 1 AND 3 THEN "Short_Stay" 
			WHEN time_in_hospital BETWEEN 4 AND 7 THEN "Moderate_Stay" 
			WHEN time_in_hospital >= 8 THEN "Extended_Stay" 
            End as stay_duration_bucket
    FROM
        diabetics_readmission
)
SELECT demographic_group,
       diag_1,
       Count(*) as patien_count, 
       Round(avg(time_in_hospital), 2) as Avg_stay,
       Round(avg(early_readmit_flag) * 100, 2) as early_readmit_rate
from     
    cleaned_patient_data
Group by 
demographic_group, diag_1 
Having Count(*) >=50
Order by early_readmit_rate desc 
limit 10;

WITH cleaned_patient_data AS (
  SELECT
    patient_nbr,
    encounter_id,
    number_inpatient,
    CASE
      WHEN number_inpatient > 1 THEN 'Repeat Visitor'
      ELSE 'Single Admission'
    END AS repeat_flag,
    readmitted,
    CASE
      WHEN readmitted = '<30' THEN 1
      ELSE 0
    END AS early_readmit_flag
  FROM
    diabetics_readmission
)
SELECT
  repeat_flag,
  COUNT(*) AS patient_count,
  ROUND(AVG(early_readmit_flag) * 100, 2) AS early_readmit_rate
FROM
  cleaned_patient_data
GROUP BY
  repeat_flag;
  
Select 
num_medications,
    Round(AVG(CASE
      WHEN readmitted = '<30' THEN 1
      ELSE 0
    END) * 100,2) AS early_readmit_rate
from diabetics_readmission
group by num_medications
Order by  early_readmit_rate desc;

Select 
number_emergency,
    Round(AVG(CASE
      WHEN readmitted = '<30' THEN 1
      ELSE 0
    END) * 100,2) AS early_readmit_rate
from diabetics_readmission
group by  number_emergency
Order by  early_readmit_rate desc;

WITH diagnosis_counts AS (
  SELECT age, diag_1,
    COUNT(*) AS diagnosis_freq
  FROM diabetics_readmission
  GROUP BY age,
    diag_1 ),
ranked_diagnoses AS (
  SELECT age, diag_1, diagnosis_freq,
    RANK() OVER (
      PARTITION BY age
      ORDER BY
        diagnosis_freq DESC
    ) AS diagnosis_rank
  FROM diagnosis_counts )
SELECT *
FROM  ranked_diagnoses
WHERE diagnosis_rank <= 3
ORDER BY age, diagnosis_rank;

    
  
  

    
    
    
    
    




    
  
  

    
    
    



