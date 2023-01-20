-- subquery
-- 'Abel'보다 월급을 많이 받는 사원을 return.
-- mainquery(inner query), subquery(outer query)
select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel');
                
select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Ernst')
and salary > (select salary
                from employees
                where last_name = 'Ernst');

-- 과제: Kochhar 에게 보고하는 사원들의 이름, 직업, 부서번호를 조회하라.
select last_name, job_id, department_id
from employees
where manager_id = (select employee_id
                    from employees
                    where last_name = 'Kochhar');
