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
--fm = fill mode ���Ӹ�.
select to_char(hire_date, 'fmDD Month YY')
from employees;

-- ����: ������� �̸�, �Ի���, �λ������� ��ȸ�϶�.
--       �λ������� �Ի����� 3���� �� ù��° �������̴�.
--       ��¥�� YYYY.MM.DD �� ǥ���Ѵ�.
select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date,
    to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') review_date
from employees;

--���� -> ����
select to_char(salary)
from employees;

--���� ǥ��. (,�� 1000������ ����, .�� �Ҽ��� ���� �ڸ� ǥ��)
select to_char(salary, '$99,999.99'), to_char(salary, '$00,000.00')
from employees
where last_name = 'Ernst';

--9 -> ���� ������ �������д�. 0 -> ���� ������ 0���� ä���.
select '|' || to_char(12.12, '9999.99') || '|',
    '|' || to_char(12.12, '0000.00') || '|'
from dual;

--space ����.
select '|' || to_char(12.12, 'fm9999.99') || '|',
    '|' || to_char(12.12, 'fm0000.00') || '|'
from dual;

-- ȯ�漳�� nls �������� �������� ǥ��ȴ�. �̱� = $, �ѱ� = ��
select to_char(1237, 'L9999')
from dual;

-- ����: <�̸�> earns <$,����> monthly but wants <$,���� x 3>. �� ��ȸ�϶�.
--       ������ 1000������ ��� ǥ���϶�.
select last_name || ' earns ' || to_char(salary, 'fm$99,999') ||
    ' monthly but wants ' || to_char(salary * 3, 'fm$99,999') || '.'
from employees;

-- ���� -> ��¥
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy');

--�������� ���ص� �������� �˾Ƶ���. factor�� ������ ����ġ�ѵ� �� �˾Ƶ�´ٴ� ��.
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon  dd yy');

--error�� �߻����� Ȯ��.
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxMon  dd yy');

-- to Number
select to_number('1237')
from dual;

--������ �𸣸� error�� �߻����� Ȯ��.
select to_number('1,237.12')
from dual;

--������ �˷��ָ� �� ��ȯ��Ų��.
select to_number('1,237.12', '9,999.99')
from dual;

