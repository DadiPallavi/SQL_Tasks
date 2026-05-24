use sql_task;
CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    designation VARCHAR(50),
    salary DECIMAL(10,2),
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

INSERT INTO Department VALUES
(101, 'HR'),
(102, 'IT'),
(103, 'Finance'),
(104, 'Marketing');

INSERT INTO Employees VALUES
(1, 'Amit', 101, 'Manager', 70000),
(2, 'Neha', 102, 'Developer', 85000),
(3, 'Ravi', 102, 'Developer', 60000),
(4, 'Sita', 103, 'Manager', 95000),
(5, 'John', 104, 'Executive', 40000),
(6, 'Priya', 103, 'HR', 50000),
(7, 'Kiran', 101, 'Executive', 45000),
(8, 'Anu', 102, 'Manager', 120000);

-- Find employees who earn higher than
-- average salary in their department

SELECT 
    e.emp_name,
    e.salary,
    e.dept_id
FROM Employees e
WHERE salary >
(
    SELECT AVG(e2.salary)
    FROM Employees e2
    WHERE e2.dept_id = e.dept_id
);

-- Find department names where total salary
-- is greater than 100000


SELECT dept_name
FROM Departments
WHERE dept_id IN
(
    SELECT dept_id
    FROM Employees
    GROUP BY dept_id
    HAVING SUM(salary) > 100000
);

-- Find employee with highest salary
-- in each department

SELECT 
    emp_name,
    dept_id,
    salary
FROM Employees e
WHERE salary =
(
    SELECT MAX(salary)
    FROM Employees
    WHERE dept_id = e.dept_id
);

-- Find employees who are not managers
-- but earn more than at least one manager


SELECT 
    emp_name,
    designation,
    salary
FROM Employees
WHERE designation != 'Manager'
AND salary >
ANY
(
    SELECT salary
    FROM Employees
    WHERE designation = 'Manager'
);
