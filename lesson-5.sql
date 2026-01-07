-- 1
select 
    employeeid, name, department, salary,
    rank() over (order by salary desc) as salary_rank
from employees;

-- 2
select 
    employeeid, name, department, salary,
    dense_rank() over (order by salary desc) as salary_rank
from employees;

-- 3
select *
from (
    select 
        employeeid, name, department, salary,
        dense_rank() over (partition by department order by salary desc) as dept_rank
    from employees
) t
where dept_rank <= 2;

-- 4
select *
from (
    select 
        employeeid, name, department, salary,
        row_number() over (partition by department order by salary asc) as rn
    from employees
) t
where rn = 1;

-- 5
select 
    employeeid, name, department, salary,
    sum(salary) over (
        partition by department 
        order by hiredate 
        rows unbounded preceding
    ) as running_total
from employees;

-- 6
select 
    employeeid, name, department, salary,
    sum(salary) over (partition by department) as dept_total
from employees;

-- 7
select 
    employeeid, name, department, salary,
    avg(salary) over (partition by department) as dept_avg
from employees;

-- 8
select 
    employeeid, name, department, salary,
    salary - avg(salary) over (partition by department) as diff_from_dept_avg
from employees;

-- 9
select 
    employeeid, name, department, salary,
    avg(salary) over (
        order by hiredate
        rows between 1 preceding and 1 following
    ) as moving_avg3
from employees;

-- 10
select employeeid, name, department, salary, hiredate
from (
    select *,
           sum(salary) over (order by hiredate 
                             rows between 2 preceding and current row) as last3_sum
    from employees
) t;

-- 11
select 
    employeeid, name, department, salary,
    avg(salary) over (
        order by hiredate 
        rows unbounded preceding
    ) as running_avg
from employees;

-- 12
select 
    employeeid, name, department, salary,
    max(salary) over (
        order by hiredate
        rows between 2 preceding and 2 following
    ) as sliding_max
from employees;

-- 13
select 
    employeeid, name, department, salary,
    cast(100.0 * salary / sum(salary) over (partition by department) as decimal(5,2)) as pct_of_dept
from employees;