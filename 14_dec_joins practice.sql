-- Joins practice
use hospital_db;

-- 1
select d.doctor_name, d.specialization, dp.department_name 
from doctors d inner join departments dp on 
d.department_id = dp.department_id;

-- 2
select p.patient_name, a.appointment_date from patients p
inner join appointments a on p.patient_id = a.patient_id 
inner join doctors d on d.doctor_id = a.doctor_id; 

-- 3
select pr.medication_name, pr.dosage, p.patient_name
from patients p inner join prescriptions pr on
p.patient_id = pr.patient_id;

-- 4
select w.ward_name, b.bed_number, p.patient_name from patients p
inner join beds b on b.patient_id = p.patient_id inner join
wards w on b.ward_id = b.bed_id;

-- 5
select di.diagnosis_description, d.doctor_name, p.patient_name 
from diagnoses di inner join doctors d on d.doctor_id = di.doctor_id
inner join patients p on p.patient_id = di.patient_id;

-- 6
select d.doctor_name, p.patient_name, a.appointment_date, 
a.appointment_type from appointments a inner join patients p 
on p.patient_id = a.patient_id inner join doctors d on
a.doctor_id = d.doctor_id where d.department_id = 1;

-- 7
select di.diagnosis_description, d.doctor_name, p.patient_name 
from diagnoses di inner join doctors d on d.doctor_id = di.doctor_id
inner join patients p on p.patient_id = di.patient_id 
where severity = 'severe';

-- 8
select d.doctor_name, p.patient_name, a.appointment_date 
from appointments a inner join patients p 
on p.patient_id = a.patient_id inner join doctors d on
a.doctor_id = d.doctor_id inner join departments dt on
d.department_id = dt.department_id
where d.department_id = 2 and d.status = 'active';

-- 9
select p.patient_name, pr.medication_name, pr.dosage from patients p 
inner join prescriptions pr on p.patient_id = pr.patient_id 
where p.city = "New York";

-- 10
select p.patient_name, m.visit_date, m.blood_pressure from patients p
inner join medical_records m on m.patient_id = p.patient_id 
where m.blood_pressure > 140;

-- 11
select d.doctor_name, p.patient_name, a.appointment_date from patients p
inner join appointments a on a.patient_id = p.patient_id inner join 
doctors d on a.doctor_id = d.doctor_id where a.status = "Completed";

-- 12
select w.ward_name, b.bed_number, p.patient_name from patients p 
inner join beds b on p.patient_id = b.patient_id inner join 
wards w on w.ward_id = b.ward_id inner join departments d 
on w.department_id = d.department_id where d.department_id = 1;