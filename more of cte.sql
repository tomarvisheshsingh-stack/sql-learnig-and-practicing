use hospital_db;

-- Question 1: Write a CTE to calculate average doctor salary and display doctors earning above average.
with c_1 as 
(select avg(salary) as avg_sal from doctors)
select doctor_name, salary from doctors join c_1 on salary > avg_sal;

-- Question 2: Write a CTE to count total appointments per doctor and display doctor_name with count.
with c_2 as 
(select doctor_id, count(appointment_id) as no_of_appointment from appointments group by doctor_id)
select d.doctor_id, doctor_name, no_of_appointment from doctors d join c_2 on d.doctor_id = c_2.doctor_id;

-- Question 3: Write a CTE to list all patients admitted in 2024 and select their names and admission_date.
with c_3 as
(select patient_id from  patients where admission_date like '2024%')
select patient_name, admission_date from patients p join  c_3 on
p.patient_id = c_3.patient_id;

-- Question 4: Write a CTE to get all 'Severe' diagnoses and display patient_name and diagnosis_description.
with c_4 as 
(select patient_id, diagnosis_description from diagnoses where severity = "Severe")
select patient_name, diagnosis_description from patients p join c_4 on c_4.patient_id = p.patient_id;

-- Question 5: Write a CTE to find total prescriptions per patient.
with c_5 as 
(select patient_id, count(prescription_id) as total_prescription from prescriptions group by patient_id)
select patient_name, total_prescription from patients natural join c_5;

-- Level 2
-- Question 1: Write a CTE to join doctors and departments and display doctor_name with department_name.
with c_6 as 
(select d.doctor_name, dp.department_name from doctors d join departments dp on dp.department_id = d.department_id)
select * from c_6;

-- Question 2: Write a CTE to join appointments, patients, and doctors to show appointment details.
with c_7 as
(select p.patient_name, d.doctor_name, a.* from patients p join appointments a on 
p.patient_id = a.patient_id join doctors d on a.doctor_id = d.doctor_id)
select * from c_7;

-- Question 3: Write a CTE to combine prescriptions and patients to show medication details.
with c_8 as
(select p.patient_name, pr.* from prescriptions pr join patients p on p.patient_id = pr.patient_id)
select * from c_8;

-- Question 4: Write a CTE to display bed occupancy with ward_name and patient_name.
with c_9 as 
(select p.patient_name, w.ward_name, b.bed_id from patients p join beds b on b.patient_id = p.patient_id join wards w on b.ward_id = w.ward_id where bed_status = 'occupied')
select * from c_9;

-- Question 5: Write a CTE to show diagnoses with doctor and patient names.
with c_10 as 
(select p.patient_name, d.doctor_name, da.diagnosis_description from doctors d join diagnoses da on d.doctor_id = da.doctor_id join patients p on p.patient_id = da.patient_id)
select * from c_10;

-- Level 3
-- Question 1: Write two CTEs: one for total appointments per doctor and another for average appointments, then compare.
with c1 as 
(select doctor_id, count(appointment_id) as total_appoint from appointments group by doctor_id),
c2 as (select avg(total_appoint) as avg_appoint from c1)
select d.doctor_name, total_appoint, avg_appoint from c1 cross join c2 join doctors d
on d.doctor_id = c1.doctor_id;

-- Question 2: Write two CTEs to separate active and inactive patients and display counts.
with c1 as 
(select count(patient_id)as active_patients from patients where status = 'active'),
c2 as (select count(patient_id) as inactive_patients from patients where status <> 'active')
select * from c1 cross join c2;

-- Question 3: Write multiple CTEs to calculate department-wise salary totals and averages.
with c1 as
(select department_id, sum(salary) as total_sal from doctors group by department_id),
c2 as (select department_id, avg(salary) as avg_sal from doctors group by department_id)
select department_name, total_sal, avg_sal from departments d join c1 on d.department_id = c1.department_id join c2 on d.department_id = c2.department_id;

-- Question 4: Write CTEs to split severe and moderate diagnoses and combine results.
with c1 as 
(select patient_id, diagnosis_description, severity from diagnoses where severity = 'Moderate'),
c2 as (select patient_id, diagnosis_description, severity from diagnoses where severity = 'Severe')
select * from c1 
union
select * from c2;

-- Question 5: Write chained CTEs to filter patients with more than 3 prescriptions.
with c1 as 
(select patient_id, count(prescription_id) as total_prescription from prescriptions group by patient_id),
c2 as (select p.patient_name, c1.total_prescription from patients p join c1 on p.patient_id = c1.patient_id where c1.total_prescription>3)
select * from c2;

-- Level 4
-- Question 1: Write a CTE to count total patients per department.
with c_1 as
(select d.department_id, count(distinct(a.patient_id)) as total_patients from appointments a join doctors d on d.doctor_id = a.doctor_id group by d.department_id)
select d.department_name, c_1.total_patients from c_1 join departments d on d.department_id = c_1.department_id;

-- Question 2: Write a CTE to calculate average blood pressure per patient.
with c_2 as
(select patient_id, avg(blood_pressure) as avg_bp from medical_records group by patient_id)
select * from c_2;

-- Question 3: Write a CTE to find top 3 doctors by appointment count.
with c_3 as
( select doctor_id, count(appointment_id) as total_apt from appointments group by doctor_id order by total_apt desc limit 3)
select d.doctor_name, c_3.total_apt from doctors d join c_3 on d.doctor_id = c_3.doctor_id;

-- Question 4: Write a CTE to calculate total occupied beds per ward.
with c_4 as 
(select ward_id, count(bed_id) as occupied_bed from beds where bed_status = 'occupied' group by ward_id)
select w.ward_name, c_4.occupied_bed from wards w join c_4 on w.ward_id = c_4.ward_id;

-- Question 5: Write a CTE to find departments with more than 10 doctors.
with c_5 as 
(select department_id, count(*) as Total_doctors from doctors group by department_id having total_doctors > 10)
select d.department_name, Total_doctors from departments d join c_5 on d.department_id = c_5.department_id;

-- Level 5
-- Question 2: Write a CTE to calculate doctor performance (total vs completed appointments).
with c1 as
(select doctor_id, count(*) as total_apt from appointments group by doctor_id),
c2 as (select doctor_id, count(*) as completed_apt from appointments where status = 'completed' group by doctor_id)
select c1.doctor_id, c1.total_apt, c2.completed_apt from c1 left join c2 on c1.doctor_id = c2.doctor_id;

-- Question 3: Write a CTE to identify high-risk patients (Severe diagnosis + high BP).
with c1 as
(select patient_id from medical_records where blood_pressure > 140),
c2 as (select patient_id from diagnoses where severity = 'Severe')
select distinct patient_name from c1 join c2 on c1.patient_id = c2.patient_id join patients p on p.patient_id = c1.patient_id;
