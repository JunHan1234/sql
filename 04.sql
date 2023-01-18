--자동 형변환 Number <-> Character <-> Date
select hire_date
from employees
where hire_date = '2003/06/17';

/*Number인 salary값 7000이 Character '7000'으로 자동 형변환되어,
    해당 true값들만 return*/
select salary
from employees
where salary = '7000';

--Date -> Character
select hire_date || ''
from employees;

--Number -> Character
select salary || ''
from employees;

--single function 을 이용한 Date -> Character
select to_char(hire_date)
from employees;

--single function 을 이용한 형변환과 동시에 형식 변경.
select to_char(sysdate, 'yyyy-mm-dd')
from dual;

--날짜를 spelling(문자)로 표현한다.
--요일 줄임말(DY)
select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual;

--첫글자만 대문자, 나머지 소문자로 출력
select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;

--오늘의 요일 Number값 출력.
select to_char(sysdate, 'd')
from dual;

select last_name, hire_date,
    to_char(hire_date, 'day'),
    to_char(hire_date, 'd')
from employees;

-- 과제: 위 테이블을 월요일부터 입사일순 오름차순 정렬하라.
select last_name, hire_date,
    to_char(hire_date, 'day') day
from employees
order by to_char(hire_date - 1, 'd'), hire_date;

--시, 분, 초의 표현
select to_char(sysdate, 'hh24:mi:ss am')
from dual;

--form에 일반 문자열을 섞을 수 있다.
select to_char(sysdate, 'DD "of" Month')
from dual;

select to_char(hire_date, 'DD Month YY')
from employees;
--위 코드의 결과 테이블에 나타나는 여분의 space를 압축해서 누른다.
select to_char(hire_date, 'fmDD Month YY')
from employees;

-- 과제: 사원들의 이름, 입사일, 인사평가일을 조회하라.
--       인사평가일은 입사한지 3개월 후 첫번째 월요일이다.
select last_name, hire_date,
    next_day(add_months(hire_date, 3), 'monday') evaluation
from employees;