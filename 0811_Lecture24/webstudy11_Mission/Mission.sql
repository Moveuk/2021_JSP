DROP TABLE employee;

CREATE TABLE employee (
    num NUMBER NOT NULL,
    id VARCHAR2(10) NOT NULL UNIQUE,
    pass VARCHAR2(10) NOT NULL,
    name VARCHAR2(24),
    lev CHAR(1) DEFAULT 'A',
    enter DATE DEFAULT SYSDATE,
    gender CHAR(1) DEFAULT '1',
    phone VARCHAR2(30)
);

CREATE SEQUENCE emp_seq
  INCREMENT BY 1
  START WITH 1;

INSERT INTO employee VALUES(emp_seq.nextval, 'admin','1111','정운영','A',sysdate,'1','010-1111-1111');
INSERT INTO employee VALUES(emp_seq.nextval, 'subin','1234','전원지','B',sysdate,'1','010-9999-9999');
INSERT INTO employee VALUES(emp_seq.nextval, 'pinksung','3333','성윤정','A',sysdate,'2','010-2222-2222');

commit;

SELECT * FROM employee;

UPDATE employee SET pass = ?, name = ?, lev = ?, gender = ?, phone = ? WHERE id = ?;