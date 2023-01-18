-- where 의 활용 
/*같다를 표현하는 연산자 = */
-- 피연산자의 type이 같아야 한다.
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

-- 비슷하다 '같다부분 + 와일드카드(%, 임의의 0개이상의 문자)'
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

/*임의의 한글자에 해당하는 와일드카드 _*/
select last_name
from employees
where last_name like 'K___';

-- 과제: 이름의 두번째 글자가 o 인 사원의 이름을 조회하라.
select last_name
from employees
where last_name like '_o%';

/*와일드카드와 똑같은 _ 를 처리하는법 -> \ 다음으로 오는 문자는 그냥 문자이다.*/
--escape 문자는 지정 가능하다.
select job_id
from employees;

select last_name, job_id
from employees
where job_id like 'I_\_%' escape '\';

select last_name, job_id
from employees
where job_id like 'I_[_%' escape '[';

-- 과제: 직업에 _R이 포함된 사원들의 이름, 직업을 조회하라.
select last_name, job_id
from employees
where job_id like '%\_R%' escape '\';

-- where절은 true값을 return하는 구문이다. expression에 null이 섞이면 null값으로 일관된다.
select employee_id, last_name, manager_id
from employees;

-- 따라서 where절 옆의 expression이 null이므로, 값이 null이다.
select last_name, manager_id
from employees
where manager_id = null;

-- 그러므로, = 연산자 대신 is 를 활용하여 요소값을 찾아낸다.
select last_name, manager_id
from employees
where manager_id is null;

-- 논리 연산자 and
select last_name, job_id, salary
from employees
where salary >= 5000 and job_id like '%IT%';

-- 논리 연산자 or
select last_name, job_id, salary
from employees
where salary >= 5000 or job_id like '%IT%';

-- 과제: 월급이 $5000 이상 $12000 이하이다. 그리고,
--       20번이나 50번 부서에서 일한다.
--       위 사원들의 이름, 월급, 부서번호를 조회하라.
select last_name, salary, department_id
from employees
where (salary between 5000 and 12000) and
    department_id in (20, 50);
    
-- 과제: 이름에 a와 e가 포함된 사원들의 이름을 조회하라.
select last_name
from employees
where last_name like '%a%' and
    last_name like '%e%';

/*여집합의 사용. not 연산자의 활용.*/
select last_name, job_id
from employees
where job_id not in ('IT_PROG', 'SA_REP');

select last_name, salary
from employees
where salary not between 10000 and 15000;

select last_name, job_id
from employees
where job_id not like '%IT%';

/*'is null' 연산자의 부정*/
select last_name, job_id
from employees
where commission_pct is not null;

/*논리 연산자의 부정*/
select last_name, salary
from employees
where not (manager_id is null and salary >= 20000);

-- 과제: 직업이 영업이다. 그리고, 월급이 $2500, $3500가 아니다.
--       위 사원들의 이름, 직업, 월급을 조회하라.
select last_name, job_id, salary
from employees
where job_id like 'SA%' and
    salary not in (2500, 3500);

--order by 절을 이용한 오름차순 정렬 ascending (asc, 기본값이므로 생략가능)
select last_name, department_id
from employees
order by department_id;

--내림차순 정렬 descending
select last_name, department_id
from employees
order by department_id desc;

/*department_id(select절 2번째 위치)로 정렬하고 싶을 경우.*/
select last_name, department_id
from employees
order by 2;

/*별명으로 정렬*/
select last_name, department_id dept_id
from employees
order by dept_id;

/*키워드를 순위별으로 정렬(1순위 select절 2순위 from절 3순위 where절 ...)*/
select last_name, hire_date
from employees
where department_id = 100
order by hire_date;

/*1차정렬에 이은 2차정렬. n차정렬이 가능하다.*/
-- 아래 예제에서는 department_id로 오름차순 1차정렬,
-- 다음으로 salary로 내림차순 2차정렬을 했다.
select last_name, department_id, salary
from employees
where department_id > 80
order by department_id asc, salary desc;