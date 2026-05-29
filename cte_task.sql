use cse;
CREATE TABLE students (
   student_id INT PRIMARY KEY,
   student_name VARCHAR(50),
   course VARCHAR(50),
   city VARCHAR(50),
   fees INT
);
CREATE TABLE trainers (
   trainer_id INT PRIMARY KEY,
   trainer_name VARCHAR(50),
   course VARCHAR(50),
   experience INT
);
INSERT INTO students VALUES
(1, 'Akhil', 'Python', 'Hyderabad', 25000),
(2, 'Sneha', 'Java', 'Bangalore', 30000),
(3, 'Rahul', 'Python', 'Chennai', 28000),
(4, 'Priya', 'MERN', 'Mumbai', 35000),
(5, 'Kiran', 'Java', 'Delhi', 22000),
(6, 'Meena', 'Python', 'Hyderabad', 26000),
(7, 'Vamsi', 'MERN', 'Pune', 40000),
(8, 'Anu', 'Java', 'Bangalore', 24000);

INSERT INTO trainers VALUES
(101, 'Ramesh', 'Python', 5),
(102, 'Suresh', 'Java', 8),
(103, 'Kavya', 'MERN', 4),
(104, 'David', 'Python', 7);

-- Create a CTE to get all Python students and display their details.
with abc as(
select student_id,student_name,course,city,fees
from students
where course="Python"
)
select * from abc;

-- Create a CTE to find students whose fees are greater than average fees using a subquery inside the main query.
with abc as(
select avg(fees) as avgfee
from students
)
select *
from students 
where fees > (select * from abc);

-- Create a CTE with JOIN to display student names along with trainer names based on matching courses.
with abc as(
select s.student_name,t.trainer_name
from students s
inner join trainers t
on s.course=t.course
)
select * from abc;

-- Create a CTE to count total students course-wise using aggregate functions.
with abc as(
select count(student_id) as total,course
from students
group by course
)
select * from abc;

-- Create a CTE to find the highest fees paid student.
with abc as(
select fees,student_name
from students
where fees=(
select max(fees) as maxfees
from students)
)
select *
from abc;

-- Create a CTE and UPDATE the fees by increasing 5000 for all MERN students.
with abc as(
select *
from students
where course="Mern")

update students
set fees=fees+5000
WHERE  student_id in(select student_id from abc);
select * from students;

-- Create a CTE and DELETE students whose fees are less than 25000.
with abc as(
select * from students where fees<25000
)
delete  from students
where student_id in (select student_id from abc);
select * from students;

-- Create a CTE with JOIN and display students who are learning from trainers having more than 5 years experience.
with abc as(
select *
from students s
inner join trainers t
using(course)
)
select * from abc where experience>5;

-- Create a CTE using aggregate functions to find total fees collected course-wise.
with abc as(
select max(fees) as total,course
from students
group by course
)
select * from abc;

-- Create a CTE and INSERT all Java students into a new table called java_students.
CREATE TABLE java_students (
    student_id INT,
    student_name VARCHAR(50),
    course VARCHAR(50),
    city VARCHAR(50),
    fees INT
);
insert into java_students
with abc as(
select * 
from students
where course="Java"
)
select * from abc;

-- Create a CTE with subquery to find students whose fees are less than maximum fees.
with abc as(
select  max(fees) as highest_fee
from students
)
select *
from students
where fees<(select * from abc);

-- Create a CTE with JOIN to display Hyderabad students and their trainer details.
with abc as(
select *
from students s
inner join trainers t
using(course)
where s.city="Hyderabad")
select * from abc;

-- Create a CTE using aggregate functions to find average fees city-wise.
with abc as(
select city,avg(fees) as avgfees
from students
group by city
)
select * from abc;

-- Create multiple CTEs:
-- First CTE → Get Python students
-- Second CTE → From Python students, get fees greater than 25000
-- Display final result.
with abc as(
select * from students where course="Python"),
def as(
select * from abc where fees>25000)
select * from def;

-- Create a CTE and DELETE students who belong to Bangalore city using a subquery.
with abc as(
select * 
from students 
where city="Bangalore"
)
delete from students
where student_id in (select student_id  from abc);



