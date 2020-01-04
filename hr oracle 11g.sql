
/* 1 -------------------------------------------
Write "hello world" greeting. The column should be called "Welcome".
*/
SELECT 'hello world' as "Welcome"
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
WHERE PHONE_NUMBER LIKE '_%7%7%';

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

/* 4 -------------------------------------------
From JOBS table select:

a) the largest minimum pay
*/
SELECT max(min_salary) 
FROM jobs;

/*
b) for each job title, find the difference between the minimum and maximum pay
*/
SELECT job_title, (max_salary - min_salary) AS "max - min" 
FROM jobs;
