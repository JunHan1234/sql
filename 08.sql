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