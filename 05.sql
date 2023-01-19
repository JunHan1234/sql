--group function :return ���� row �ϳ��̴�.(single function���� �������̴�.)
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

/*date type�� SQL�󿡼� DB�� long type�� ���ڷ� �����Ѵ�.
 �츮�� physical�ϰ� ���⿡�� character type�ε� ���δ�.*/
select min(hire_date), max(hire_date)
from employees;

-- ����: �ְ���ް� �ּҿ����� ������ ��ȸ�϶�.
select max(salary) - min(salary)
from employees;

-- ��� Į���� ��ȸ -> row ������ ���� ��.
select count(*)
from employees;

-- ����: 70�� �μ����� ������� ��ȸ�϶�.
select count(*)
from employees
where department_id = 70;

select count(employee_id)
from employees;

--group function�� Ư¡: null��(����)�� �����ʰ�, �����Ѵ�.
--primary key�� ������ field�� null���� ���⶧����,
--group function�� ����ص� �����ϴ�.
select count(manager_id)
from employees;

--����������� commission �����.
select avg(commission_pct)
from employees;

-- ����: ������ ��� Ŀ�̼����� ��ȸ�϶�.
-- ����: nvl�� null���� 0���� ����� avg�� ����Ѵ�.
select avg(nvl(commission_pct, 0))
from employees;
/*select sum(commission_pct) / count(employee_id)
from employees;*/

--�⺻�� all��.(��������)
select avg(all salary)
from employees;

--�ߺ��� ���� �����ϴ� distinct.
select avg(distinct salary)
from employees;

-- ����: ������ ��ġ�� �μ� ������ ��ȸ�϶�.
select count(distinct department_id)
from employees;

-- ����: �Ŵ��� ���� ��ȸ�϶�.
select count(distinct manager_id)
from employees;

-- group by���� Ȱ��.
/*department_id�������� employee_id�� ���°��̹Ƿ�, 
            department_id�� group���� ���ش�.*/
select department_id, count(employee_id)
from employees
group by department_id
order by department_id;

select employee_id
from employees
where department_id = 30;

/*����, �������� group by expression�� select���� ���;��Ѵ�.*/
select department_id, job_id, count(employee_id)
from employees
group by department_id, job_id
order by department_id;

-- ����: ������ ������� ��ȸ�϶�.
select job_id, count(employee_id)
from employees
group by job_id;

-- group�� ���� ���ǹ� "having"
select department_id, max(salary)
from employees
group by department_id
having department_id > 50;

-- having�������� group�Լ��� ��밡���ϴ�.
select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

-- ���ǹ��� ������ ������ ���˾Ƶ�´�. �������� Ȯ��.
select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000;

select department_id, max(salary) max_sal
from employees
where max_sal > 10000
group by department_id;

-- where ���� group function ���Ұ�.
select department_id, max(salary)
from employees
where max(salary) > 10000
group by department_id;

-- ���ռ�����Ʈ. ����� ��� ���� ����.
select job_id, sum(salary) payroll
from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 13000
order by payroll;

-- ����: �Ŵ���ID, �Ŵ����� ���� ������ �� �ּҿ����� ��ȸ�϶�.
--       �ּҿ����� $6,000 �ʰ����� �Ѵ�.
select manager_id, min(salary) min_sal
from employees
where manager_id is not null /*where manager_id != employee_id*/
group by manager_id
having min(salary) > 6000
order by min_sal desc;

--function �� function
select max(avg(salary))
from employees
group by department_id;

--group function�� 2�������� ��ø��밡��. 3���̻��� ����.
select sum(max(avg(salary)))
from employees
group by department_id;

select department_id, round(avg(salary))
from employees
group by department_id;

-- group by �� ���̴� group function ���Ұ�.
select department_id, round(avg(salary))
from employees;

-- ����: 2001��, 2002��, 2003�⵵�� �Ի��� ���� ��ȸ�϶�.
select sum(decode(to_char(hire_date, 'yyyy'), '2001', 1, 0)) "2001",
    sum(decode(to_char(hire_date, 'yyyy'), '2002', 1, 0)) "2002",
    sum(decode(to_char(hire_date, 'yyyy'), '2003', 1, 0)) "2003"
from employees;
/*
select count(case when hire_date like '2001%' then 1 else null end) "2001",
    count(case when hire_date like '2002%' then 1 else null end) "2002",
    count(case when hire_date like '2003%' then 1 else null end) "2003"
from employees;
*/
/*
select to_char(hire_date, 'yyyy') year, count(employee_id)
from employees
where to_char(hire_date, 'yyyy') in (2001, 2002, 2003)
group by to_char(hire_date, 'yyyy')
order by year;
*/

-- ����: ������, �μ��� �������� ��ȸ�϶�.
--       �μ��� 20, 50, 80 �̴�.
select job_id, sum(decode(department_id, 20, salary)) "20",
    sum(decode(department_id, 50, salary)) "50",
    sum(decode(department_id, 80, salary)) "80"
from employees
group by job_id;
/*
select job_id, sum(case department_id when 20 then salary else null end) "20",
            sum(case department_id when 50 then salary else null end) "50",
            sum(case department_id when 80 then salary else null end) "80"
from employees
group by job_id;
*/