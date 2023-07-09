SELECT * FROM TB_BOOK;
SELECT * FROM TB_WRITER;
SELECT * FROM TB_PUBLISHER;
SELECT * FROM TB_BOOK_AUTHOR;
--3. �������� 25�� �̻��� å ��ȣ�� �������� ȭ�鿡 ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT BOOK_NO, BOOK_NM
FROM TB_BOOK
WHERE LENGTH(BOOK_NM) >= 25;

--4.�޴��� ��ȣ�� ��019���� �����ϴ� �达 ���� ���� �۰��� �̸������� �������� �� ���� ���� ǥ�õǴ� �۰� �̸��� �繫�� ��ȭ��ȣ, �� ��ȭ��ȣ, �޴��� ��ȭ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT ROWNUM, WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
FROM(
SELECT * FROM TB_WRITER
WHERE MOBILE_NO LIKE '019%' AND WRITER_NM LIKE '��%'
ORDER BY WRITER_NM)
WHERE ROWNUM = '1';

--5. ���� ���°� ���ű衱�� �ش��ϴ� �۰����� �� �� ������ ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��� ����� ���۰�(��)������ ǥ�õǵ��� �� ��)
SELECT COUNT(DISTINCT WRITER_NO) AS "�۰�(��)" 
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE = '�ű�';

--6. 300�� �̻� ��ϵ� ������ ���� ���� �� ��ϵ� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.(�������°� ��ϵ��� ���� ���� ������ ��)
SELECT ��������, ����
FROM
    (SELECT COMPOSE_TYPE AS ��������, COUNT(*) AS ����
    FROM TB_BOOK_AUTHOR
    GROUP BY COMPOSE_TYPE)
WHERE ���� >= 300 AND �������� IS NOT NULL;

--7. ���� �ֱٿ� �߰��� �ֽ��� �̸��� ��������, ���ǻ� �̸��� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
FROM 
(SELECT * 
FROM TB_BOOK
ORDER BY ISSUE_DATE DESC)
WHERE ROWNUM = 1;

--8. ���� ���� å�� �� �۰� 3���� �̸��� ������ ǥ���ϵ�, ���� �� ������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. ��, ��������(��٣���) �۰��� ���ٰ� �����Ѵ�. (��� ����� ���۰� �̸���, ���� ������ ǥ�õǵ��� �Ұ�)
SELECT WRITER_NM, ����
FROM
(SELECT WRITER_NO, COUNT(*) AS ����
FROM TB_BOOK_AUTHOR
GROUP BY WRITER_NO
ORDER BY ���� DESC)
JOIN TB_WRITER USING(WRITER_NO)
WHERE ROWNUM <= 3;



--9. �۰� ���� ���̺��� ��� ������� �׸��� �����Ǿ� �ִ� �� �߰��Ͽ���. ������ ������� ���� �� �۰��� ������ ���ǵ����� �����ϰ� ������ ��¥���� �����Ű�� SQL ������ �ۼ��Ͻÿ�. (COMMIT ó���� ��)
UPDATE TB_WRITER A
SET    REGIST_DATE = (SELECT MIN(ISSUE_DATE)
                       FROM   TB_BOOK_AUTHOR 
                       JOIN   TB_BOOK USING (BOOK_NO)
                       WHERE  A.WRITER_NO = WRITER_NO); 
                       

-- 10. ���� �������� ���� ���̺��� ������ �������� ���� ���� �����ϰ� �ִ�. �����δ� �������� ���� �����Ϸ�
-- �� �Ѵ�. ���õ� ���뿡 �°� ��TB_BOOK_ TRANSLATOR�� ���̺��� �����ϴ� SQL ������ �ۼ��Ͻÿ�. 
-- (Primary Key ���� ���� �̸��� ��PK_BOOK_TRANSLATOR���� �ϰ�, Reference ���� ���� �̸���
-- ��FK_BOOK_TRANSLATOR_01��, ��FK_BOOK_TRANSLATOR_02���� �� ��)
CREATE TABLE TB_BOOK_TRANSLATOR(
    BOOK_NO VARCHAR2(10) NOT NULL CONSTRAINT FK_BOOK_TRANSLATOR_01  REFERENCES TB_BOOK,
    WRITER_NO VARCHAR2(10) NOT NULL CONSTRAINT FK_BOOK_TRANSLATOR_02 REFERENCES TB_WRITER,
    TRANS_LANG VARCHAR2(60),
    CONSTRAINT PK_BOOK_TRANSLATOR PRIMARY KEY(BOOK_NO, WRITER_NO) 
);


-- 11. ���� ���� ����(compose_type)�� '�ű�', '����', '��', '����'�� �ش��ϴ� �����ʹ�
-- ���� ���� ���� ���̺��� ���� ���� ���� ���̺�(TB_BOOK_ TRANSLATOR)�� �ű�� SQL 
-- ������ �ۼ��Ͻÿ�. ��, ��TRANS_LANG�� �÷��� NULL ���·� �ε��� �Ѵ�. (�̵��� �����ʹ� ��
-- �̻� TB_BOOK_AUTHOR ���̺� ���� ���� �ʵ��� ������ ��)
SELECT * FROM TB_BOOK_AUTHOR;

INSERT INTO  TB_BOOK_TRANSLATOR (BOOK_NO, WRITER_NO)
  SELECT BOOK_NO, WRITER_NO
  FROM   TB_BOOK_AUTHOR
  WHERE  COMPOSE_TYPE IN ('�ű�', '����', '��', '����'); 
  
  DELETE FROM TB_BOOK_AUTHOR
  WHERE  COMPOSE_TYPE IN ('�ű�', '����', '��', '����'); 
  
  COMMIT;
  
  SELECT * FROM TB_BOOK_AUTHOR;
  SELECT * FROM TB_BOOK_TRANSLATOR;


-- 12. 2007�⵵�� ���ǵ� ������ �̸��� ������(����)�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT BOOK_NM AS "������", WRITER_NM AS "������(����)" 
FROM TB_BOOK_TRANSLATOR
JOIN TB_BOOK USING(BOOK_NO)
JOIN TB_WRITER USING(WRITER_NO)
WHERE ISSUE_DATE BETWEEN '07/01/01' AND '07/12/31';

SELECT * FROM TB_BOOK;
SELECT * FROM TB_WRITER;


-- 13. 12�� ����� Ȱ���Ͽ� ��� ���������� �������� ������ �� ������ �ϴ� �並 �����ϴ� SQL
-- ������ �ۼ��Ͻÿ�. (�� �̸��� ��VW_BOOK_TRANSLATOR���� �ϰ� ������, ������, ��������
-- ǥ�õǵ��� �� ��)
GRANT CREATE VIEW TO FINAL;

CREATE OR REPLACE VIEW VW_BOOK_TRANSLATOR
AS SELECT BOOK_NM AS "������", WRITER_NM AS "������", ISSUE_DATE AS "������" 
FROM TB_BOOK_TRANSLATOR
JOIN TB_BOOK USING(BOOK_NO)
JOIN TB_WRITER USING(WRITER_NO)
WHERE ISSUE_DATE BETWEEN '07/01/01' AND '07/12/31'
WITH READ ONLY;

SELECT * FROM VW_BOOK_TRANSLATOR;




-- 14. ���ο� ���ǻ�(�� ���ǻ�)�� �ŷ� ����� �ΰ� �Ǿ���. ���õ� ���� ������ �Է��ϴ� SQL
-- ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)
-- ���ǻ� �繫�� ��ȭ��ȣ �ŷ�����
-- �� ���ǻ� 02-6710-3737 Default �� ���
SELECT * FROM TB_BOOK_AUTHOR;
SELECT * FROM TB_PUBLISHER WHERE PUBLISHER_NM = '�� ���ǻ�';

INSERT INTO TB_PUBLISHER(PUBLISHER_NM, PUBLISHER_TELNO)
VALUES ('�� ���ǻ�', '02-6710-3737');

COMMIT;



-- 15. ��������(��٣���) �۰��� �̸��� ã������ �Ѵ�. �̸��� �������� ���ڸ� ǥ���ϴ� SQL ������
-- �ۼ��Ͻÿ�.
SELECT WRITER_NM, COUNT(*)
FROM TB_WRITER
GROUP BY WRITER_NM
HAVING COUNT(*) > 1;

-- 16. ������ ���� ���� �� ���� ����(compose_type)�� ������ �����͵��� ���� �ʰ� �����Ѵ�. �ش� �÷���
-- NULL�� ��� '����'���� �����ϴ� SQL ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)

UPDATE TB_BOOK_AUTHOR
SET COMPOSE_TYPE = '����'
WHERE COMPOSE_TYPE IS NULL;

COMMIT;

SELECT COMPOSE_TYPE 
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IS NULL;

-- 17. �������� �۰� ������ �����Ϸ��� �Ѵ�. �繫���� �����̰�, �繫�� ��ȭ ��ȣ ������ 3�ڸ��� �۰���
-- �̸��� �繫�� ��ȭ ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.

SELECT * FROM TB_WRITER
WHERE SUBSTR(OFFICE_TELNO, 1,2) = '02' 
AND OFFICE_TELNO LIKE '02-___-%'
ORDER BY WRITER_NM;


-- 18. 2006�� 1�� �������� ��ϵ� �� 31�� �̻� �� �۰� �̸��� �̸������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT * FROM TB_WRITER
WHERE EXTRACT(YEAR FROM TO_DATE('2006/01/31')) - EXTRACT(YEAR FROM REGIST_DATE) >= 32
ORDER BY WRITER_NM;


-- 19. ���� ��� �ٽñ� �α⸦ ��� �ִ� 'Ȳ�ݰ���' ���ǻ縦 ���� ��ȹ���� ������ �Ѵ�. 'Ȳ�ݰ���' 
-- ���ǻ翡�� ������ ���� �� ��� ������ 10�� �̸��� ������� ����, �����¸� ǥ���ϴ� SQL ������
-- �ۼ��Ͻÿ�. ��� ������ 5�� �̸��� ������ ���߰��ֹ��ʿ䡯��, �������� ���ҷ��������� ǥ���ϰ�, 
-- �������� ���� ��, ������ ������ ǥ�õǵ��� �Ѵ�. 
SELECT * FROM TB_PUBLISHER
WHERE PUBLISHER_NM = 'Ȳ�ݰ���';

SELECT BOOK_NM AS "������",
        PRICE AS "����",
      CASE
         WHEN STOCK_QTY < 5 THEN
          '�߰��ֹ��ʿ�'
         ELSE
          '�ҷ�����' 
       END "������" 
FROM   TB_BOOK
WHERE  PUBLISHER_NM = 'Ȳ�ݰ���'
AND    STOCK_QTY < 10
ORDER BY STOCK_QTY DESC, 1;



-- 20. '��ŸƮ��' ���� �۰��� ���ڸ� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� �����
-- ��������,�����ڡ�,�����ڡ��� ǥ���� ��)
SELECT BOOK_NM "������", D.WRITER_NM "����", E.WRITER_NM "����"
FROM TB_BOOK A
JOIN TB_BOOK_AUTHOR B ON (A.BOOK_NO = B.BOOK_NO)
JOIN TB_BOOK_TRANSLATOR C ON(A.BOOK_NO = C.BOOK_NO)
JOIN TB_WRITER D ON (B.WRITER_NO = D.WRITER_NO)
JOIN TB_WRITER E ON (C.WRITER_NO = E.WRITER_NO)
WHERE BOOK_NM = '��ŸƮ��'; --1991081002

SELECT * FROM TB_BOOK_AUTHOR;
SELECT * FROM TB_BOOK_TRANSLATOR;
SELECT * FROM TB_WRITER;


-- 21. ���� �������� ���� �����Ϸκ��� �� 30���� ����ǰ�, ��� ������ 90�� �̻��� ������ ���� ������, ���
-- ����, ���� ����, 20% ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� ����� ��������, �����
-- ������, ������(Org)��, ������(New)���� ǥ���� ��. ��� ������ ���� ��, ���� ������ ���� ��, ������
-- ������ ǥ�õǵ��� �� ��


SELECT BOOK_NM AS "������", 
        STOCK_QTY AS "��� ����", 
				TO_CHAR(PRICE, '99,999') AS "����(Org)",
				TO_CHAR(PRICE*0.8, '99,999') AS "����(New)"
FROM   TB_BOOK
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM ISSUE_DATE) >= 31
AND    STOCK_QTY >= 90
ORDER BY 2 DESC, 4 DESC, 1;

