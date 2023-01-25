--합집합
    -->조건 2가지: field의 data type이 같아야한다, column의 수가 같아야한다.
--set 1
select employee_id, job_id
from employees
union /*set 1, 2를 합한다. set은 자동으로 중복제거를 한다.*/
--set 2
select employee_id, job_id
from job_history;

select employee_id, job_id
from employees
union all /*all로 중복 허용을 할 수 있다.*/
select employee_id, job_id
from job_history;

-- 과제: 과거 직업을 현재 갖고 있는 사원들의 사번, 이름, 직업을 조회하라.
select e.employee_id, e.last_name, e.job_id
from employees e, job_history j
where e.employee_id = j.employee_id
and e.job_id = j.job_id;

select employee_id, last_name, job_id
from employees e
where exists (select *
                from job_history j
                where e.employee_id = j.employee_id
                    and e.job_id = j.job_id);

select employee_id, last_name, job_id
from employees e
where e.job_id in (select job_id
                    from job_history j
                    where e.employee_id = j.employee_id);

--department_name과 state_province는 하나로 뭉친다.
select location_id, department_name
from departments
union
select location_id, state_province
from locations;

-- 과제: 위 문장을 service 관점에서 고쳐라.
--       union 을 사용한다.
select location_id, null state_province, department_name
from departments
union
select location_id, state_province, null department_name
from locations;

-- column 개수가 안맞으면 에러뜸을 확인.
select employee_id, job_id, salary
from employees
union
select employee_id, job_id
from job_history;

--3번째 column은 number type 0을 기입.
select employee_id, job_id, salary
from employees
union
select employee_id, job_id, 0
from job_history;

select employee_id, job_id, salary
from employees
union
select employee_id, job_id, 0
from job_history
order by salary;