.
--1Q. What is the overall distribution of patients across the readmission groups (<30 days, >30 days, and no readmission)?
select readmitted,
count(*) as patient_count,
round(count(*) * 100.0 / sum(count(*)) over (),2) as percentage
from diabetic_data
group by readmitted;


--2Q.Which age groups have the highest 30-day readmission rates?
select age,
count(*) as total_patients,
sum(case when readmission_30_days = 1 then 1
else 0
end) as readmitted_patients,round(avg(cast(readmission_30_days as float)) * 100,2) as readmission_rate
from diabetic_data
group by age
order by readmission_rate desc;

--3Q.Does a longer hospital stay (time_in_hospital) increase the likelihood of 30-day readmission?
 select
time_in_hospital,
count(*) as total_patients,
round(avg(cast(readmission_30_days as float)) * 100,2) as readmission_rate
from diabetic_data
group by time_in_hospital
order by time_in_hospital;

--4Q.How do prior inpatient, outpatient, and emergency visits relate to readmission risk?
select
readmitted,
round(avg(number_inpatient), 2) as avg_inpatient_visits,
round(avg(number_outpatient), 2) as avg_outpatient_visits,
round(avg(number_emergency), 2) as avg_emergency_visits,
round(avg(total_prior_visits), 2) as avg_total_prior_visits
from diabetic_data
group by readmitted;

--5Q.Which admission types have the highest 30-day readmission rates?
select
admission_type_id,
count(*) as total_patients,
round(avg(cast(readmission_30_days as float)) * 100,2) as readmission_rate
from diabetic_data
group by admission_type_id
order by readmission_rate desc;

--6Q.Does discharge disposition influence the likelihood of readmission?
select
discharge_disposition_id,
count(*) as total_patients,
round(avg(cast(readmission_30_days as float)) * 100,2) as readmission_rate
from diabetic_data
group by discharge_disposition_id
order by readmission_rate desc;

--7Q.Is a higher number of medications associated with an increased risk of 30-day readmission?
select
num_medications,
count(*) as total_patients,
round(avg(cast(readmission_30_days as float)) * 100,2) as readmission_rate
from diabetic_data
group by num_medications
order by num_medications;

--8Q.Do patients with a greater number of diagnoses experience higher 30-day readmission rates?s
select
number_diagnoses,
count(*) as total_patients,
round(avg(cast(readmission_30_days as float)) * 100,2) as readmission_rate
from diabetic_data
group by number_diagnoses
order by number_diagnoses;