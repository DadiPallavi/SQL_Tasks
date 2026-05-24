use klu;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary INT
);

INSERT INTO employees VALUES
(101, 'Amit',   'IT',      90000),
(102, 'Sneha',  'IT',      85000),
(103, 'Rahul',  'IT',      85000),
(104, 'Priya',  'IT',      70000),

(105, 'Kiran',  'HR',      60000),
(106, 'Anu',    'HR',      60000),
(107, 'Ravi',   'HR',      50000),
(108, 'Divya',  'HR',      45000),

(109, 'Arjun',  'Sales',   95000),
(110, 'Meena',  'Sales',   80000),
(111, 'John',   'Sales',   80000),
(112, 'Sara',   'Sales',   65000);

--  Get the highest paid employee in each department
SELECT *
FROM
(
    SELECT *,
           RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = 1;
-- Show top 2 salaries in each department
SELECT *
FROM
(
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS rn
    FROM employees
) t
WHERE rn <= 2;

-- Handle Salary Ties
-- Show all employees with highest salary
SELECT *
FROM
(
    SELECT *,
           RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = 1;

--  Unique Ranking Assign unique row number within department
SELECT *,
       ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS row_num
FROM employees;

-- Continuous Ranking No skipped ranks
SELECT *,
       DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dense_rank_num
FROM employees;

-- Competition Ranking
-- Same salary → same rank
-- Next rank skipped
SELECT *,
       RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS rank_num
FROM employees;


-- =====================================================
-- ✅ Task 7: Find 2nd Highest Salary per Department
-- =====================================================

SELECT *
FROM
(
    SELECT *,
           DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS drnk
    FROM employees
) t
WHERE drnk = 2;



-- =====================================================
-- ✅ Task 8: Bottom 2 Employees per Department
-- =====================================================

SELECT *
FROM
(
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary ASC) AS rn
    FROM employees
) t
WHERE rn <= 2;



-- =====================================================
-- ✅ Task 9: Remove Duplicate Salaries
-- Show one employee per salary per department
-- =====================================================

SELECT *
FROM
(
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY department, salary
               ORDER BY emp_id
           ) AS rn
    FROM employees
) t
WHERE rn = 1;



-- =====================================================
-- ✅ Task 10: Department-wise Salary Leaderboard
-- =====================================================

SELECT 
    emp_id,
    name,
    department,
    salary,
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS leaderboard_rank
FROM employees;





