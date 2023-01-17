-- where 의 활용 
/*같다를 표현하는 연산자 = */
select employee_id, last_name, department_id
from employees
where department_id = 50;

-- 과제: 176번 사원의 사번, 이름, 부서번호를 조회하라.
select employee_id, last_name, department_id
from employees
where employee_id = 176;

/*data에서는 대소문자가 구별된다.*/
select employee_id, last_name, department_id
from employees
where last_name = 'Whalen';

/*date type의 검색은 char type을 이용한다.*/
select employee_id, last_name, hire_date
from employees
where hire_date = '2008/02/06';

select last_name, salary
from employees
where salary <= 3000;

-- 과제: 월 $12,000 이상 버는 사원들의 이름, 월급을 조회하라.
select last_name, salary
from employees
where salary >= 12000;

/*다르다 연산자 != */
select last_name, job_id
from employees
where job_id != 'IT_PROG';

/*범위를 표현, 여기서는 이상 이하*/
select last_name, salary
from employees
where salary between 2500 and 3500;

/*K에서 S값 까지의 character를 출력*/
select last_name
from employees
where last_name between 'King' and 'Smith';

-- 과제: 'King' 사원의 first_name, last_name, 직업, 월급을 조회하라.
select first_name, last_name, job_id, salary
from employees
where last_name = 'King';

select last_name, hire_date
from employees
where hire_date between '2002/01/01' and '2002/12/31';

/*n번 사원을 상사로 두는 사원을 출력.*/
select employee_id, last_name, manager_id
from employees
where manager_id in (100, 101, 201);

-- 조건 n개를 나열.
select employee_id, last_name, manager_id
from employees
where manager_id = 100 or
    manager_id = 101 or
    manager_id = 201;

-- 조건이 포함된 항목을 출력.
select employee_id, last_name
from employees
where last_name in ('Hartstein', 'Vargas');

select last_name, hire_date
from employees
where hire_date in ('2003/06/17', '2005/09/21');

-- 비슷하다 '같다부분 + 와일드카드(%)'
-- 첫 글자가 S인 사원명을 호출한다.
select last_name
from employees
where last_name like 'S%';

-- 끝나는 글자가 r인 사원명을 호출한다.
select last_name
from employees
where last_name like '%r';

-- 과제: 이름에 s 가 포함된 사원들의 이름을 조회하라.
select last_name
from employees
where last_name like 'S%' or 
    last_name like '%s'; /*틀림. 요구사항의 대소문자와 위치를 구별하라.*/

--정답 
select last_name
from employees
where last_name like '%s%';

-- 과제: 2005년에 입사한 사원들의 이름, 입사일을 조회하라.
select last_name, hire_date
from employees
where hire_date like '2005%';