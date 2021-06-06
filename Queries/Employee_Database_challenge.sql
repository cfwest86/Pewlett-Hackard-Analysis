-- create a Retirement Titles table 
SELECT e.emp_no,
e.first_name,
e.last_name,
ti.title,
ti.from_date,
ti.to_date
INTO Retirement_Titles
FROM employees AS e
Inner JOIN titles as ti
ON(ti.emp_no = e.emp_no)

WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title

INTO Unique_Titles
FROM retirement_titles AS rt
ORDER BY rt.emp_no, rt.to_date DESC;

--retrieve number of employees by their most recent job title who are about to retire

Select count (ut.title),ut.title
into Retiring_Titles
from unique_titles as ut
GROUP BY ut.title 
order by count(ut.title) DESC;

--query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program

select DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
--into mentorship_eligibility
From employees as e
inner Join dept_emp as de
ON (e.emp_no = de.emp_no)
inner join titles as t
ON (e.emp_no = t.emp_no)

Where (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
order by e.emp_no;