/*practice 06*/

drop table book; --예전 작업 삭제
drop table author; --예전 작업 삭제

drop sequence seq_author_id;
drop sequence seq_book_id;
--1) author 테이블 생성
--2) author 시퀀스 생성

--3)book 테이블 생성
--4)book 시퀀스 생성

--5)author 데이터 insert
--6)book 데이터 insert

--7)select 문
/***************************************************/

--1) author 테이블 생성
create table author(
    author_id number(10),
    author_name varchar2(100) not null unique, 
    author_desc varchar2(500) unique,
    primary key(author_id)
); 


--2)author 시퀀스 생성 : 이미 존재한다고 뜬다;;
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