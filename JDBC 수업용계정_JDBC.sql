--(�����ͼ�Ȯ�ο�)INSERT INTO MEMBER VALUES(SEQ_USERNO.NEXTVAL, 'XXX', 'XXX', 'XXX', 'X', XX, 'XXX', 'XX', 'XX', 'XX', SYSDATE);

--(�����ͼ�Ȯ�ο�)INSERT INTO MEMBER VALUES(SEQ_USERNO.NEXTVAL, 'user02', '1234', '�����', 'F', 11, 'a@a', '01011112222', '������', '���ڱ�', SYSDATE);

DELETE FROM MEMBER WHERE USERID = USERID AND USERPWD = USERPWD AND USERNAME = USERNAME;

SELECT * FROM MEMBER;

SELECT * FROM MEMBER WHERE USERNAME LIKE '%��%';

UPDATE MEMBER
SET USERNAME = '�̸���'
WHERE USERNO = 4;

COMMIT;

UPDATE MEMBER
SET USERPWD = '',
    EMAIL = '',
    PHONE = '',
    ADDRESS = ''
WHERE USERID = '';

-- 4��, ȸ�� �̸����� �˻� ��û�� ����� SQL��
SELECT * FROM MEMBER WHERE USERNAME LIKE '%?%'; --> �̷��� �������� �� ����ɱ�? ����!

-- 5��, ȸ�� ���� ���� ��û�� ����� SQL��
UPDATE MEMBER SET USERPWD = ?, EMAIL = ?, PHONE = ?, ADDRESS = ? WHERE USERID = ?;

-- 6��, ȸ�� Ż�� ��û�� ����� SQL��
DELETE FROM MEMBER WHERE USERID = ?;



