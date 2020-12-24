select *
from author;

--* 시퀀스 삭제
drop sequence seq_author_id;


--* 시퀀스 만들기
create sequence seq_author_id --'author_id' 이름을 넣어준다.
increment by 1 --버튼 누를 때마다 '1'씩 늘어나라.
start with 1;

--* 현재 시퀀스 조회
select seq_author_id.currval
from dual;

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

insert into book
values(1,'삼국지','삼양출판사', '20-01-01',6);
