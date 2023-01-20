-- join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equi join
/*location_id가 같은 row끼리 병합시켜 return*/
select department_id, department_name, location_id, city
from departments natural join locations;

/*where절로 원하는 row를 고른다.*/
select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);

-- using을 사용하면, 특정 칼럼만 join한다.
-- 따라서, department_id가 true값인 것만 return.
-- manager_id는 return 안한다.
select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

-- 복습과제: 위에서 누락된 1인의 이름, 부서번호를 조회하라.
select last_name, department_id
from employees
where department_id is null;

/*netural join을 사용하면, 테이블에 있는 모든 공통 칼럼을 조회하므로,
    department_id, manager_id 두개 다 join이 된다.
    따라서, 참조하는 두 칼럼의 값이 모두 true일때만 return 한다.*/
select employee_id, last_name, department_id, location_id
from employees natural join departments;

/*생각과 코드를 일치시키면, 코드가 길다는 단점이 있다.*/
select locations.city, departments.department_name
from locations join departments
using (location_id)
where location_id = 1400;

/*별명의 사용으로 단점 보완.*/
select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400;

--using에서 사용된 칼럼에 접두사를 붙일 수 없다.
select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400;

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400;

--using에 쓰이지 않은 공통칼럼에는 접두사를 붙여야 한다.
select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where d.manager_id = 100;

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id);

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- 과제: 위 query를 using 으로 refactoring 하라.
select employee_id, city, department_name
from employees e join departments d
using (department_id)
join locations l
using (location_id);

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

-- 과제: Toronto 에 위치한 부서에서 일하는 사원들의
--       이름, 직업, 부서번호, 부서명, 도시를 조회하라.
select e.last_name, e.job_id, e.department_id,
    d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where l.city = 'Toronto';
/*
on d.location_id = l.location_id --> 조건문 1
and l.city = 'Toronto';          --> 조건문 2
로 접근해도 결과는 같다.
*/

-- non-equi join
/*IT_PROG만큼 돈을 받는 직원을 찾아라*/
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

-- self join
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

-- on, select 절에서 접두사를 빼면,
-- 어느 테이블에서 오는 칼럼인지 불명확 하므로 오류.
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on manager_id = employee_id;

select last_name emp, last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

-- 과제: 같은 부서에서 일하는 사원들의 부서번호, 이름, 동료명을 조회하라.
-- 새로운 다르다 연산자 <>
select e.department_id, e.last_name employee, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id
order by 1, 2, 3;

-- 과제: Davies 보다 후에 입사한 사원들의 이름, 입사일을 조회하라.
select e.last_name, e.hire_date
from employees e join employees d
on d.last_name = 'Davies'
and d.hire_date < e.hire_date
order by 2, 1;

-- 과제: 매니저보다 먼저 입사한 사원들의 이름, 입사일, 매니저명, 매니저 입사일을 조회하라.
select w.last_name, w.hire_date, m.last_name manager, m.hire_date m_hire_date
from employees w join employees m
on w.manager_id = m.employee_id
and m.hire_date > w.hire_date;

-- inner join
select e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

-- outer join -> join되지 않은 row도 포함시킨다. "left outer"
select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id;
-- outer join -> "right outer" departments 에서 join되지 않은 row도 포함시키고 return
select e.last_name, e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;
-- outer join -> "full outer"
select e.last_name, e.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;

-- 과제: 사원들의 이름, 사번, 매니저명, 매니저의 사번을 조회하라.
--       King 회장도 테이블에 포함하라.
select w.last_name w_name, w.employee_id w_id, m.last_name m_name, m.employee_id m_id
from employees w left outer join employees m
on w.manager_id = m.employee_id
order by 2;

-- 20세기 join의 표현. equi join, inner join의 결과물.
select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id;
-- 코드가 깔끔하기 때문에 여전히 현장에서 조직문화에 따라 쓰인다.
select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id
    and d.department_id in (20, 50);
-- 3개 이상의 테이블 join.
select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;
-- non-equi join
select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';
-- right outer join, null을 왼쪽에 둔다.
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;
-- left outer join, null을 오른쪽에 둔다.
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);
-- full outer join은 없다. 에러 확인.
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id(+);

select worker.last_name || ' works for ' || manager.last_name
from employees worker, employees manager
where worker.manager_id = manager.employee_id;