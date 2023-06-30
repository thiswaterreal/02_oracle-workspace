--����
--1.�� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. ��, ��� ����� "�а� ��", "�迭"���� ǥ���ϵ��� ����.
SELECT DEPARTMENT_NAME AS "�а� ��", CATEGORY AS "�迭"
FROM TB_DEPARTMENT;

--2. �а��� �а� ������ ������ ���� ���·� ȭ�鿡 �������.

SELECT DEPARTMENT_NAME||'�� ������ '|| CAPACITY||'�� �Դϴ�.' AS "�а��� ����"
FROM TB_DEPARTMENT;

--3. "������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û��
--���Դ�. �����ΰ�? (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ�
--ã�� ������ ����)
SELECT * FROM tb_department;
SELECT * FROM TB_STUDENT;
SELECT DEPARTMENT_NO
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME = '������а�';

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001'
AND SUBSTR(STUDENT_SSN,8,1) = '2'
AND ABSENCE_YN = 'Y';

--4. ���������� ���� ���� ��� ��ü�� ���� ã�� �̸��� �Խ��ϰ��� ����. �� ����ڵ���
--�й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�.
SELECT * FROM TB_STUDENT;

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079','A513090','A513110','A513091','A513119')
ORDER BY 1 DESC;

--5. ���������� 20 �� �̻� 30 �� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.
SELECT * FROM tb_department;

SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

--6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�. �׷� ��
--������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT * FROM tb_professor;

SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

--7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� ����.
--��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

--8. ������û�� �Ϸ��� ����. �������� ���θ� Ȯ���ؾ� �ϴµ�, ���������� �����ϴ�
--������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.
SELECT * FROM TB_CLASS;

SELECT CLASS_NO 
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

--9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.
SELECT * FROM tb_department;

SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT
ORDER BY 1;


--10. 02 �й� ���� �����ڵ��� ������ ������� ����. ������ ������� ������ ��������
--�л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO,1,2) = 'A2'
AND STUDENT_ADDRESS LIKE '%����%'
AND ABSENCE_YN = 'N';


-- ADDITIONAL SELECT �Լ�
--1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ����
--������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.( ��, ����� "�й�", "�̸�", "���г⵵" ��
--ǥ�õǵ��� ����.)
SELECT * FROM tb_student;

SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�̸�", TO_CHAR(ENTRANCE_DATE,'RRRR-MM-DD')
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE;

--2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� ����. �� ������
--�̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. (* �̶� �ùٸ��� �ۼ��� SQL
--������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)
SELECT * FROM tb_professor;

SELECT PROFESSOR_NAME, PROFESSOR_SSN FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) != 3;

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';


--3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��
--�̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. (��, ���� ��
--2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� ����. ���̴� ����������
--�������.)
SELECT * FROM tb_professor;

SELECT PROFESSOR_NAME AS "�����̸�", EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE('19'||SUBSTR(PROFESSOR_SSN,1,6))) AS "����"
FROM TB_PROFESSOR
ORDER BY 2;

--4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��� �����
--?�̸�? �� �������� ����. (���� 2 ���� ���� ������ ���ٰ� �����Ͻÿ�)
SELECT SUBSTR(PROFESSOR_NAME,2,LENGTH(PROFESSOR_NAME)-1) AS "�̸� "
FROM TB_PROFESSOR;

--5. �� ������б��� ����� �����ڸ� ���Ϸ��� ����. ��� ã�Ƴ� ���ΰ�? �̶�,
--19 �쿡 �����ϸ� ����� ���� ���� ������ �A������.
SELECT * FROM tb_student;

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN,1,6))) > 19;

--6. 2020 �� ũ���������� ���� �����ΰ�?
SELECT TO_CHAR(TO_DATE(20201225),'DAY') FROM DUAL;

--7.
--TO_DATE('99/10/11','YY/MM/DD'): 20991011�ǹ�
-- TO_DATE('49/10/11','YY/MM/DD') : 20491011�ǹ�
--TO_DATE('99/10/11','RR/MM/DD') : 19991011�ǹ�
--TO_DATE('49/10/11','RR/MM/DD') : 20491011�ǹ�

--8. �� ������б��� 2000 �⵵ ���� �����ڵ��� �й��� A �� �����ϰ� �Ǿ��ִ�. 2000 �⵵
--�̠� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO,1,1) <>'A';

--9. �й��� A517178 �� ���Ƹ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��,
--�̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� ��
--�ڸ������� ǥ������.
SELECT ROUND(AVG(POINT),1) AS "����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

--10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� �������
--��µǵ��� �Ͻÿ�.

SELECT * FROM tb_department;
SELECT * FROM TB_STUDENT;

SELECT DEPARTMENT_NO AS "�а���ȣ", COUNT(*) AS "�л���(��)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

--11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL ����
--�ۼ��Ͻÿ�.
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

--12. �й��� A112113 �� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��,
--�̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ�
--�Ҽ��� ���� �� �ڸ������� ǥ������.
SELECT * FROM tb_grade;
SELECT SUBSTR(TERM_NO,1,4) AS "�⵵", ROUND(AVG(POINT),1)
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY 1;

--13. �а� �� ���л� ���� �ľ��ϰ��� ����. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������
--�ۼ��Ͻÿ�.
SELECT * FROM TB_STUDENT;
SELECT DEPARTMENT_NO AS "�а��ڵ��", COUNT(DECODE(ABSENCE_YN,'Y','*')) AS "���л� ��"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

--14. �� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� ����. � SQL
--������ ����ϸ� �����ϰڴ°�?
SELECT STUDENT_NAME AS "�����̸�", COUNT(*) AS "������ ��"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) >=2;

--15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ���� , ��
--������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ�
--ǥ������.)
SELECT * FROM tb_grade;
SELECT NVL(SUBSTR(TERM_NO,1,4),' ') AS "�⵵", NVL(SUBSTR(TERM_NO,5,2),' ') AS "�б�", ROUND(AVG(POINT),1)
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,2));

-- addtional select
--1. �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�,
--������ �̸����� �������� ǥ���ϵ��� ����.
SELECT * FROM tb_student;
SELECT STUDENT_NAME AS "�л� �̸�", STUDENT_ADDRESS AS "�ּ���"
FROM TB_STUDENT
ORDER BY 1;

--2. �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;

--3. �ּ����� �������� ��⵵�� �л��� �� 1900 ��� �й��� ���� �л����� �̸��� �й�,
--�ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�. ��, ���������� "�л��̸�","�й�",
--"������ �ּ�" �� ��µǵ��� ����.
SELECT * FROM tb_student;

SELECT STUDENT_NAME AS "�л��̸�", STUDENT_NO AS "�й�", STUDENT_ADDRESS AS "������ �ּ�"
FROM TB_STUDENT
WHERE STUDENT_NO LIKE '9%'
AND STUDENT_ADDRESS LIKE '%��⵵%'
OR STUDENT_ADDRESS LIKE '%������%';

--4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������
--�ۼ��Ͻÿ�. (���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã��
--������ ����)
SELECT DEPARTMENT_NO
FROM tb_department
WHERE DEPARTMENT_NAME = '���а�';

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = '005'
ORDER BY PROFESSOR_SSN;

--5. 2004 �� 2 �б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� ����. ������
--���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������
--�ۼ��غ��ÿ�.
SELECT * FROM tb_grade;

SELECT STUDENT_NO, TO_CHAR(POINT,'0.00') AS "POINT"
FROM TB_GRADE
WHERE TERM_NO = '200402'
AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC;

--6. �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL
--���� �ۼ��Ͻÿ�.
SELECT * FROM tb_student;
SELECT * FROM tb_department;

SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY 2;

--7. �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT * FROM tb_class;

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);

--8. ���� ���� �̸��� ã������ ����. ���� �̸��� ���� �̸��� ����ϴ� SQL ����
--�ۼ��Ͻÿ�.
SELECT * FROM tb_class;
SELECT * FROM tb_professor;
SELECT * FROM tb_class_professor;

SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO);

--9. 8 ���� ��� �� ���ι���ȸ�� �迭�� ���� ������ ���� �̸��� ã������ ����. �̿�
--�ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT * FROM tb_department;
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON(C.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE CATEGORY = '�ι���ȸ';

--10. �������а��� �л����� ������ ���Ϸ��� ����. �����а� �л����� "�й�", "�л� �̸�",
--"��ü ����"�� ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ�������
--�ݿø��Ͽ� ǥ������.)
SELECT * FROM tb_student;
SELECT * FROM tb_department;
SELECT * FROM tb_grade;

SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�л� �̸�", ROUND(AVG(POINT),1) AS "��ü ����"
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(STUDENT_NO)
WHERE DEPARTMENT_NAME = '�����а�'
GROUP BY STUDENT_NO, STUDENT_NAME;

--11. �й��� A313047 �� �л��� �б��� ������ ���� �ʴ�. ���� �������� ������ �����ϱ�
--���� �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�. �̶� ����� SQL ����
--�ۼ��Ͻÿ�. ��, �������� ?�а��̸�?, ?�л��̸�?, ?���������̸�?����
--��µǵ��� ����.
SELECT * FROM tb_student;
SELECT * FROM tb_professor;

SELECT DEPARTMENT_NAME, STUDENT_NAME, PROFESSOR_NAME
FROM TB_STUDENT S
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_PROFESSOR P ON(S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';

--12. 2007 �⵵�� '�΁A�����' ������ ������ �л��� ã�� �л��̸��� �����б⸧ ǥ���ϴ�
--SQL ������ �ۼ��Ͻÿ�.
SELECT * FROM tb_student;
SELECT * FROM tb_department;
SELECT * FROM tb_class;
SELECT * FROM tb_grade;

SELECT STUDENT_NAME, TERM_NO  AS "TERM_NAME"
FROM TB_STUDENT S
JOIN TB_GRADE G USING(STUDENT_NO)
JOIN TB_CLASS C USING(CLASS_NO)
WHERE CLASS_NAME = '�ΰ������'
AND SUBSTR(TERM_NO,1,4) = '2007';

--13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� �� ����
--�̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT * FROM tb_class;
SELECT * FROM tb_department;
SELECT * FROM tb_class_professor;
SELECT * FROM tb_professor;

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR C1,TB_DEPARTMENT D
WHERE C.CLASS_NO = C1.CLASS_NO(+)
AND C.DEPARTMENT_NO = D.DEPARTMENT_NO
AND PROFESSOR_NO IS NULL
AND CATEGORY = '��ü��';

--14.
SELECT * FROM tb_department;
SELECT* FROM TB_CLASS;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_CLASS_PROFESSOR;

SELECT STUDENT_NAME AS "�л��̸�", NVL(PROFESSOR_NAME,'�������� ������') AS "��������"
FROM TB_STUDENT S, TB_DEPARTMENT D, TB_PROFESSOR P
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO(+)
AND S.COACH_PROFESSOR_NO = P.PROFESSOR_NO(+)
AND DEPARTMENT_NAME = '���ݾƾ��а�';

--15
SELECT * FROM tb_department;
SELECT* FROM TB_CLASS;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_CLASS_PROFESSOR;

SELECT S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME, ROUND(AVG(POINT),3)
FROM TB_STUDENT S, TB_DEPARTMENT D, TB_GRADE G
WHERE G.STUDENT_NO = S.STUDENT_NO
AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND ABSENCE_YN = 'N'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME
HAVING AVG(POINT) >= 4.0;

--16
SELECT * FROM tb_department;
SELECT* FROM TB_CLASS;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_CLASS_PROFESSOR;

SELECT C.CLASS_NO, C.CLASS_NAME, ROUND(AVG(POINT),7)
FROM TB_CLASS C, TB_GRADE G,TB_DEPARTMENT D
WHERE G.CLASS_NO = C.CLASS_NO
AND C.DEPARTMENT_NO = D.DEPARTMENT_NO
AND DEPARTMENT_NAME = 'ȯ�������а�'
AND CLASS_TYPE LIKE '����%'
GROUP BY C.CLASS_NO, C.CLASS_NAME;

--17. 
SELECT * FROM tb_department;
SELECT* FROM TB_CLASS;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_CLASS_PROFESSOR;

SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO =(SELECT DEPARTMENT_NO FROM TB_STUDENT
WHERE STUDENT_NAME = '�ְ���');

--18
SELECT * FROM tb_department;
SELECT* FROM TB_CLASS;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_CLASS_PROFESSOR;

SELECT STUDENT_NO, STUDENT_NAME
FROM (SELECT STUDENT_NO, STUDENT_NAME, AVG(POINT)
      FROM TB_STUDENT
      JOIN TB_GRADE USING(STUDENT_NO)
      WHERE DEPARTMENT_NO = '001'
      GROUP BY STUDENT_NO, STUDENT_NAME
      ORDER BY AVG(POINT) DESC)
WHERE ROWNUM = 1;

--19
SELECT * FROM tb_department;
SELECT* FROM TB_CLASS;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_CLASS_PROFESSOR;

SELECT DEPARTMENT_NAME AS "�迭 �а���", ROUND(AVG(POINT),1) AS "��������"
FROM TB_DEPARTMENT
JOIN TB_CLASS USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(CLASS_NO)
WHERE CATEGORY = (SELECT CATEGORY
                  FROM TB_DEPARTMENT
                  WHERE DEPARTMENT_NAME = 'ȯ�������а�')
GROUP BY DEPARTMENT_NAME;


