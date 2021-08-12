CREATE USER shopping identified by shopping;
GRANT CONNECT, RESOURCE TO shopping;
GRANT CREATE VIEW TO shopping;

SELECT * FROM all_users;

CREATE USER nonage identified by tiger;
GRANT CONNECT, RESOURCE TO nonage;
GRANT CREATE VIEW TO nonage;

SELECT * FROM all_users;