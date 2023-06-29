/*
    <SELECT>
    ������ ��ȸ�� �� ���Ǵ� ����
    
    >> RESULT SET : SELECT���� ���� ��ȸ�� ����� (��, ��ȸ�� ����� ������ �ǹ�)
    
    [ǥ����]
    SELECT ��ȸ�ϰ��� �ϴ� �÷�1, �÷�2, ....
    FROM ���̺��;
    
    * �ݵ�� �����ϴ� �÷����� ����Ѵ�!! ���� �÷� ���� ������!!
    
*/

-- EMPLOYEE ���̺��� ��� �÷�{*} ��ȸ
-- SELECT EMP_ID, EMP_NAME
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ���, �̸�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- JOB ���̺��� ��� �÷� ��ȸ
SELECT *
FROM JOB;

------------------------------ �ǽ����� -----------------------------
-- 1. JOB ���̺��� ���޸� ��ȸ
SELECT JOB_NAME
FROM JOB;

-- 2. DEPARTMENT ���̺��� ��� �÷� ��ȸ
SELECT *
FROM DEPARTMENT;

-- 3. DEPARTMENT ���̺��� �μ��ڵ�, �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 4. EMPLOYEE ���̺��� �����, �̸���, ��ȭ��ȣ, �Ի���, �޿� ��ȸ
SELECT * --EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    < �÷����� ���� ������� >
    SELECT�� �÷��� �ۼ� �κп� ������� ��� ���� (�̶�, �������� ��� ��ȸ)
*/
-- EMPLOYEE ���̺��� �����, ����ǿ���(�޿� * 12) ��ȸ
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �޿�, ���ʽ� ��ȸ
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �޿�, ���ʽ�, ����, ���ʽ� ���Ե� ����((�޿�+���ʽ�*�޿�)*12) ��ȸ
SELECT EMP_NAME, SALARY, BONUS, SALARY * 12, ((SALARY + BONUS * SALARY)*12)
FROM EMPLOYEE;
--> ������� ���� �� NULL ���� ������ ���, ��������� ����� ������ ������ NULL�� ����
--> NULL ���� ó���غ���!
SELECT EMP_NAME, SALARY, NVL(BONUS, 0), SALARY * 12, ((SALARY + NVL(BONUS, 0) * SALARY)*12)
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �Ի���
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �Ի���, �ٹ��ϼ�(���ó�¥ - �Ի���)
-- DATE ���ĳ����� ���� ����!
-- *** ���ó�¥ : SYSDATE ***
SELECT EMP_NAME, HIRE_DATE, (SYSDATE - HIRE_DATE)
FROM EMPLOYEE;
-- DATE - DATE : ������� �� ������ ����
-- ��, ���� �������� ������ DATE ���� ��/��/��/��/��/�� ������ �ð����������� ������ �ϱ� ����!
-- �Լ������ϸ� ����� ��� Ȯ�� ���� => ���߿� ���

-----------------------------------------------------------------------
/*
    < �÷��� ��Ī �����ϱ� >
    ��������� �ϰԵǸ� �÷��� ��������.. �̶� �÷������� ��Ī �ο��ؼ� ����ϰ� ������
    
    [ǥ����]
    �÷��� ��Ī / �÷��� AS ��Ī / �÷��� "��Ī" / �÷��� AS "��Ī"
    
    AS ���̵� �Ⱥ��̵� �ο��ϰ��� �ϴ� ��Ī�� ���� Ȥ�� Ư�����ڰ� ���Ե� ��� �ݵ�� �ֵ���ǥ�� �������
*/

SELECT EMP_NAME �����, SALARY AS �޿�, SALARY * 12 "����(��)", (SALARY + SALARY * BONUS)*12 AS "�� �ҵ�(���ʽ�����)"
FROM EMPLOYEE;

------------------------------------------------------------------------------
/*
    < ���ͷ� >
    ���Ƿ� ������ ���ڿ�('')
    
    SELECT ���� ���ͷ��� �����ϸ� ��ġ ���̺�� �����ϴ� ������ó�� ��ȸ ����
    ��ȸ�� RESULT SET�� ��� �࿡ �ݺ������� ���� ���
*/

-- EMPLOYEE ���̺��� ���, �����, �޿� ��ȸ
SELECT EMP_NO, EMP_NAME, SALARY, '��' AS "����"
FROM EMPLOYEE;

/*
    < ���� ������ : || >
    ���� �÷������� ��ġ �ϳ��� �÷��� �� ó�� �����ϰų�, �÷����� ���ͷ��� ������ �� ����
    
    System.out.println("num�� �� : " + num);
*/

-- ���, �̸�, �޿��� �ϳ��� �÷����� ��ȸ
SELECT EMP_NO || EMP_NAME || SALARY
FROM EMPLOYEE;

-- �÷����� ���ͷ��� ����
-- XXX�� ������ XXX�� �Դϴ�. => �÷��� ��Ī : �޿�����
SELECT EMP_NAME || '�� ������ ' || SALARY || '�� �Դϴ�.' AS "�޿�����"
FROM EMPLOYEE;

-------------------------------------------------------------------------
/*
    < DISTINCT >
    �÷��� �ߺ��� ������ �� ������ ǥ���ϰ��� �� �� ���
*/
-- ���� �츮ȸ�翡 � ������ ������� �����ϴ��� �ñ���.

SELECT JOB_CODE
FROM EMPLOYEE; -- ����� 23���� ������ ���� �� ��ȸ�� ��.

-- EMPLOYEE�� �����ڵ�(�ߺ�����) ��ȸ
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; -- �ߺ����� �Ǿ� 7�ุ ��ȸ

-- ������� � �μ��� �����ִ��� �ñ�
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; -- null : ���� �μ���ġ �ȵ� ���

-- ** ���� ���� : DISTINCT�� SELECT ���� �� �ѹ���!! ��� ����
/* (��������. 2����⶧����)
SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
FROM EMPLOYEE;
*/

SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE;
-- (JOB_CODE, DEPT_CODE) ������ ��� �ߺ� �Ǻ�

-- ========================================================================

/*
    < WHERE �� >
    ��ȸ�ϰ��� �ϴ� ���̺�κ��� Ư�� ���ǿ� �����ϴ� �����͸��� ��ȸ�ϰ��� �� �� ���
    �̶�, WHERE���� ���ǽ��� �����ϰ� ��
    ���ǽĿ����� �پ��� �����ڵ� ��� ����!
    
    [ǥ����]
    SELECT �÷�1, �÷�2, ....
    FROM ���̺��
    WHERE ���ǽ�;
    
    [�񱳿�����]
    >, <, >=, <=        --> ��Һ�
    =                   --> �����
    !=, ^=, <>          --> �������� ������ ��
*/

-- EMPLOYEE ���� �μ��ڵ尡 'D9'�� ����鸸 ��ȸ (�̶�, ��� �÷� ��ȸ)
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE ���� �μ��ڵ尡 'D1'�� => ������� �����, �޿�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- EMPLOYEE���� �μ��ڵ尡 'D1'�� �ƴ� ������� ���, �����, �μ��ڵ� ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D1';
--WHERE DEPT_CODE ^= 'D1';
WHERE DEPT_CODE <> 'D1';

-- �޿��� 400���� �̻��� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE���� ������(EMP_YN �÷����� 'N')�� ������� ���, �����, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

------------------------------ �ǽ����� --------------------------------

-- 1. �޿��� 300���� �̻��� ������� �����, �޿�, �Ի���, ����(���ʽ� ������) ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE, SALARY*12 AS "����"
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. ������ 5000���� �̻��� ������� �����, �޿�, ����, �μ��ڵ� ��ȸ
SELECT EMP_NAME, SALARY, SALARY*12 AS "����", DEPT_CODE
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;
--WHERE ���� >= 50000000;  <= ����!! (WHERE �������� SELECT ���� �ۼ��� ��Ī ��� �Ұ�!!)

-- ���� ���� ����
-- FROM �� ==> WHERE �� ==> SELECT ��

-- 3. �����ڵ� 'J3'�� �ƴ� ������� ���, �����, �����ڵ�, ��翩�� ��ȸ
SELECT EMP_NO, EMP_NAME, JOB_CODE, ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

-- �μ��ڵ尡 'D9' �̸鼭 �޿��� 500���� �̻��� ������� ���, �����, �޿�, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- �μ��ڵ尡 'D6'�̰ų� �޿��� 300���� �̻��� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- �޿��� 350���� �̻� 600���� ���ϸ� �޴� ������� �����, ���, �޿� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE 3500000 <= SALARY <= 6000000;            -- ����!! (�ڹٶ� ���������� �ȵ�)
--WHERE 3500000 <= SALARY AND SALARY <= 6000000; -- ���������� ���� ����..
WHERE SALARY >= 3500000 AND SALARY <= 6000000;  -- �Ϲ������� �� ����!!

/*
    < BETWEEN AND >
    ���ǽĿ��� ���Ǵ� ����
    �� �̻� �� ������ ������ ���� ������ ������ �� ���Ǵ� ������
    
    [ǥ����]
    �񱳴���÷� BETWEEN A(��1) AND B(��2)
    => �ش� �÷����� A(��1) �̻��̰� B(��2) ������ ���
*/

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- ���� ���� ���� ���� ����� ��ȸ�ϰ� �ʹٸ�? 350 �̸� + 600 �ʰ�
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE SALARY < 3500000 OR SALARY > 6000000;       -- ����
--WHERE NOT SALARY BETWEEN 3500000 AND 6000000;     -- ����
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;       -- ����
-- NOT : ������������ => �ڹٿ����� !
-- �÷��� �� �Ǵ� BETWEEN �տ� ���� ����

-- �Ի����� '90/01/01' ~ '01/01/01'
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '01/01/01'; -- DATE ������ ��Һ� ����
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

/*
    < LIKE >
    ���ϰ��� �ϴ� �÷����� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
    
    [ǥ����]
    �񱳴���÷� LIKE 'Ư������'
    
    - Ư������ ���ý� '%', '_' �� ���ϵ� ī��� ����� �� ����
    
    >> '%' : 0���� �̻�
    EX) �񱳴���÷� LIKE '����%'       => �񱳴���� �÷����� ���ڷ� '����' �Ǵ� ���� ��ȸ
        �񱳴���÷� LIKE '%����'       => �񱳴���� �÷����� ���ڷ� '��' ���� ���� ��ȸ
        �񱳴���÷� LIKE '%����%'      => �񱳴���� �÷����� �ش� ���ڰ� '����' �Ǵ� ���� ��ȸ (Ű���� �˻�)
       
    >> '_' : 1���� �̻�
    EX) �񱳴���÷� LIKE '_����'       => �񱳴���� �÷����� ���ھտ� ������ �ѱ��ڸ� �� ��� ��ȸ
        �񱳴���÷� LIKE '__����'      => �񱳴���� �÷����� ���ھտ� ������ �α��ڰ� �� ��� ��ȸ
        �񱳴���÷� LIKE '_����_'      => �񱳴���� �÷����� ���� �հ� ���� �ڿ� ������ �ѱ��ھ� �� ��� ��ȸ
    
*/
-- ����� �� ���� '��'���� ������� �����, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- ����� �� �̸��� '��'�� ������ ������� �����, �ֹι�ȣ, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

-- ����� �� �̸��� '��'�� ���Ե� ������� �����, �ֹι�ȣ, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- �̸��� ��� ���ڰ� '��'�� ������� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';

-- ��ȭ��ȣ�� 3��° �ڸ��� 1�� ������� ���, �����, ��ȭ��ȣ, �̸��� ��ȸ (ex) 011-)
-- ���ϵ�ī�� : _(1����), %(0���� �̻�)
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%'; -- '%'�ں��ʹ� �� �͵� ��������~ �� ��!

-- ** Ư�����̽� **
-- �̸��� �� _ �������� �ձ��ڰ� 3������ �������  ���, �̸�, �̸��� ��ȸ
-- EX) sim_bs@kh.or.kr, sun_di@kh.or.kr
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%'; -- (_4������) ���ߴ� ��� ���� ����..
-- ���ϵ�ī��� ����ϰ��ִ� ���ڿ� �÷����� ��� ���ڰ� �����ϱ� ������ ����� ��ȸ �ȵ�!!
--> ��� ���ϵ�ī���̰� ��� ������ ������ ���� ����� ��
--> ������ ������ ����ϰ��� �ϴ� �� �տ� ������ ���ϵ� ī�带 �����ϰ� ������ ���ϵ� ī�带 ESCAPE OPTION���� ����ؾ� ��
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';

-- ���� ������� �ƴ� �� ���� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
--WHERE NOT EMAIL LIKE '___$_%' ESCAPE '$';     -- ����
WHERE EMAIL NOT LIKE '___$_%' ESCAPE '$';       -- ����

-------------------------------------- �ǽ����� ------------------------------------

-- 1. EMPLOYEE���� �̸��� '��'���� ������ ������� �����, �Ի���, ��ȸ
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

-- 2. EMPLOYEE���� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ������� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- 3. EMPLOYEE���� �̸��� '��'�� ���ԵǾ��ְ�, �޿��� 240���� �̻��� ������� �����, �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%' AND SALARY >= 2400000;

-- 4. DEPARTMENT���� �ؿܿ������� �μ����� �ڵ�, �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '�ؿܿ���%';     -- '%�ؿܿ���%' �� ����

---------------------------------------------------------------------------------

/*
    < IS NULL / IS NOT NULL >
    �÷����� NULL�� ���� ���, NULL�� �񱳿� ���Ǵ� ������
*/

-- ���ʽ��� ���� �ʴ� ���(BONUS ���� NULL)���� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
-- WHERE BONUS = NULL;      ���������� ��ȸ �ȵ� ***����***
WHERE BONUS IS NULL;

-- ���ʽ��� �޴� ���(BONUS ���� NULL�� �ƴ�)���� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
-- WHERE BONUS != NULL;     ���������� ��ȸ �ȵ� ***����***
WHERE BONUS IS NOT NULL;
-- WHERE NOT BONUS IS NULL;
-- NOT�� �÷��� �Ǵ� IS �ڿ��� ��� ����

-- ����� ���� ���(MANAGER_ID ���� NULL��)���� �����, ������, �μ��ڵ� ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- �μ���ġ�� ���� ������ �ʾ�����(DEPT_CODE ���� NULL��), ���ʽ��� �޴� ���(BONUS ���� NULL�� �ƴ�)���� �̸�, ���ʽ�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

----------------------------------------------------------------------------------

/*
    < IN >
    �񱳴���÷����� ���� ������ ����߿� ��ġ�ϴ� ���� �ִ���
    
    [ǥ����]
    �񱳴���÷� IN ('��1', '��2', '��3', ....);
*/

-- �μ��ڵ� 'D6' �̰ų� 'D8' �̰ų� 'D5'�� �μ������� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
-- WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';  ���������� ���
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');

-- �� ���� �����
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D6', 'D8', 'D5');

--================================================================================

/*
    < ������ �켱���� >
    0. ()
    1. ��������� :  +  -  /  * 
    2. ���Ῥ���� :  || 
    3. �񱳿����� :  >  <  =  >=  <=  !=  <>  ^= 
    4. IS NULL / LIKE 'Ư������' / IN
    5. BETWEEN AND
    6. NOT(��������)
    7. AND(��������)
    8. OR(��������)
*/

-- �����ڵ尡 J7�̰ų� J2�� ����� �� �޿��� 200���� �̻��� ������� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;

------------------------------- �ǽ����� -----------------------------
-- 1. ����� ����, �μ���ġ�� ���� ���� ������� (�����, ������, �μ��ڵ�) ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- 2. ����(���ʽ�������)�� 3000���� �̻��̰�, ���ʽ��� ���� �ʴ� ������� (���, �����, �޿�, ���ʽ�) ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE SALARY*12 >= 30000000 AND BONUS IS NULL;

-- 3. �Ի����� '95/01/01' �̻��̰�, �μ���ġ�� ���� ������� (���, �����, �Ի���, �μ��ڵ�) ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01' AND DEPT_CODE IS NOT NULL;

-- 4. �޿��� 200���� �̻� 500���� �����̰�, �Ի����� '01/01/01' �̻��̰�, ���ʽ��� ���� �ʴ� �������
-- (���, �����, �޿�, �Ի���, ���ʽ�) ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE, BONUS
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 5000000 AND HIRE_DATE >= '01/01/01' AND BONUS IS NULL;

-- 5. ����(���ʽ�����)�� NULL�� �ƴϰ�, �̸��� '��'�� ���ԵǾ� �ִ� ������� (���, �����, �޿�, ���ʽ����Կ���) ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, (SALARY + SALARY * BONUS)*12 AS "(���ʽ�����)����"
FROM EMPLOYEE
WHERE (SALARY + SALARY * BONUS)*12 IS NOT NULL AND EMP_NAME LIKE '%��%';
--WHERE BONUS IS NOT NULL AND EMP_NAME LIKE '%��%';  <= �̰͵� ����

---------------------------------------------------------------------------------
SELECT EMP_ID, EMP_NAME, SALARY --3
FROM EMPLOYEE --1
WHERE DEPT_CODE IS NULL; --2
-- ���� WHERE������ ��Ī�� ����� �� ���� --

--===============================================================================
/*
    < ORDER BY �� >
    ���� ������ �ٿ� �ۼ�! �Ӹ��ƴ϶� ������� ���� �������� ����
    
    [ǥ����]
    SELECT ��ȸ�� �÷�, �÷�, �������� AS "��Ī", ..
    FROM ��ȸ�� ���̺��
    WHERE ���ǽ�
    ORDER BY �����ϰ�����÷�|��Ī|�÷����� [ASC|DESC] [NULLS FIRST | NULLS LAST]
    
    - ASC   : �������� ���� (������ �⺻��)
    - DESC  : �������� ����
    
    - NULLS LAST    : �����ϰ��� �ϴ� �÷����� NULL�� ���� ���, �ش� �����͸� �� '��'�� ��ġ (������ ASC�϶��� �⺻��)
    - NULLS FIRST   : �����ϰ��� �ϴ� �÷����� NULL�� ���� ���, �ش� �����͸� �� '��'�� ��ġ (������ DESC�϶��� �⺻��)
*/

SELECT *
FROM EMPLOYEE
--ORDER BY BONUS;
--ORDER BY BONUS ASC;               -- ��������(ASC) ������ �� �⺻������ NULLS LAST ����!
--ORDER BY BONUS ASC NULLS FIRST;
--ORDER BY BONUS DESC;              -- ��������(DESC) ������ �� �⺻������ NULLS FIRST ����!
--ORDER BY BONUS DESC NULLS LAST;
ORDER BY BONUS DESC, SALARY ASC;    -- ���ı��� ������ ���� ���� (ù��° ������ �÷����� ������ ���, �ι�° ���� �÷������� ����)

-- ��ü ����� �����, ���� ��ȸ (�̶� ������ �������� ���� ��ȸ)
SELECT EMP_NAME, SALARY*12 AS "����"  --2
FROM EMPLOYEE   --1
--ORDER BY SALARY*12 DESC;
--ORDER BY ���� DESC;   --3 (���� ������ �켱������ ���� ������ ��Ī ��� ����)
ORDER BY 2 DESC;        -- (�÷� ���� ��� ����. ��, �÷� �������� ū ���� �ȵ�)

-- ** ��������(NULL, 9, 8 ... 1) ��ġ�� NULL���� �ڷ� ������ �غ���! (9, 8, ... 1, NULL)
SELECT EMP_NAME, BONUS
FROM EMPLOYEE
ORDER BY 2 DESC NULLS LAST;

