-- 테이블 생성법. auto_commit.
-- create table x (column name / data type);
create table dept(
department_id number(4),
department_name varchar2(30),
manager_id number(6),
location_id number(4)
);

-- 테이블 삭제법
drop table dept;

create table emp (
employee_id number(6),
first_name varchar2(20),
last_name varchar2(25),
email varchar2(25),
phone_number varchar2(20),
hire_date date,
job_id varchar2(10),
salary number(8, 2),
commission_pct number(2, 2),
manager_id number(6),
department_id number(4)
);

-- table에 data를 insert 해보기.
insert into dept(department_id, department_name, manager_id, location_id)
values (100, 'Public Relation', 100, 1700);

insert into dept(department_id, department_name)
values (310, 'Purchasing');

select *
from dept;

-- table 만들기 종료. (끝을 내는 습관) transaction의 끝. -> commit
commit;

insert into emp(employee_id, first_name, last_name,
                email, phone_number, hire_date,
                job_id, salary, commission_pct,
                manager_id, department_id)
values(300, 'Louis', 'Pop',
        'Pop@gmail.com', '010-378-1278', sysdate,  /*insert행에서 function(sysdate)을 넣을수 있음.*/
        'AC_ACCOUNT', 6900, null,
        205, 110);

--emp() 가로 안 내용물 생략가능.
insert into emp
values(320, 'Terry', 'Benard',
        'Benard@gmail.com', '010-637-0972', '2022/07/20',
        'AD_PRES', 5000, .2,
        100, 310);

commit;

select *
from emp;

create table sa_reps (
rep_id number(6),
rep_name varchar2(25),
salary number(8, 2),
commission_pct number(2, 2)
);

-- data를 수동으로 insert 해보기.
insert all
    into sa_reps values(1, '최한석', 20000, .1)
    into sa_reps values(2, '한아름', 30000, .12)
    select * from dual;
-- dummy table을 이용한 문법 맞추기.
commit;

select *
from sa_reps;

-- data를 자동으로 insert 해보기.
declare
    base number(6) := 400; /*할당 연산자 := */
begin
    for i in 1..10 loop
        insert into sa_reps(rep_id, rep_name, salary, commission_pct)
        values (base + i, 'n' || (base + i), base * i, i * 0.01);
    end loop; /*i 변수의 scope은 loop 내부다.*/
end;
/

commit;
/* / 가 있어야 PL/SQL의 끝을 나타낼 수 있다.
     프로시저가 성공적으로 완료됨을 확인.*/

select *
from sa_reps
where rep_id > 400;

-- 다른 table의 data를 나만의 table에 insert 해보기.
insert into sa_reps(rep_id, rep_name, salary, commission_pct)
    select employee_id, last_name, salary, commission_pct
    from employees
    where job_id like 'SA_%';
    
commit;

select *
from sa_reps;

-- update 방법. where절을 꼭 병행사용 해야한다.
update emp
set job_id = 'IT_PROG',
    salary = 30000
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

update emp
set salary = null
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

-- commit 전이라면 아직 transaction이 진행중이므로,
-- rollback으로 마지막 commit 시점으로 회귀 가능.
rollback;

select job_id, salary
from emp
where employee_id = 300;


update emp
set job_id = (select job_id
                from employees
                where employee_id = 205), 
    salary = (select salary
                from employees
                where employee_id = 205)
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

rollback;

select job_id, salary
from emp
where employee_id = 300;

--136행을 좋은 코드로 수정
update emp
set (job_id, salary) = (select job_id, salary
                        from employees
                        where employee_id = 205)
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

commit; /*transaction의 끝.*/


-- delete 방법.
delete dept
where department_id = 310;

select * from dept;

rollback;

select * from dept;

delete emp
where department_id = (select department_id
                        from departments
                        where department_name = 'Purchasing');
                        
select * from emp;

commit;