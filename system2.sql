--you라는 user 생성 후 password는 you로 설정.
create user you identified by you;
--role 2개를 you에게 부여.
grant connect, resource to you;
/*
설정이 끝났으면,
접속에서 새접속(녹색십자가) 클릭 후,
Name, 사용자이름, 비밀번호에 you를 입력하고,
테스트 후 저장을 누르고 나온다.
*/