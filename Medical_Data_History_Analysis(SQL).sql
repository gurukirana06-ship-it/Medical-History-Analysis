use project_medical_history;
show tables;
select * from patients;
select * from admissions;
select * from doctors;
select * from province_names;

-- 1
 select first_name,last_name,gender
 from patients
 where gender='M';
 
 -- 2
 select first_name,last_name,allergies
 from patients
 where allergies is null;
 
 -- 3
 select first_name 
 from patients
 where first_name like 'C%';
 
 -- 4
 select first_name,last_name,weight
 from patients 
 where weight between 100 and 120;
 
 set sql_safe_updates=0;
 
 -- 5
 update patients
 set allergies = 'NKA'
 where allergies is null;
 
 select * from patients;
 
 -- 6
 select concat(first_name,' ',last_name)
 as full_name
 from patients;
 
 -- 7
 select p.first_name,p.last_name,n.province_name
 from patients p join province_names n
 on p.province_id=n.province_id;
 
 -- 8
 select count(*)
 from patients
 where year(birth_date)=2010;
 
 select * from patients;
 -- 9
SELECT first_name,last_name,height
FROM patients
WHERE height =(SELECT MAX(height)
    FROM patients);

 
 -- 10
 
 select * from patients
 where patient_id in (1,45,534,879,1000);
 
 select * from admissions;
 -- 11
select count(*) as Total_admissions
from admissions; 

-- 12
select * from admissions
where admission_date=discharge_date;

-- 13
select count(*)
from admissions
where patient_id=579;

-- 14
select distinct(city) as city_in_NS
from patients
where province_id ='NS';
 
-- 15
select first_name,last_name,birth_date
from  patients
where weight>= 70 and height >=160;

-- 16
select distinct(year(birth_date))
as unique_birthyear_acending
from patients
order by year(birth_date);

-- 17
select first_name
from patients
group by first_name
having count(*)=1;

-- 18 
select patient_id,first_name 
from patients
where first_name like'S%s'
and length(first_name)>=6;

select * from patients;
select * from admissions;
 
 -- 19
 select p.patient_id,p.first_name,p.last_name
 from patients p join admissions a
 on p.patient_id=a.patient_id
 where a.diagnosis='Dementia';
 
 -- 20
 select first_name from patients
 order by length(first_name),first_name;
 
 -- 21,22
 
 select count(gender) as male_patients,
 (select count(gender) from patients
 where gender='F')as female_patients
 from patients
 where gender='M';
 
-- 23
select patient_id,diagnosis
from admissions
group by patient_id,diagnosis
having count(*)>1;

-- 24
select city,count(distinct(patient_id))
as number_of_patients from patients
group by city
order by number_of_patients desc,city;

-- 25
select first_name,last_name,'patient'
as role from patients
union
select first_name,last_name,'doctor'
as role from doctors;

-- 26
select allergies,count(patient_id)
number_of_patients
from patients
where allergies <> 'NKA'
group by allergies
order by count(patient_id) desc;

-- 27
select first_name,last_name,birth_date
from patients
where year(birth_date) like '197%'
order by birth_date;

-- 28
select concat(ucase(last_name),',',lcase(first_name))
as full_name
from patients
order by first_name desc; 

-- 29
select province_id,sum(height)
as sum_of_height from patients
group by province_id
having sum(height)>=7000;

-- 30
select max(weight) -min(weight)
as weight_diff
from patients
where last_name='Maroni';

-- 31
select day(admission_date) as day_month,
count(*) as number_of_admissions
from admissions
group by day(admission_date)
order by count(*) desc;

 -- 32
select max(weight),min(weight)
from patients;
 -- weight group 0,10,20.....,140
 select floor(weight/10)*10
 as weight_group,count(patient_id)
 as number_of_patients from patients
 group by weight_group
 order by count(patient_id) desc;
 
 -- 33
 select patient_id,weight,height,
 case
 when weight/power(height/100,2)>= 30
 then 1
 else 0
 end as is_obese
 from patients;
 
 
 select * from patients;
 select * from admissions;
 select * from doctors;
 
 alter table admissions
 rename column attending_doctor_id
 to doctor_id;
 
 -- 34
 select p.patient_id,p.first_name,p.last_name,d.specialty
 from patients p
 join admissions a
 on p.patient_id=a.patient_id
 join doctors d
 on a.doctor_id=d.doctor_id
 where a.diagnosis='Epilepsy'
 and d.first_name='Lisa';
 
 