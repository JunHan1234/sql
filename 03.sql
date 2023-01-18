-- single function
desc dual

--single function은 row 하나를 받아서 결과 하나를 도출한다.
select *
from dual;

-- parameter에 lower 하나 들어갔다.
select lower('SQL Course')
from dual;

select upper('SQL Course')
from dual;

select initcap('SQL Course')
from dual;

/*대소문자 구별하는 검색기능의 특징.*/
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

-- index 길이 측정.
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

/*문자의 앞열이나 뒷열의 공백을 지울 경우,
                        trim은 from을 생략해도 된다.*/
select '|' || trim(' Hello World ') || '|'
from dual;

--PROG직업인 사람 중에, last_name의 n번째에 'a'문자가 존재하는지 조사.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

-- 과제: 위 query에서 where 절을 like 로 refactoring 하라.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

-- 과제: 이름이 J나 A나 M으로 시작하는 사원들의 이름, 이름의 글자수를 조회하라.
--       이름의 첫글자는 대문자, 나머지는 소문자로 출력한다.
select initcap(last_name), length(last_name)
from employees
where last_name like 'J%' or
    last_name like 'A%' or
    last_name like 'M%';
    
/*2번째 parameter는 자릿수이다.*/
--round: 반올림, trunc: 버림
select round(45.926, 2)
from dual;
select trunc(45.926, 2)
from dual;

select round(45.926, 0), round(45.923)
from dual;
select trunc(45.926, 0), trunc(45.923)
from dual;

-- 과제: 사원들의 이름, 월급, 15.5% 인상된 월급(New Salary, 정수), 인상액(Increase)을 조회하라.
select last_name, salary,
    round(salary * 1.155) "New Salary",
    round(salary * 0.155) "Increase"
from employees;

-- system의 날짜를 불러온다.
select sysdate
from dual;

-- 날짜에 산술연산을 하면 하루가 더해지고 빼진다.
select sysdate + 1
from dual;

select sysdate - 1
from dual;

--기간을 얻어낼 수 있다.
select sysdate - sysdate
from dual;

select last_name, sysdate - hire_date
from employees
where department_id = 90;

select months_between('2023/12/31', '2022/12/31')
from dual;

--n개월 수를 더한다.
select add_months('2024/01/18', 3)
from dual;

--5는 목요일을 뜻한다. -> 1월 18일 이후로 첫번째 목요일을 뜻한다.
select next_day('2023/01/18', 5)
from dual;
--문자, 약어로 요일을 표현가능하다.
select next_day('2023/01/18', 'thursday')
from dual;
select next_day('2023/01/18', 'thu')
from dual;
--달의 말일을 나타낼 수 있다.
select last_day('2023/01/18')
from dual;

-- 과제: 20년 이상 재직한 사원들의 이름, 첫월급일을 조회하라.
--       월급은 매월 말일에 지급한다.
select last_name, last_day(hire_date) "FIRST_SALARY"
from employees
where months_between(sysdate, hire_date) / 12 >= 20;

-- 과제: 사원들의 이름, 월급, 월급 그래프를 조회하라.
--       그래프는 $1000 당 * 하나를 표시한다.
select last_name, salary, rpad('*', salary / 1000, '*') sal
from employees
order by sal desc;