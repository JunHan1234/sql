/* view ��ü */
drop view empvu80;

create view empvu80 as
    select employee_id, last_name, department_id
    from employees
    where department_id = 80;
    
desc empvu80

--�� query�� ���� ȿ���� ���ϰ� �ȴ�.
select *
from empvu80;
select *
from (select employee_id, last_name, department_id
        from employees
        where department_id = 80);
        
--view �����ϱ�
create or replace view empvu80 as
    select employee_id, job_id
    from employees
    where department_id = 80;

desc empvu80

------------------------------------------------------------
-- ����: 50�� �μ������� ���, �̸�, �μ���ȣ�� ������ DEPT50 view�� ������.
--       view ������ EMPNO, EMPLOYEE, DEPTNO �̴�.
drop view dept50 cascade constraints;
drop table teams cascade constraints;
drop view team50 cascade constraints;
/*������ ans*/
create or replace view dept50(empno, employee, deptno) as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50;
/*�� ans*/
create view dept50 as
    select employee_id empno, last_name employee, department_id deptno
    from employees
    where department_id = 50;
    
desc dept50

select *
from dept50;

-- with check option ���� �������� �߰�
-- 50�� �μ��� �ƴϸ� insert �Ұ����� �ǹ�.
create or replace view dept50(empno, employee, deptno) as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50
    with check option constraint dept50_ch;
    
------------------------------------------------------------
-- with check option Ȯ���غ���.
create table teams as
    select department_id team_id, department_name team_name
    from hr.departments;
    
create view team50 as
    select *
    from teams
    where team_id = 50;

select * from team50;

--teams table���� 27�� �μ� ����
select * from teams;
select count(*) from teams;

--view�� ���� insert
insert into team50
values(300, 'Marketing');
--�� �ڵ尡 teams table�� insert�Ǿ� �μ��� 28���� ����.
select * from teams;
select count(*) from teams;

--check option���� 50�� �μ� check option�� update ����.
create or replace view team50 as
    select *
    from teams
    where team_id = 50
    with check option;
    
insert into team50 values(50, 'IT Support');
--insert�� �����Ͽ� �μ��� 29���� ����.
select count(*) from teams;
-- with check option�� �ɷ� insert �Ұ���.
insert into team50 values(301, 'IT Support');

-- insert update delete �ź� ����(�б� ����).
drop view empvu10 cascade constraints;

create or replace view empvu10(employee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only;
    
/*read only�̹Ƿ� insert �Ұ�.*/
insert into empvu10 values(501, 'abel', 'Sales');
select * from empvu10;

------------------------------------------------------------
/* sequence ��ü */
drop sequence team_teamid_seq;

create sequence team_teamid_seq;

select team_teamid_seq.nextval from dual; /*nextval: ���ο� ��*/
select team_teamid_seq.currval from dual; /*currval: ���簪*/

insert into teams
values(team_teamid_seq.nextval, 'Marketing');

select * from teams
where team_id < 5;

--sequence ����ȭ
drop sequence x_xid_seq;

create sequence x_xid_seq
    start with 10  /*���۰�*/
    increment by 5 /*����ġ*/
    maxvalue 20    /*�ְ�ġ*/
    nocache        /*�̸� �غ� ���ϰڴٸ� ����*/
    nocycle;       /*�ְ�ġ ���� �� ��ȯ ���Ѵ�.*/
    
select x_xid_seq.nextval from dual; /*20���� max value �ʰ��ϸ� ������.*/

-- ����: DEPT ���̺��� DEPARTMENT_ID Į���� field value�� �� sequence�� ������.
--       sequence�� 400�̻� 1000���Ϸ� �����Ѵ�. 10�� �����Ѵ�.
drop sequence dept_deptid_seq;

create sequence dept_deptid_seq
    start with 400
    increment by 10
    maxvalue 1000
    nocache
    nocycle;

select dept_deptid_seq.nextval from dual;

-- ����: �� sequence�� �̿��ؼ�, DEPT ���̺��� Education �μ��� insert�϶�.
insert into dept(department_id, department_name)
values(dept_deptid_seq.nextval, 'Education');

select * from dept;

commit;
------------------------------------------------------------
/* index ��ü */
drop index emp_lastname_idx;

create index emp_lastname_idx
on employees(last_name);
--DB������ ������ ��(index)�� �ο�. "rowid"
select last_name, rowid
from employees;

select last_name
from employees
where rowid = 'AAAEAbAAEAAAADNABe';

select index_name, index_type, table_owner, table_name
from user_indexes;

-- ����: DEPT ���̺��� DEPARTMENT_NAME �� ���� index�� ������.
create index dept_deptname_idx
on dept(department_name);

select department_name, rowid
from dept;

------------------------------------------------------------
/* synonym ��ü */
drop synonym team;
drop synonym emps;

create synonym team
for departments;

select * from team;

-- ����: EMPLOYEES ���̺� EMPS synonym �� ������.
create synonym emps
for employees;

select * from emps;