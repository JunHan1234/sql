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

--오늘의 요일에 해당하는 Number값 출력.
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

--9 -> 형식에 값을 채울때, 해당 자릿수에 값이 없으면 내버려둔다.
--0 -> 형식에 값을 채울때, 해당 자릿수에 값이 없으면 0으로 채운다.
select '|' || to_char(12.12, '9999.99') || '|',
    '|' || to_char(12.12, '0000.00') || '|'
from dual;

--space 삭제. fill mode(fm)
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

--null값을 없애는 function "NVL"
select nvl(null, 0)
from dual;

select job_id, nvl(commission_pct, 0)
from employees;

-- 과제: 사원들의 이름, 직업, 연봉을 조회하라.
select last_name, job_id,
    salary * (1 + nvl(commission_pct, 0)) * 12 ann_sal
from employees
order by ann_sal desc;

-- 과제: 사원들의 이름, 커미션율을 조회하라.
--       커미션이 없으면, No Commission 을 표시한다.
select last_name, nvl(to_char(commission_pct), 'No Commission')
from employees;

-- 기준값을 보고 값이 있으면 첫번째 return, null이면 두번째를 return.
select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees;

-- 두번째 0은 숫자 0으로 자동형변환된 것이다.
select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income
from employees;

-- nullif의 첫째 값과 둘째 값이 다르면 첫째 값 return, 
--          같다면 null return.
select first_name, last_name,
    nullif(length(first_name), length(last_name))
from employees;

-- 각 타입의 null값.
select to_char(null), to_number(null), to_date(null)
from dual;

-- 앞에서부터 값을 비교해서 null이 아니면 return. (처음으로 null이 아닌 값 return)
select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;

-- a에서 b로 바꾸는 "decode" (기준값, 비교값, 기본값) 기준값과 비교값의 타입은 같아야한다.
-- 월급에 따른 소득세율 계산해보는 예제이다.
-- decode의 기본값은 null 이다.
/*80번 부서 직원들의 월급을 2000으로 나눴을 때,
                0부터 해당하는 값의 세율이 return.*/
select last_name, salary,
    decode(trunc(salary / 2000),
        0, 0.00,
        1, 0.09,
        2, 0.20,
        3, 0.30,
        4, 0.40,
        5, 0.42,
        6, 0.44,
           0.45) tax_rate
from employees
where department_id = 80;

--salary는 number type이므로,
-- character type으로 형변환 했을때,
-- 'a'와 일치하는 값이 없으므로, null이 리턴됨을 확인.
select decode(salary, 'a', 1)
from employees;

--리턴된 null값에 기본값 0을 주었다.
select decode(salary, 'a', 1, 0)
from employees;

-- 비교값이 number type이라서 기준값 job_id를 변환시키려는데,
-- character를 number로 바꿀 수 없으므로, error가 발생함을 확인.
select decode(job_id, 1, 1)
from employees;

-- 과제: 사원들의 직업, 직업별 등급을 조회하라.
--       기본 등급은 null 이다.
--       IT_PROG    A
--       AD_PRES    B
--       ST_MAN     C
--       ST_CLERK   D
select job_id, decode(job_id,
                'IT_PROG',  'A',
                'AD_PRES',  'B',
                'ST_MAN',   'C',
                'ST_CLERK', 'D') job_grade
from employees
order by job_grade;

--case 기준값 when 비교값 then 리턴값.
select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees;

select case job_id when '1' then 1
                   when '2' then 2
                   else 0
        end grade
from employees;

-- 기준으로 삼는 값 뒤에오는 비교하는 값들은 type을 통일해야한다.
select case job_id when '1' then '1'
                   when '2' then '2'
                   else '0'
        end grade
from employees;

select case salary when 1 then '1'
                   when 2 then '2'
                   else '0'
        end grade
from employees;

select last_name, salary,
    case when salary < 5000 then 'low'
         when salary < 10000 then 'medium'
         when salary < 20000 then 'high'
         else 'good'
    end grade
from employees
order by salary desc;

-- 과제: 사원들의 이름, 입사일, 입사요일을 월요일부터 요일순으로 조회하라.
/*order by 절에 case 절을 활용함을 확인.*/
select last_name, hire_date, to_char(hire_date, 'fmday') day
from employees
order by case day
         when 'monday' then 1
         when 'tuesday' then 2
         when 'wednesday' then 3
         when 'thursday' then 4
         when 'friday' then 5
         when 'saturday' then 6
         else 7
    end;

-- 과제: 2005년 이전에 입사한 사원들에게 100만원 상품권,
--       2005년 후에 입사한 사원들에게 10만원 상품권을 지급한다.
--       사원들의 이름, 입사일, 상품권 금액을 조회하라.
-- 정답:
select last_name, hire_date,
    case when hire_date <= '2005/12/31' then '100만원'
        else '10만원' end gift
from employees
order by gift, hire_date;
/*select last_name, hire_date,
    case when to_number(to_char(hire_date, 'yyyy')) <= 2005 then '1,000,000'
    else '100,000'
    end gift
from employees
order by gift, hire_date;*/