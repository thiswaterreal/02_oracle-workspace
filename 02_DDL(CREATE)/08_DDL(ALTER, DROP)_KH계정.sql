/*
    DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
    
    ��ü���� ����(CREATE), ����(ALTER), ����(DROP) �ϴ� ����
    
    < ALTER >
    ��ü�� �����ϴ� ����
    
    [ǥ����]
    ALTER TABLE ���̺�� �����ҳ���;
    
    * �����ҳ���
    1) �÷� �߰�/����/����
    2) �������� �߰�/����     --> ������ �Ұ� (�����ϰ��� �Ѵٸ� �����ϰ� �� ������ �߰�)
    3) �÷���/�������Ǹ�/���̺�� ����
    
*/

-- 1  ) �÷� �߰�/����/����
-- 1_1) �÷� �߰�(ADD) : ADD �÷��� �ڷ��� [DEFAULT �⺻��] ��������
-- DEPT_COPY ���̺� CNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
--> ���ο� �÷��� ��������� �⺻������ NULL�� ä����

SELECT * FROM DEPT_COPY;

-- DEPT_COPY ���̺� LNAME �÷� �߰� (�⺻���� ������ä��)
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';

-- 1_2) �÷� ����(MODIFY)
--> �ڷ��� ����          : MODIFY �÷��� �ٲٰ����ϴ��ڷ���
--> DEFAULT�� ����       : MODIFY �÷��� DEFAULT �ٲٰ����ϴ±⺻��

ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
-- ORA-01439: column to be modified must be empty to change datatype
-- ����!! �̹� ���ڰ� �ƴ� ���� �����͵� �������
-- �����ϴ� �����Ͱ� ����߸� �̷��� �ٲ� �� ����

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);
-- ORA-01441: cannot decrease column length because some value is too big
-- ����!! �̹� ����ִ� �����Ͱ� 10����Ʈ ���� ŭ

-- DEPT_COPY ���̺���
-- 1. DEPT_TITLE �÷��� VARCHAR2(50) �� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(50);

-- 2. LOCATION_ID �÷��� VARCHAR2(4) �� ����
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR2(4);

-- 3. LNAME �÷��� �⺻���� '�̱�' ���� ����
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '�̱�';

-- ���� ���� ���� (�ѹ���)
ALTER TABLE DEPT_COPY
    MODIFY DEPT_TITLE VARCHAR2(40)
    MODIFY LOCATION_ID VARCHAR2(2)
    MODIFY LNAME DEFAULT '����';

-- ����Ʈ���� �ٲ۴ٰ��ؼ� ������ �߰��� �����Ͱ��� �ٲ�� ���� �ƴϴ�. (ó�� �־��� ���� �� �״��)

-- 1_3) �÷� ���� (DROP COLUMN) : DROP COLUMN �����ϰ����ϴ��÷���
-- ������ ���� ���纻 ���̺� ����
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- DEPT_COPY2 ���̺�κ��� DEPT_ID, DEPT_TITLE �÷� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;

-- ���� ���� ���� ?? ���� DROP������ �ȵ�
ALTER TABLE DEPT_COPY2
    DROP COLUMN CNAME
    DROP COLUMN LNAME;

ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;

ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
-- ORA-12983: cannot drop all columns in a table
-- ���̺� �ּ��� 1���� �÷��� �����ؾ���

---------------------------------------------------------------------------------
-- 2) �������� �߰�/����
/*
    2_1) �������� �߰�
         PRIMARY KEY    : ADD PRIMARY KEY(�÷���)
         FOREIGN KEY    : ADD FOREIGN KEY(�÷���) REPERENCES ���������̺�� [(�÷���)] -- �����ϸ� PK�� �ڵ� ����
         UNIQUE         : ADD UNIQUE(�÷���)
         CHECK          : ADD CHECH(�÷��� ���� ����)
         NOT NULL       : MODIFY �÷��� NOT NULL | NULL => �̰ž��� NULL ���
         
         �������Ǹ��� �����ϰ��� �Ѵٸ�?  [CONSTRAINT �������Ǹ�] ��������
*/

-- DEPT_ID �� PRIMARY KEY �������� �߰� (ADD)
-- DEPT_TITLE �� UNIQUE �������� �߰� (ADD)
-- LNAME �� NOT NULL �������� �߰� (MODIFY)

ALTER TABLE DEPT_COPY
    ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
    ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
    MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;

-- 2_2) �������� ���� : DROP CONTRAINT �������Ǹ�
-- NOT NULL �������� MODIFY �÷��� NULL �� ����

ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

ALTER TABLE DEPT_COPY
    DROP CONSTRAINT DCOPY_UQ
    MODIFY LNAME NULL;

----------------------------------------------------------------------------------
-- 3) �÷��� / �������Ǹ� / ���̺�� ���� (RENAME)
-- 3_1) �÷��� ���� : RENAME COLUMN �����÷��� TO �ٲ��÷���

-- DEPT_TITLE => DEPT_NAME
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3_2) �������Ǹ� ���� : RENAME CONSTRAINT �����������Ǹ� TO �ٲ��������Ǹ�
-- SYS_C007163 (LOCATION_ID NN �ڱⲨ ��������)
-- SYS_C007163 => DCOPY_LID_NN
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007163 TO DCOPY_LID_NN;

-- 3_3) ���̺�� ���� : RENAME [�������̺��] TO �ٲ����̺��
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;

SELECT * FROM DEPT_TEST;

----------------------------------------------------------------------------------
/*
    < DROP >
    ���̺��� �����ϴ� ����
*/

-- ���̺� ����
DROP TABLE DEPT_TEST;

-- ��, ��򰡿��� �����ǰ� �ִ� �θ����̺��� �Ժη� ���� �ȵ�!
-- ���࿡ �����ϰ��� �Ѵٸ�
-- ���1. �ڽ����̺� ���� ������ �� => �θ����̺� �����ϴ� ���
-- ���2. �׳� �θ����̺� �����ϴµ� �������Ǳ��� ���� �����ϴ� ���
--        DROP TABLE ���̺�� CASCADE CONSTRAINT; (11:10)
