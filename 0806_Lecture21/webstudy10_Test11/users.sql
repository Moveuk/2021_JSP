drop table users;

create table users(
    id varchar2(15) primary key,
    password varchar2(10),
    addr varchar2(50),
    age number(3),
    gender char(1) DEFAULT 'M',
    name varchar2(15),
    nation varchar2(15)
);

INSERT INTO users VALUES ('admin', '1234', '���� ������', 20, 'M', '���', '���ѹα�');

Commit;

select * from users where id = 'admin';