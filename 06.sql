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
select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

-- 복습과제: 위에서 누락된 1인의 이름, 부서번호를 조회하라.
select last_name, department_id
from employees
where department_id is null;

/*netural join을 사용하면, 테이블에 있는 모든 공통 칼럼을 조회하므로,
    department_id, manager_id 두개 다 join이 된다.*/
select employee_id, last_name, department_id, location_id
from employees natural join departments;

/*생각과 코드를 일치시키면, 코드가 길다는 단점이 있다.*/
select locations.city, departments.department_name
from locations join departments
using (location_id)
where location_id = 1400;

/*단점 보완.*/
select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400;

--조건문에서는 접두사로 별명을 붙일 수 없다.
select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400;

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where d.location_id = 1400;