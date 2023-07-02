/*
    * �������� (SUBQUERY) == '����ȸ'
    - �ϳ��� SQL�� �ȿ� ���Ե� �� �ٸ� SELECT��
    - ���� SQL���� ���� ���� ������ �ϴ� ������
*/

-- ���� �������� ���� 1
-- ���ö ����� ���� �μ��� ���� ����� ��ȸ�ϰ� ����
-- 1) ���� ���ö ����� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';     --D9

-- 2) �μ��ڵ尡 D9�� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- ���� 1, 2�� �ϳ��� ����������..
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '���ö');
                   
-- ���� �������� ���� 2
-- �� ������ ��ձ޿����� �� ���� �޿��� �޴� ������� ���, �̸�, �����ڵ�, �޿� ��ȸ
-- 1) �� ������ ��� �޿� ��ȸ
SELECT AVG(SALARY)
FROM EMPLOYEE;      -- �뷫 3047663�� �ΰ� �˾Ƴ�

-- 2) �޿��� 3047663�� �̻��� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047663;

-- ���� 1, 2�� �ϳ��� ����������..
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                 FROM EMPLOYEE);
                
---------------------------------------------------------------------------------
/*
    * ���������� ����
      �������� ������ ������� �� �� �� ���̳Ŀ� ���� �з���
      
      - ������ �������� : ���������� ��ȸ ������� ������ ������ 1�� �϶� (�� �� �� ��) /
      - ������ �������� : ���������� ��ȸ ������� ������ �϶� (������ �ѿ�) => �������� ���ö / IN, ANY, ALL
      - ���߿� �������� : ���������� ��ȸ ������� �� �������� �÷��� �������� �� (�� �� ���� ��) / = > <
      - ������ ���߿� �������� : �������� ��ȸ ������� ������ �����÷��� �� (������ ������) / () IN ()
      
      >> �������� ������ ���Ŀ� ���� �������� �տ� �ٴ� �����ڰ� �޶���!! *** �߿� ***
*/

--==================================< ������ �������� >===================================
/*
    1. ������ �������� (SINGLE ROW SUBQUERY)
    ���������� ��ȸ ������� ������ ������ 1���� �� (���� �ѿ�)
    �Ϲ� �� ������ ��� ����
    =, !=, ^=, <>, <, >, >=, <= ...
*/

-- 1) �� ������ ��ձ޿�'���� �޿��� �� ���� �޴� ������� �����, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)     
                FROM EMPLOYEE);         -- 3047662.6 �������� ��� �޿�
                
-----------------------------------------               
-- 2) ���� �޿�'�� �޴� ����� ���, �̸�, �޿�, �Ի���
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)     
                FROM EMPLOYEE);         -- 1380000 ���������� ���� �޿�
                
-----------------------------------------                
-- 3) ���ö ����� �޿�'���� �� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY         
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');  -- 3700000 ���ö ����� �޿�
                
-- >> ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE (DEPT_CODE = DEPT_ID)
AND SALARY > (SELECT SALARY
              FROM EMPLOYEE
              WHERE EMP_NAME = '���ö');

-- >> ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');

-----------------------------------------               
-- 4) �μ���: �޿����� ���� ū �μ�'�� �μ��ڵ�, �޿� �� ��ȸ
-- 4_1) ���� �μ��� �޿��� �߿����� ���� ū �� �ϳ��� ��ȸ
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE; --17700000

-- 4_2) �μ��� �޿����� 177700000���� �μ� ��ȸ (�μ��ڵ�, �޿���)
SELECT DEPT_CODE, SUM(SALARY)       -- GROUP���� �����͵��� �հ�ϱ�, �׷��Լ����� �������Լ� ���� �� �� ����
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;

-- ���� �� �ܰ踦 �ϳ��� ����������..
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);

-----------------------------------------                       
-- �����غ���
-- ������ ����� ���� �μ�'������ ���, �����, ��ȭ��ȣ, �Ի���, �μ���
-- ��, �������� ����!
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '������') -- D1
AND EMP_NAME != '������';

-- >> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_CODE = (SELECT DEPT_CODE
                 FROM EMPLOYEE
                 WHERE EMP_NAME = '������') -- D1
AND EMP_NAME != '������';

-- >> ANSI ����
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '������') -- D1
AND EMP_NAME != '������';

--==================================< ������ �������� >===================================
/*
    2. ������ �������� (MULTI ROW SUBQUERY)
    ���������� ������ ������� ���� �� �϶� (�÷�(��)�� �Ѱ�)
    
    - IN �������� : �������� ����� �߿��� �Ѱ��� ��ġ�ϴ� ���� �ִٸ�   // '=' ��� ���� ����
    
    - > ANY �������� : �������� ����� �߿��� '�Ѱ���' Ŭ ��� (�������� ����� �߿��� ���� ���� �� ���� Ŭ ���)
    - < ANY �������� : �������� ����� �߿��� '�Ѱ���' ���� ��� (�������� ����� �߿��� ���� ū �� ���� ���� ���)

    �񱳴�� > ANY (��1, ��2, ��3)
    �񱳴�� > ��1 OR �񱳴�� > ��2 OR �񱳴�� > ��3                  // > <  ���?
    
    - > ALL �������� : �������� '���' ������� ���� Ŭ ���
    - < ALL �������� : �������� '���' ������� ���� ���� ���
    
    �񱳴�� > ALL (��1, ��2, ��3)
    �񱳴�� > ��1 AND �񱳴�� > ��2 AND �񱳴�� > ��3
    
*/

-- 1) ����� �Ǵ� ������ ����� ���� ����'�� ������� ���, �����, �����ڵ�, �޿�
-- 1_1) ����� �Ǵ� ������ ����� � �������� ��ȸ
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('�����', '������');   -- J3, J7

-- 1_2) J3, J7�� ������ ����� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3', 'J7');

-- ���� �� �ܰ踦 �ϳ��� ����������..
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME IN ('�����', '������'));      -- J3, J7 (������)
                   -- = �̶�� ���� ����!! ���� ������ ��ȸ�߱� ����
                   -- ���࿡ ������� ���� �� ���� �� ������ �׳� �����ϰ� IN ���� ����
                   
----------------------------------------
-- ��� => �븮 => ���� => ���� => ���� ..
-- 2) (�븮 �����ӿ��� �ұ��ϰ�) ���� ���� �޿���' �� �ּ� �޿����� < ���� �޴� (�븮)���� ��ȸ (���, �̸�, ����, �޿�)
-- 2_1) ���� ���� ������ ������� �޿� ��ȸ
SELECT SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND J.JOB_NAME = '����';  -- 2200000 2500000 3760000 (������� �޿�)

-- 2_2) ������ �븮�̸鼭 �޿����� ���� ��ϵ� �� �߿� �ϳ��� ū ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > ANY (2200000, 2500000, 3760000);       -- �� �� �ϳ��� ������ ũ�⸸ �ϸ� ��! (ANY!!)

-- ���� �� �ܰ踦 �ϳ��� ����������..
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > ANY (SELECT SALARY
                  FROM EMPLOYEE E, JOB J
                  WHERE E.JOB_CODE = J.JOB_CODE
                  AND J.JOB_NAME = '����');

-- ��� ������ ���������ε� ����!
-- ���� ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE SALARY > (SELECT MIN(SALARY)
                FROM EMPLOYEE
                JOIN JOB USING (JOB_CODE)
                WHERE JOB_NAME = '����')  -- 2200000 (����� �� �ּ� �޿�)
AND JOB_NAME = '�븮';

-- ����
/*
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > (SELECT MIN(SALARY)
                  FROM EMPLOYEE E, JOB J
                  WHERE E.JOB_CODE = J.JOB_CODE
                  AND JOB_NAME = '����');
*/
-----------------------------------------                  
-- 3) (���� �����ӿ��� �ұ��ϰ�) ���� ������ ������� ��� �޿�'���ٵ� �� ���� �޴� ������� ���, �̸�, ���޸�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '����'
AND SALARY > ALL (SELECT SALARY
                    FROM EMPLOYEE E, JOB J
                    WHERE E.JOB_CODE = J.JOB_CODE
                    AND JOB_NAME = '����');         -- 2800000, 1550000, 2490000, 2480000 (������� �޿�)
                                                    -- �� ����� ������ Ŀ���� (ALL!!)

--==================================< ���߿� �������� >===================================
/*
    3. ���߿� ��������
    ������� �� �������� ������ �÷����� �������� ���
*/

-- 1) '������' ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ����� ��ȸ (�����, �μ��ڵ�, �����ڵ�, �Ի�����)
-- ������ �������� ** 2���� ���������� �ۼ��� ��!
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������')      -- D5 (DEPT_CODE)
AND JOB_CODE = (SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������');     -- J5 (JOB_CODE)

-- >> ���߿� ����������
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
--WHERE (DEPT_CODE, JOB_CODE) = (������ ����� �μ��ڵ� ������ ����� �����ڵ�);
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE                      -- D5, D6
                               FROM EMPLOYEE
                               WHERE EMP_NAME = '������'); -- ���� �߿���!!, ���� �������!!

--------------------------------------------
-- '�ڳ���' ����� ���� �����ڵ�, ���� ����� ������ �ִ� ������� ���, �����, �����ڵ�, ������ ��ȸ
-- ������ ��������
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE JOB_CODE = (SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '�ڳ���')     -- J7 (JOB_CODE)
AND MANAGER_ID = (SELECT MANAGER_ID
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '�ڳ���');    -- 207 (MANAGER_ID)
                    
-- ���߿� ��������
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '�ڳ���');      -- J7, 207 (JOB_CODE, MANAGER_ID)



-- 1. ã�����ϴ� �ٽ�!! (���� �÷�)�� �������� ����
-- 2. ����ȸ : 'SELECT ���� �÷�' �� �ʵη� �Ҷ�� �ۼ�
-- 3. ������ȸ : WHERE ���� (�����÷�) = (����ȸ)

--==================================< ���߿� ���߿� �������� >===================================
/*
    4. ������ ���߿� ��������
    �������� ��ȸ ������� ������, ������ �� ���
*/

-- 1) �� ���޺� �ּ� �޿�'�� �޴� ��� ��ȸ (���, �����, �����ڵ�, �޿�)

-- >> �� ���޺� �ּ� �޿� ��ȸ
SELECT JOB_CODE, MIN(SALARY)    -- 3
FROM EMPLOYEE   -- 1
GROUP BY JOB_CODE;   -- 2                       -- J1, J2, J3 ... J7 : ������

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY = 3700000
OR    JOB_CODE = 'J7' AND SALARY = 1380000;     -- (JOB_CODE, SALARY) : ������
... -- �ʹ� ����..

-- ���������� �����ؼ� �غ���
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE); -- ���������� ������, ���߿�

-- 2) �� �μ��� �ְ� �޿��� �޴� ��� ��ȸ (���, �����, �����ڵ�, �޿�)
-- >> �� �μ��� �ְ� �޿� ��ȸ
SELECT DEPT_CODE, MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                              FROM EMPLOYEE
                              GROUP BY DEPT_CODE);
                              
--=====================================< �ζ��� �� >==========================================
/*
    5. �ζ��� �� (INLINE - VIEW)
    
    ���������� ������ ����� ��ġ ���̺�ó�� ���! ( WHERE ������ ��Ī ��� ����!)
*/

-- ������� ���, �̸�, ���ʽ� ���� ���� (��Ī�ο� : ����), �μ��ڵ� ��ȸ => ���ʽ� ���� ������ ���� NULL�� �ȳ�����
-- ��, ���ʽ� ���� ������ 3000���� �̻��� ����鸸 ��ȸ
-- (�޿� + �޿� * ���ʽ�)*12
SELECT EMP_NO, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0))*12 AS "����", DEPT_CODE   -- 3
FROM EMPLOYEE   -- 1
WHERE (SALARY + SALARY * NVL(BONUS, 0))*12 >= 30000000; -- 2

SELECT EMP_NO, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0))*12 AS "����", DEPT_CODE
FROM EMPLOYEE;
-- �� ��ȸ ����� ��ġ �����ϴ� ���̺��� �� ���� ����� �� ����!! �װ� �ٷ� �ζ��κ�!

SELECT EMP_NO, EMP_NAME, ����, DEPT_CODE  -- ,MANAGER_ID �Ұ�. ���� ������ ���̺� ���� ����
FROM (SELECT EMP_NO, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0))*12 AS "����", DEPT_CODE
FROM EMPLOYEE)  -- 1
WHERE ���� >= 30000000;   -- 2 (��Ī�� ����!!)

-- >> �ζ��� �並 �ַ� ����ϴ� ��  =>  TOP-N �м� (���� ��� �����ְ� ���� �� : BEST ��ǰ!)

-- �� ���� �� �޿��� ���� ���� ���� 5�� ��ȸ

-- * ROWNUM : ����Ŭ���� �������ִ� �÷�, ��ȸ�� ������� 1���� ������ �ο����ִ� �÷�

SELECT ROWNUM, EMP_NAME, SALARY --2
FROM EMPLOYEE   --1
ORDER BY SALARY DESC;   --3
-- FROM -> SELECT ROWNUM (�̶� ������ �ο���. ���ĵ� �ϱ����� �̹� ���� �ο�)
--> ���� �� �̻���.. => ������� ����!

SELECT ROWNUM, EMP_NAME, SALARY --2
FROM EMPLOYEE   --1
WHERE ROWNUM <= 5   --3
ORDER BY SALARY DESC;   --4
--> �������� ����� ��ȸ���� ����!! (SALARY �� ������ �Ǳ⵵ ���� 5���� �߷������� ����)

-- ORDER BY ���� �� ����� ����� ������, ROWNUM �ο� ��, 5�� �߷�����
SELECT EMP_NAME, SALARY, DEPT_CODE  --2
FROM EMPLOYEE   --1
ORDER BY SALARY DESC; -- 3 ���ĳ�

-- �� ���ĳ����� ����ͼ� ROWNUM ���� �ο�
SELECT ROWNUM, EMP_NAME, SALARY     --3
FROM (SELECT EMP_NAME, SALARY, DEPT_CODE
        FROM EMPLOYEE
        ORDER BY SALARY DESC)   --1
WHERE ROWNUM <= 5;  --2

-- ROWNUM �̶� ��ü�÷� ��ȸ�ϰ� ���� => ����!!
SELECT ROWNUM, * --EMP_NAME, SALARY     --3
FROM (SELECT * --EMP_NAME, SALARY, DEPT_CODE
        FROM EMPLOYEE
        ORDER BY SALARY DESC)   --1
WHERE ROWNUM <= 5;

--> ��Ī �ο��ϴ� �������
SELECT ROWNUM, E.* --EMP_NAME, SALARY     --3
FROM (SELECT * --EMP_NAME, SALARY, DEPT_CODE
        FROM EMPLOYEE
        ORDER BY SALARY DESC) E  --1
WHERE ROWNUM <= 5;

-------------------------------
-- 1. ���� �ֱٿ� �Ի��� ��� 5�� ��ȸ (�����, �޿�, �Ի���)
SELECT * --EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;     --���ĳ�

--> ROWNUM
SELECT *    --ROWNUM, EMP_NAME, SALARY, HIRE_DATE
FROM (SELECT EMP_NAME, SALARY, HIRE_DATE
        FROM EMPLOYEE
        ORDER BY HIRE_DATE DESC)
WHERE ROWNUM <= 5;
--> RANK() OVER (���ı���)
SELECT *   --EMP_NAME, SALARY, HIRE_DATE, ����
FROM (SELECT EMP_NAME, SALARY, HIRE_DATE, RANK() OVER(ORDER BY HIRE_DATE DESC) AS "����"
        FROM EMPLOYEE)
WHERE ���� <= 5;

-- 2. �� �μ��� ��ձ޿��� ���� ���� 3���� �μ� ��ȸ (�μ��ڵ�, ��ձ޿�)
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY AVG(SALARY) DESC;   --���ĳ�

SELECT ROWNUM, E.*
FROM (SELECT DEPT_CODE, FLOOR(AVG(SALARY))
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY AVG(SALARY) DESC) E
WHERE ROWNUM <= 3;

SELECT ROWNUM, DEPT_CODE, FLOOR(AVG(SALARY)     -- ��� �� �ȵ�? �׷����� �������� �����ϱ� �׷��Լ��� �� �� ����..
FROM (SELECT DEPT_CODE, FLOOR(AVG(SALARY))
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY AVG(SALARY) DESC) 
WHERE ROWNUM <= 3;


-- ��Ī�༭�� �غ���
SELECT ROWNUM, FLOOR(��ձ޿�)
FROM (SELECT DEPT_CODE, AVG(SALARY) AS "��ձ޿�"
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY AVG(SALARY) DESC)
WHERE ROWNUM <= 3;

----------------------------------------------------------------------------------
/*
    * ���� �ű�� �Լ� ( WINDOW FUNCTION )
      RANK() OVER(���ı���)               |               DENSE_RANK() OVER(���ı���)
    
    - RANK() OVER(���ı���) : ������ ���� ������ ����� ������ �ο��� ��ŭ �ǳʶٰ� ���� ���
                             EX) ���� 1���� 2�� �� ���� ������ 3��                                   => ����1��, ����1��, 3�� (1,1,3)
    - DENSE_RANK() OVER(���ı���) : ������ ������ �ִٰ� �ص� �� ���� ����� ������ 1�� ������Ŵ
                                   EX) ����1���� 2���̴��� �� ���� ������ 2��                       => ����1��, ����1��, 2�� (1,1,2)
    >> �� �Լ��� ������ SELECT�������� ��� ����!!
*/

-- �޿��� ���� ����� ������ �Űܼ� ��ȸ
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;
-- ���� 19�� 2�� �� ���� ������ 21 => ������ ������ ��ȸ�� �� ���� ����

SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;
-- ���� 19�� 2�� �� ���� ������ 20 => ������ ������ ��ȸ�� �� ���� �ٸ�


-- ���� 5�� ��ȸ
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;
--WHERE ���� <= 5; --2 .�Ұ��� ��Ī���Ұ���
--WHERE RANK() OVER(ORDER BY SALARY DESC) <= 5; -- RANK�� SELECT�������� ��� ����

-- �ᱹ, �ζ��κ並 �� �� �ۿ� ����!
SELECT *
FROM (SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) AS "����"
        FROM EMPLOYEE)
WHERE ���� <= 5;
