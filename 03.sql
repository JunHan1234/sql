-- single function
-- parameter에 lower 하나 들어갔다.
desc dual

select *
from dual;

select lower('SQL Course')
from dual;

select upper('SQL Course')
from dual;

select initcap('SQL Course')
from dual;

/*대소문자 구별하는 검색.*/
select last_name
from employees
where last_name = 'higgins';

select last_name
from employees
where last_name = 'Higgins';

/*last_name의 필드들을 lower 적용 후 검색한 경우이다.*/
-- lower function의 return값을 상수 'higgins'와 비교한다.
select last_name
from employees
where lower(last_name) = 'higgins';

/*concat의 이용. parameter로 2개의 field를 받고 하나의 row을 return 한다.*/
select concat('Hello', 'World')
from dual;

/*1개의 field를 받아 하나의 field가 있는 row를 return 한다.*/
-- index 2번부터 5글자 출력.
select substr('HelloWorld', 2, 5)
from dual;

-- index 뒤에서 1번부터 1글자 출력.
select substr('Hello', -1, 1)
from dual;

select length('Hello')
from dual;

-- 'l' data가 index 3에 존재한다 라는것을 확인.
select instr('Hello', 'l')
from dual;
-- data가 없는경우, return 값이 0이다. (있는경우는 > 0 이다.)
select instr('Hello', 'w')
from dual;

/*5자리로 맞추고 빈자리에는 *을 채운다.*/
select lpad(salary, 5, '*')
from employees;

select rpad(salary, 5, '*')
from employees;

select replace('JACK and JUE', 'J', 'BL')
from dual;

--머리, 꼬리의 특정 문자를 뜯는다.
select trim('H' from 'Hello')
from dual;

select trim('l' from 'Hello')
from dual;

select trim(' ' from ' Hello ')
from dual;

-- 과제: 위 query에서 ' '가 trim 됐음을, 눈으로 확인할 수 있게 조회하라.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;

/*trim은 from을 생략해도 된다.*/
select trim(' Hello World ')
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

-- 과제: 위 query에서 where 절을 like 로 refactoring 하라.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';