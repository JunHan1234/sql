select *
from departments;

select department_id, location_id
from departments;

/*language 이기 때문에 ;로 마무리한다.*/
select location_id, department_id
from departments;

/*column 유형을 스크립트로 출력. command 이기 때문에 ;로 마무리하지 않는다.*/
desc departments

--select 절에서, expression의 사용.
select last_name, salary, salary + 300
from employees;

-- 과제: 사원들의 월급, 연봉을 조회하라.
select salary, salary * 12
from employees;

--sql에서도 연산자 우선순위가 존재한다.
select last_name, salary, 12 * salary + 100
from employees;

select last_name, salary, 12 * (salary + 100)
from employees;

select last_name, job_id, commission_pct
from employees;

select last_name, job_id, 12 * salary + (12 * salary * commission_pct)
from employees;

/*as는 생략 가능하다.*/
select last_name as name, commission_pct comm 
from employees;

/*""로 대소문자 구별 가능하다.*/
select last_name "Name", salary * 12 "Annual Salary"
from employees;

-- 과제: 사원들의 사번, 이름, 직업, 입사일(STARTDATE)을 조회하라.

-- 과제: 사원들의 사번(Emp #), 이름(Name), 직업(Job), 입사일(Hire Date)을 조회하라.

select employee_id, last_name, job_id, hire_date startdate
from employees;

select employee_id "Emp #", last_name "Name", job_id "Job", hire_date "Hire Date"
from employees;

/*붙이기 연산자 ||를 이용하여 column을 하나로 만든다.*/
--필드값들이 띄어쓰기 없이 붙는것을 확인.
select last_name || job_id
from employees;

/*is와 같은 상수를 쓸수도 있다.*/
--필드값 사이에 ' is ' 삽입이 되는것을 확인.
select last_name || ' is ' || job_id
from employees;

/*column 명(last_name || ' is ' || job_id)을 별명 employee로 표현했다.*/
--필드 label은 별명으로 바뀌고, 필드값들은 is로 연결되는것을 확인.
select last_name || ' is ' || job_id employee
from employees;

/*null 값은 parsing 한다.*/
select last_name || null
from employees;

/*commission_pct field의 null값들이 parsing 되는것을 확인하자.*/
select last_name || commission_pct
from employees;

/*아래 3개의 예제는 expression의 뒷부분(char type이 아닌것)이 character type으로 변환되어 합쳐져 출력된다.*/
select last_name || salary
from employees;

select last_name || hire_date
from employees;

select last_name || (salary * 12)
from employees;

-- 과제: 사원들의 '이름, 직업'(Emp and Title)을 조회하라.
select last_name || ', ' || job_id "Emp and Title"
from employees;