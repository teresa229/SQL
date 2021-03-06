/*practice 06*/

drop table book; --예전 작업 삭제
drop table author; --예전 작업 삭제

drop sequence seq_author_id; --예전 시퀀스 삭제
drop sequence seq_book_id; --예전 시퀀스 삭제

--1) author 테이블 생성
--2) author 시퀀스 생성

--3) book 테이블 생성
--4) book 시퀀스 생성

--5) author 데이터 insert
--6) book 데이터 insert

--7) select 문
/***************************************************/

--1) author 테이블 생성
create table author(
    author_id number(10),
    author_name varchar2(100) not null unique, 
    author_desc varchar2(500) unique,
    primary key(author_id)
); 


--2)author 시퀀스 생성
create sequence seq_author_id 
increment by 1
start with 1;


--3)book 테이블 생성
create table book(
    book_id number(10),
    title varchar2(100) not null,
    pubs varchar2(100),
    pub_date date,
    author_id number(10),
    primary key(book_id),
    constraint book_fk foreign key(author_id)
    references author(author_id)
);


--4)book 시퀀스 생성
create sequence seq_book_id 
increment by 1
start with 1;


--5)author 데이터 insert
insert into author
values(seq_author_id.nextval,'이문열', '경북 영양');

insert into author
values(seq_author_id.nextval,'박경리', '경상남도 통영');

insert into author
values(seq_author_id.nextval,'유시민', '17대 국회의원');

insert into author
values(seq_author_id.nextval,'기안84', '기안동에서 산 84년생');

insert into author
values(seq_author_id.nextval,'강풀', '온라인 만화가 1세대');

insert into author
values(seq_author_id.nextval,'김영하', '알뜰신잡');


--현상황 확인
select *
from author;


--6)book 데이터 insert
insert into book
values(seq_book_id.nextval,'우리들의 일그러진 영웅','다림', '98-02-22',1);

insert into book
values(seq_book_id.nextval,'삼국지','민음사', '02-03-01',1);

insert into book
values(seq_book_id.nextval,'토지','마로니에북스', '12-08-15',2);

insert into book
values(seq_book_id.nextval,'유시민의 글쓰기 특강','생각의길', '15-04-01',3);

insert into book
values(seq_book_id.nextval,'패션왕','중앙북스(books)', '12-02-22',4);

insert into book
values(seq_book_id.nextval,'순정만화','재미주의', '11-08-03',5);

insert into book
values(seq_book_id.nextval,'오직두사람','문학동네', '17-05-04',6);

insert into book
values(seq_book_id.nextval,'26년','재미주의', '12-02-04',5);

--현상황 확인
select *
from book;

commit;

---------------------------------------------------
--강풀의 author_desc 정보를 ‘서울특별시’ 로 변경해 보세요
---------------------------------------------------
update author
set author_name = '강풀',
author_desc = '서울특별시'
where author_id = 5;

select *
from author;

commit; --dml에서 select를 제외하고는 적용해주자!

---------------------------------------------------
책 삭제하기 : 작가부터 삭제한다.
---------------------------------------------------
--기안 84작가 데이터 삭제
delete from author
where author_id = 4; --ORA-02292: integrity constraint (WEBDB.BOOK_FK) violated - child record found

--기안 84책(패션왕)을 먼저 삭제해야 함
delete from book
where book_id = 24;

--기안 84작가 삭제
delete from author
where author_id = 4;

commit;

---------------------------------------------------
--전체 리스트 보기
---------------------------------------------------
select b.book_id,
       b.title,
       b.pubs,
       b.pub_date,
       a.author_id,
       a.author_name,
       a.author_desc
from book b, author a
where b.author_id = a.author_id;

--------------------------------
select *
from author;
--------------------------------
수업중에 이클립스로 추가함.

--실행 전 문제없는지 test 1
update author
set author_name = '하이미디어',
author_desc = '서울시 강남구'
where author_id = 7;

rollback;

--실행 전 문제없는지 test 2
delete from author
where author_id = 7;

--실행 전 문제없는지 test 3
select author_id,
       author_name,
       author_desc
from author;

--------------------------------
select *
from book;
--------------------------------
--과제 book 
--------------------------------
--실행 전 문제없는지 test 1 : insert
insert into book
values(seq_book_id.nextval, '28년', '수업주의', '20-12-28', '2');

--실행 전 문제없는지 test 2 :
update book
set title = '29년',
    pubs = '비대면수업',
    pub_date = '20-12-29',
    author_id = '2'
where book_id = 9;