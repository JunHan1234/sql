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