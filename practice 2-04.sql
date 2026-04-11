use hospital_db;

-- **Question 1:** Write a SELECT query to display all doctors who are currently 'active' and show their doctor_name, specialization, and salary.
select doctor_name, specialization, salary from doctors where status = 'active';

-- **Question 2:** Write a SELECT query to find all patients admitted to the hospital in January 2024 (admission_date >= '2024-01-01' AND admission_date < '2024-02-01').
select * from patients where admission_date between '2024-02-01' and '2024-02-01';

-- **Question 3:** Write a SELECT query to show all wards in the 'Cardiology' department (department_id = 1) and display ward_name and total_beds.
select w.ward_name, w.total_beds from wards w join departments d on w.department_id = d.department_id where d.department_name = 'Cardiology';

-- **Question 4:** Write a SELECT query to display all appointments with status 'completed' and show appointment_id, appointment_date, and status.
select appointment_id, appointment_date, status from appointments where status = 'completed';

-- **Question 5:** Write a SELECT query to find all prescriptions that are currently 'active' and show medication_name, dosage, and frequency.
select medication_name, dosage, frequency from prescriptions where status = 'active';

-- **Question 8:** Write a SELECT query to find all medical records where blood_pressure indicates hypertension (systolic > 140) AND the visit was in 2024. Display patient_id, visit_date, and blood_pressure.
select patient_id, visit_date, blood_pressure from medical_records where blood_pressure > 140 and visit_date like "2024-%";

-- **Question 9:** Write a SELECT query to find all diagnoses with 'Severe' severity AND from February 2024 (diagnosis_date >= '2024-02-01' AND diagnosis_date < '2024-03-01'). Show diagnosis_description, severity, and diagnosis_date
select diagnosis_description, severity, diagnosis_date from diagnoses where severity = 'Severe' and diagnosis_date between '2024-02-01' and '2024-03-01';

