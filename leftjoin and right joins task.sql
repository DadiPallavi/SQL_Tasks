use sql_task;
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO departments VALUES
(101, 'HR'),
(102, 'IT'),
(103, 'Finance'),
(104, 'Marketing');

INSERT INTO employees VALUES
(1, 'Amit', 101),
(2, 'Neha', 102),
(3, 'Ravi', NULL),
(4, 'Sita', 103),
(5, 'John', NULL),
(6, 'Priya', 102);

#Write a query to display all employees and their department names.
select *
from departments d
left join employees e
on d.dept_id=e.emp_id;

--  Write a query to display all employees along with department names, 
-- and show "No Department" if an employee is not assigned to any department.
SELECT e.emp_name,COALESCE(d.dept_name, 'No Department') AS dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;

-- Find employees who do not belong to any department
SELECT emp_name
FROM employees
WHERE dept_id IS NULL;

-- Display all departments and number of employees in each department
SELECT d.dept_name,COUNT(e.emp_id) AS total_employees
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;
-- Display all employees and only their department name if it is 'IT', otherwise NULL
SELECT 
    e.emp_name,
    CASE
        WHEN d.dept_name = 'IT' THEN d.dept_name
        ELSE NULL
    END AS dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;

-- Display only employees who belong to HR department
select emp_name,dept_name
from departments d
left join employees e
on e.dept_id = d.dept_id
where dept_name="HR";

-- Display employee name and department name
-- Include only departments where dept_id = 101 using LEFT JOIN condition
SELECT e.emp_name,d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
AND d.dept_id = 101;

-- Display all departments that do not have employees

SELECT 
    d.dept_name
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL;




-- Display employee name and department name sorted by department name

SELECT 
    e.emp_name,
    d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
ORDER BY d.dept_name;




-- Display employee name, department name and status

SELECT 
    e.emp_name,
    d.dept_name,
    CASE
        WHEN d.dept_id IS NOT NULL THEN 'Assigned'
        ELSE 'Not Assigned'
    END AS status
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;

