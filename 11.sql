/* view 객체 */
drop view empvu80;

create view empvu80 as
    select employee_id, last_name, department_id
    from employees
    where department_id = 80;
    
desc empvu80

--두 query는 같은 효과를 지니게 된다.
select *
from empvu80;
select *
from (select employee_id, last_name, department_id
        from employees
        where department_id = 80);
        
--view 수정하기
create or replace view empvu80 as
    select employee_id, job_id
    from employees
    where department_id = 80;

desc empvu80

------------------------------------------------------------
-- 과제: 50번 부서원들의 사번, 이름, 부서번호로 구성된 DEPT50 view를 만들어라.
--       view 구조는 EMPNO, EMPLOYEE, DEPTNO 이다.
drop view dept50 cascade constraints;
drop table teams cascade constraints;
drop view team50 cascade constraints;
/*강사의 ans*/
create or replace view dept50(empno, employee, deptno) as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50;
/*내 ans*/
create view dept50 as
    select employee_id empno, last_name employee, department_id deptno
    from employees
    where department_id = 50;
    
desc dept50

select *
from dept50;

-- with check option 으로 제약조건 추가
-- 50번 부서가 아니면 insert 불가함을 의미.
create or replace view dept50(empno, employee, deptno) as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50
    with check option constraint dept50_ch;
    
------------------------------------------------------------
-- with check option 확인해보기.
create table teams as
    select department_id team_id, department_name team_name
    from hr.departments;
    
create view team50 as
    select *
    from teams
    where team_id = 50;

select * from team50;

--teams table에는 27개 부서 존재
select * from teams;
select count(*) from teams;

--view를 통한 insert
insert into team50
values(300, 'Marketing');
--위 코드가 teams table에 insert되어 부서가 28개로 증가.
select * from teams;
select count(*) from teams;

--check option으로 50번 부서 check option을 update 설정.
create or replace view team50 as
    select *
    from teams
    where team_id = 50
    with check option;
    
insert into team50 values(50, 'IT Support');
--insert가 성공하여 부서가 29개로 증가.
select count(*) from teams;
-- with check option에 걸려 insert 불가능.
insert into team50 values(301, 'IT Support');

-- insert update delete 거부 설정(읽기 전용).
drop view empvu10 cascade constraints;

create or replace view empvu10(employee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only;
    
/*read only이므로 insert 불가.*/
insert into empvu10 values(501, 'abel', 'Sales');
select * from empvu10;

------------------------------------------------------------
/* sequence 객체 */
drop sequence team_teamid_seq;

create sequence team_teamid_seq;

select team_teamid_seq.nextval from dual; /*nextval: 새로운 값*/
select team_teamid_seq.currval from dual; /*currval: 현재값*/

insert into teams
values(team_teamid_seq.nextval, 'Marketing');

select * from teams
where team_id < 5;

--sequence 복잡화
drop sequence x_xid_seq;

create sequence x_xid_seq
    start with 10  /*시작값*/
    increment by 5 /*증가치*/
    maxvalue 20    /*최고치*/
    nocache        /*미리 준비 안하겠다를 설정*/
    nocycle;       /*최고치 도달 후 순환 안한다.*/
    
select x_xid_seq.nextval from dual; /*20에서 max value 초과하면 오류뜸.*/

-- 과제: DEPT 테이블의 DEPARTMENT_ID 칼럼의 field value로 쓸 sequence를 만들어라.
--       sequence는 400이상 1000이하로 생성한다. 10씩 증가한다.
drop sequence dept_deptid_seq;

create sequence dept_deptid_seq
    start with 400
    increment by 10
    maxvalue 1000
    nocache
    nocycle;

select dept_deptid_seq.nextval from dual;

-- 과제: 위 sequence를 이용해서, DEPT 테이블에서 Education 부서를 insert하라.
insert into dept(department_id, department_name)
values(dept_deptid_seq.nextval, 'Education');

select * from dept;

commit;
------------------------------------------------------------
/* index 객체 */
drop index emp_lastname_idx;

create index emp_lastname_idx
on employees(last_name);
--DB내에서 유일한 값(index)을 부여. "rowid"
select last_name, rowid
from employees;

select last_name
from employees
where rowid = 'AAAEAbAAEAAAADNABe';

select index_name, index_type, table_owner, table_name
from user_indexes;

-- 과제: DEPT 테이블의 DEPARTMENT_NAME 에 대해 index를 만들어라.
create index dept_deptname_idx
on dept(department_name);

select department_name, rowid
from dept;

------------------------------------------------------------
/* synonym 객체 */
drop synonym team;
drop synonym emps;

create synonym team
for departments;

select * from team;

-- 과제: EMPLOYEES 테이블에 EMPS synonym 을 만들어라.
create synonym emps
for employees;

select * from emps;