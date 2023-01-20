-- join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equi join
/*location_id�� ���� row���� ���ս��� return*/
select department_id, department_name, location_id, city
from departments natural join locations;

/*where���� ���ϴ� row�� ����.*/
select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);

-- using�� ����ϸ�, Ư�� Į���� join�Ѵ�.
-- ����, department_id�� true���� �͸� return.
-- manager_id�� return ���Ѵ�.
select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

-- ��������: ������ ������ 1���� �̸�, �μ���ȣ�� ��ȸ�϶�.
select last_name, department_id
from employees
where department_id is null;

/*netural join�� ����ϸ�, ���̺� �ִ� ��� ���� Į���� ��ȸ�ϹǷ�,
    department_id, manager_id �ΰ� �� join�� �ȴ�.
    ����, �����ϴ� �� Į���� ���� ��� true�϶��� return �Ѵ�.*/
select employee_id, last_name, department_id, location_id
from employees natural join departments;

/*������ �ڵ带 ��ġ��Ű��, �ڵ尡 ��ٴ� ������ �ִ�.*/
select locations.city, departments.department_name
from locations join departments
using (location_id)
where location_id = 1400;

/*������ ������� ���� ����.*/
select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400;

--using���� ���� Į���� ���λ縦 ���� �� ����.
select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400;

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400;

--using�� ������ ���� ����Į������ ���λ縦 �ٿ��� �Ѵ�.
select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where d.manager_id = 100;

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id);

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- ����: �� query�� using ���� refactoring �϶�.
select employee_id, city, department_name
from employees e join departments d
using (department_id)
join locations l
using (location_id);

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

-- ����: Toronto �� ��ġ�� �μ����� ���ϴ� �������
--       �̸�, ����, �μ���ȣ, �μ���, ���ø� ��ȸ�϶�.
select e.last_name, e.job_id, e.department_id,
    d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where l.city = 'Toronto';
/*
on d.location_id = l.location_id --> ���ǹ� 1
and l.city = 'Toronto';          --> ���ǹ� 2
�� �����ص� ����� ����.
*/

-- non-equi join
/*IT_PROG��ŭ ���� �޴� ������ ã�ƶ�*/
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

-- self join
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

-- on, select ������ ���λ縦 ����,
-- ��� ���̺��� ���� Į������ �Ҹ�Ȯ �ϹǷ� ����.
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on manager_id = employee_id;

select last_name emp, last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

-- ����: ���� �μ����� ���ϴ� ������� �μ���ȣ, �̸�, ������� ��ȸ�϶�.
-- ���ο� �ٸ��� ������ <>
select e.department_id, e.last_name employee, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id
order by 1, 2, 3;

-- ����: Davies ���� �Ŀ� �Ի��� ������� �̸�, �Ի����� ��ȸ�϶�.
select e.last_name, e.hire_date
from employees e join employees d
on d.last_name = 'Davies'
and d.hire_date < e.hire_date
order by 2, 1;

-- ����: �Ŵ������� ���� �Ի��� ������� �̸�, �Ի���, �Ŵ�����, �Ŵ��� �Ի����� ��ȸ�϶�.
select w.last_name, w.hire_date, m.last_name manager, m.hire_date m_hire_date
from employees w join employees m
on w.manager_id = m.employee_id
and m.hire_date > w.hire_date;

-- inner join
select e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

-- outer join -> join���� ���� row�� ���Խ�Ų��. "left outer"
select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id;
-- outer join -> "right outer" departments ���� join���� ���� row�� ���Խ�Ű�� return
select e.last_name, e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;
-- outer join -> "full outer"
select e.last_name, e.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;

-- ����: ������� �̸�, ���, �Ŵ�����, �Ŵ����� ����� ��ȸ�϶�.
--       King ȸ�嵵 ���̺� �����϶�.
select w.last_name w_name, w.employee_id w_id, m.last_name m_name, m.employee_id m_id
from employees w left outer join employees m
on w.manager_id = m.employee_id
order by 2;

-- 20���� join�� ǥ��. equi join, inner join�� �����.
select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id;
-- �ڵ尡 ����ϱ� ������ ������ ���忡�� ������ȭ�� ���� ���δ�.
select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id
    and d.department_id in (20, 50);
-- 3�� �̻��� ���̺� join.
select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;
-- non-equi join
select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';
-- right outer join, null�� ���ʿ� �д�.
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;
-- left outer join, null�� �����ʿ� �д�.
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);
-- full outer join�� ����. ���� Ȯ��.
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id(+);

select worker.last_name || ' works for ' || manager.last_name
from employees worker, employees manager
where worker.manager_id = manager.employee_id;