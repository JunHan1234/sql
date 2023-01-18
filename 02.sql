-- where �� Ȱ�� 
/*���ٸ� ǥ���ϴ� ������ = */
-- �ǿ������� type�� ���ƾ� �Ѵ�.
select employee_id, last_name, department_id
from employees
where department_id = 50;

-- ����: 176�� ����� ���, �̸�, �μ���ȣ�� ��ȸ�϶�.
select employee_id, last_name, department_id
from employees
where employee_id = 176;

/*data������ ��ҹ��ڰ� �����ȴ�.*/
select employee_id, last_name, department_id
from employees
where last_name = 'Whalen';

/*date type�� �˻��� char type�� �̿��Ѵ�.*/
select employee_id, last_name, hire_date
from employees
where hire_date = '2008/02/06';

select last_name, salary
from employees
where salary <= 3000;

-- ����: �� $12,000 �̻� ���� ������� �̸�, ������ ��ȸ�϶�.
select last_name, salary
from employees
where salary >= 12000;

/*�ٸ��� ������ != */
select last_name, job_id
from employees
where job_id != 'IT_PROG';

/*������ ǥ��, ���⼭�� �̻� ����*/
select last_name, salary
from employees
where salary between 2500 and 3500;

/*K���� S�� ������ character�� ���*/
select last_name
from employees
where last_name between 'King' and 'Smith';

-- ����: 'King' ����� first_name, last_name, ����, ������ ��ȸ�϶�.
select first_name, last_name, job_id, salary
from employees
where last_name = 'King';

select last_name, hire_date
from employees
where hire_date between '2002/01/01' and '2002/12/31';

/*n�� ����� ���� �δ� ����� ���.*/
select employee_id, last_name, manager_id
from employees
where manager_id in (100, 101, 201);

-- ���� n���� ����.
select employee_id, last_name, manager_id
from employees
where manager_id = 100 or
    manager_id = 101 or
    manager_id = 201;

-- ������ ���Ե� �׸��� ���.
select employee_id, last_name
from employees
where last_name in ('Hartstein', 'Vargas');

select last_name, hire_date
from employees
where hire_date in ('2003/06/17', '2005/09/21');

-- ����ϴ� '���ٺκ� + ���ϵ�ī��(%, ������ 0���̻��� ����)'
-- ù ���ڰ� S�� ������� ȣ���Ѵ�.
select last_name
from employees
where last_name like 'S%';

-- ������ ���ڰ� r�� ������� ȣ���Ѵ�.
select last_name
from employees
where last_name like '%r';

-- ����: �̸��� s �� ���Ե� ������� �̸��� ��ȸ�϶�.
select last_name
from employees
where last_name like 'S%' or 
    last_name like '%s'; /*Ʋ��. �䱸������ ��ҹ��ڿ� ��ġ�� �����϶�.*/

--���� 
select last_name
from employees
where last_name like '%s%';

-- ����: 2005�⿡ �Ի��� ������� �̸�, �Ի����� ��ȸ�϶�.
select last_name, hire_date
from employees
where hire_date like '2005%';

/*������ �ѱ��ڿ� �ش��ϴ� ���ϵ�ī�� _*/
select last_name
from employees
where last_name like 'K___';

-- ����: �̸��� �ι�° ���ڰ� o �� ����� �̸��� ��ȸ�϶�.
select last_name
from employees
where last_name like '_o%';

/*���ϵ�ī��� �Ȱ��� _ �� ó���ϴ¹� -> \ �������� ���� ���ڴ� �׳� �����̴�.*/
--escape ���ڴ� ���� �����ϴ�.
select job_id
from employees;

select last_name, job_id
from employees
where job_id like 'I_\_%' escape '\';

select last_name, job_id
from employees
where job_id like 'I_[_%' escape '[';

-- ����: ������ _R�� ���Ե� ������� �̸�, ������ ��ȸ�϶�.
select last_name, job_id
from employees
where job_id like '%\_R%' escape '\';

-- where���� true���� return�ϴ� �����̴�. expression�� null�� ���̸� null������ �ϰ��ȴ�.
select employee_id, last_name, manager_id
from employees;

-- ���� where�� ���� expression�� null�̹Ƿ�, ���� null�̴�.
select last_name, manager_id
from employees
where manager_id = null;

-- �׷��Ƿ�, = ������ ��� is �� Ȱ���Ͽ� ��Ұ��� ã�Ƴ���.
select last_name, manager_id
from employees
where manager_id is null;

-- �� ������ and
select last_name, job_id, salary
from employees
where salary >= 5000 and job_id like '%IT%';

-- �� ������ or
select last_name, job_id, salary
from employees
where salary >= 5000 or job_id like '%IT%';

-- ����: ������ $5000 �̻� $12000 �����̴�. �׸���,
--       20���̳� 50�� �μ����� ���Ѵ�.
--       �� ������� �̸�, ����, �μ���ȣ�� ��ȸ�϶�.
select last_name, salary, department_id
from employees
where (salary between 5000 and 12000) and
    department_id in (20, 50);
    
-- ����: �̸��� a�� e�� ���Ե� ������� �̸��� ��ȸ�϶�.
select last_name
from employees
where last_name like '%a%' and
    last_name like '%e%';

/*�������� ���. not �������� Ȱ��.*/
select last_name, job_id
from employees
where job_id not in ('IT_PROG', 'SA_REP');

select last_name, salary
from employees
where salary not between 10000 and 15000;

select last_name, job_id
from employees
where job_id not like '%IT%';

/*'is null' �������� ����*/
select last_name, job_id
from employees
where commission_pct is not null;

/*�� �������� ����*/
select last_name, salary
from employees
where not (manager_id is null and salary >= 20000);

-- ����: ������ �����̴�. �׸���, ������ $2500, $3500�� �ƴϴ�.
--       �� ������� �̸�, ����, ������ ��ȸ�϶�.
select last_name, job_id, salary
from employees
where job_id like 'SA%' and
    salary not in (2500, 3500);

--order by ���� �̿��� �������� ���� ascending (asc, �⺻���̹Ƿ� ��������)
select last_name, department_id
from employees
order by department_id;

--�������� ���� descending
select last_name, department_id
from employees
order by department_id desc;

/*department_id(select�� 2��° ��ġ)�� �����ϰ� ���� ���.*/
select last_name, department_id
from employees
order by 2;

/*�������� ����*/
select last_name, department_id dept_id
from employees
order by dept_id;

/*Ű���带 ���������� ����(1���� select�� 2���� from�� 3���� where�� ...)*/
select last_name, hire_date
from employees
where department_id = 100
order by hire_date;

/*1�����Ŀ� ���� 2������. n�������� �����ϴ�.*/
-- �Ʒ� ���������� department_id�� �������� 1������,
-- �������� salary�� �������� 2�������� �ߴ�.
select last_name, department_id, salary
from employees
where department_id > 80
order by department_id asc, salary desc;