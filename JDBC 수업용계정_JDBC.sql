--(데려와서확인용)INSERT INTO MEMBER VALUES(SEQ_USERNO.NEXTVAL, 'XXX', 'XXX', 'XXX', 'X', XX, 'XXX', 'XX', 'XX', 'XX', SYSDATE);

--(데려와서확인용)INSERT INTO MEMBER VALUES(SEQ_USERNO.NEXTVAL, 'user02', '1234', '김뫄뫄', 'F', 11, 'a@a', '01011112222', '내맘속', '잠자기', SYSDATE);

DELETE FROM MEMBER WHERE USERID = USERID AND USERPWD = USERPWD AND USERNAME = USERNAME;

SELECT * FROM MEMBER;

SELECT * FROM MEMBER WHERE USERNAME LIKE '%뫄%';

UPDATE MEMBER
SET USERNAME = '이뫄뫄'
WHERE USERNO = 4;

COMMIT;

UPDATE MEMBER
SET USERPWD = '',
    EMAIL = '',
    PHONE = '',
    ADDRESS = ''
WHERE USERID = '';

-- 4번, 회원 이름으로 검색 요청시 실행될 SQL문
SELECT * FROM MEMBER WHERE USERNAME LIKE '%?%'; --> 이렇게 했을때는 잘 실행될까? 보완!

-- 5번, 회원 정보 변경 요청시 실행될 SQL문
UPDATE MEMBER SET USERPWD = ?, EMAIL = ?, PHONE = ?, ADDRESS = ? WHERE USERID = ?;

-- 6번, 회원 탈퇴 요청시 실행될 SQL문
DELETE FROM MEMBER WHERE USERID = ?;



