create table member(
    name varchar2(10),
    userid varchar2(10),
    pwd varchar2(10),
    email varchar2(20),
    phone char(13),
    admin number(1) default 0,
    primary key (userid)
);

insert into member values('ÀÌ¼Ò¹Ì', 'somi', '1234', 'gmd@naver.com', '010-2362-5157', 0);
insert into member values('ÇÏ»ó¿À', 'sang12', '1234', 'ha12@naver.com', '010-5629-8888', 1);
insert into member values('±èÀ±½Â', 'light', '1234', 'youn1004@naver.com', '010-9999-8282', 0);

commit;

select * from member;

update member
set phone = '010-8765-4321'
where userid = 'somi';

delete member
where userid='somi';

rollback;

create table student(
    num number,
    name varchar2(10),
    Primary key(num)
);

insert into student
values (1, 'È«±æµ¿');

insert into student
values (2, 'È«±æµ¿');

insert into student
values (3, '°í±æµ¿');

insert into student
values (4, '±èÃ¶¼ö');

insert into student
values (5, '±è±æµ¿');

insert into student
values (6, '±è±â¹®');

update student
set name = '±è±æµ¿'
where num = 2;

select * from student;

insert into student
values (12, '½ÊÀÌ¹ø');

select e.empno, e.ename, e.deptno, d.dname, d.loc from emp e, dept d where e.deptno = d.deptno;

select * from dept;