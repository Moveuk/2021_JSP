DROP TABLE board;

CREATE TABLE board(
    num number(5) primary key,
    pass varchar2(30),
    name varchar2(30),
    email varchar2(30),
    title varchar2(50),
    content varchar2(1000),
    readcount number(4) Default 0,
    writedate date default sysdate
);

create SEQUENCE board_seq start with 1 increment by 1;

insert into board(num,pass,name,email,title,content) values(board_seq.nextval,'������','pinksung@nate.com','1234','ù�湮','�ݰ����ϴ�.');

insert into board(num,pass,name,email,title,content) values(board_seq.nextval,'������','pinksung@nate.com','1234','���','���־��.');

insert into board(num,pass,name,email,title,content) values(board_seq.nextval,'������','raccon@nate.com','3333','����','�Ͻ��Դϴ�.');

insert into board(num,pass,name,email,title,content) values(board_seq.nextval,'������','one@nate.com','1111','������','���������� ���ֽ��ϴ�.');

commit;

select * from board;

select * from board order by num desc;