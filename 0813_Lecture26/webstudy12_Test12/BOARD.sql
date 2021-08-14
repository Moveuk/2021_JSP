CREATE TABLE board2 AS
SELECT * FROM board;

drop table board;

CREATE TABLE BOARD(
	BOARD_NUM NUMBER,
	BOARD_NAME VARCHAR2(20),
	BOARD_PASS VARCHAR2(15),
	BOARD_SUBJECT VARCHAR2(50),
	BOARD_CONTENT VARCHAR2(2000),
	BOARD_FILE VARCHAR2(50),
	BOARD_READCOUNT NUMBER,
	BOARD_DATE DATE,
	PRIMARY KEY(BOARD_NUM)
);

COMMIT;

SELECT COUNT(*) FROM board;

SELECT * FROM board ORDER BY board_num DESC;

INSERT INTO board VALUES(3,'moveuk','fd','sdf','fds','fds',0,sysdate);

rollback;

INSERT INTO board(board_num, board_name, board_pass, board_subject, board_content, board_file, board_readcount, board_date) VALUES(2, 'fds', 'fds', 'fds', 'fds', 'fds', 0, sysdate);