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

--������ ���Ͽ� �ش��ϴ� Number�� ���.
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

--9 -> ���Ŀ� ���� ä�ﶧ, �ش� �ڸ����� ���� ������ �������д�.
--0 -> ���Ŀ� ���� ä�ﶧ, �ش� �ڸ����� ���� ������ 0���� ä���.
select '|' || to_char(12.12, '9999.99') || '|',
    '|' || to_char(12.12, '0000.00') || '|'
from dual;

--space ����. fill mode(fm)
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

--null���� ���ִ� function "NVL"
select nvl(null, 0)
from dual;

select job_id, nvl(commission_pct, 0)
from employees;

-- ����: ������� �̸�, ����, ������ ��ȸ�϶�.
select last_name, job_id,
    salary * (1 + nvl(commission_pct, 0)) * 12 ann_sal
from employees
order by ann_sal desc;

-- ����: ������� �̸�, Ŀ�̼����� ��ȸ�϶�.
--       Ŀ�̼��� ������, No Commission �� ǥ���Ѵ�.
select last_name, nvl(to_char(commission_pct), 'No Commission')
from employees;

-- ���ذ��� ���� ���� ������ ù��° return, null�̸� �ι�°�� return.
select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees;

-- �ι�° 0�� ���� 0���� �ڵ�����ȯ�� ���̴�.
select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income
from employees;

-- nullif�� ù° ���� ��° ���� �ٸ��� ù° �� return, 
--          ���ٸ� null return.
select first_name, last_name,
    nullif(length(first_name), length(last_name))
from employees;

-- �� Ÿ���� null��.
select to_char(null), to_number(null), to_date(null)
from dual;

-- �տ������� ���� ���ؼ� null�� �ƴϸ� return. (ó������ null�� �ƴ� �� return)
select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;

-- a���� b�� �ٲٴ� "decode" (���ذ�, �񱳰�, �⺻��) ���ذ��� �񱳰��� Ÿ���� ���ƾ��Ѵ�.
-- ���޿� ���� �ҵ漼�� ����غ��� �����̴�.
-- decode�� �⺻���� null �̴�.
/*80�� �μ� �������� ������ 2000���� ������ ��,
                0���� �ش��ϴ� ���� ������ return.*/
select last_name, salary,
    decode(trunc(salary / 2000),
        0, 0.00,
        1, 0.09,
        2, 0.20,
        3, 0.30,
        4, 0.40,
        5, 0.42,
        6, 0.44,
           0.45) tax_rate
from employees
where department_id = 80;

--salary�� number type�̹Ƿ�,
-- character type���� ����ȯ ������,
-- 'a'�� ��ġ�ϴ� ���� �����Ƿ�, null�� ���ϵ��� Ȯ��.
select decode(salary, 'a', 1)
from employees;

--���ϵ� null���� �⺻�� 0�� �־���.
select decode(salary, 'a', 1, 0)
from employees;

-- �񱳰��� number type�̶� ���ذ� job_id�� ��ȯ��Ű���µ�,
-- character�� number�� �ٲ� �� �����Ƿ�, error�� �߻����� Ȯ��.
select decode(job_id, 1, 1)
from employees;

-- ����: ������� ����, ������ ����� ��ȸ�϶�.
--       �⺻ ����� null �̴�.
--       IT_PROG    A
--       AD_PRES    B
--       ST_MAN     C
--       ST_CLERK   D
select job_id, decode(job_id,
                'IT_PROG',  'A',
                'AD_PRES',  'B',
                'ST_MAN',   'C',
                'ST_CLERK', 'D') job_grade
from employees
order by job_grade;

--case ���ذ� when �񱳰� then ���ϰ�.
select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees;

select case job_id when '1' then 1
                   when '2' then 2
                   else 0
        end grade
from employees;

-- �������� ��� �� �ڿ����� ���ϴ� ������ type�� �����ؾ��Ѵ�.
select case job_id when '1' then '1'
                   when '2' then '2'
                   else '0'
        end grade
from employees;

select case salary when 1 then '1'
                   when 2 then '2'
                   else '0'
        end grade
from employees;

select last_name, salary,
    case when salary < 5000 then 'low'
         when salary < 10000 then 'medium'
         when salary < 20000 then 'high'
         else 'good'
    end grade
from employees
order by salary desc;

-- ����: ������� �̸�, �Ի���, �Ի������ �����Ϻ��� ���ϼ����� ��ȸ�϶�.
/*order by ���� case ���� Ȱ������ Ȯ��.*/
select last_name, hire_date, to_char(hire_date, 'fmday') day
from employees
order by case day
         when 'monday' then 1
         when 'tuesday' then 2
         when 'wednesday' then 3
         when 'thursday' then 4
         when 'friday' then 5
         when 'saturday' then 6
         else 7
    end;

-- ����: 2005�� ������ �Ի��� ����鿡�� 100���� ��ǰ��,
--       2005�� �Ŀ� �Ի��� ����鿡�� 10���� ��ǰ���� �����Ѵ�.
--       ������� �̸�, �Ի���, ��ǰ�� �ݾ��� ��ȸ�϶�.
-- ����:
select last_name, hire_date,
    case when hire_date <= '2005/12/31' then '100����'
        else '10����' end gift
from employees
order by gift, hire_date;
/*select last_name, hire_date,
    case when to_number(to_char(hire_date, 'yyyy')) <= 2005 then '1,000,000'
    else '100,000'
    end gift
from employees
order by gift, hire_date;*/