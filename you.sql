--10���� ���弱.
select tname
from tab;

drop table depts cascade constraints;
drop table emps cascade constraints;
--DDL
create table depts(
/*DB�� ���Ἲ�� Ȯ���ϱ� ���� ��������(constraint)�� ����.*/
/*�������Ǹ�: table��_column��_key����*/
department_id number(3) constraint depts_deptid_pk primary key,
department_name varchar2(20));

desc user_constraints

select constraint_name, constraint_type, table_name
from user_constraints;

create table emps(
/*primary key�� Ư¡: not null, unique�� ���� ���̴�.
                        pk = not null + unique */
employee_id number(3) primary key,
emp_name varchar2(10) constraint emps_empname_nn not null,
email varchar2(20),
/*salary�� field���� check*/
salary number(6) constraint emps_sal_ck check(salary > 1000),
/*constraint ���� -> �ڵ����� sql�� constraint �̸� ������.
                        35�࿡�� Ȯ���غ���.*/
department_id number(3),
/*table level�� constraint �˻�. email field value ���� �˻�.*/
constraint emps_email_uk unique(email),
/*foreign key�� relationship�� ǥ���ϱ� ���� references ���.*/
constraint emps_deptid_fk foreign key(department_id)
    references depts(department_id));

--���������� �� ��������� Ȯ��.
select constraint_name, constraint_type, table_name
from user_constraints;

--data insert
insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gmail.com', 5000, 100);
/*�������� ���� �����غ���.*/
--insert into emps values(501, 'a', 'a@gmail.com', 2000, 100);
/*table�� �������� ��� ��������� �Ѵ�.*/
drop table emps cascade constraints;
--���������� �� ������� Ȯ��.
select constraint_name, constraint_type, table_name
from user_constraints;

select *
from depts;

------------------------------------------------------------
/*system user�� �����ϴ� �κ�*/
--system user�� hr.departments�� ��� ������ you���� ��밡���ϰ� grant �ϴ�.
grant all on hr.departments to you;

------------------------------------------------------------
/*you user�� �����ϴ� �κ�*/
drop table employees cascade constraints;

create table employees(
employee_id number(6) constraint emp_empid_pk primary key,
first_name varchar2(20),
last_name varchar2(25) constraint emp_lastname_nn not null,
/*email column�� �������� 2�� �ο�.*/
email varchar2(25) constraint emp_email_nn not null
                    constraint emp_email_uk unique,
phone_number varchar2(20),
hire_date date constraint emp_hiredate_nn not null,
job_id varchar2(10) constraint emp_jobid_nn not null,
salary number(8) constraint emp_salary_ck check(salary > 0),
commission_pct number(2, 2),
manager_id number(6) constraint emp_managerid_fk 
                            references employees(employee_id),
department_id number(4) constraint emp_dept_fk 
                            references hr.departments(department_id));
                            
select * from employees;
------------------------------------------------------------
drop table gu cascade constraints;
drop table dong cascade constraints;
drop table dong2 cascade constraints;
/*�θ�� �ڽ� table ����*/
create table gu (
gu_id number(3) primary key,
gu_name char(9) not null);

create table dong (
dong_id number(4) primary key,
dong_name varchar2(12) not null,
/*gu�� dong ������ relationship�� references�� ǥ��*/
/*on delete cascade �� �θ� ���̺��� �������� ���� ��������� �� ��.*/
gu_id number(3) references gu(gu_id) on delete cascade);

create table dong2 (
dong_id number(4) primary key,
dong_name varchar2(12) not null,
/*on delete set null �� �θ� ���̺��� �������� ���� null�� �ٲ�� �� ��.*/
gu_id number(3) references gu(gu_id) on delete set null);

/*�θ�, �ڽ� table�� data insert.*/
insert into gu values(100, '������');
insert into gu values(200, '�����');

insert into dong values(5000, '�б�����', null);
insert into dong values(5001, '�Ｚ��', 100);
insert into dong values(5002, '���ﵿ', 100);
insert into dong values(6001, '��赿', 200);
insert into dong values(6002, '�߰赿', 200);

insert into dong2
select * from dong;

select * from gu;
select * from dong;

delete gu
where gu_id = 100;

select * from dong;     /*delete cascade�� ȿ��*/
select * from dong2;    /*delete set null�� ȿ��*/

commit;
------------------------------------------------------------
drop table a cascade constraints;
drop table b cascade constraints;

create table a (
aid number(1) constraint a_aid_pk primary key);

create table b (
bid number(2),
aid number(1),
/*a table�� aid column�� b table�� �����ͼ� �̿�.*/
constraint b_aid_fk foreign key(aid) references a(aid));

insert into a values(1);
insert into b values(31, 1);
-- a table�� ���� ���� b table���� ����� ����.
insert into b values(32, 9);/*������������ insert �Ұ�.*/

/*table b�� b_aid_fk�� �������� ����.*/
alter table b disable constraint b_aid_fk;
insert into b values(32, 9);/*�������� ���� �� insert ����.*/
select * from b;

/*�̹� table b�� �θ����̺� ���� 9�� �����ϱ⿡ ���� �缳�� �Ұ�.*/
alter table b enable constraint b_aid_fk;
/*���� ���� �缳��.*/
alter table b enable novalidate constraint b_aid_fk;

/*�������� ��Ȱ�� �θ� ���� key(8)�� insert �Ұ���.*/
insert into b values(33, 8);

/*hr.departments���� sub_departments�� column �����ؼ� table�����ϱ�.*/
drop table sub_departments cascade constraints;
drop table users cascade constraints;

create table sub_departments as
    select department_id dept_id, department_name dept_name
    from hr.departments;
--�� ������� Ȯ��.
select * from sub_departments;

--table ���� �����.
create table users(
user_id number(3));
desc users
--column �߰� add(insert).
alter table users add(user_name varchar2(10));
desc users
--column type update.
alter table users modify(user_name number(7));
desc users
--column delete
alter table users drop column user_name;
desc users

insert into users values(1);

-- table users�� �б� �������� ����
alter table users read only;
-- user_name column�� �� �߰� �Ұ������� Ȯ��.
insert into users values(2);

-- table users�� �ٽ� �б⾲�� �����ϰ� ����
alter table users read write;
-- user_name column�� �� �߰� ������.
insert into users values(2);

commit;

select *
from users;