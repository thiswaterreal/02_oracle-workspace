CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR2(10)
);
-- ����!! CREATE TABLE �� �� �ִ� ������ ��� ���� �߻�
-- 3_1. CREATE TABLE ���� �ޱ�
-- 3_2. TABLESPACE �Ҵ� �ޱ�

SELECT * FROM TEST;
INSERT INTO TEST VALUES(10, '�ȳ�');
-- CREATE TABLE ���� ������ ���̺�� �ٷ� ���� ����

---------------------------------------------------------------------------------

-- KH������ �ִ� EMPLOYEE ���̺� ����
-- �ٵ� ��ȸ ������ ����

-- 4. SELECT ON KH.EMPLOYEE ���� �ο� ����
SELECT * FROM KH.EMPLOYEE;

-- 5. INSERT ON KH.DEPARTMENT ���� �ο� ����
INSERT INTO KH.DEPARTMENT 
VALUES('D0', 'ȸ���', 'L1');

COMMIT; -- Ȯ������

SELECT * FROM DEPARTMENT;   -- (�Ķ���KH���� ����)

DELETE FROM DEPARTMENT  -- �ٽ� ���󺹱�
WHERE DEPT_ID = 'D0';