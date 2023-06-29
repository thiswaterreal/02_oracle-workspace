/*
    * DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
    ����Ŭ���� �����ϴ� ��ü(OBJECT)�� ������ �����(CREATE), ������ ����(ALTER), ���� ��ü�� ����(DROP)
    ��, ���� ������ ���� �ƴ� ���� ��ü�� �����ϴ� ���
    �ַ� DB������, �����ڰ� �����
    
    ����Ŭ���� �����ϴ� ��ü(����) : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE), 
                                  �ε���(INDEX), ��Ű��(PACKAGE), Ʈ����(TRIGER),
                                  ���ν���(PROCEDUER), �Լ�(FUNCTION), ���Ǿ�(SYNONYM), �����(USER)
                                  
    < CREAGE >
    ��ü�� ������ �����ϴ� ����
*/

/*
    1. ���̺� ����
    - ���̺��̶�? ��(ROW)�� ��(COLUMN)�� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
                 ��� �����͵��� ���̺��� ���ؼ� �����!
                 (DBMS ��� �� �ϳ���, �����͸� ������ ǥ ���·� ǥ���� ��)
                 
    [ǥ����]
    CREATE TABLE ���̺��(
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���,
        ...
    );
    
    * �ڷ���
    - ���� (CHAR(����Ʈ ũ��) | VARCHAR2(����Ʈũ��)) => �ݵ�� ũ�� ���� �ؾ���
        > CHAR : �ִ� 2000����Ʈ���� ���� ����. ������ ���� �ȿ����� ����� / �������� (������ ũ�⺸�� �� ���� ���� ���͵� �������� ä������)
                 ������ ���ڼ��� �����͸��� ��� ��� ��� => �Ϲ������� '��'����! (Y/N, M/F)
        
        > VARCHAR2 : �ִ� 4000����Ʈ���� ���� ����. ���� ����(��� ���� ���� ������ ũ�� ������)
                     �� ������ �����Ͱ� ������ �𸣴� ��� , �� ���� ������ ���
    
    - ���� (NUMBER)
    - ��¥ (DATE)
    
*/

-- ȸ���� ���� �����͸� ��� ���� ���̺� MEMBER �����ϱ�
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

-- ���� �÷��� ��Ÿ�� �߻��ߴٸ�?
-- �ٽ� ����� �ɱ�? ���� �����ϰ� �ٽ� ������ ��!!
-- DROP TABLE ���̺��;
DROP TABLE MEMBER;

-- ������ ��ųʸ� : �پ��� ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺��
-- [����] USER_TABLE : ���� �� ������ ������ �ִ� ���̺� ���� �� �� ����

SELECT * FROM USER_TABLES;

-- [����] USER_TAB_COLUMNS : �� ����ڰ� ������ �ִ� ���̺���� ��� �÷� �� �� ����
SELECT * FROM USER_TAB_COLUMNS;

----------------------------------------------------------------------------------
/*
    2. �÷��� �ּ� �ޱ� (�÷��� ���� ���� ���� ��)
    
    [ǥ����]
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
    
    >> �߸� �ۼ��ؼ� �������� ���, ���� �� �ٽ� �����ϸ� ��!
*/

COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ������';
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';

COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ����';
COMMENT ON COLUMN MEMBER.GENDER IS '����(��/��)';
COMMENT ON COLUMN MEMBER.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS 'ȸ��������';

-- ���̺��� �����ϰ��� �� �� : DROP TABLE ���̺��;

-- ���̺� ������ �߰���Ű�� ���� (DML : INSERT) �̶� �ڼ��ϰ� ���
-- INSERT INOT ���̺�� VALUES (��1, ��2, ��3 ...);

SELECT * FROM MEMBER;

-- INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', 'ȫ�浿'); -- �� �Է� ���ϸ� ������. ���� ��ü �� �Է��ؾ���
INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'aaa@naver.com', '20/12/30');
INSERT INTO MEMBER VALUES(2, 'user02', 'pass02', 'ȫ���', '��', null, NULL, SYSDATE);

INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- ��ȿ���� ���� �����Ͱ� ���� ����.. ���� ������ �ɾ������

---------------------------------------------------------------------------------
/*
    < �������� CONSTRAINTS >
    - ���ϴ� �����Ͱ� (��ȿ�� ������ ��)�� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ��������
    - ������ ���Ἲ ������ �������� �Ѵ�!
    
    * ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
*/

/*
    * NOT NULL ��������
    �ش� �÷��� �ݵ�� ���� �����ؾ߸� �� ��� (��, �ش� �÷��� ���� NULL�� ���ͼ��� �ȵǴ� ���)
    ���� / ������ NULL ���� ������� �ʵ��� ����
    
    ���� ������ �ο��ϴ� ����� ũ�� 2������ ���� (�÷�������� / ���̺������)
    * NOT NULL ���������� ������ �÷����߹��!! �ۿ� �ȵ� **�߿�**
*/

-- �÷�������� : �÷��� �ڷ��� ��������
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES (1, 'user01', 'pass01', '�����', '��', null, null);
INSERT INTO MEM_NOTNULL VALUES (2, 'user02', null, '�̰���', '��', null, 'aaa@naver.com');
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_NOTNULL"."MEM_PWD")
-- �ǵ��ߴ���� ������!! (NOT NULL �������ǿ� ����Ǿ� ���� �߻�)
INSERT INTO MEM_NOTNULL VALUES (2, 'user01', 'pass01', '�̽¿�', null, null, null);
--> ���̵� �ߺ��Ǿ��������� �ұ��ϰ� �� �߰��� ��..�̤�

----------------------------------------------------------------------------------
/*
    * UNIQUE ��������
    �ش� �÷��� �ߺ��� ���� ������ �� �� ���
    �÷����� �ߺ����� �����ϴ� ���� ����
    ���� / ������ ������ �ִ� �����Ͱ� �� �ߺ����� ���� ��� ���� �߻�!!
*/

CREATE TABLE MEM_UNIQUE(    -- �÷��������
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_UNIQUE;
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID)    --> ���̺� ������� (3:07)
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '�����', null, null,null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass02', '�̰���', null, null,null);
-- ORA-00001: unique constraint (DDL.SYS_C007081) violated
--> UNIQUE �������ǿ� ����Ǿ�����! INSERT ����!
--> ���������� �������Ǹ����� �˷���! (Ư�� �÷��� � ������ �ִ��� ���� �˷������� ����)
--> ���� �ľ��ϱ� �����..
--> �������� �ο���, �������Ǹ��� ���������� ������ �ý��ۿ��� ���Ƿ� �������Ǹ��� �ο��ع���

/*
    * �������� �ο���, �������Ǹ���� �����ִ� ���
    
    > �÷��������
    CREATE TABLE ���̺��(
        �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] ��������,
        �÷��� �ڷ���
    );
    
    > ���̺������
    CREATE TABLE ���̺��(
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        [CONSTRAINT �������Ǹ�] ��������(�÷���)
    );
    
*/

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL,
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPW_NN NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID)    --> ���̺� �������
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '�����', null, null,null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass02', '�̰���', null, null,null);
-- ORA-00001: unique constraint (DDL.MEMID_UQ) violated     -- ��,, MEMID_UQ ����������

INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '�̰���', null, null,null);
INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pass02', '�̰���', '��', null,null);
--> ������ ��ȿ�� ���� �ƴϾ �� INSERT�� �ȴ� => �̷��� �ȵ�..

----------------------------------------------------------------------------------
/*
    * CHECK(���ǽ�) ��������
    �ش� �÷��� ���� �� �ִ� ���� ���� ������ �����ص� �� ����
    �ش� ���ǿ� �����ϴ� �����Ͱ��� ��� �� ����
*/

CREATE TABLE MEM_CHECK(    -- �÷��������
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),  -- �÷��������
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    --CHECK(GENDER IN('��', '��'))  -- ���̺� ���� ���
);

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK VALUES(1, 'user01', 'pass01', '�����', '��', null, null);
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass02', '�̰���', '��', null, null);
-- ORA-02290: check constraint (DDL.SYS_C007091) violated
-- check �������ǿ� ����Ʊ� ������ ���� �߻�

INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass02', '�̰���', '��', null, null);
-- ���� GENDER �÷��� ������ ���� �ְ��� �Ѵٸ� CHECK �������ǿ� �����ϴ� ���� �־���ߵ�
-- NOT NULL �ƴϸ� NULL �� �����ϱ� ��!!
-- CHECK �������� == �Ա���!

INSERT INTO MEM_CHECK
VALUES (2, 'user03', 'pass03', '�̽¿�', '��', null, null);
-- ȸ����ȣ�� �����ص� ���������� insert �Ź���..

---------------------------------------------------------------------------------
/*
    * PRIMARY KEY(�⺻Ű) �������� => PK
    ���̺��� �� ����� �ĺ��ϱ� ���� ���� �÷��� �ο��ϴ� �������� (��ġ �ĺ����� ����)
    
    EX) ȸ����ȣ, �й�, �����ȣ, �μ��ڵ�, �����ڵ�, �ֹ���ȣ, �����ȣ, ������ȣ
    
    PRIMARY KEY ���������� �ο��ϸ� �� �÷��� �ڵ����� NOT NULL + UNIQUE �������� ������.
    
    * ���ǻ��� : �� ���̺�� ������ �Ѱ���!! ����
*/

CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,     -- ���� �ĺ� �ʷ� ���ߴ�!
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),  -- �÷��������
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO)  -- ���̺� ���� ���
);

SELECT * FROM MEM_PRI;

INSERT INTO MEM_PRI
VALUES(1, 'user01', 'pass01', '�����', '��', '010-1111-2222', null);

INSERT INTO MEM_PRI
VALUES(1, 'user02', 'pass02', '�̰���', '��', null, null);
-- ORA-00001: unique constraint (DDL.MEMNO_PK) violated
-- �⺻Ű�� �ߺ����� �������� �� �� (UNIQUE �������� ����)

INSERT INTO MEM_PRI
VALUES(NULL, 'user02', 'pass02', '�̰���', '��', null, null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI"."MEM_NO")
-- �⺻Ű�� NULL�� �������� �� �� (NOT NULL �������ǿ� �����)

INSERT INTO MEM_PRI
VALUES(2, 'user02', 'pass02', '�̰���', '��', null, null);

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER PRIMARY KEY,   
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),  -- �÷��������
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO)  -- ���̺� ���� ���
);
-- ORA-02260: table can have only one primary key
-- �⺻Ű�� �ϳ���!! �ȴ�

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER,  
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),  -- �÷��������
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO, MEM_ID)  -- ��� PRIMARY KEY ���� ���� �ο� (����Ű)
);

SELECT * FROM MEM_PRI2;

INSERT INTO MEM_PRI2
VALUES(1, 'user01', 'pass01', '�����', null, null, null);

INSERT INTO MEM_PRI2
VALUES(1, 'user02', 'pass02', '�̰���', null, null, null);

INSERT INTO MEM_PRI2
VALUES(2, 'user02', 'pass02', '�̽¿�', null, null, null);

INSERT INTO MEM_PRI2
VALUES(NULL, 'user02', 'pass02', '�̰���', null, null, null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI2"."MEM_NO")
-- PRIMARY KEY �� �����ִ� �� �÷����� ���� NULL�� ������� ����

---------------------------------------------------------------------------------
-- ����Ű ��� ���� (���ϱ�, ���ƿ�, ����)
-- ���ϱ� : �� ��ǰ�� ������ �ѹ��� ���� �� ����
-- � ȸ���� � ��ǰ�� ���ϴ����� ���� �����͸� �����ϴ� ���̺�
CREATE TABLE TB_LIKE(
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(30),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_NO, PRODUCT_NAME)
);

SELECT * FROM TB_LIKE;

INSERT INTO TB_LIKE VALUES(1, '����', SYSDATE);
INSERT INTO TB_LIKE VALUES(1, '����', SYSDATE);
INSERT INTO TB_LIKE VALUES(1, '����', SYSDATE);   -- ���� �߻�!! ���� �ѹ���!!
INSERT INTO TB_LIKE VALUES(2, '����', SYSDATE);

---------------------------------------------------------------------------------
-- ȸ�� ��޿� ���� �����͸� ���� �����ϴ� ���̺�
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

SELECT * FROM MEM_GRADE;

INSERT INTO MEM_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES(20, '���ȸ��');
INSERT INTO MEM_GRADE VALUES(30, 'Ư��ȸ��');

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,  
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),  -- �÷��������
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER -- ȸ�� ��޹�ȣ ���� ������ �÷�
);

SELECT * FROM MEM;

INSERT INTO MEM 
VALUES(1, 'user01', 'pass01', '�����', '��', null, null, null);

INSERT INTO MEM 
VALUES(2, 'user02', 'pass02', '�̰���', null, null, null, 10);

INSERT INTO MEM 
VALUES(3, 'user03', 'pass03', '�̽¿�', '��', null, null, 40);
-- 40�� ��ȿ�� ȸ����� ��ȣ�� �ƴԿ��� �ұ��ϰ� �� insert ��..

---------------------------------------------------------------------------------
/*
    * FOREIGN KEY(�ܷ�Ű) ��������
    �ٸ� ���̺� �����ϴ� ���� ���;� �Ǵ� Ư�� �÷��� �ο��ϴ� ���� ����
    --> �ٸ� ���̺��� �����Ѵٰ� ǥ��
    --> �ַ� FOREIGN KEY �������ǿ� ���� ���̺��� ���谡 ������
    
    > �÷��������
    �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] REFERENCES ���������̺�� [(�������÷���)]
    
    > ���̺������
   [CONSTRAINT �������Ǹ�] FOREIGN KEY(�÷���) REFERENCES ���������̺�� [(�������÷���)]
   
   --> ������ �÷��� ������, ������ ���̺� PRIMARY KEY�� ������ �÷����� �ڵ���Ī
*/

DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,  
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),  -- �÷��������
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) -- �÷��������
    -- , FOREIGNKEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
);

SELECT * FROM MEM;

INSERT INTO MEM 
VALUES(1, 'user01', 'pass01', '�����', '��', null, null, null);

INSERT INTO MEM 
VALUES(2, 'user02', 'pass02', '�̰���', null, null, null, 10);

INSERT INTO MEM 
VALUES(3, 'user03', 'pass03', '�̽¿�', '��', null, null, 40);
-- ORA-02291: integrity constraint (DDL.SYS_C007118) violated - parent key not found
-- 10, 20, 30, NULL ������ ���� ��.. �ٸ����� �Ұ���.

INSERT INTO MEM 
VALUES(3, 'user03', 'pass03', '�̽¿�', '��', null, null, 20);
