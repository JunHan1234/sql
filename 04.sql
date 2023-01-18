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
--fm = fill mode 줄임말.
select to_char(hire_date, 'fmDD Month YY')
from employees;

-- 과제: 사원들의 이름, 입사일, 인사평가일을 조회하라.
--       인사평가일은 입사한지 3개월 후 첫번째 월요일이다.
--       날짜는 YYYY.MM.DD 로 표시한다.
select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date,
    to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') review_date
from employees;

--숫자 -> 문자
select to_char(salary)
from employees;

--단위 표기. (,는 1000단위로 끊고, .은 소수점 이하 자리 표기)
select to_char(salary, '$99,999.99'), to_char(salary, '$00,000.00')
from employees
where last_name = 'Ernst';

--9 -> 값이 없으면 내버려둔다. 0 -> 값이 없으면 0으로 채운다.
select '|' || to_char(12.12, '9999.99') || '|',
    '|' || to_char(12.12, '0000.00') || '|'
from dual;

--space 삭제.
select '|' || to_char(12.12, 'fm9999.99') || '|',
    '|' || to_char(12.12, 'fm0000.00') || '|'
from dual;

-- 환경설정 nls 기준으로 단위수가 표기된다. 미국 = $, 한국 = ￦
select to_char(1237, 'L9999')
from dual;

-- 과제: <이름> earns <$,월급> monthly but wants <$,월급 x 3>. 로 조회하라.
--       월급은 1000단위로 끊어서 표시하라.
select last_name || ' earns ' || to_char(salary, 'fm$99,999') ||
    ' monthly but wants ' || to_char(salary * 3, 'fm$99,999') || '.'
from employees;

-- 문자 -> 날짜
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy');

--개떡같이 말해도 찰떡같이 알아들음. factor의 형식이 불일치한데 잘 알아듣는다는 뜻.
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon  dd yy');

--error가 발생함을 확인.
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxMon  dd yy');

-- to Number
select to_number('1237')
from dual;

--형식을 모르면 error가 발생함을 확인.
select to_number('1,237.12')
from dual;

--형식을 알려주면 잘 변환시킨다.
select to_number('1,237.12', '9,999.99')
from dual;

