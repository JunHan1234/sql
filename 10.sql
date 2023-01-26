-- table 삭제 -- ddl: auto commit
drop table hire_dates;

-- table 생성 -- ddl: auto commit
create table hire_dates (
emp_id number(8),
hire_date date default sysdate);

-- data dictionary -> meta data을 가지고 있는 곳.
select tname
from tab; /*oracle에서 미리 구성해놓은 table(dual같은)*/
/*tab은 11장에서 배우는 view 객체이다.*/

select tname
from tab
where tname not like 'BIN%';

--case 1,2,3 insert. -- dml: 수동 commit
insert into hire_dates values(1, to_date('2025/12/21'));
insert into hire_dates values(2, null);
insert into hire_dates(emp_id) values(3
    /*쓰지 않은 hire_date column에 설정했던 default값이 들어간다.*/);

select * from hire_dates;

commit; /*hr schema에 저장*/

-- DCL (Data Control Language) 연습
-- system에 접속 후 아래 입력. /system2.sql로 저장했음.
/*
--you라는 user 생성 후 password는 you로 설정.
create user you identified by you;
--role 2개를 you에게 부여.
grant connect, resource to you;
*/
-- you 접속 생성. / you.sql로 저장했음.