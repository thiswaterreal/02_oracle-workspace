/*
    < GROUP BY �� >
    �׷������ ������ �� �ִ� ���� (�ش� �׷� ���غ��� ���� �׷��� ���� �� ����)
    �������� ������ �ϳ��� �׷����� ��� ó���� �������� ���
*/

SELECT SUM(SALARY)
FROM EMPLOYEE;  --> ��ü ����� �ϳ��� �׷����� ��� �� ���� ���� ���

-- �� �μ��� �� �޿� ��
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �� �μ��� ��� ��
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY)   -- 3
FROM EMPLOYEE   -- 1
GROUP BY DEPT_CODE -- 2
ORDER BY DEPT_CODE; -- 4

SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- �� ���޺�
SELECT JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- �� ���޺� �� �����, ���ʽ��� �޴� �����, �޿� ��, ��ձ޿�, �����޿�, �ִ�޿� (��Ī���) + ���޸� �������� ����
SELECT JOB_CODE AS "����", COUNT(*) AS "�� �����", COUNT(BONUS) AS "���ʽ��� �޴� �����",
       SUM(SALARY) AS "�޿� ��", ROUND(AVG(SALARY)) AS "��ձ޿�",
       MIN(SALARY) AS "�����޿�", MAX(SALARY) AS "�ִ�޿�"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;
-- ORDER BY 1;  �̰͵� ���� (JOB_CODE�� 1���̴ϱ�)

-- GROUP BY ���� �Լ��� ��� ����
-- ��/���� �� ��� ��
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��'), COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

-- GROUP BY ���� ���� �÷� ��� ����
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1;

--===========================================================================================
/*
    < HAVING �� >
    �׷쿡 ���� ������ ������ �� ���Ǵ� ���� (�ַ� �׷��Լ����� ������ ������ ������ �� ���)
*/

-- �� �μ��� ��� �޿� ��ȸ (�μ��ڵ�, ��ձ޿�)
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;

-- �μ��� ��� �޿��� 300���� �̻��� �μ��鸸 ��ȸ
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
WHERE AVG(SALARY) >= 3000000    -- ����!! (�׷��Լ� ������ ���� ���ý� WHERE ������ �ȵ�)
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, AVG(SALARY)   -- 4
FROM EMPLOYEE   -- 1
GROUP BY DEPT_CODE  -- 2
HAVING AVG(SALARY) >= 3000000;  -- 3

-- ���޺� �� �޿��� (�� ���޺� �޿��� 1000���� �̻��� ���޸��� ��ȸ). �����ڵ�, �޿��� ��ȸ
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

SELECT *
FROM EMPLOYEE;

-- �μ��� ���ʽ��� �޴� ����� ���� �μ����� ��ȸ. �μ��ڵ�, ���ʽ��� �޴� ����� �� ��ȸ
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

---------------------------------------------------------------------------------
/*
    < SELECT�� ���� ���� >
    5. SELECT *|��ȸ�ϰ��� �ϴ� �÷� ��Ī | ����� "��Ī" | �Լ��� AS "��Ī"
    1. FROM ��ȸ�ϰ��� �ϴ� ���̺��
    2. WHERE ���ǽ� (�����ڵ� ������ ���)
    3. GROUP BY �׷�������� ���� �÷� | �Լ���
    4. HAVING ���ǽ� (�׷��Լ��� ������ ���)
    6. ORDER BY �÷��� | �÷����� | ��Ī [ 'ASC' | 'DESC' ] { NULLS FIRST | NULLS LAST }
*/

--===========================================================================================
/*
    < ���� ������ == SET OPERATION >
    
    �������� �������� ������ �ϳ��� ���������� ����� ������
    
    - UNION         : OR | ������ (�� ������ ������ ������� ���� �� �ߺ��Ǵ� ���� �ѹ��� ����������)
    - INTERSECT     : AND | ������ (�� ������ ������ ������� �ߺ��� �����)
    - UNION ALL     : ������ + ������ (�ߺ��� �κ��� �� �� ǥ���� �� ����)
    - MINUS         : ���� ��������� ���� ������� �� ������ (������)
*/

-- �μ��ڵ尡 D5�� ��� �Ǵ� �޿��� 300���� �ʰ��� ����� ��ȸ (���, �̸�, �μ��ڵ�, �޿�)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'; -- 6���� (�ڳ���, ������, ���ؼ�, �ɺ���, ������, ���ȥ)

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8���� (������, ������, ��ȫö, ���缮, ������, �ɺ���, ���ȥ, ������)

-- 1. UNION(������)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- ���� ������ ��� �Ʒ�ó�� WHERE ���� OR �ᵵ �ذ� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

---------------------------------------------------------------------------------
-- 2. INTERSECT(������)
-- �μ��ڵ尡 D5 �̸鼭 �޿������� 300���� �ʰ��� ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- ���� ������ ��� �Ʒ�ó�� WHERE ���� AND �ᵵ �ذ� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

---------------------------------------------------------------------------------

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY > 3000000;
-- ����!! �� �������� SELECT���� �ۼ��Ǿ��ִ� �÷� ���� �����ؾߵ�

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, BONUS -- HIRE_DATE�� �Ұ��� (��¥Ÿ��)
FROM EMPLOYEE
WHERE SALARY > 3000000;
-- �÷� ���� �Ӹ� �ƴ϶� �� �÷� �ڸ����� ������ Ÿ������ ����ؾ���

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
--ORDER BY EMP_NAME
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, BONUS -- HIRE_DATE�� �Ұ��� (��¥Ÿ��)
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY EMP_NAME;
-- ORDER BY ���� ���̰��� �Ѵٸ� �������� �ѹ� ���������

---------------------------------------------------------------------------------
-- 3. UNION ALL : �������� ���� ����� ������ �� ���ϴ� ������ (�ߺ��� ����)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

----------------------------------------------------------------------------------
-- 4. MINUS : ���� SELECT ������� ���� SELECT ����� �� ������ (������)
-- �μ��ڵ尡 D5�� ����� �� �޿��� 300���� �ʰ��� ������� �����ؼ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- �� ������ ��� �Ʒ�ó���� �����ϱ� ��
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;
