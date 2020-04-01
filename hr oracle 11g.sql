
/* 1 -------------------------------------------
Write "hello world" greeting. The column should be called "Welcome".
*/
SELECT 'hello world' AS "Welcome"
FROM dual;

/* 2 -------------------------------------------
From EMPLOYEES table select:

a) people who started work in 2000 or 2001 or 2002
*/
SELECT first_name, last_name, to_char(hire_date, 'DD.MM.YYYY') AS "hire date"
FROM employees
WHERE hire_date >= '2001/01/01' AND hire_date < '2003/01/01';
-- can also be:
--WHERE EXTRACT(year from hire_date) IN (2000, 2001, 2002);
-- can also be:
--WHERE hire_date BETWEEN '2001/01/01' AND '2002/12/31';
/*

b) those who don't work in departments ID 50 and 80
*/
SELECT first_name, last_name, department_id 
FROM employees
WHERE department_id NOT IN (50, 80);
-- can also be:
-- WHERE department_id <> 50 AND department_id <> 80;

/*
c) those employees whose phone number contains two digits 7 in any place except the first place
*/
SELECT first_name, last_name, phone_number 
FROM employees
WHERE phone_number LIKE '_%7%7%';

/*
d) 10 people with the highest salary
*/ 
SELECT first_name, last_name, salary
FROM (
      SELECT first_name, last_name, salary
      FROM employees 
      ORDER BY salary DESC
      )
WHERE rownum <= 10;

/*
e) people who have the same salary as Den Raphaely
*/
SELECT first_name, last_name, salary
FROM employees
WHERE salary = (
                SELECT salary
                FROM employees
                WHERE first_name = 'Den' AND last_name = 'Raphaely'
                );

/*
f) how many employees are in each department. Sort the result from the largest number of employees
*/
SELECT department_id, COUNT(ROWNUM)
FROM employees
GROUP BY department_id
ORDER BY COUNT(ROWNUM) DESC;

/*
g) employees from each department whose salary is greater than the average salary in that department.
   Sort the result by department_id. Use correlated query
*/
SELECT outer.department_id, outer.employee_id, outer.first_name, outer.last_name, outer.salary
FROM employees outer
WHERE outer.salary > (
                     SELECT AVG(salary)
                     FROM employees
                     WHERE department_id = outer.department_id
                     )
ORDER BY outer.department_id;

/*
h) verbal description of the salary depending on its amount. Order by salary descending.
*/
SELECT employee_id, first_name, last_name, salary, 
    CASE
        WHEN salary < 7000 THEN 'poor'
        WHEN salary BETWEEN 7000 AND 10000 THEN 'mid'
        WHEN salary > 10000 THEN 'rich'
    END AS "Employee status"
FROM employees
ORDER BY salary DESC;


/* 3 -------------------------------------------
From LOCATIONS table select:

/*
a) locations where the city name doesn't begin with the letter S but has s in the name
*/
SELECT city FROM locations
WHERE city NOT LIKE 'S%' AND city LIKE '_%s%'; 

/*
b) locations that don't have state_province. The state_province field should contain the information 'lack of state_province'.
*/
SELECT location_id, NVL(state_province, 'lack of state_province')
FROM locations
WHERE state_province IS NULL;
