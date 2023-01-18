--�ڵ� ����ȯ Number <-> Character <-> Date
select hire_date
from employees
where hire_date = '2003/06/17';

/*Number�� salary�� 7000�� Character '7000'���� �ڵ� ����ȯ�Ǿ�,
    �ش� true���鸸 return*/
select salary
from employees
where salary = '7000';

--Date -> Character
select hire_date || ''
from employees;

--Number -> Character
select salary || ''
from employees;

--single function �� �̿��� Date -> Character
select to_char(hire_date)
from employees;

--single function �� �̿��� ����ȯ�� ���ÿ� ���� ����.
select to_char(sysdate, 'yyyy-mm-dd')
from dual;

--��¥�� spelling(����)�� ǥ���Ѵ�.
--���� ���Ӹ�(DY)
select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual;

--ù���ڸ� �빮��, ������ �ҹ��ڷ� ���
select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;

--������ ���� Number�� ���.
select to_char(sysdate, 'd')
from dual;

select last_name, hire_date,
    to_char(hire_date, 'day'),
    to_char(hire_date, 'd')
from employees;

-- ����: �� ���̺��� �����Ϻ��� �Ի��ϼ� �������� �����϶�.
select last_name, hire_date,
    to_char(hire_date, 'day') day
from employees
order by to_char(hire_date - 1, 'd'), hire_date;

--��, ��, ���� ǥ��
select to_char(sysdate, 'hh24:mi:ss am')
from dual;

--form�� �Ϲ� ���ڿ��� ���� �� �ִ�.
select to_char(sysdate, 'DD "of" Month')
from dual;

select to_char(hire_date, 'DD Month YY')
from employees;
--�� �ڵ��� ��� ���̺� ��Ÿ���� ������ space�� �����ؼ� ������.
select to_char(hire_date, 'fmDD Month YY')
from employees;

-- ����: ������� �̸�, �Ի���, �λ������� ��ȸ�϶�.
--       �λ������� �Ի����� 3���� �� ù��° �������̴�.
select last_name, hire_date,
    next_day(add_months(hire_date, 3), 'monday') evaluation
from employees;