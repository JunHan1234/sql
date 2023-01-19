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
select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

-- ��������: ������ ������ 1���� �̸�, �μ���ȣ�� ��ȸ�϶�.
select last_name, department_id
from employees
where department_id is null;

/*netural join�� ����ϸ�, ���̺� �ִ� ��� ���� Į���� ��ȸ�ϹǷ�,
    department_id, manager_id �ΰ� �� join�� �ȴ�.*/
select employee_id, last_name, department_id, location_id
from employees natural join departments;

/*������ �ڵ带 ��ġ��Ű��, �ڵ尡 ��ٴ� ������ �ִ�.*/
select locations.city, departments.department_name
from locations join departments
using (location_id)
where location_id = 1400;

/*���� ����.*/
select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400;

--���ǹ������� ���λ�� ������ ���� �� ����.
select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400;

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where d.location_id = 1400;