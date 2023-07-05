-- �ϴ� P.21 ���� Ǯ��
-- ���� �ϳ��� �����Ͽ� Ŭ�����뿡 ����
-- DDL (2,3��)
-- (+) SQL 200�� (76����)

/* -- <��ü��ȸ>
SELECT * FROM TB_CLASS; 
SELECT * FROM TB_CLASS_PROFESSOR;
SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_STUDENT;
*/

--=================================[ Basic SELECT ]=======================================
/*
1. �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. ��, ��� ����� "�а� ��", "�迭" ���� ǥ���ϵ��� ����.
*/
SELECT DEPARTMENT_NAME AS "�а� ��", CATEGORY AS "�迭"
FROM TB_DEPARTMENT;

/*
2. �а��� �а� ������ ������ ���� ���·� ȭ�鿡 �������.
*/
SELECT DEPARTMENT_NAME || '���� ������ ' || CAPACITY || ' �� �Դϴ�.'
FROM TB_DEPARTMENT;

/*
3. "������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û��
���Դ�. �����ΰ�? (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ�
ã�� ������ ����)
*/
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001' 
AND SUBSTR(STUDENT_SSN, 8, 1) IN ('2', '4')
AND ABSENCE_YN = 'Y'; 

/*
4. ���������� ���� ���� ��� ��ü�� ���� ã�� �̸��� �Խ��ϰ��� ����. �� ����ڵ���
�й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�.
*/
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
ORDER BY 1 DESC;

/*
5. ���������� 20 �� �̻� 30 �� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.
*/
SELECT DEPARTMENT_NAME, CATEGORY, CAPACITY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

/*
6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�. �׷� ��
������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

/*
7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� ����. 
��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.
*/
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

/*
8. ������û�� �Ϸ��� ����. �������� ���θ� Ȯ���ؾ� �ϴµ�, ���������� �����ϴ�
������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.
*/
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

/*
9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.
*/
SELECT DISTINCT(CATEGORY)
FROM TB_DEPARTMENT
ORDER BY 1;

/*
10. 02 �й� ���� �����ڵ��� ������ ������� ����. ������ ������� ������ ��������
�л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�.
*/
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE SUBSTR(ENTRANCE_DATE, 1, 2) = '02' 
AND STUDENT_ADDRESS LIKE '%����%' 
AND ABSENCE_YN = 'N';

--=================================[ Additional SELECT - �Լ� ]=======================================
/*
1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ����
������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.( ��, ����� "�й�", "�̸�", "���г⵵" ��
ǥ�õǵ��� ����.)
*/
SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�̸�", TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') AS "���г⵵"
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

-- �� �ٸ� ���
SELECT PROFESSOR_NAME, PROFESSOR_SSN FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) != 3;

/*
3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��
�̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. (��, ���� ��
2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� ����. ���̴� ����������
�������.)
*/ --����ö : 42�� ����
SELECT PROFESSOR_NAME AS "�����̸�", 
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE('19' || SUBSTR(PROFESSOR_SSN, 1, 6))) AS "(��)����"
       --FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('19' || SUBSTR(PROFESSOR_SSN, 1, 6), 'YYYYMMDD'))/12) AS "(��)����"   <- �̰ɷ� �ϸ� ����/12�� ���̰� �ָ��ϰ� ������
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) IN ('1', '3')
ORDER BY 2;

/*
4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��� �����
?�̸�? �� �������� ����. (���� 2 ���� ���� ������ ���ٰ� �����Ͻÿ�)
*/
SELECT LTRIM(PROFESSOR_NAME, SUBSTR(PROFESSOR_NAME,1,1)) AS "�̸�"
FROM TB_PROFESSOR;

-- �� �ٸ� ���
SELECT SUBSTR(PROFESSOR_NAME,2,LENGTH(PROFESSOR_NAME)-1) AS "�̸� "
FROM TB_PROFESSOR;

/*
5. �� ������б��� ����� �����ڸ� ���Ϸ��� �Ѵ�. ��� ã�Ƴ� ���ΰ�?
�̶�, 19 �쿡 �����ϸ� ����� ���� ���� ������ �����Ѵ�.
-- ���г⵵ - ���� �¾ �⵵
-- 2014 - 1995 = 19��
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
--WHERE SUBSTR(STUDENT_NO,1,1) != 'A';   :(�� �ٸ� ���)
/*
9. �й��� A517178 �� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��,
�̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� ��
�ڸ������� ǥ���Ѵ�.
*/
SELECT ROUND(AVG(POINT), 1) AS "����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

/*
10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� ������� ��µǵ��� �Ͻÿ�.
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
--ROUND(AVG(POINT), 1) AS "����(�������)"

SELECT SUBSTR(TERM_NO, 1, 4) AS "�⵵", ROUND(AVG(POINT),1) AS "�⵵ �� ����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 1;

/*
13. �а� �� ���л� ���� �ľ��ϰ��� ����. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������
�ۼ��Ͻÿ�.
*/
--SELECT DEPARTMENT_NO, COUNT(DECODE(ABSENCE_YN, 'Y', '*'))   :(�� �ٸ� ���)
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
HAVING COUNT(*) >= 2;

/*
15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ���� , 
�� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ�
ǥ������.) (HINT : ROLLUP)
*/
SELECT NVL(SUBSTR(TERM_NO, 1, 4), ' ') AS "�⵵", NVL(SUBSTR(TERM_NO, 5, 2), ' ') AS "�б�", ROUND(AVG(POINT), 1) AS "����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP (SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2));     -- GROUP BY ROLLUP : GROUP BY�� ���� ������ �ұ׷� �հ�, ��ü �հ踦 ��� ����

--=================================[ Additional SELECT - Option ]=======================================
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
���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������ �ۼ��غ��ÿ�.
*/
SELECT STUDENT_NO, TO_CHAR(POINT, '9.99') AS "POINT"                 --** ���ϴ� �Ҽ������� ����ϱ�
FROM TB_GRADE
WHERE TERM_NO = '200402' AND CLASS_NO = 'C3118100'
ORDER BY 2 DESC, 1 ASC;

/*
6. �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
*/    -- ����� (DEPARTMENT_NO, DEPARTMENT_NO)
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
ORDER BY 2;

/*
7. �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO);

/*
8. ���� ���� �̸��� ã������ ����. ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�. -------******
*/
--> ANSI
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS 
JOIN TB_CLASS_PROFESSOR  USING (CLASS_NO)
JOIN TB_PROFESSOR C USING (PROFESSOR_NO)
ORDER BY C.DEPARTMENT_NO, PROFESSOR_SSN, CLASS_TYPE DESC, CLASS_NO;     --**���Ĺ��ƴ�
--> ����Ŭ
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR A, TB_PROFESSOR P
WHERE C.CLASS_NO = A.CLASS_NO
AND A.PROFESSOR_NO = P.PROFESSOR_NO;

-- (8,9)��ü��ȸ
SELECT *
FROM TB_CLASS;  --CLASS_NAME           CLASS_NO                   (DEPARTMENT_NO)
SELECT * 
FROM TB_CLASS_PROFESSOR; --            CLASS_NO    PROFESSOR_NO
SELECT *
FROM TB_PROFESSOR; --PROFESSOR_NAME                PROFESSOR_NO    DEPARTMENT_NO
SELECT *
FROM TB_DEPARTMENT; --CATEGORY                                     DEPARTMENT_NO

/*
9. 8 ���� ��� �� ���ι���ȸ�� �迭�� ���� ������ ���� �̸��� ã������ ����. �̿�
�ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
*/
--> ANSI
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING (CLASS_NO)
JOIN TB_PROFESSOR C USING (PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON (C.DEPARTMENT_NO = D.DEPARTMENT_NO)         -- **������ 3���̺� ��� DEPARTMENT_NO ���� �ֱ� ������ ������ ����!!
WHERE CATEGORY = '�ι���ȸ'
ORDER BY C.DEPARTMENT_NO, PROFESSOR_SSN, CLASS_TYPE DESC, CLASS_NO; --** ��ģ����
--> ����Ŭ
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR A, TB_PROFESSOR P, TB_DEPARTMENT D
WHERE C.CLASS_NO = A.CLASS_NO
AND A.PROFESSOR_NO = P.PROFESSOR_NO
AND P.DEPARTMENT_NO = D.DEPARTMENT_NO
AND CATEGORY = '�ι���ȸ';


/*
10. �������а��� �л����� ������ ���Ϸ��� ����. �����а� �л����� "�й�", "�л� �̸�", 
"��ü ����"�� ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ�������
�ݿø��Ͽ� ǥ������.)
*/

-- TB_GRADE;      -- STUDENT_NO
-- TB_STUDENT;    -- STUDENT_NO, DEPARTMENT_NO
-- TB_DEPARTMENT; --             DEPARTMENT_NO

--> ����Ŭ
SELECT G.STUDENT_NO AS "�й�", S.STUDENT_NAME AS "�л� �̸�", ROUND(AVG(POINT),1) AS "��ü ����"
FROM TB_GRADE G, TB_STUDENT S, TB_DEPARTMENT D
WHERE (G.STUDENT_NO = S.STUDENT_NO)
AND (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
AND DEPARTMENT_NAME = '�����а�'
GROUP BY G.STUDENT_NO, S.STUDENT_NAME
ORDER BY 1;

/*
11. �й��� A313047 �� �л��� �б��� ������ ���� �ʴ�. ���� �������� ������ �����ϱ�
���� �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�. �̶� ����� SQL ����
�ۼ��Ͻÿ�. ��, �������� ?�а��̸�?, ?�л��̸�?, ?���������̸�?����
��µǵ��� ����.
*/

-- TB_DEPARTMENT; --DEPARTMENT_NAME   DEPARTMENT_NO
-- TB_STUDENT;    -- STUDENT_NAME     DEPARTMENT_NO       COACH_PROFESSOR_NO
-- TB_PROFESSOR;  -- PROFESSOR_NAME                       PROFESSOR_NO

--> ANSI
SELECT DEPARTMENT_NAME AS "�а��̸�", STUDENT_NAME AS "�л��̸�", PROFESSOR_NAME AS "���������̸�"
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';

/*
12. 2007 �⵵�� '�΁A�����' ������ ������ �л��� ã�� �л��̸��� �����б⸧ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
*/

-- TB_CLASS;   -- CLASS_NAME(�ΰ������)     CLASS_NO
-- TB_GRADE;   -- TERM_NO                   CLASS_NO      STUDENT_NO
-- TB_STUDENT; -- STUDENT_NAME                            STUDENT_NO

SELECT STUDENT_NAME, TERM_NO
FROM TB_GRADE
JOIN TB_CLASS USING (CLASS_NO)
JOIN TB_STUDENT USING (STUDENT_NO)
WHERE SUBSTR(TERM_NO, 1, 4) = '2007' AND CLASS_NAME = '�ΰ������'
ORDER BY 1;

/*
13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� �� ����     -- **���!!**
�̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
*/

-- TB_CLASS             --CLASS_NAME         CLASS_NO     DEPARTMENT_NO
-- TB_CLASS_PROFESSOR   --PROFESSOR_NO       CLASS_NO
-- TB_DEPARTMENT        --DEPARTMENT_NAME                 DEPARTMENT_NO

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
LEFT JOIN TB_CLASS_PROFESSOR USING (CLASS_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE CATEGORY = '��ü��' AND PROFESSOR_NO IS NULL;

SELECT CLASS_NAME, PROFESSOR_NO
FROM TB_CLASS
LEFT JOIN TB_CLASS_PROFESSOR USING (CLASS_NO);

/*
14. �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� ����. �л��̸���
�������� �̸��� ã�� ���� ���� ������ ���� �л��� ��� "�������� ������?����
ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�. ��, �������� ?�л��̸�?, ?��������?��
ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� ����.
*/

--TB_STUDENT;    --STUDENT_NAME              COACH_PROFESSOR_NO    (DEPARTMENT_NO)    
--TB_PROFESSOR;  --PROFESSOR_NAME            PROFESSOR_NO           DEPARTMENT_NO     
--TB_DEPARTMENT; --DEPARTMENT_NAME(����)                            DEPARTMENT_NO

SELECT STUDENT_NAME AS "�л��̸�", NVL(PROFESSOR_NAME, '�������� ������') AS "��������"
FROM TB_STUDENT S
LEFT JOIN TB_PROFESSOR P ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)           --** NULL ������ �������� TB_PROFESSOR�� LEFT �����!!
WHERE DEPARTMENT_NAME = '���ݾƾ��а�'                                  --** DEPARTMENT_NO 3��!! / �����̶� �����ؾ���!! (S. = D.)
ORDER BY STUDENT_NO;

SELECT STUDENT_NAME AS "�л��̸�", NVL(PROFESSOR_NAME, '�������� ������') AS "��������"
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D USING (DEPARTMENT_NO)                             --** DEPARTMENT_NO 2���� �ν�!!
LEFT JOIN TB_PROFESSOR P ON (COACH_PROFESSOR_NO = PROFESSOR_NO)        --** ���⼭�� ������ TB_STUDENT �� TB_DEPARTMENT ������ �־.. 2���� �ν��ϹǷ� �ָ��� �� ����!! (�����ʿ� X)
WHERE DEPARTMENT_NAME = '���ݾƾ��а�'
ORDER BY STUDENT_NO;

/*
15. ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� �� �л��� �й�, �̸�, �а�
�̸�, ������ ����ϴ� SQL ���� �ۼ��Ͻÿ�.
*/
--TB_STUDENT        DEPARTMENT_NO   STUDENT_NO
--TB_DEPARTMENT     DEPARTMENT_NO
--TB_GRADE                          STUDENT_NO

SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�̸�", DEPARTMENT_NAME AS "�а� �̸�", ROUND(AVG(POINT), 8) AS "����"           --** AVG(POINT) �׷��Լ��θ� ���� ���� ��..
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (STUDENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING ROUND(AVG(POINT), 8) >= 4.0
ORDER BY STUDENT_NO;

/*
16. �Q�������а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.
*/
--TB_CLASS          CLASS_NO    DEPARTMENT_NO
--TB_GRADE          CLASS_NO 
--TB_DEPARTMENT                 DEPARTMENT_NO
SELECT CLASS_NO, CLASS_NAME, ROUND(AVG(POINT), 8)
FROM TB_CLASS
JOIN TB_GRADE USING (CLASS_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = 'ȯ�������а�' 
AND CLASS_TYPE = '��������'
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY 1;

SELECT *
FROM TB_CLASS;

-- ���� 1)
SELECT CLASS_NO, CLASS_NAME
FROM TB_CLASS
JOIN TB_GRADE USING (CLASS_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = 'ȯ�������а�' 
AND CLASS_TYPE = '��������';
-- ���� 2)
SELECT CLASS_NO, CLASS_NAME
FROM TB_CLASS
JOIN TB_GRADE USING (CLASS_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = 'ȯ�������а�' 
AND CLASS_TYPE = '��������'
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY 1;

/*
17. �� ������б��� �ٴϰ� �ִ� '�ְ���' �л��� ���� �� �л����� �̸��� �ּҸ� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
*/
--�ְ��� ������? => DEPARTMENT_NO??
SELECT DEPARTMENT_NO
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE STUDENT_NAME = '�ְ���';             -- ���½ý��۰��а� => 038
--���½ý��۰��а� �ٴϴ� �л��̸�, �ּ�
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                            FROM TB_STUDENT
                            JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
                            WHERE STUDENT_NAME = '�ְ���');

/*
18. ������а����� �� ������ ���� ���� �л��� �̸��� �й��� ǥ���ϴ� SQL ���� �ۼ��Ͻÿ�.
*/
-- ������а� �а���ȣ
SELECT DEPARTMENT_NO
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME = '������а�'; --001

SELECT STUDENT_NO, STUDENT_NAME -- ,ROWNUM
FROM(SELECT STUDENT_NO, STUDENT_NAME, AVG(POINT)
        FROM TB_STUDENT
        JOIN TB_GRADE USING (STUDENT_NO)
        WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                FROM TB_DEPARTMENT
                                WHERE DEPARTMENT_NAME = '������а�')
        GROUP BY STUDENT_NO, STUDENT_NAME
        ORDER BY 3 DESC)
WHERE ROWNUM = 1;

/*
19. �� ������б��� "�Q�������а�"�� ���� ���� �迭 �а����� �а� �� �������� ������
�ľ��ϱ� ���� ������ SQL ���� ã�Ƴ��ÿ�. ��, �������� "�迭 �а���", 
"��������"���� ǥ�õǵ��� �ϰ�, ������ �Ҽ��� �� �ڸ������� �ݿø��Ͽ� ǥ�õǵ���
����.
*/
SELECT CATEGORY
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME = 'ȯ�������а�'; --�ڿ�����

SELECT DEPARTMENT_NAME AS "�迭 �а���", ROUND(AVG(POINT),1) AS "��������"
FROM TB_CLASS
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (CLASS_NO)
WHERE CATEGORY = (SELECT CATEGORY
                    FROM TB_DEPARTMENT
                    WHERE DEPARTMENT_NAME = 'ȯ�������а�') --�ڿ������� �а��� �Ҷ��~
GROUP BY DEPARTMENT_NAME
ORDER BY 1;

--======================================[ DDL ]=========================================
/*
1. �迭 ������ ������ ī�װ� ���̺��� ������� ����. ������ ���� ���̺��� �ۼ��Ͻÿ�.
---------------------------------------
���̺� �̸�
TB_CATEGORY
�÷�
NAME, VARCHAR2(10) 
USE_YN, CHAR(1), �⺻���� Y �� ������
*/
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);

DROP TABLE TB_CATEGORY;
SELECT * FROM TB_CATEGORY;


/*
2. ���� ������ ������ ���̺��� ������� ����. ������ ���� ���̺��� �ۼ��Ͻÿ�.
----------------------------
���̺��̸�
TB_CLASS_TYPE
�÷�
NO, VARCHAR2(5), PRIMARY KEY
NAME , VARCHAR2(10)
*/
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10) 
);

/*
3. TB_CATAGORY ���̺��� NAME �÷��� PRIMARY KEY �� �����Ͻÿ�.
(KEY �̸��� �������� �ʾƵ� ������. ���� KEY �̸� �����ϰ��� ���ٸ� �̸��� ������
�˾Ƽ� ������ �̸��� ����Ѵ�.) (ALTER ���!!)
*/
ALTER TABLE TB_CATEGORY ADD PRIMARY KEY (NAME);

/*
4. TB_CLASS_TYPE ���̺��� NAME �÷��� NULL ���� ���� �ʵ��� �Ӽ��� �����Ͻÿ�.
*/
ALTER TABLE TB_CLASS_TYPE MODIFY NAME NOT NULL;

/*
5. �� ���̺��� �÷� ���� NO �� ���� ���� Ÿ���� �����ϸ鼭 ũ��� 10 ����, 
�÷����� NAME �� ���� ���C������ ���� Ÿ���� �����ϸ鼭 ũ�� 20 ���� �����Ͻÿ�.
*/
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(20);
ALTER TABLE TB_CLASS_TYPE MODIFY NO VARCHAR2(10);
ALTER TABLE TB_CLASS_TYPE MODIFY NAME VARCHAR2(20);

/*
6. �� ���̺��� NO �÷��� NAME �÷��� �̸��� �� �� TB_ �� ������ ���̺� �̸��� �տ� ���� ���·� ��������.
(ex. CATEGORY_NAME)
*/
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CLASS_TYPE_NO;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NAME TO CLASS_TYPE_NAME;

/*
7. TB_CATEGORY ���̺�� TB_CLASS_TYPE ���̺��� PRIMARY KEY �̸��� ������ ���� �����Ͻÿ�.
Primary Key �� �̸��� 'PK_ + �÷��̸�'���� �����Ͻÿ�. (ex. PK_CATEGORY_NAME )
*/
ALTER TABLE TB_CATEGORY RENAME CONSTRAINT SYS_C007168 TO PK_CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME CONSTRAINT SYS_C007123 TO PK_CLASS_TYPE_NO;

/*
8. ������ ���� INSERT ���� �����Ѵ�.
*/
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����','Y');
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��','Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ','Y');
COMMIT; 

SELECT * FROM TB_CATEGORY;

/*
9.TB_DEPARTMENT �� CATEGORY �÷��� TB_CATEGORY ���̺��� CATEGORY_NAME �÷��� 
�θ� ������ �����ϵ��� FOREIGN KEY �� �����Ͻÿ�. �̶� KEY �̸���
'FK_���̺��̸�_�÷��̸�' ���� �����Ѵ�. (ex. FK_DEPARTMENT_CATEGORY )
*/
ALTER TABLE TB_DEPARTMENT 
    ADD CONSTRAINT FK_DEPARTMENT_CATEGORY FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY;

/*
10. �� ������б� �л����� �������� ���ԵǾ� �ִ� �л��Ϲ����� VIEW �� ������� ����. 
�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�.
(�� ���� : DROP VIEW ���;)
--------------------------------
�� �̸�
    VW_�л��Ϲ�����
�÷�
    �й�
    �л��̸�
    �ּ�
*/
SELECT * FROM TB_STUDENT;

CREATE OR REPLACE VIEW VW_�л��Ϲ�����
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
     FROM TB_STUDENT;
-- ORA-01031: insufficient privileges

-- ������ ������ �����ؼ� ���� �ο�
GRANT CREATE VIEW TO workbook;   -- �����ڰ���(������)����!!

SELECT * FROM VW_�л��Ϲ�����;

/*
11. �� ������б��� 1 �⿡ �� ���� �а����� �л��� ���������� ���� ����� �����Ѵ�. 
�̸� ���� ����� �л��̸�, �а��̸�, ��米���̸� ���� �����Ǿ� �ִ� VIEW �� ����ÿ�.
�̶� ���� ������ ���� �л��� ���� �� ������ ����Ͻÿ� (��, �� VIEW �� �ܼ� SELECT 
���� �� ��� �а����� ���ĵǾ� ȭ�鿡 �������� ����ÿ�.)
-----------------------------
�� �̸�
    VW_�������
�÷�
    �л��̸�
    �а��̸�
    ���������̸�
*/
SELECT * FROM TB_STUDENT;       -- DEPARTMENT_NO
SELECT * FROM TB_DEPARTMENT;    -- DEPARTMENT_NO
SELECT * FROM TB_PROFESSOR;     -- DEPARTMENT_NO

CREATE OR REPLACE VIEW VW_�������
AS SELECT STUDENT_NAME, DEPARTMENT_NAME, PROFESSOR_NAME
     FROM TB_STUDENT
     JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
     JOIN TB_PROFESSOR USING (DEPARTMENT_NO);

SELECT * FROM VW_�������;


/*
12. ��� �а��� �а��� �л� ���� Ȯ���� �� �ֵ��� ������ VIEW �� �ۼ��� ����.
------------------------
�� �̸�
    VW_�а����л���
�÷�
    DEPARTMENT_NAME
    STUDENT_COUNT
*/
SELECT * FROM TB_STUDENT;       -- DEPARTMENT_NO 
SELECT * FROM TB_DEPARTMENT;    -- DEPARTMENT_NO

CREATE OR REPLACE VIEW VW_�а����л���
AS SELECT DEPARTMENT_NAME, COUNT(*) AS "STUDENT_COUNT"
     FROM TB_STUDENT
     JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
     GROUP BY DEPARTMENT_NAME;

SELECT * FROM VW_�а����л���;

/*
13. ������ ������ �л��Ϲ����� View �� ���ؼ� �й��� A213046 �� �л��� �̸���
�����̸����� �����ϴ� SQL ���� �ۼ��Ͻÿ�.
*/
UPDATE VW_�л��Ϲ�����
SET STUDENT_NAME = '�̼���'      -- ������(����)
WHERE STUDENT_NO = 'A213046';

SELECT * FROM VW_�л��Ϲ����� WHERE STUDENT_NO = 'A213046';

/*
14. 13 �������� ���� VIEW �� ���ؼ� �����Ͱ� ����� �� �ִ� ��Ȳ�� �������� VIEW ��
��� �����ؾ� �ϴ��� �ۼ��Ͻÿ�. (������ ���� ���� : WITH READ ONLY)
*/
CREATE OR REPLACE VIEW VW_�л��Ϲ�����
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
     FROM TB_STUDENT
WITH READ ONLY;

/*
15. �� ������б��� �ų� ������û �Ⱓ�� �Ǹ� Ư�� �α� ����鿡 ���� ��û�� ����
������ �ǰ� �ִ�. �ֱ� 3 ���� �������� �����ο��� ���� ���Ҵ� 3 ������ ã�� ������
�ۼ��غ��ÿ�.
----------------------------------------------------------
�����ȣ    �����̸�                        ������������(��)
---------- ------------------------------ ----------------
C1753800    ��������                       29
C1753400    ���ü��                       23
C2454000    �����۹�������Ư��                22
*/
SELECT * FROM TB_CLASS;         --                  CLASS_NO
SELECT * FROM TB_GRADE;         -- STUDENT_NO       CLASS_NO
SELECT * FROM TB_STUDENT;       -- STUDENT_NO

SELECT �����ȣ, �����̸�, "������������(��)"
FROM (
      SELECT CLASS_NO AS "�����ȣ", CLASS_NAME AS "�����̸�", COUNT(*) AS "������������(��)"
      FROM TB_CLASS
      JOIN TB_GRADE USING (CLASS_NO)
      JOIN TB_STUDENT USING (STUDENT_NO)
      WHERE TERM_NO BETWEEN '200501' AND '200903'
      GROUP BY CLASS_NO, CLASS_NAME
      ORDER BY 3 DESC
      )
WHERE ROWNUM <= 3;




--======================================[ DML ]=========================================
/*
1. �������� ���̺�(TB_CLASS_TYPE)�� �Ʒ��� ���� �����͸� �Է��Ͻÿ�.
------------
��ȣ, �����̸�
------------
01, �����ʼ�
02, ��������
03, �����ʼ�
04, ���缱��
05. ������
*/
SELECT * FROM TB_CLASS_TYPE;

INSERT INTO TB_CLASS_TYPE VALUES ('01', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES ('02', '��������');
INSERT INTO TB_CLASS_TYPE VALUES ('03', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES ('04', '���缱��');
INSERT INTO TB_CLASS_TYPE VALUES ('05', '������');

DELETE FROM TB_CLASS_TYPE;

/*
2. �� ������б� �л����� ������ ���ԵǾ� �ִ� �л��Ϲ����� ���̺��� ������� ����. 
�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (���������� �̿��Ͻÿ�)
---------------------
���̺��̸�
    TB_�л��Ϲ�����
�÷�
    �й�
    �л��̸�
    �ּ�

*/

/*
3. ������а� �л����� �������� ���ԵǾ� �ִ� �а����� ���̺��� ������� ����. 
�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (��Ʈ : ����� �پ���, �ҽŲ�
�ۼ��Ͻÿ�)
*/

/*
4. �� �а����� ������ 10% ������Ű�� �Ǿ���. �̿� ����� SQL ���� �ۼ��Ͻÿ�. (��, 
�ݿø��� ����Ͽ� �Ҽ��� �ڸ����� ������ �ʵ��� ����)
*/

/*
5. �й� A413042 �� �ڰǿ� �л��� �ּҰ� "����� ���α� ���ε� 181-21 "�� ����Ǿ��ٰ�
����. �ּ����� �����ϱ� ���� ����� SQL ���� �ۼ��Ͻÿ�.
*/

/*
6. �ֹε�Ϲ�ȣ ��ȣ���� ���� �л����� ���̺��� �ֹι�ȣ ���ڸ��� �������� �ʱ��
�����Ͽ���. �� ������ �ݿ��� ������ SQL ������ �ۼ��Ͻÿ�.
(��. 830530-2124663 ==> 830530 )
*/

/*
7. ���а� ����� �л��� 2005 �� 1 �б⿡ �ڽ��� ������ '�Ǻλ�����' ������
�߸��Ǿ��ٴ� ���� �߰��ϰ�� ������ ��û�Ͽ���. ��� ������ Ȯ�� ���� ��� �ش�
������ ������ 3.5 �� ����Ű�� �����Ǿ���. ������ SQL ���� �ۼ��Ͻÿ�.
*/

/*
8. ���� ���̺�(TB_GRADE) ���� ���л����� �����׸��� �����Ͻÿ�.
*/


