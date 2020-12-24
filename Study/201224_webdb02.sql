create table author(
    author_id number(10),
    author_name varchar2(100) not null unique, --비우는 칸수는 상관없음.
    author_desc varchar2(500) unique,
    primary key(author_id) --신중하게 정리해야 해서 밖으로 뺐다. 마지막은 ','없다.
);  

delete from author;



select *
from author;

insert into author
values(seq_author_id.nextval,'이문열', '경북 영양');

insert into author
values(seq_author_id.nextval,'박경리', '경남 통영');

insert into author
values(seq_author_id.nextval, '유시민', '17대 국회의원');

insert into author
values(seq_author_id.nextval, '기안84', '나혼자산다');

select seq_author_id.
from dual;

--'번호표 기계'를 만들었다고 생각하자. --> 시퀀스
--* 시퀀스 만들기
create sequence seq_author_id --'author_id' 이름을 넣어준다.
increment by 1 --버튼 누를 때마다 '1'씩 늘어나라.
start with 1; --시작번호가 1번부터 시작하라.

--* 시퀀스 삭제
drop sequence seq_author_id;

--* 시퀀스 조회
select * from user_sequences; -- 계정에 있는

--* 현재 시퀀스 조회
select seq_author_id.currval
from dual;

--* 다음 시퀀스 조회 --> 번호 1증가함
select seq_author_id.nextval
from dual;

