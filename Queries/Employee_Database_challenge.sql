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
into mentorship_eligibility
From employees as e
inner Join dept_emp as de
ON (e.emp_no = de.emp_no)
inner join titles as t
ON (e.emp_no = t.emp_no)

Where (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
order by e.emp_no;




--query to see which department managers will be retiring 
Select e.first_name, e.last_name,d.dept_name
into department_managers_retiring
from employees as e
inner join dept_manager as dm 
on (e.emp_no = dm.emp_no)
inner join departments as d
on (dm.dept_no = d.dept_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (dm.to_date = '9999-01-01')

--query to identify the count of mentorship elegible employees by department 

Select count ( me.emp_no), d.dept_name
into mentorship_departments
from mentorship_eligibility as me
inner join dept_emp as de
on (me.emp_no = de.emp_no)
inner join departments as d 
on (de.dept_no = d.dept_no)
WHere de.to_date = '9999-01-01'
Group by (d.dept_name)
order by count (me.emp_no) desc;

-- query to identify how many current non-retiring employees each department has 

select count (de.emp_no) as employees, d.dept_name
into total_employees_by_department
from dept_emp as de
inner join departments as d
on (de.dept_no =d.dept_no)
inner join employees as e
on (de.emp_no = e.emp_no)
where (de.to_date = '9999-01-01') AND (e.birth_date > '1955-12-31')
group by(d.dept_name)
order by count(de.emp_no) desc;

-- query to combine mentorship eligble employees and total employees by department 

select ted.employees, md.count as mentors, md.dept_name
into mentors_and_total_employees_by_department
from total_employees_by_department as ted
inner join mentorship_departments as md
on (ted.dept_name = md.dept_name)
group by (ted.employees, md.count, md.dept_name)
order by ted.employees desc;