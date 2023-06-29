--(�������غ���)
------------------------------- QUIZ 1 --------------------------------
-- ���ʽ��� ���� ������, �μ���ġ�� �� ��� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CPDE != NULL;
-- NULL ���� ���� ���������� �� ó�� ���� ����! ��?

--> ������     : NULL�� ���Ҷ��� �ܼ��� �Ϲ� �񱳿����ڸ� ���� ���� �� ����!
--> �ذ���    : IS NULL / IS NOT NULL �����ڸ� �̿��Ͽ� ���ؾ���
--> ��ġ�� SQL��
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CPDE IS NOT NULL;

------------------------------- QUIZ 2 --------------------------------
-- �˻��ϰ��� �ϴ� ����
-- JOB_CODE J7 �̰ų� J6 �̸鼭 SALARY���� 200���� �̻��̰�
-- BONUS�� �ְ�, �����̸�, �̸����ּҴ� _�տ� 3���ڸ� �ִ� �����
-- EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS �� ��ȸ�Ϸ��� ��.
-- ���������� ��ȸ�� �ߵȴٸ� �������� 2�� �̾�� ��.

-- ���� ������ �����Ű���� �ۼ��� SQL���� �Ʒ��� ����
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
AND EMAIL LIKE '____%' AND BONUS IS NULL;
-- ���� SQL�� ����� ���ϴ� ����� ����� ��ȸ���� �ʴ´�. �̶� � ��������(5��)�� �ִ���
-- ��� ã�Ƽ� �����غ���! �׸��� ��ġ�� �Ϻ��� SQL���� �ۼ��غ� ��!
-- SUBSTR(�÷�, �����ε���, ����) *** �ε��� 1���� ���� ***

--> ������(5��) : AND OR �켱����, > , $����, IS NULL, ���ڱ��� ����
-- 1. OR �����ڿ� AND ������ �����Ǿ����� ���, AND������ ������ ���� �����! �������� �䱸�� �������� OR������ ���� ����Ǿ����!
-- 2. �޿����� ���� �񱳰� �߸��Ǿ�����. >�� �ƴ� >= ���� ���ؾ���
-- 3. ���ʽ��� �ִ� �̶�� ���ǿ� IS NULL�� �ƴ� IS NOT NULL�� ���ؾ���
-- 4. ���ڿ� ���� ������ �����Ǿ�����
-- 5. �̸��Ͽ� ���� �񱳽� �׹�° �ڸ��� �ִ� _�� �����Ͱ����� ����ϱ� ���ؼ��� �� ���ϵ� ī�带 �����ؾߵǰ�, �� ESCAPE�� ��ϱ��� �ؾ���

--> �ذ��� : (), >=, $, IS NOT NULL, ���ڱ����߰�
--> ��ġ�� SQL��
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
AND SUBSTR(EMP_NO, 8, 1) IN ('2', '4')
--AND EMP_NO LIKE '_______2%'
AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL;

------------------------------- QUIZ 3 --------------------------------
-- [������������] CREATE USER ������ IDENTIFIED BY ��й�ȣ;

-- ������ : SCOTT, ��й�ȣ : TIGER ������ �����ϰ� �ʹ�!
-- �̶� �Ϲݻ���� ������ KH������ �����ؼ� CREATE USER SCOTT; �� �����ϴ� ���� �߻�!

--> ������
-- 1. ����� ���� ������ ������!! ������ ���������� ����!!
-- 2. SQL���� �߸��Ǿ�����. ������� �Է��ؾ���

--> ��ġ����
-- 1. �����ڰ������� �����ؾ��Ѵ�
-- 2. CREATE USER SCOTT IDENTIFIED BY TIGER;

-- ���� SQL(CREATE)���� ���� �� ������ ����� ������ �Ϸ��� �ߴ��� ����!
-- �Ӹ� �ƴ϶� �ش� ������ ���̺� ���������͵� ���� ����.. ��??

--> ������
-- 1. ����� ���� ���� �� �ּ����� ���� �ο��������

--> ��ġ����
-- 1. GRANT CONNECT, RESOURCE TO SCOTT; ���� �����Ͽ� ���� �ο�!!

------------------------------------------------------------------------
-- �μ��ڵ尡 D5�� ������� �� ���� ��
SELECT SUM(SALARY * 12)   -- ,EMP_NAME : �׷��Լ��̱� ������ �������Լ� ���� ������ *****
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

------------------------------------------------------------------------
-- 5. COUNT(*|�÷�|DISTINCT �÷�) : ��ȸ�� �� ������ ���� ��ȯ

--    COUNT(*)            : ��ȸ�� ����� ��� �� ������ ���� ��ȯ
--    COUNT(�÷�)          : ������ �ش� �÷����� NULL�� �ƴѰ͸� �� ���� ���� ��ȯ
--    COUNT(DISTINCT �÷�) : �ش� �÷��� �ߺ��� ������ �� �� ���� ���� ��ȯ

-- ��ü ��� ��
SELECT COUNT(*)
FROM EMPLOYEE;

-- ���� ��� �� 
SELECT COUNT(*) -- 3
FROM EMPLOYEE   -- 1
WHERE SUBSTR(EMP_NO, 8, 1) IN('2', '4');    -- 2

-- ���ʽ��� �޴� ��� ��
SELECT COUNT(BONUS) -- �÷��� NULL�� �ƴ�!!�͸�(�� ����) ī������
FROM EMPLOYEE;
--WHERE BONUS IS NOT NULL;

-- �μ���ġ�� ���� ��� ��
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- ���� ������� ��� �μ��� �����Ǿ��ִ���
SELECT COUNT(DISTINCT DEPT_CODE)    --6 (D1 D2 D5 D6 D8 D9)
FROM EMPLOYEE;
----------------------------------------------------------------------------------

-- ���� ��� �� 
SELECT COUNT(*) -- 3
FROM EMPLOYEE   -- 1
WHERE SUBSTR(EMP_NO, 8, 1) IN('2', '4');    -- 2

-- GROUP BY�� ������?   //������
SELECT SUBSTR(EMP_NO, 8, 1) IN ('2'), COUNT(*) -- 3
FROM EMPLOYEE   -- 1
WHERE SUBSTR(EMP_NO, 8, 1);    -- 2 

-- GROUP BY ���� �Լ��� ��� ����
-- ��/���� �� ��� ��
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��'), COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);
