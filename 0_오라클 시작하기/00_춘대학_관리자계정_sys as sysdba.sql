SELECT * FROM DBA_USERS;

CREATE USER workbook IDENTIFIED BY workbook; 

GRANT RESOURCE, CONNECT TO workbook;