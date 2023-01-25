select tname
from tab;

--DDL
create table depts(
/*DB의 무결성을 확보하기 위해 제약조건(constraint)을 쓴다.*/
/*제약조건명: table명_column명_key종류*/
department_id number(3) constraint depts_deptid_pk primary key,
department_name varchar2(20));

desc user_constraints

select constraint_name, constraint_type, table_name
from user_constraints;

create table emps(
/*constraint 생략 -> 자동으로 sql이 constraint 이름 생성함.
                        33행에서 확인해보자.*/
/*primary key의 특징: not null, unique을 합한 것이다.
                        pk = not null + unique */
employee_id number(3) primary key,
emp_name varchar2(10) constraint emps_empname_nn not null,
email varchar2(20),
/*salary의 field값을 check*/
salary number(6) constraint emps_sal_ck check(salary > 1000),
department_id number(3),
/*table level의 constraint 검사. email field value 만을 검사.*/
constraint emps_email_uk unique(email),
/*foreign key의 relationship을 표현하기 위해 references 사용.*/
constraint emps_deptid_fk foreign key(department_id)
    references depts(department_id));

--제약조건이 잘 만들어졌나 확인.
select constraint_name, constraint_type, table_name
from user_constraints;

--data insert
insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gmail.com', 5000, 100);
--/*제약조건 오류 구경해보기.*/insert into emps values(501, 'a', 'a@gmail.com', 2000, 100);

/*table과 제약조건 모두 삭제해줘야 한다.*/
drop table emps cascade constraints;
--제약조건이 잘 사라졌나 확인.
select constraint_name, constraint_type, table_name
from user_constraints;

select *
from depts;