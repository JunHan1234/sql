-- single function
desc dual

--single function�� row �ϳ��� �޾Ƽ� ��� �ϳ��� �����Ѵ�.
select *
from dual;

-- parameter�� lower �ϳ� ����.
select lower('SQL Course')
from dual;

select upper('SQL Course')
from dual;

select initcap('SQL Course')
from dual;

/*��ҹ��� �����ϴ� �˻������ Ư¡.*/
select last_name
from employees
where last_name = 'higgins';

select last_name
from employees
where last_name = 'Higgins';

/*last_name�� �ʵ���� lower ���� �� �˻��� ����̴�.*/
-- lower function�� return���� ��� 'higgins'�� ���Ѵ�.
select last_name
from employees
where lower(last_name) = 'higgins';

/*concat�� �̿�. parameter�� 2���� field�� �ް� �ϳ��� row�� return �Ѵ�.*/
select concat('Hello', 'World')
from dual;

/*1���� field�� �޾� �ϳ��� field�� �ִ� row�� return �Ѵ�.*/
-- index 2������ 5���� ���.
select substr('HelloWorld', 2, 5)
from dual;

-- index �ڿ��� 1������ 1���� ���.
select substr('Hello', -1, 1)
from dual;

-- index ���� ����.
select length('Hello')
from dual;

-- 'l' data�� index 3�� �����Ѵ� ��°��� Ȯ��.
select instr('Hello', 'l')
from dual;
-- data�� ���°��, return ���� 0�̴�. (�ִ°��� > 0 �̴�.)
select instr('Hello', 'w')
from dual;

/*5�ڸ��� ���߰� ���ڸ����� *�� ä���.*/
select lpad(salary, 5, '*')
from employees;

select rpad(salary, 5, '*')
from employees;

select replace('JACK and JUE', 'J', 'BL')
from dual;

--�Ӹ�, ������ Ư�� ���ڸ� ��´�.
select trim('H' from 'Hello')
from dual;

select trim('l' from 'Hello')
from dual;

select trim(' ' from ' Hello ')
from dual;

-- ����: �� query���� ' '�� trim ������, ������ Ȯ���� �� �ְ� ��ȸ�϶�.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;

/*������ �տ��̳� �޿��� ������ ���� ���,
                        trim�� from�� �����ص� �ȴ�.*/
select '|' || trim(' Hello World ') || '|'
from dual;

--PROG������ ��� �߿�, last_name�� n��°�� 'a'���ڰ� �����ϴ��� ����.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

-- ����: �� query���� where ���� like �� refactoring �϶�.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

-- ����: �̸��� J�� A�� M���� �����ϴ� ������� �̸�, �̸��� ���ڼ��� ��ȸ�϶�.
--       �̸��� ù���ڴ� �빮��, �������� �ҹ��ڷ� ����Ѵ�.
select initcap(last_name), length(last_name)
from employees
where last_name like 'J%' or
    last_name like 'A%' or
    last_name like 'M%';
    
/*2��° parameter�� �ڸ����̴�.*/
--round: �ݿø�, trunc: ����
select round(45.926, 2)
from dual;
select trunc(45.926, 2)
from dual;

select round(45.926, 0), round(45.923)
from dual;
select trunc(45.926, 0), trunc(45.923)
from dual;

-- ����: ������� �̸�, ����, 15.5% �λ�� ����(New Salary, ����), �λ��(Increase)�� ��ȸ�϶�.
select last_name, salary,
    round(salary * 1.155) "New Salary",
    round(salary * 0.155) "Increase"
from employees;

-- system�� ��¥�� �ҷ��´�.
select sysdate
from dual;

-- ��¥�� ��������� �ϸ� �Ϸ簡 �������� ������.
select sysdate + 1
from dual;

select sysdate - 1
from dual;

--�Ⱓ�� �� �� �ִ�.
select sysdate - sysdate
from dual;

select last_name, sysdate - hire_date
from employees
where department_id = 90;

select months_between('2023/12/31', '2022/12/31')
from dual;

--n���� ���� ���Ѵ�.
select add_months('2024/01/18', 3)
from dual;

--5�� ������� ���Ѵ�. -> 1�� 18�� ���ķ� ù��° ������� ���Ѵ�.
select next_day('2023/01/18', 5)
from dual;
--����, ���� ������ ǥ�������ϴ�.
select next_day('2023/01/18', 'thursday')
from dual;
select next_day('2023/01/18', 'thu')
from dual;
--���� ������ ��Ÿ�� �� �ִ�.
select last_day('2023/01/18')
from dual;

-- ����: 20�� �̻� ������ ������� �̸�, ù�������� ��ȸ�϶�.
--       ������ �ſ� ���Ͽ� �����Ѵ�.
select last_name, last_day(hire_date) "FIRST_SALARY"
from employees
where months_between(sysdate, hire_date) / 12 >= 20;

-- ����: ������� �̸�, ����, ���� �׷����� ��ȸ�϶�.
--       �׷����� $1000 �� * �ϳ��� ǥ���Ѵ�.
select last_name, salary, rpad('*', salary / 1000, '*') sal
from employees
order by sal desc;