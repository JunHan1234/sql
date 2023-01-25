--������
    -->���� 2����: field�� data type�� ���ƾ��Ѵ�, column�� ���� ���ƾ��Ѵ�.
--set 1
select employee_id, job_id
from employees
union /*set 1, 2�� ���Ѵ�. set�� �ڵ����� �ߺ����Ÿ� �Ѵ�.*/
--set 2
select employee_id, job_id
from job_history;

select employee_id, job_id
from employees
union all /*all�� �ߺ� ����� �� �� �ִ�.*/
select employee_id, job_id
from job_history;

-- ����: ���� ������ ���� ���� �ִ� ������� ���, �̸�, ������ ��ȸ�϶�.
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

--department_name�� state_province�� �ϳ��� ��ģ��.
select location_id, department_name
from departments
union
select location_id, state_province
from locations;

-- ����: �� ������ service �������� ���Ķ�.
--       union �� ����Ѵ�.
select location_id, null state_province, department_name
from departments
union
select location_id, state_province, null department_name
from locations;

-- column ������ �ȸ����� �������� Ȯ��.
select employee_id, job_id, salary
from employees
union
select employee_id, job_id
from job_history;

--3��° column�� number type 0�� ����.
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