/*
    < TCL : TRANSACTION CONTROL LANGUAGE >      *** 가장 중요 ***
    트랜젝션 제어 언어
    
    * 트랜젝션(TRANSATION)
    - 데이터베이스의 논리적 연산단위
    - 데이터의 변경사항(DML 추가, 수정, 삭제)들을 하나의 트랜젝션에 묶어서 처리
      DML문 한 개를 수행할 때 트랜젝션이 존재하면 해당 트랜젝션에 같이 묶어서 처리
                            트랜젝션이 존재하지 않으면 트랜젝션 만들어서 묶음
      COMMIT 하기 전!까지 변경사항들을 하나의 트랜젝션에 담게 됨
      COMMIT 을 해야만 실제 DB에 반영이 된다고 생각하면 됨
      - 트랜젝션의 대상이 되는 SQL : INSERT, UPDATE, DELETE (DML에서만 반영!!)
      
      COMMIT (트랜젝션 종료 처리 후 확정)
      ROLLBACK (트랜젝션 취소)
      SAVEPOINT (임시저장)
      
      - COMMIT;     진행하면 : 한 트랜젝션에 담겨있는 변경사항들을 실제 DB에 반영시키겠다는 의미 (후에 트랜젝션은 사라짐)
      - ROLLBACK;   진행하면 : 한 트렌잭션에 담겨있는 변경사항들을 삭제(취소) 한 후 마지막 COMMIT 시점으로 돌아감
      - SAVEPOINT 포인트명; 진행 : 현재 이 시점에서 해당 포인트명으로 임시저장점을 정의해두는 것
                                 ROLLBACK 진행시 전체 변경사항들을 다 삭제하는게 아니라 일부만 ROLLBACK 가능
*/

SELECT * FROM EMP_01;

-- 사번이 900번인 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID = 900; --차은우
-- 뭔가 진짜 삭제된 것 처럼 보임!

DELETE FROM EMP_01
WHERE EMP_ID = 901; --주지훈

ROLLBACK;
-- 변경사항 취소되고, 트랜젝션도 없어짐. 데이터 다시 되살아난다.

----------------------------------------------------------------------------------
-- 200번인 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID = 200; --선동일

SELECT * FROM EMP_01;

-- 800번, 황민현, 총무부 사원 추가
INSERT INTO EMP_01
VALUES(800, '황민현', '총무부');

COMMIT;
-- 실제 DB에 반영됨!!                // 데이터들을 실제 DB에 다 반영시키고, 트랜젝션 비우고 삭제까지 됨

ROLLBACK;
-- 이미 COMMIT 해서 못들어감          // 위에 COMMIT; 선언한 바로 뒷 상태로 돌아감 (마지막COMMIT시점으로 돌아감)(트랜젝션 내용들 취소)

-- 217, 216, 214 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID IN (217, 216, 214);

-- 임시저장점(SAVEPOINT) 잡기 (3:38)
SAVEPOINT SP;

-- 801, 안효섭, 인사관리부 사원 추가
INSERT INTO EMP_01
VALUES(801, '안효섭', '인사관리부');

-- 218 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID = 218;

SELECT * FROM EMP_01;

-- 801 추가랑 218 삭제만 취소하고 싶다!!
ROLLBACK TO SP;

COMMIT;

----------------------------------------------------------------------------------
-- 900, 901 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID IN (900, 901);

-- 218 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID = 218;

SELECT * FROM EMP_01;

-- DDL문
CREATE TABLE TEST(
    TID NUMBER
);

ROLLBACK;
-- DDL문 (CREATE, ALTER, DROP)을 수행하는 순간 기존에 트랜젝션에 있던 변경사항들을
-- 무조건 COMMIT(실제 DB에 반영)
-- 따라서, ROLLBACK 했음에도 900,901,218이 살아나지 않는다..
-- 즉, DDL문 수행 전 변경사항이 있었다면 정확히 픽스(COMMIT, ROLLBACK) 하고 하자!!

