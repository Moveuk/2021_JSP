create table movie(
    code number(4) primary key,
    title varchar2(50),
    price number(10),
    director varchar2(20),
    actor varchar2(20),
    poster varchar2(100),
    synopsis varchar2(3000)
);

create SEQUENCE movie_seq 
    start with 1
    increment by 1;

INSERT INTO movie VALUES (movie_seq.nextval, '������', 10000, '���¿�', '������', 'movie1.jpg', '�Ŵ��� ������ ���� ������ ����� ���� ������');
INSERT INTO movie VALUES (movie_seq.nextval, '�ڼ��Ǵ�', 10000, '������', '�ڽž�, ������', 'movie2.jpg', '�Ǵ޷� �����, �������� ����� �װ��� �����δ�.');
INSERT INTO movie VALUES (movie_seq.nextval, '���������', 10000, '�� ����', '�� ���', 'movie3.jpg', '�� �� ������ ��ģ �˷� 19���� �������̸� �� �����');
INSERT INTO movie VALUES (movie_seq.nextval, '7������ ����', 9000, '��ȯ��', '���·�, ���ҿ�', 'movie4.jpg', '�־��� ��ǹ����� ���� ������ 7���濡 �̻��� ���� ��������.');

select * from movie;

select * from movie order by code desc;