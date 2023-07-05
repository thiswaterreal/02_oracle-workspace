/*
    < VIEW �� >
    
    SELECT�� (������)�� �����ص� �� �ִ� ��ü
    (���� ���� �� SELECT���� �������ָ� �� �� SELECT���� �Ź� �ٽ� ����� �ʿ� ����)
    �ӽ����̺� ���� ���� (���� �����Ͱ� ����ִ� �� �ƴ�) => �����ֱ��(�������̺�)
    �������� ���̺� : ����!
    ������ ���̺� : ����! => ��� ������ ���̺�
*/

-- �� ����� ���� ������ ������ �ۼ�
-- ������������

SELECT * FROM EMPLOYEE;     -- DEPT_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION;     --              LOCAL_CODE      NATIONAL_CODE
SELECT * FROM NATIONAL;     --                              NATIONAL_CODE

-- '�ѱ�' ���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
  FROM EMPLOYEE
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING (NATIONAL_CODE)
 WHERE NATIONAL_NAME = '�ѱ�';

-- '���þ�' ���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
  FROM EMPLOYEE
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING (NATIONAL_CODE)
 WHERE NATIONAL_NAME = '���þ�';

-- '�Ϻ�' ���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
  FROM EMPLOYEE
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING (NATIONAL_CODE)
 WHERE NATIONAL_NAME = '�Ϻ�';

----------------------------------------------------------------------------------
/*
    1. VIEW ���� ���
    
    [ǥ����]
    CREATE [OR REPLACE] VIEW ���
    AS ��������;
    
    [OR REPLACE] : �� ������ ������ �ߺ��� �̸��� �䰡 ���ٸ� ������ �並 �����ϰ�,
                            ������ �ߺ��� �̸��� �䰡 �ִٸ� �並 ����(����)�ϴ� �ɼ�
*/

CREATE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME --, BONUS
      FROM EMPLOYEE
      JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
      JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
      JOIN NATIONAL USING (NATIONAL_CODE);
-- ORA-01031: insufficient privileges
-- privileges : ���� => ������ ���ٴ� ����

-- ������ ������ �����ؼ� ���� �ο�
GRANT CREATE VIEW TO KH;   -- �����ڰ���(������)����!!

-- �������̺��� �ƴ�. ����, �����̺�(��)!!  => ��ȸ���̶�� ����
SELECT * FROM VW_EMPLOYEE;

-- ��� ���� �ƶ�
SELECT *
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
      FROM EMPLOYEE
      JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
      JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
      JOIN NATIONAL USING (NATIONAL_CODE)   -- �̰� �ζ��κ� // �������� ��
);

-- �ѱ�, ���þ�, �Ϻ��� �ٹ��ϴ� ���
SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�ѱ�';

SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '���þ�';

SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�Ϻ�';

-- [����]
SELECT *
FROM USER_VIEWS;

-- ���� �信�ٰ� �� �ϳ� (BONUS) �� �߰��ϰ� ����
CREATE OR REPLACE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
      FROM EMPLOYEE
      JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
      JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
      JOIN NATIONAL USING (NATIONAL_CODE);
-- ORA-00955: name is already used by an existing object
-- �̹� �ش� �̸��� ���� �䰡 �ִٰ� ������     
-- 'OR REPLACE' �ۼ��Ͽ� 'BONUS' �߰�
SELECT * FROM VW_EMPLOYEE; -- BONUS���� �߰��Ǿ� �� ������

----------------------------------------------------------------------------------
/*
    * �� �÷��� ��Ī �ο�
      ���������� SELECT�� �Լ����̳� ���������� ����Ǿ� ���� ��� �ݵ��!! ��Ī ���� �ؾ���!
*/

-- ��ü ����� ���, �̸�, ���޸�, ����(��/��), �ٹ���� ��ȸ�� �� �ִ� SELECT���� ��(VW_EMP_JOB)�� �����غ���
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
          DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') AS "����(��/��)",
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "�ٹ����"
     FROM EMPLOYEE
     JOIN JOB USING (JOB_CODE);
-- ORA-00998: must name this expression with a column alias
-- alias : ��Ī

SELECT * FROM VW_EMP_JOB;

-- �� �ٸ� ��Ī �ο� ���
CREATE OR REPLACE VIEW VW_EMP_JOB(���, �̸�, ���޸�, ����, �ٹ����) -- ��, ����÷��� ��Ī �ο��ؾ���
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
          DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��'),
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
     FROM EMPLOYEE
     JOIN JOB USING (JOB_CODE);

SELECT �̸�, ���޸�
FROM VW_EMP_JOB
WHERE ���� = '��';

SELECT *
FROM VW_EMP_JOB
WHERE �ٹ���� >= 20;

-- �並 �����ϰ��� �Ѵٸ�
DROP VIEW VW_EMP_JOB;

----------------------------------------------------------------------------------
-- ������ �並 �̿��ؼ� DML(INSERT, UPDATE, DELETE) ��밡��
-- �並 ���ؼ� �����ϴ��� ���� �����Ͱ� ����ִ� ���̽����̺� �ݿ���
-- �ٵ� �� �ȵǴ� ��찡 ���Ƽ� ������ ���� ������ ����

CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
     FROM JOB;
     
SELECT * FROM VW_JOB; -- ������ ���̺� (���������Ͱ� ������� ����)
SELECT * FROM JOB;    -- ���̽� ���̺�   (���������Ͱ� �������)

-- �並 ���ؼ� INSERT
INSERT INTO VW_JOB VALUES('J8', '����');

-- �並 ���ؼ� UPDATE
UPDATE VW_JOB
   SET JOB_NAME = '�˹�'
 WHERE JOB_CODE = 'J8';
 
 -- �並 ���ؼ� DELETE
DELETE
  FROM VW_JOB
 WHERE JOB_CODE = 'J8';
 
 ---------------------------------------------------------------------------------
 /*
    * ��, DML ��ɾ�� ������ �Ұ����� ��찡 �� ����
    1) �信 ���ǵǾ����� ���� �÷��� �����Ϸ��� �ϴ� ���
    2) �信 ���ǵǾ����� ���� �÷� �߿� ���̽����̺� �� NOT NULL ���������� �����Ǿ� �ִ� ��� => ��� �ǰ�, ��� �ȵ�
    3) �������� �Ǵ� �Լ������� ���ǵǾ��ִ� ���
    4) �׷��Լ��� GROUP BY���� ���Ե� ���
    5) DISTINCT ������ ���Ե� ���
    6) JOIN�� �̿��ؼ� ���� ���̺��� ������ѳ��� ���
    
    => ��� ��ȸ�Ϸ��� ����Ŷ� �並 ������ DML�� ��������!!!!!!!!!!!!!! 
    => ��ư �ȵ�!!
 */
 
-- 1) �信 ���ǵǾ����� ���� �÷��� �����Ϸ��� �ϴ� ���
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE
     FROM JOB;

SELECT * FROM VW_JOB;
SELECT * FROM JOB;

-- INSERT (����)
INSERT INTO VW_JOB(JOB_CODE, JOB_NAME) VALUES('J8', '����');
-- ORA-00904: "JOB_NAME": invalid identifier

-- UPDATE (����)
UPDATE VW_JOB
SET JOB_NAME = '����'
WHERE JOB_CODE = 'J7';
-- ORA-00904: "JOB_NAME": invalid identifier

-- DELETE (����)
DELETE FROM VW_JOB
WHERE JOB_NAME = '���';
-- ORA-00904: "JOB_NAME": invalid identifier

--> ���, ��� ���� ������ �Ӽ� �ƴϸ� ���� �ȵȴ�..!



-- 2) �信 ���ǵǾ����� ���� �÷� �߿� ���̽����̺� �� NOT NULL ���������� �����Ǿ� �ִ� ��� => ��� �ǰ�, ��� �ȵ�
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

SELECT * FROM VW_JOB;
SELECT * FROM JOB;  -- JOB_CODE NN��

-- INSERT (����)
INSERT INTO VW_JOB VALUES('����'); -- ���� ���̽� ���̺� INSERT�� (NULL, '����') �߰�
-- ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")

-- UPDATE (����)
UPDATE VW_JOB
SET JOB_NAME = '�˹�'
WHERE JOB_NAME = '���';

ROLLBACK;

-- DELETE (�ɼ���, �ȵɼ���)
DELETE FROM VW_JOB
WHERE JOB_NAME = '���';
-- ORA-02292: integrity constraint (KH.SYS_C007151) violated - child record found
-- �� �����͸� ���� �ִ� �ڽĵ����Ͱ� �����ϱ� ������ ���� ����
-- ��, �����ٸ� �������� ��



-- 3) �������� �Ǵ� �Լ������� ���ǵǾ��ִ� ���
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS "����"
     FROM EMPLOYEE;

SELECT * FROM VW_EMP_SAL;   -- �����̺�
SELECT * FROM EMPLOYEE;     -- ���̽����̺�

-- INSERT (����)
INSERT INTO VW_EMP_SAL VALUES(400, '������', 3000000, 36000000);
-- ORA-01733: virtual column not allowed here
-- EMPLOYEE ���� '����' �̶�� ���̺� ���� ������ �ȵ�

-- UPDATE 
-- 200�� ����� ������ 8000�������� ���� (����)
UPDATE VW_EMP_SAL
SET ���� = 80000000
WHERE EMP_ID = 200;
-- ORA-01733: virtual column not allowed here
-- EMPLOYEE ���� '����' �̶�� ���̺� ���� ������ �ȵ�

-- 200�� ����� �޿��� 700�������� ���� (����)
UPDATE VW_EMP_SAL
SET SALARY = 7000000
WHERE EMP_ID = 200;

ROLLBACK;

-- DELETE (����)  11:18
DELETE FROM VW_EMP_SAL
WHERE ���� = 72000000;

ROLLBACK;



-- 4) �׷��Լ��� GROUP BY���� ���Ե� ���
CREATE OR REPLACE VIEW VW_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) AS "�հ�", FLOOR(AVG(SALARY)) AS "���"
     FROM EMPLOYEE
 GROUP BY DEPT_CODE;
 
SELECT * FROM VW_GROUPDEPT;
SELECT * FROM EMPLOYEE;

-- INSERT (����)
INSERT INTO VW_GROUPDEPT VALUES('D3', 8000000, 400000);
-- ORA-01733: virtual column not allowed here
-- ���� EMPLOYEE �� �ֱⰡ �ָ���..

-- UPDATE (����)
UPDATE VW_GROUPDEPT
SET �հ� = 8000000
WHERE DEPT_CODE = 'D1';
-- ORA-01732: data manipulation operation not legal on this view
-- �̰͵� ����.. ��� �����ϱⰡ �ָ���

-- DELETE (����)
DELETE FROM VW_GROUPDEPT
WHERE �հ� = 5210000;
-- ORA-01732: data manipulation operation not legal on this view
-- �̰͵� ����.. � ���� �����ؾ����� �Ǵ� �ָ���



-- 5) DISTINCT ������ ���Ե� ���
CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT JOB_CODE
     FROM EMPLOYEE;
     
SELECT * FROM VW_DT_JOB;

-- INSERT (����)
INSERT INTO VW_DT_JOB VALUES('J8');

-- UPDATE (����)
UPDATE VW_DT_JOB
SET JOB_CODE = 'J8'
WHERE JOB_CODE = 'J7';

-- DELETE (����)
DELETE FROM VW_DT_JOB
WHERE JOB_CODE = 'J4';



-- 6) JOIN�� �̿��ؼ� ���� ���̺��� ������� ���� ���
CREATE OR REPLACE VIEW VW_JOINEMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
     FROM EMPLOYEE
     JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

SELECT * FROM VW_JOINEMP;

-- INSERT (����)
INSERT INTO VW_JOINEMP VALUES(300, '�����', '�ѹ���');

-- UPDATE (����) ��..? �ڱ� �������..
UPDATE VW_JOINEMP
SET EMP_NAME = '������'
WHERE EMP_ID = 200;

ROLLBACK;

-- UPDATE (����)
UPDATE VW_JOINEMP
SET DEPT_TITLE = 'ȸ���'
WHERE EMP_ID = 200;
-- EMPLOYEE ���� DEPT_TITLE �÷� ����

-- DELETE (����)
DELETE FROM VW_JOINEMP
WHERE EMP_ID = 200;

ROLLBACK;

----------------------------------------------------------------------------------
/*
     * VIEW �ɼ�
     
     [��ǥ����]
     CREATE [OR REPLACE] [FORCE | "NOFORCE"] VIEW ���
     AS ��������
     [WITH CHECK OPTION]
     [WITH READ ONLY];  <= ������ ��ȸ�� ����
     
     1) OR REPLACE          : ������ ������ �䰡 ���� ��� ���Ž�Ű��, �������� ������ ������ ������Ų��.
     2) FORCE | NOFORCE
            > FORCE     : ���������� ����� ���̺��� �������� �ʾƵ� �䰡 �����ǰ� �ϴ�
            > NOFORCE   : ���������� ����� ���̺��� �����ϴ� ���̺��̾�߸� �䰡 �����ǰ� �ϴ� (�⺻�� NOFORCE)
     3) WITH CHECH OPTION   : DML ��, ���������� ����� ���ǿ� ������ �����θ� DML �����ϵ���
     4) WITH READ ONLY      : �信 ���� ��ȸ�� ���� (DML�� ���� �Ұ�)
*/

-- 2) FORCE | NOFORCE
--    NOFORCE : ���������� ����� ���̺��� �����ϴ� ���̺��̾�߸� �䰡 �����ǰ� �ϴ� (������ /*�⺻��*/)
CREATE OR REPLACE /*NOFORCE*/ VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
     FROM TT;
-- ORA-00942: table or view does not exist
-- �ش� ���̺��� ��� ���� ��!!

-- FORCE : ���������� ����� ���̺��� �������� �ʾƵ� �䰡 �����ǰ� �ϴ�
CREATE OR REPLACE FORCE VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
     FROM TT;
-- ���: ������ ������ �Բ� �䰡 �����Ǿ����ϴ�.

SELECT * FROM VW_EMP;   -- ����â���� �� Ȯ���� ����������, ��ȸ�� �ȵ�
-- ���߿� TT ���̺� �����ϸ�, �׶����� VIEW (VW_EMP) Ȱ�� ����

CREATE TABLE TT(
    TCODE NUMBER,
    TNAME VARCHAR2(20),
    TCONTENT VARCHAR2(30)
);

-- 3) WITH CHECK OPTION : ���������� ����� ���ǿ� �������� �ʴ� ������ ������ ���� �߻�
--    WITH CHECK OPTION ���ְ�
CREATE OR REPLACE VIEW VW_EMP
AS SELECT *
     FROM EMPLOYEE
    WHERE SALARY >= 3000000;

SELECT * FROM VW_EMP; -- 8�� ��ȸ

-- 200�� ����� �޿��� 200�������� ���� (���������� ���ǿ� �������� �ʴ� ������ ���� �õ�)  => �� �����
UPDATE VW_EMP
SET SALARY = 2000000
WHERE EMP_ID = 200;   -- 7�� ��ȸ (������ �޿� 2000000 ���� �ٲ��� ������ ���ܵ�)

ROLLBACK;

--    WITH CHECK OPTION �ְ�
CREATE OR REPLACE VIEW VW_EMP
AS SELECT *
     FROM EMPLOYEE
    WHERE SALARY >= 3000000
WITH CHECK OPTION; 

SELECT * FROM VW_EMP;   -- 8�� ��ȸ

UPDATE VW_EMP
SET SALARY = 2000000
WHERE EMP_ID = 200;
-- ORA-01402: view WITH CHECK OPTION where-clause violation
-- ���������� ����� ���ǿ� ���յ��� �ʱ� ������ ���� �Ұ� 

UPDATE VW_EMP
SET SALARY = 4000000
WHERE EMP_ID = 200;
-- ���������� ����� ���ǿ� ���յǱ� ������ ���� ����

ROLLBACK;

-- 4) WITH READ ONLY : �信 ���� ��ȸ��!! ���� (DML�� ���� �Ұ�)
CREATE OR REPLACE VIEW VW_EMP
AS SELECT EMP_ID, EMP_NAME, BONUS
     FROM EMPLOYEE
    WHERE BONUS IS NOT NULL
WITH READ ONLY;

SELECT * FROM VW_EMP;

DELETE FROM VW_EMP
WHERE EMP_ID = 200;
-- ORA-42399: cannot perform a DML operation on a read-only view
-- �б� ������