/*
 단일행 서브쿼리 : 서브쿼리의 결과가 1개 행인 경우
         사용가능한 연산자 : =, >, <, >=,<= 

 복수행(다중행) 서브쿼리에서 사용가능한 연산자 : in,any,all 
        in : 같은 경우
        any : 결과 중 한개만 조건  만족
        all : 모두 결과가  조건 만족

 다중 컬럼 서브쿼리 : 비교 대상 컬럼이 2개인 경우

 상호연관 서브쿼리 : 외부query의 컬럼이 subquery에 영향을 주는 query
                      성능이 안좋다.

DDL : Data Definition Language (데이터 정의어)
        객체의 구조를 생성,수정,제거하는 명령어
      create : 객체 생성 명령어
		   table 생성 : create table  
		   user 생성  : create user
		   index 생성  : create index
		   ....
		alter : 객체 수정 명령어. 컬럼 추가, 컬럼제거, 컬럼크기변경...
		   컬럼 추가 : alter table 테이블명 add 컬럼명 자료형
		   컬럼 크기 변경 : alter table 테이블명 modify 컬럼명 자료형
		   컬럼 이름 변경 : alter table 테이블명 change 원본컬럼명 새로운컬럼명 자료형
		   컬럼 제거 : alter table 테이블명 drop 컬럼명
		   제약조건 추가: alter table 테이블명 add constraint .... 
		   제약조건 제거: alter table 테이블명 drop constraint 제약조건 이름
		   
		제약조건 조회
		  information_schema 데이터베이스 선택
		  table_constraints 테이블 조회하기
*/
USE information_schema
SELECT * FROM table_constraints
WHERE TABLE_NAME = "professor_101"
USE gdjdb
-- 제약조건 제거하기
-- 외래키 제거
ALTER TABLE professor_101 DROP FOREIGN KEY professor_101_ibfk_1
ALTER TABLE professor_101 DROP FOREIGN KEY professor_101_ibfk_2
-- 기본키 제거
ALTER TABLE professor_101 DROP PRIMARY KEY

/*
   drop 명령어 : 객체 제거
*/
SHOW tables
DESC test1
-- test1 테이블을 제거하기
DROP TABLE test1
DESC test1

/*
   truncate : 테이블과 데이터 분리
*/
SELECT * FROM professor_101
-- delete 명령문 비교 : autocommit false 설정
SET autocommit=FALSE -- 자동 commit 안함
SHOW VARIABLES LIKE 'autocommit%'
SELECT * FROM professor_101
-- delete 명령어로 데이터 제거 : rollback 가능
DELETE FROM professor_101
SELECT * FROM professor_101
ROLLBACK  -- TCL 트랜젝션 실행 취소
SELECT * FROM professor_101

-- truncate로 데이터 제거 : rollback 불가능. 
TRUNCATE TABLE professor_101
SELECT * FROM professor_101
ROLLBACK
SELECT * FROM professor_101

/*
   DML : Data Manipulation Language : 데이터 처리(조작)어
         데이터의 추가,변경,삭제 언어
      insert : 데이터 추가 - C
		update : 데이터 수정,변경 - U
		delete : 데이터 삭제 - D
		select : 데이터 조회 - R
		
		CRUD : Create,Read,Update,Delete   
	Transaction 처리 가능 : commit,rollback 가능	
*/
/*
   insert : 데이터(레코드)추가
   insert into 테이블명 [(컬럼명1,컬럼명2,...)] values (값1,값2,....)
    => 컬럼명의 갯수 값의 갯수가 동일해야함.
     컬럼명1 <= 값1
     컬럼명2 <= 값2     
     ....
     
     컬럼명 부분을 구현하지 않으면 스키마에 정의된 순서대로 값을 입력해야함.
     
     -- 컬럼명 구현해야 하는 경우
     1. 모든 컬럼의 값을 입력하지 않는 경우
     2. 스키마의 순서를 모를때
     3. db 구조의 변경이 자주 발생시 컬럼명을 기술하는 것이 안전함 
*/
SELECT * FROM depttest1
-- depttest1 테이블에 90번특판팀 추가하기
INSERT INTO depttest1 (deptno,dname) VALUES (90,'특판팀')
SELECT * FROM depttest1
ROLLBACK  -- insert 실행 취소
SELECT * FROM depttest1

-- depttest1 테이블에 91번특판1팀 추가하기
INSERT INTO depttest1  VALUES (91,'특판1팀') -- 컬럼부분이 없으면 스키마 순서대로 모든값 입력
INSERT INTO depttest1  VALUES (91,'특판1팀',NULL)
SELECT * FROM depttest1
COMMIT -- 실행 완성. 
ROLLBACK -- commit 이후의 rollback은 의미 없다

-- depttest1 테이블에 70,총무부 레코드 추가하기 - 컬럼명 생략하기
INSERT INTO depttest1 VALUES (70,"총무부",NULL)
-- depttest1 테이블에 80,인사부 레코드 추가하기 - 컬럼명 기술하기
INSERT INTO depttest1 (deptno,dname) VALUES (80,"인사부")
SELECT * FROM depttest1

-- 여러개의 레코드를 한번 추가하기
-- (91, 특판1팀), (50,운용팀,울산),(70,총무부,울산),(80,인사부,서울)
SELECT * FROM depttest2
INSERT INTO depttest2 VALUES 
  (91, '특판1팀',NULL),
  (50,'운용팀','울산'),
  (70,'총무부','울산'),
  (80,'인사부','서울')
SELECT * FROM depttest2  

-- 기존의 테이블을 이용하여 데이터 추가하기
SELECT * FROM depttest3
INSERT INTO depttest3 SELECT * FROM depttest2
SELECT * FROM depttest3

-- professor_101 테이블에 내용을 추가하기
SELECT * FROM professor_101

INSERT INTO professor_101 (NO,NAME,deptno,POSITION,mname) 
SELECT p.no,p.name,p.deptno,p.position, m.name 
FROM professor p, major m
WHERE p.deptno = m.code
  AND p.deptno = 101
SELECT * FROM professor_101
/*
   컬럼 부분의 갯수와 select에서 조회되는 컬럼의 갯수가 동일해야 함
*/  
INSERT INTO professor_101  -- 컬럼의 갯수가 다르므로 오류 발생
SELECT * FROM professor p, major m
WHERE p.deptno = m.code
  AND p.deptno = 101

-- test3 테이블에 3학년학생의 정보 저장하기
DESC test3
INSERT INTO test3 
SELECT studno,NAME,birthday FROM student
WHERE grade = 3
SELECT * FROM test3

/*
   update : 데이터의 내용을 변경하는 명령어
   
   update 테이블명 set 컬럼1=값1,컬럼2=값2,....
   [where 조건문] => 없는 경우 모든 레코드값이 변경
                     있는 경우 조건문의 결과 참인 레코드만 변경
*/
-- emp 테이블에서 사원 직급인 경우 보너스 10만원 인상하기
-- 보너스가 없는 경우도 10만원 변경하기
SELECT * FROM emp WHERE job='사원'
-- bonus가 null인경우 인상 안됨
UPDATE emp SET bonus = bonus + 10
WHERE job='사원'

SELECT * FROM emp WHERE job='사원'
rollback
UPDATE emp SET bonus = ifnull(bonus,0) + 10
WHERE job='사원'
SELECT * FROM emp WHERE job='사원'

-- 이상미교수와 같은 직급의 교수 중 급여가 350미만인 교수의 급여를 10%
-- 인상하기
SELECT * FROM professor 
WHERE POSITION = (SELECT POSITION FROM professor WHERE NAME='이상미')
 AND salary < 350 
 
UPDATE professor SET salary = salary * 1.1 
WHERE POSITION = (SELECT POSITION FROM professor WHERE NAME='이상미')
 AND salary < 350 
SELECT * FROM professor 
WHERE POSITION = (SELECT POSITION FROM professor WHERE NAME='이상미')

-- 보너스가 없는 시간강사의 보너스를 조교수의 평균보너스의 50%로 변경하기
SELECT * FROM professor WHERE POSITION='조교수'
SELECT AVG(bonus) FROM professor WHERE POSITION='조교수'
SELECT * FROM professor WHERE POSITION='시간강사' AND bonus IS NULL

UPDATE professor SET bonus = 50
WHERE POSITION='시간강사' AND bonus IS NULL

SELECT * FROM professor WHERE POSITION='시간강사'

ROLLBACK
SELECT * FROM professor WHERE POSITION='시간강사'

UPDATE professor 
SET bonus = (SELECT AVG(bonus)*0.5 FROM professor WHERE POSITION='조교수') 
WHERE POSITION='시간강사' AND bonus IS NULL
SELECT * FROM professor WHERE POSITION='시간강사'

-- 지도교수가 없는 학생의 지도교수를 이용학생의 지도교수로 변경하기
SELECT * FROM student WHERE profno IS NULL
SELECT * FROM student WHERE grade =1
SELECT profno FROM student WHERE NAME='이용'
UPDATE student SET profno = (SELECT profno FROM student WHERE NAME='이용')
WHERE profno IS NULL
SELECT * FROM student WHERE profno IS NULL
SELECT * FROM student WHERE grade =1
ROLLBACK

-- 교수 중 김옥남교수와 같은 직급의 교수 급여를 101학과의 평균급여로 변경하기
-- 소숫점이하는 반올림하여 정수로 저장하기
SELECT * FROM professor
where POSITION = (SELECT position FROM professor WHERE NAME='김옥남')
-- 101 평균급여
SELECT round(AVG(salary)) FROM professor WHERE deptno = 101

-- 
UPDATE professor SET salary = (SELECT round(AVG(salary)) FROM professor WHERE deptno = 101)
WHERE POSITION = (SELECT position FROM professor WHERE NAME='김옥남')

SELECT * FROM professor
where POSITION = (SELECT position FROM professor WHERE NAME='김옥남')

rollback

/*
   delete : 레코드 삭제
   
   delete from 테이블명
   [where 조건문] => 조건문의 결과가 참인 레코드만 삭제
*/
SELECT * FROM depttest1
-- depttest1의 모든 레코드를 삭제하기
DELETE FROM depttest1

SELECT * FROM depttest2
-- depetest2 테이블에서 기획부 삭제하기
DELETE FROM depttest2 WHERE dname='기획부'
SELECT * FROM depttest2
-- depetest2 테이블에서 부서명에 '기' 문자가 있는 부서 삭제하기
DELETE FROM depttest2 WHERE dname LIKE '%기%'
SELECT * FROM depttest2
ROLLBACK
-- 교수 중 김옥남 교수와 같은 부서의 교수정보 제거하기
SELECT * FROM professor 
WHERE deptno = (SELECT deptno FROM professor WHERE NAME='김옥남')

delete FROM professor 
WHERE deptno = (SELECT deptno FROM professor WHERE NAME='김옥남')

SELECT * FROM professor 
WHERE deptno = (SELECT deptno FROM professor WHERE NAME='김옥남')

ROLLBACK

/*
   SQL의 종류
   DDL : 데이터정의어. Data Definition Language
        create, alter, drop, truncate
        Transaction 처리 안됨. autocommit 임.  
*/
delete FROM professor 
WHERE deptno = (SELECT deptno FROM professor WHERE NAME='김옥남')

SELECT * FROM professor 
WHERE deptno = (SELECT deptno FROM professor WHERE NAME='김옥남')

DROP TABLE test2 -- DDL 명령 실행시 자동 commit됨

ROLLBACK
/*
   DML : 데이터 조작어(처리어) : Data Manupulation Language 
      insert(C),select(R),update(U),delete(D)
      Transaction 처리 가능. rollback,commit 실행 가능.
      autocommit이 아닌 환경에서 rollback,commit 가능
   TCL : Transaction Control Language : 트랜잭션 제어 언어
	   commit,rollback
	DCL : 데이터 제어어 : Data Control Language => db 관리자의 언어
	   grant  : 사용자에게 db 권한 부여.
	   revoke : 사용자에게 부여되었던 권한 회수. 제거
*/

/*
    View : 가상테이블
         물리적으로 메모리 할당이 없음. 테이블처럼 join,subquery 가능함
*/

-- 2 학년 학생의 학번,이름,키,몸무게를 가진 뷰 v_stu2 생성하기
CREATE OR REPLACE VIEW v_stu2
AS SELECT studno,NAME,height,weight FROM student WHERE grade=2

-- v_stu2 뷰의 내용 조회하기
SELECT * FROM v_stu2

-- 232001,홍길동,2,160, 60, hongkd 학생테이블 추가하기
-- 242001,김삿갓,1,165, 65, kimsk 학생테이블 추가하기
INSERT INTO student (studno,NAME,grade,height,weight,id,jumin)
VALUES (232001,'홍길동',2,160,60,'hongkd','12345'),
       (242001,'김삿갓',1,165,65,'kimsk','56789')
       
SELECT * FROM v_stu2
ROLLBACK

-- view 객체  조회하기
USE information_schema
SELECT view_definition FROM VIEWS
WHERE TABLE_NAME="v_stu2"

select `gdjdb`.`student`.`studno` AS `studno`,
  `gdjdb`.`student`.`name` AS `NAME`,
  `gdjdb`.`student`.`height` AS `height`,
  `gdjdb`.`student`.`weight` AS `weight` 
  from `gdjdb`.`student`
   where `gdjdb`.`student`.`grade` = 2
   
-- 2학년 학생의 학번,이름,국어,영어,수학 값을 가지는 v_score2 뷰생성하기
CREATE or replace VIEW v_score2 
AS
SELECT s1.studno,s1.name, s2.kor,s2.eng,s2.math 
FROM student s1, score s2
WHERE s1.studno = s2.studno
  AND s1.grade = 2
  
-- CREATE or replace : 생성 또는 변경  

SELECT * FROM v_score2

-- v_stu2,v_score2 뷰를 이용하여 학번,이름,점수들, 키,몸무게 정보 조회하기
SELECT v1.*,v2.height,v2.weight 
FROM v_score2 v1, v_stu2 v2
WHERE v1.studno = v2.studno

-- v_score2 뷰와 student 테이블을 이용하여 학번,이름,점수들,학년,지도교수번호
-- 출력하기
SELECT v.*,s.grade,s.profno
FROM v_score2 v, student s
WHERE v.studno = s.studno

-- v_score2 뷰와 student,professor 테이블을 이용하여 
-- 학번,이름,점수들,학년,지도교수번호,지도교수이름 출력하기
SELECT v.studno,v.name,v.kor,v.eng,v.math, s.profno, p.`name`
FROM v_score2 v, student s, professor p
WHERE v.studno = s.studno
  AND s.profno = p.no   

-- 뷰 삭제하기
DROP VIEW v_stu2  
SELECT * FROM v_stu2

/*
   inline 뷰 : 뷰의 이름이 없고, 일회성으로 사용되는 뷰
               select 구문의 from 절에 사용되는 subquery
               반드시 별명을 설정해야 함
*/
-- 학생의 학번,이름,학년,키,몸무게, 학년의 평균키,평균몸무게 조회하기
SELECT studno,NAME,grade,height,weight,
  (SELECT AVG(height) FROM student s2 WHERE s1.grade = s2.grade) 평균키,
  (SELECT AVG(weight) FROM student s2 WHERE s1.grade = s2.grade) 평균몸무게
FROM student s1    
-- inline 뷰를 이용하기
SELECT studno,NAME,s.grade,height,weight,avg_h 평균키 ,avg_w 평균몸무게
FROM student s, 
(SELECT grade, AVG(height) avg_h ,AVG(weight) avg_w 
 FROM student GROUP BY grade) a
WHERE s.grade = a.grade 

-- 사원테이블에서 사원번호,사원명,직급,부서코드,부서명, 부서별평균급여,
-- 부서별 평균보너스 출력하기. 보너스가 없으면 0으로 처리한다
SELECT e.empno, e.ename,e.job,e.deptno,d.dname, a.avg_s, a.avg_b
FROM emp e, dept d,
  (SELECT deptno, AVG(salary) avg_s, AVG(ifnull(bonus,0)) avg_b 
   FROM emp GROUP by deptno) a
WHERE e.deptno = d.deptno
  AND e.deptno = a.deptno   
   
/*
    사용자 관리
*/   
-- 데이터베이스 생성
CREATE DATABASE mariadb 
-- 데이터베이스 목록 조회
SHOW DATABASES
-- 테이블 목록 조회
SHOW TABLES

-- 사용자 생성하기
USE mariadb
CREATE USER test1
-- 비밀번호 설정하기
SET PASSWORD FOR 'test1'=PASSWORD("pass1")

-- 권한 주기
grant select,insert,update,delete,create,drop,create VIEW 
on mariadb.* to 'test1'@'%'

GRANT ALTER ON mariadb.* TO 'test1'@'%';
-- 권한 조회
SELECT * FROM USER_PRIVILEGES WHERE grantee LIKE '%test1%'

-- 권한 회수 : revoke
REVOKE all PRIVILEGES ON mariadb.* FROM test1@'%'

-- test1 사용자 삭제하기
DROP USER 'test1'@'%';