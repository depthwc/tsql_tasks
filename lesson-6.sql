-- 1. 
select e.employeeid, e.name, d.departmentname
from employees e
inner join departments d
    on e.departmentid = d.departmentid;

-- 2. 
select e.employeeid, e.name, d.departmentname
from employees e
left join departments d
    on e.departmentid = d.departmentid;

-- 3. R
select e.employeeid, e.name, d.departmentname
from employees e
right join departments d
    on e.departmentid = d.departmentid;

-- 4. 
select e.employeeid, e.name, d.departmentname
from employees e
full outer join departments d
    on e.departmentid = d.departmentid;

-- 5. 
select d.departmentname, sum(e.salary) as total_salary
from employees e
inner join departments d
    on e.departmentid = d.departmentid
group by d.departmentname;

-- 6. 
select d.departmentname, p.projectname
from departments d
cross join projects p;

-- 7. 
select e.employeeid, e.name, d.departmentname, p.projectname
from employees e
left join departments d
    on e.departmentid = d.departmentid
left join projects p
    on e.employeeid = p.employeeid;
