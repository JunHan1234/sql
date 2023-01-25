--you라는 user 생성 후 password는 you로 설정.
create user you identified by you;
--role 2개를 you에게 부여.
grant connect, resource to you;