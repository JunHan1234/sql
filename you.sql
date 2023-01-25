select tname
from tab;

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
/*constraint ���� -> �ڵ����� sql�� constraint �̸� ������.
                        33�࿡�� Ȯ���غ���.*/
/*primary key�� Ư¡: not null, unique�� ���� ���̴�.
                        pk = not null + unique */
employee_id number(3) primary key,
emp_name varchar2(10) constraint emps_empname_nn not null,
email varchar2(20),
/*salary�� field���� check*/
salary number(6) constraint emps_sal_ck check(salary > 1000),
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
--/*�������� ���� �����غ���.*/insert into emps values(501, 'a', 'a@gmail.com', 2000, 100);

/*table�� �������� ��� ��������� �Ѵ�.*/
drop table emps cascade constraints;
--���������� �� ������� Ȯ��.
select constraint_name, constraint_type, table_name
from user_constraints;

select *
from depts;