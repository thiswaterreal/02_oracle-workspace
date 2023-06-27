-- �ϴ� ~19������ Ǯ��
-- <��ü��ȸ>
SELECT * FROM TB_CLASS; 
SELECT * FROM TB_CLASS_PROFESSOR;
SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_STUDENT;

-- 1.
SELECT DEPARTMENT_NAME AS "�а� ��", CATEGORY AS "�迭"
FROM TB_DEPARTMENT;

-- 2.
SELECT DEPARTMENT_NAME || '���� ������ ' || CAPACITY || ' �� �Դϴ�.'
FROM TB_DEPARTMENT;

-- 3.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001' AND SUBSTR(STUDENT_SSN, 8, 1) IN ('2', '4')
      AND ABSENCE_YN = 'Y'; 

-- 4.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
ORDER BY 1 DESC;

-- 5.
SELECT DEPARTMENT_NAME, CATEGORY, CAPACITY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

-- 6.
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- 7.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-- 8.
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 9.
SELECT DISTINCT(CATEGORY)
FROM TB_DEPARTMENT;

-- 10.
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE SUBSTR(ENTRANCE_DATE, 1, 2) = '02' AND STUDENT_ADDRESS LIKE '%����%' AND ABSENCE_YN = 'N';

/*
    1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ����
������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.( ��, ����� "�й�", "�̸�", "���г⵵" ��
ǥ�õǵ��� ����.)
*/
SELECT STUDENT_NO, STUDENT_NAME, ENTRANCE_DATE
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY 2;

/*
    2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� ����. �� ������
�̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. (* �̶� �ùٸ��� �ۼ��� SQL 
������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)
*/
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

/*
    3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��
�̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. (��, ���� ��
2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� ����. ���̴� ����������
�������.)
*/
SELECT PROFESSOR_NAME AS "�����̸�", 
       FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('19' || SUBSTR(PROFESSOR_SSN, 1, 6), 'YYYYMMDD'))/12) AS "������"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) IN ('1', '3')
ORDER BY 2;

/*
    4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��� �����
?�̸�? �� �������� ����. (���� 2 ���� ���� ������ ���ٰ� �����Ͻÿ�)
*/
SELECT LTRIM(PROFESSOR_NAME, SUBSTR(PROFESSOR_NAME,1,1)) AS "�̸�"
FROM TB_PROFESSOR;

/*
    5. �� ������б��� ����� �����ڸ� ���Ϸ��� �Ѵ�. ��� ã�Ƴ� ���ΰ�?
�̶�, 19 �쿡 �����ϸ� ����� ���� ���� ������ �����Ѵ�.
-- ���г⵵ - ���� �¾ �⵵
-- 2010 - 1990 = 20��,,
*/
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6))) > 19;

/*
    6. 2020 �� ũ���������� ���� �����ΰ�?
*/
SELECT TO_CHAR(TO_DATE(20201225), 'DAY')
FROM DUAL;

/*
    7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') �� ���� �� �� ��
�� �� ���� �ǹ�����? �� TO_DATE('99/10/11','RR/MM/DD'), 
TO_DATE('49/10/11','RR/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ�����?
*/
SELECT EXTRACT(YEAR FROM TO_DATE('990630', 'YYMMDD')) AS "�⵵",
       EXTRACT(MONTH FROM TO_DATE('990630', 'YYMMDD')) AS "��",
       EXTRACT(DAY FROM TO_DATE('990630', 'YYMMDD')) AS "��"
FROM DUAL;
SELECT EXTRACT(YEAR FROM TO_DATE('490630', 'YYMMDD')) AS "�⵵",
       EXTRACT(MONTH FROM TO_DATE('490630', 'YYMMDD')) AS "��",
       EXTRACT(DAY FROM TO_DATE('490630', 'YYMMDD')) AS "��"
FROM DUAL;
SELECT EXTRACT(YEAR FROM TO_DATE('990630', 'RRMMDD')) AS "�⵵",
       EXTRACT(MONTH FROM TO_DATE('990630', 'RRMMDD')) AS "��",
       EXTRACT(DAY FROM TO_DATE('990630', 'RRMMDD')) AS "��"
FROM DUAL;
SELECT EXTRACT(YEAR FROM TO_DATE('490630', 'RRMMDD')) AS "�⵵",
       EXTRACT(MONTH FROM TO_DATE('490630', 'RRMMDD')) AS "��",
       EXTRACT(DAY FROM TO_DATE('490630', 'RRMMDD')) AS "��"
FROM DUAL;

/*
    8. �� ������б��� 2000 �⵵ ���� �����ڵ��� �й��� A �� �����ϰ� �Ǿ��ִ�. 2000 �⵵
���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

/*
    9. �й��� A517178 �� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��,
�̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� ��
�ڸ������� ǥ���Ѵ�.
*/
SELECT ROUND(AVG(POINT), 1) AS "����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

/*
    10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� �������
��µǵ��� �Ͻÿ�.
*/
SELECT DEPARTMENT_NO AS "�а���ȣ", COUNT(*) AS "�л���(��)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

/*
    11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL ���� �ۼ��Ͻÿ�.
*/
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

/*
     12. �й��� A112113 �� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
��, �̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ�
�Ҽ��� ���� �� �ڸ������� ǥ������.
*/
--ROUND(AVG(POINT), 1) AS "����"

SELECT SUBSTR(TERM_NO, 1, 4) AS "�⵵", ROUND(AVG(POINT),1) AS "�⵵ �� ����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 1;

/*
    13. �а� �� ���л� ���� �ľ��ϰ��� ����. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������
�ۼ��Ͻÿ�.
*/
--SELECT DEPARTMENT_NO, COUNT(DECODE(ABSENCE_YN, 'Y', 1)) 
SELECT DEPARTMENT_NO AS "�а��ڵ��", NVL(SUM(DECODE(ABSENCE_YN, 'Y', 1)), 0) AS "���л� ��"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

/*
    14. �� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� ����. � SQL 
������ ����ϸ� �����ϰڴ°�?
*/
SELECT STUDENT_NAME AS "�����̸�", COUNT(*) AS "������ ��"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1;

/*
    15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ���� , 
�� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ�
ǥ������.)
*/
SELECT SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2), ROUND(AVG(POINT), 1)
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY TERM_NO
ORDER BY 1;

SELECT *
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
ORDER BY 1;

/*
    1. �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�,
������ �̸����� �������� ǥ���ϵ��� ����.
*/
SELECT STUDENT_NAME AS "�л� �̸�", STUDENT_ADDRESS AS "�ּ���"
FROM TB_STUDENT
ORDER BY 1;

/*
2. �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.
*/
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY 2 DESC;

/*
3. �ּ����� �������� ��⵵�� �л��� �� 1900 ��� �й��� ���� �л����� �̸��� �й�, 
�ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�. ��, ���������� "�л��̸�","�й�",
"������ �ּ�" �� ��µǵ��� ����.
*/
SELECT STUDENT_NAME AS "�л��̸�", STUDENT_NO AS "�й�", STUDENT_ADDRESS AS "������ �ּ�"
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '%����%' OR STUDENT_ADDRESS LIKE '%���%') AND SUBSTR(STUDENT_NO, 1, 1) = '9';

/*
4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������
�ۼ��Ͻÿ�. (���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã��
������ ����)
*/
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = '005'
ORDER BY 2;

/*
5. 2004 �� 2 �б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� ����. ������
���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������
�ۼ��غ��ÿ�.
*/
SELECT STUDENT_NO, POINT
FROM TB_GRADE
WHERE TERM_NO = '200402' AND CLASS_NO = 'C3118100';

/*
6. �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL 
���� �ۼ��Ͻÿ�.
*/

-- ��ü��ȸ
SELECT *
FROM TB_GRADE;
