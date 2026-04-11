use hospital_db;

-- 1. Assign a row number to each appointment for every doctor ordered by appointment date.
select appointment_id, doctor_id, appointment_date, 
	   row_number() over (partition by doctor_id order by appointment_date) as row_num
from appointments;

-- 2. Rank doctors based on the total number of appointments they have handled.
select distinct doctor_id, 
	count(appointment_id) over (partition by doctor_id) as no_of_appointments
from appointments order by no_of_appointments desc;

-- chatgpt's recommendation
select doctor_id, count(*) as total_appointment,
	rank() over (order by count(*) desc) as doctor_rank
from appointments group by doctor_id;

-- 3. Find the dense rank of patients based on the number of appointments they have booked.
select patient_id, count(*) as total_appointment,
	dense_rank() over (order by count(*) desc) as patient_rank
from appointments group by patient_id;

-- 4. Calculate the running total of appointments for each doctor ordered by appointment date
select doctor_id, appointment_date, sum(1) over 
(partition by doctor_id order by appointment_date asc 
rows between unbounded preceding and current row) as no_of_appointments
from appointments;

-- 5. Find the cumulative count of completed appointments for each doctor.
select doctor_id, appointment_date, 
sum(case when status = 'completed' then 1
			else 0 end) over 
(partition by doctor_id order by appointment_date asc 
rows between unbounded preceding and current row) as no_of_appointments
from appointments;

-- 6. Calculate the moving average of appointments (last 3 appointments) for each doctor.
select *,
	count(*) over (partition by doctor_id order by appointment_date 
					rows between 2 preceding and current row) as `avg appoint`
from appointments;

-- 7. Find the difference in days between consecutive appointments for each patient.
select *,
	datediff(appointment_date, lag(appointment_date) over 
    (partition by patient_id order by appointment_date))
as difference
from appointments;

-- 8. Identify the first appointment date for each patient using window functions.
select distinct patient_id,
	min(appointment_date) over (partition by patient_id) as `first appointment`
from appointments;

SELECT 
    patient_id,
    appointment_date AS first_appointment
FROM (
    SELECT 
        patient_id,
        appointment_date,
        ROW_NUMBER() OVER (
            PARTITION BY patient_id 
            ORDER BY appointment_date
        ) AS rn
    FROM appointments
) t
WHERE rn = 1;

-- 9. Identify the last appointment date for each doctor using window functions.
select distinct doctor_id,
	max(appointment_date) over (partition by doctor_id) as `last_appointment`
from appointments;