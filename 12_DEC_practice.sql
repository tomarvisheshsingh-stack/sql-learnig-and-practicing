use hospital_db;

-- 1
select doctor_name, specialization, salary from doctors
where status = 'active';

-- 2
select * from patients 
where admission_date >= "2024-01-01" 
and admission_date < "2024-02-01";

-- 3 
select ward_name, total_beds from wards 
where department_id = 1;

-- 4
select appointment_id, appointment_date, status 
from appointments where status = 'completed';

-- 5  
select medication_name, dosage, frequency
from prescriptions where status = "active";

-- 6
select doctor_name, specialization, years_experience 
from doctors where department_id = 1 and 
years_experience > 10;

-- 7
select patient_name, city, admission_date from patients
where status = "active" and city = "new york";

select * from medical_records;
-- 8
select patient_id, visit_date, blood_pressure 
from medical_records where blood_pressure > 140 
and visit_date > "2024&";

-- 9
select diagnosis_description, severity, diagnosis_date 
from diagnoses where severity = "severe"
and diagnosis_date >= "2024-02-01" 
and diagnosis_date < "2024-03-01";

-- 10
select appointment_id, appointment_date, department_id 
from appointments where status = 'scheduled' 
and department_id = 1;

-- 11
select bed_number, patient_id, expected_discharge 
from beds where bed_status = "occupied" 
and expected_discharge >= "2024-03-01" and
expected_discharge < "2024-04-01";

-- 12
select doctor_name, salary, hire_date from doctors
where salary > 170000 and hire_date > "2010-12-31";

-- 13
update appointments set status = "confirmed" 
where status = "pending";

set sql_safe_updates = 0;

-- 14
update wards set available_beds = available_beds + 2 
where department_id = 1;

-- 15
update patients set status = "discharged" 
where patient_id = 3;

-- 16
update doctors set salary = salary * 0.95
where hire_date < "2008-01-01";

-- 17
update beds set bed_status = "maintenance" 
where bed_status = "available";

-- 18
update prescriptions set status = "expired" 
where expiry_date < current_date();

-- 19
update prescriptions set duration_days = duration_days + 7
where status = 'active' and prescription_date >= "2024-01-01"
and prescription_date < "2024-02-01";

-- 20
update diagnoses set status = 'released' where
severity = 'mild' and status = 'active';

-- 21
update doctors set salary = 195000 where department_id = 1
and years_experience > 10;

-- 22
update beds set bed_status = "maintenance" where 
ward_id in (1,2) and bed_status = "available";

-- 23
update appointments set status = 'confirmed' 
where status = 'scheduled' and doctor_id in (1, 2, 3) 
and appointment_date >= "2024-04-01"
and appointment_date < "2024-05-01";

-- 24
update prescriptions set expiry_date = expiry_date + 30 where 
status = 'active' and patient_id >= 15 
and medication_name like "Lisinopril";