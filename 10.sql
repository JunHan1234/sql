-- table ���� : auto commit :dml -- ddl: ���� commit
drop table hire_dates;

-- table ���� : auto commit
create table hire_dates (
emp_id number(8),
hire_date date default sysdate);

-- data dictionary -> meta data�� ������ �ִ� ��.
select tname
from tab; /*oracle���� �̸� �����س��� table(dual����)*/

select tname
from tab
where tname not like 'BIN%';

--case 1,2,3 insert.
insert into hire_dates values(1, to_date('2025/12/21'));
insert into hire_dates values(2, null);
insert into hire_dates(emp_id) values(3); /*���� ���� hire_date column�� �����ߴ� default���� ����.*/

select *
from hire_dates;

commit; /*hr schema�� ����*/

-- DCL (Data Control Language) ����
-- system�� ���� �� �Ʒ� �Է�. /system2.sql�� ����.
/*
--you��� user ���� �� password�� you�� ����.
create user you identified by you;
--role 2���� you���� �ο�.
grant connect, resource to you;
*/
-- you ���� ����. / you.sql�� ����.