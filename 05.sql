--group function :return 값은 row 하나이다.(single function과의 공통점이다.)
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

/*date type은 SQL상에서 DB에 long type의 숫자로 저장한다.
 우리가 physical하게 보기에는 character type인듯 보인다.*/
select min(hire_date), max(hire_date)
from employees;

-- 과제: 최고월급과 최소월급의 차액을 조회하라.
select max(salary) - min(salary)
from employees;

-- 모든 칼럼을 조회 -> row 갯수를 세는 것.
select count(*)
from employees;

-- 과제: 70번 부서원이 몇명인지 조회하라.
select count(*)
from employees
where department_id = 70;

select count(employee_id)
from employees;

--group function의 특징: null값(사장)은 세지않고, 무시한다.
--primary key로 지정된 field는 null값이 없기때문에,
--group function을 사용해도 안전하다.
select count(manager_id)
from employees;

--영업사원들의 commission 평균율.
select avg(commission_pct)
from employees;

-- 과제: 조직의 평균 커미션율을 조회하라.
-- 정답: nvl로 null값을 0으로 만들고 avg를 계산한다.
select avg(nvl(commission_pct, 0))
from employees;
/*select sum(commission_pct) / count(employee_id)
from employees;*/

--기본은 all값.(생략가능)
select avg(all salary)
from employees;

--중복된 값을 제거하는 distinct.
select avg(distinct salary)
from employees;

-- 과제: 직원이 배치된 부서 개수를 조회하라.
select count(distinct department_id)
from employees;

-- 과제: 매니저 수를 조회하라.
select count(distinct manager_id)
from employees;

-- group by절의 활용.
/*department_id기준으로 employee_id를 세는것이므로, 
            department_id를 group으로 써준다.*/
select department_id, count(employee_id)
from employees
group by department_id
order by department_id;

select employee_id
from employees
where department_id = 30;

/*따라서, 논리적으로 group by expression은 select절에 나와야한다.*/
select department_id, job_id, count(employee_id)
from employees
group by department_id, job_id
order by department_id;

-- 과제: 직업별 사원수를 조회하라.
select job_id, count(employee_id)
from employees
group by job_id;

-- group에 대한 조건문 "having"
select department_id, max(salary)
from employees
group by department_id
having department_id > 50;

-- having절에서는 group함수를 사용가능하다.
select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

-- 조건문에 별명을 적으면 못알아듣는다. 오류뜸을 확인.
select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000;

select department_id, max(salary) max_sal
from employees
where max_sal > 10000
group by department_id;

-- where 절에 group function 사용불가.
select department_id, max(salary)
from employees
where max(salary) > 10000
group by department_id;

-- 종합선물세트. 배웠던 모든 문법 등장.
select job_id, sum(salary) payroll
from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 13000
order by payroll;

-- 과제: 매니저ID, 매니저별 관리 직원들 중 최소월급을 조회하라.
--       최소월급이 $6,000 초과여야 한다.
select manager_id, min(salary) min_sal
from employees
where manager_id is not null /*where manager_id != employee_id*/
group by manager_id
having min(salary) > 6000
order by min_sal desc;

--function 속 function
select max(avg(salary))
from employees
group by department_id;

--group function은 2개까지만 중첩사용가능. 3개이상은 오류.
select sum(max(avg(salary)))
from employees
group by department_id;

select department_id, round(avg(salary))
from employees
group by department_id;

-- group by 절 없이는 group function 사용불가.
select department_id, round(avg(salary))
from employees;

-- 과제: 2001년, 2002년, 2003년도별 입사자 수를 조회하라.
select sum(decode(to_char(hire_date, 'yyyy'), '2001', 1, 0)) "2001",
    sum(decode(to_char(hire_date, 'yyyy'), '2002', 1, 0)) "2002",
    sum(decode(to_char(hire_date, 'yyyy'), '2003', 1, 0)) "2003"
from employees;
/*
select count(case when hire_date like '2001%' then 1 else null end) "2001",
    count(case when hire_date like '2002%' then 1 else null end) "2002",
    count(case when hire_date like '2003%' then 1 else null end) "2003"
from employees;
*/
/*
select to_char(hire_date, 'yyyy') year, count(employee_id)
from employees
where to_char(hire_date, 'yyyy') in (2001, 2002, 2003)
group by to_char(hire_date, 'yyyy')
order by year;
*/

-- 과제: 직업별, 부서별 월급합을 조회하라.
--       부서는 20, 50, 80 이다.
select job_id, sum(decode(department_id, 20, salary)) "20",
    sum(decode(department_id, 50, salary)) "50",
    sum(decode(department_id, 80, salary)) "80"
from employees
group by job_id;
/*
select job_id, sum(case department_id when 20 then salary else null end) "20",
            sum(case department_id when 50 then salary else null end) "50",
            sum(case department_id when 80 then salary else null end) "80"
from employees
group by job_id;
*/