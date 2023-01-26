--10장의 연장선.
select tname
from tab;

drop table depts cascade constraints;
drop table emps cascade constraints;
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
/*primary key의 특징: not null, unique을 합한 것이다.
                        pk = not null + unique */
employee_id number(3) primary key,
emp_name varchar2(10) constraint emps_empname_nn not null,
email varchar2(20),
/*salary의 field값을 check*/
salary number(6) constraint emps_sal_ck check(salary > 1000),
/*constraint 생략 -> 자동으로 sql이 constraint 이름 생성함.
                        35행에서 확인해보자.*/
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
/*제약조건 오류 구경해보기.*/
--insert into emps values(501, 'a', 'a@gmail.com', 2000, 100);
/*table과 제약조건 모두 삭제해줘야 한다.*/
drop table emps cascade constraints;
--제약조건이 잘 사라졌나 확인.
select constraint_name, constraint_type, table_name
from user_constraints;

select *
from depts;

------------------------------------------------------------
/*system user로 실행하는 부분*/
--system user가 hr.departments의 모든 권한을 you에서 사용가능하게 grant 하다.
grant all on hr.departments to you;

------------------------------------------------------------
/*you user로 실행하는 부분*/
drop table employees cascade constraints;

create table employees(
employee_id number(6) constraint emp_empid_pk primary key,
first_name varchar2(20),
last_name varchar2(25) constraint emp_lastname_nn not null,
/*email column에 제약조건 2개 부여.*/
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
/*부모와 자식 table 연습*/
create table gu (
gu_id number(3) primary key,
gu_name char(9) not null);

create table dong (
dong_id number(4) primary key,
dong_name varchar2(12) not null,
/*gu와 dong 사이의 relationship을 references로 표현*/
/*on delete cascade 는 부모 테이블이 없어지면 같이 사라지도록 한 것.*/
gu_id number(3) references gu(gu_id) on delete cascade);

create table dong2 (
dong_id number(4) primary key,
dong_name varchar2(12) not null,
/*on delete set null 는 부모 테이블이 없어지면 값만 null로 바뀌도록 한 것.*/
gu_id number(3) references gu(gu_id) on delete set null);

/*부모, 자식 table에 data insert.*/
insert into gu values(100, '강남구');
insert into gu values(200, '노원구');

insert into dong values(5000, '압구정동', null);
insert into dong values(5001, '삼성동', 100);
insert into dong values(5002, '역삼동', 100);
insert into dong values(6001, '상계동', 200);
insert into dong values(6002, '중계동', 200);

insert into dong2
select * from dong;

select * from gu;
select * from dong;

delete gu
where gu_id = 100;

select * from dong;     /*delete cascade의 효과*/
select * from dong2;    /*delete set null의 효과*/

commit;
------------------------------------------------------------
drop table a cascade constraints;
drop table b cascade constraints;

create table a (
aid number(1) constraint a_aid_pk primary key);

create table b (
bid number(2),
aid number(1),
/*a table의 aid column을 b table에 가져와서 이용.*/
constraint b_aid_fk foreign key(aid) references a(aid));

insert into a values(1);
insert into b values(31, 1);
-- a table에 없는 값을 b table에서 만들어 보자.
insert into b values(32, 9);/*제약조건으로 insert 불가.*/

/*table b의 b_aid_fk의 제약조건 해제.*/
alter table b disable constraint b_aid_fk;
insert into b values(32, 9);/*제약조건 해제 후 insert 가능.*/
select * from b;

/*이미 table b에 부모테이블에 없는 9가 존재하기에 제약 재설정 불가.*/
alter table b enable constraint b_aid_fk;
/*강제 제약 재설정.*/
alter table b enable novalidate constraint b_aid_fk;

/*제약조건 부활로 부모에 없는 key(8)로 insert 불가능.*/
insert into b values(33, 8);

/*hr.departments에서 sub_departments로 column 복사해서 table생성하기.*/
drop table sub_departments cascade constraints;
drop table users cascade constraints;

create table sub_departments as
    select department_id dept_id, department_name dept_name
    from hr.departments;
--잘 복사됨을 확인.
select * from sub_departments;

--table 구조 변경법.
create table users(
user_id number(3));
desc users
--column 추가 add(insert).
alter table users add(user_name varchar2(10));
desc users
--column type update.
alter table users modify(user_name number(7));
desc users
--column delete
alter table users drop column user_name;
desc users

insert into users values(1);

-- table users를 읽기 전용으로 변경
alter table users read only;
-- user_name column에 값 추가 불가능함을 확인.
insert into users values(2);

-- table users를 다시 읽기쓰기 가능하게 변경
alter table users read write;
-- user_name column에 값 추가 가능함.
insert into users values(2);

commit;

select *
from users;