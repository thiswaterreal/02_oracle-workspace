----KH_��������
--1. JOB ���̺��� ��� ���� ��ȸ
SELECT *
FROM JOB;

--2. JOB ���̺��� ���� �̸� ��ȸ
SELECT JOB_NAME
FROM JOB;

--3. DEPARTMENT ���̺��� ��� ���� ��ȸ
SELECT *
FROM DEPARTMENT;

--4. EMPLOYEE���̺��� ������, �̸���, ��ȭ��ȣ, ����� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

--5. EMPLOYEE���̺��� �����, ��� �̸�, ���� ��ȸ
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

--6. EMPLOYEE���̺��� �̸�, ����, �Ѽ��ɾ�(���ʽ�����), �Ǽ��ɾ�(�Ѽ��ɾ� - (����*���� 3%)) ��ȸ
SELECT EMP_NAME, SALARY * 12 AS "����", (SALARY + SALARY*NVL(BONUS,0))*12 AS "�Ѽ��ɾ�", ((SALARY + SALARY*NVL(BONUS,0))*12 -  SALARY * 12*0.03) AS "�Ǽ��ɾ�"
FROM EMPLOYEE;

--7. EMPLOYEE���̺��� SAL_LEVEL�� S1�� ����� �̸�, ����, �����, ����ó ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE, PHONE
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

--8. EMPLOYEE���̺��� �Ǽ��ɾ�(6�� ����)�� 5õ���� �̻��� ����� �̸�, ����, �Ǽ��ɾ�, ����� ��ȸ
SELECT EMP_NAME, SALARY, ((SALARY + SALARY*NVL(BONUS,0))*12 -  SALARY * 12*0.03) AS "�Ǽ��ɾ�", HIRE_DATE
FROM EMPLOYEE
WHERE ((SALARY + SALARY*NVL(BONUS,0))*12 -  SALARY * 12*0.03) >= 50000000;

--9. EMPLOYEE���̺� ������ 4000000�̻��̰� JOB_CODE�� J2�� ����� ��ü ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';

--10. EMPLOYEE���̺� DEPT_CODE�� D9�̰ų� D5�� ��� ��
--������� 02�� 1�� 1�Ϻ��� ���� ����� �̸�, �μ��ڵ�, ����� ��ȸ
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE IN('D9','D5')
AND HIRE_DATE<'020101';

--11. EMPLOYEE���̺� ������� 90/01/01 ~ 01/01/01�� ����� ��ü ������ ��ȸ
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '900101' AND '010101';

--12. EMPLOYEE���̺��� �̸� ���� '��'���� ������ ����� �̸� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

--13. EMPLOYEE���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ�� ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE SUBSTR(PHONE, 1,3) <> '010';

--14. EMPLOYEE���̺��� �����ּ� '_'�� ���� 4���̸鼭 DEPT_CODE�� D9 �Ǵ� D6�̰�
--������� 90/01/01 ~ 00/12/01�̰�, �޿��� 270�� �̻��� ����� ��ü�� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE LENGTH(SUBSTR(EMAIL,1,INSTR(EMAIL,'_')-1)) = 4
AND DEPT_CODE IN ('D9','D6')
AND HIRE_DATE BETWEEN '900101' AND '001201'
AND SALARY >= 2700000;

--15. EMPLOYEE���̺��� ��� ��� ������ �ֹι�ȣ�� �̿��Ͽ� ����, ����, ���� ��ȸ
SELECT EMP_NAME, EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,6),'RRMMDD')) AS "����",
EXTRACT(MONTH FROM TO_DATE(SUBSTR(EMP_NO,1,6),'RRMMDD')) AS "����",
EXTRACT(DAY FROM TO_DATE(SUBSTR(EMP_NO,1,6),'RRMMDD')) AS "����"
FROM EMPLOYEE;

SELECT EMP_NAME, '19'||SUBSTR(EMP_NO,1,2) AS "����", SUBSTR(EMP_NO,3,2) AS "����",
SUBSTR(EMP_NO,5,2) AS "����"
FROM EMPLOYEE;

--16. EMPLOYEE���̺��� �����, �ֹι�ȣ ��ȸ (��, �ֹι�ȣ�� ������ϸ� ���̰� �ϰ�, '-'���� ���� '*'�� �ٲٱ�)
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,7),14,'*') AS "�ֹι�ȣ"
FROM EMPLOYEE;

--17. EMPLOYEE���̺��� �����, �Ի���-����, ����-�Ի��� ��ȸ
--(��, �� ��Ī�� �ٹ��ϼ�1, �ٹ��ϼ�2�� �ǵ��� �ϰ� ��� ����(����), ����� �ǵ��� ó��)
SELECT EMP_NAME, ABS(FLOOR(HIRE_DATE - SYSDATE)) AS "�ٹ��ϼ�1", FLOOR(SYSDATE - HIRE_DATE) AS "�ٹ��ϼ�2"
FROM EMPLOYEE;

--18. EMPLOYEE���̺��� ����� Ȧ���� �������� ���� ��� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID,2) = '1';

--19. EMPLOYEE���̺��� �ٹ� ����� 20�� �̻��� ���� ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) >=20;

--20. EMPLOYEE ���̺��� �����, �޿� ��ȸ (��, �޿��� '\9,000,000' �������� ǥ��)
SELECT EMP_NAME, TO_CHAR(SALARY,'L9,999,999') AS "�޿�"
FROM EMPLOYEE;

--21. EMPLOYEE���̺��� ���� ��, �μ��ڵ�, �������, ����(��) ��ȸ
--(��, ��������� �ֹι�ȣ���� �����ؼ� 00�� 00�� 00�Ϸ� ��µǰ� �ϸ�
--���̴� �ֹι�ȣ���� ����ؼ� ��¥�����ͷ� ��ȯ�� ���� ���)

SELECT EMP_NAME, DEPT_CODE, TO_CHAR(TO_DATE(SUBSTR(EMP_NO,1,6)),'YY"��" MM"��" DD"��"') AS "�������",
EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,6),'RRMMDD')) AS "����(��)"
FROM EMPLOYEE;

--22. EMPLOYEE���̺��� �μ��ڵ尡 D5, D6, D9�� ����� ��ȸ�ϵ� D5�� �ѹ���, D6�� ��ȹ��, D9�� �����η� ó��
--(��, �μ��ڵ� ������������ ����)
SELECT DECODE(DEPT_CODE,'D5','�ѹ���','D6','��ȹ��','D9','������')
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D9');
--
--23. EMPLOYEE���̺��� ����� 201���� �����, �ֹι�ȣ ���ڸ�, �ֹι�ȣ ���ڸ�,
--�ֹι�ȣ ���ڸ��� ���ڸ��� �� ��ȸ
SELECT EMP_NAME, SUBSTR(EMP_NO,1,6) AS "�ֹι�ȣ ���ڸ�", SUBSTR(EMP_NO, 8,7) AS "�ֹι�ȣ ���ڸ�", SUBSTR(EMP_NO,1,6)+ SUBSTR(EMP_NO, 8,7) AS "�ֹι�ȣ ��"
FROM EMPLOYEE
WHERE EMP_ID = '201';

--24. EMPLOYEE���̺��� �μ��ڵ尡 D5�� ������ ���ʽ� ���� ���� �� ��ȸ
SELECT SUM((SALARY + SALARY*NVL(BONUS,0))*12) AS "���ʽ� ���� ���� ��"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--25. EMPLOYEE���̺��� �������� �Ի��Ϸκ��� �⵵�� ������ �� �⵵�� �Ի� �ο��� ��ȸ
--��ü ���� ��, 2001��, 2002��, 2003��, 2004��
SELECT COUNT(*) AS "��ü ������"
, COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE),'2001','*')) AS "2001��",
COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE),'2002','*')) AS "2002��",
COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE),'2003','*')) AS "2003��",
COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE),'2004','*')) AS "2004��"
FROM EMPLOYEE;
