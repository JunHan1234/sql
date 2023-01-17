-- single function
-- parameter�� lower �ϳ� ����.
desc dual

select *
from dual;

select lower('SQL Course')
from dual;

select upper('SQL Course')
from dual;

select initcap('SQL Course')
from dual;

/*��ҹ��� �����ϴ� �˻�.*/
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

/*trim�� from�� �����ص� �ȴ�.*/
select trim(' Hello World ')
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

-- ����: �� query���� where ���� like �� refactoring �϶�.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';