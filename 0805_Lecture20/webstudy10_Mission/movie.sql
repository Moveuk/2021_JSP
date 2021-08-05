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

INSERT INTO movie VALUES (movie_seq.nextval, '베를린', 10000, '류승완', '하정우', 'movie1.jpg', '거대한 국제적 음모가 숨겨진 운명의 도시 베를린');
INSERT INTO movie VALUES (movie_seq.nextval, '박수건달', 10000, '조진규', '박신양, 엄지원', 'movie2.jpg', '건달로 사느냐, 무당으로 사느냐 그것이 문제로다.');
INSERT INTO movie VALUES (movie_seq.nextval, '레미제라블', 10000, '톰 후퍼', '휴 잭맨', 'movie3.jpg', '빵 한 조각을 훔친 죄로 19년의 감옥살이를 한 장발장');
INSERT INTO movie VALUES (movie_seq.nextval, '7번방의 선물', 9000, '이환경', '류승룡, 갈소원', 'movie4.jpg', '최악의 흉악범들이 모인 교도소 7번방에 이상한 일이 벌어졌다.');

select * from movie;

select * from movie order by code desc;