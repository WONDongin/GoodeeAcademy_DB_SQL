-- 1. 학년의 평균 몸무게가 70보다 큰 학년의 학년와 평균 몸무게 출력하기
SELECT grade, avg_weight FROM (SELECT grade,AVG(weight) avg_weight FROM student GROUP BY grade) a
HAVING avg_weight >= 70;

SELECT grade,AVG(weight) FROM student
GROUP BY grade
HAVING AVG(weight) >= 70;

-- 2. 학년별로 평균체중이 가장 적은 학년의   학년과 평균 체중을 출력하기
SELECT grade, AVG(weight) FROM student GROUP BY grade
HAVING AVG(weight) <= ALL (SELECT AVG(weight) FROM student GROUP BY grade);

-- 3. 전공테이블(major)에서 공과대학(deptno=10)에 소속된  학과이름을 출력하기
SELECT CODE,NAME,part FROM  major
WHERE part IN (SELECT m1.code FROM major m1, major m2 WHERE m1.part = m2.code AND m2.`name` = '공과대학');

-- 4. 자신의 학과 학생들의 평균 몸무게 보다 몸무게가 적은   학생의 학번과,이름과, 학과번호, 몸무게를 출력하기
SELECT studno,NAME,studno,weight FROM student s1
WHERE weight < (SELECT AVG(weight) FROM student s2 WHERE s1.major1 = s2.major1 );

-- 5. 학번이 220212학생과 학년이 같고 키는  210115학생보다  큰 학생의 이름, 학년, 키를 출력하기
SELECT NAME,grade,height FROM student
WHERE grade = (SELECT grade FROM student WHERE studno = '220212') 
AND height > (SELECT height FROM student WHERE studno = '210115');
 
-- 6. 컴퓨터정보학부에 소속된 모든 학생의 학번,이름, 학과번호, 학과명 출력하기
SELECT s.studno,s.NAME,s.major1,m.name FROM student s, major m
WHERE s.major1 = m.code AND s.major1 IN (SELECT CODE FROM major WHERE part = 100);

SELECT s.studno,s.NAME,s.major1,m.name FROM student s, major m
WHERE s.major1 = m.code AND s.major1 IN (SELECT m1.CODE FROM major m1, major m2 WHERE m1.part = m2.code AND m2.`name` = '컴퓨터정보학부');

-- 7. 4학년학생 중 키가 제일 작은 학생보다  키가 큰 학생의 학번,이름,키를 출력하기
SELECT studno,NAME,height FROM student
WHERE height > (SELECT MIN(height) FROM student WHERE grade = 4);

SELECT studno, NAME, height FROM student
WHERE height >ANY (SELECT height FROM student WHERE grade = 4);
-- > ANY : height > ANY (...)는 "서브쿼리에서 반환된 값 중 하나라도 초과하는 값

-- 8. 학생 중에서 생년월일이 가장 빠른 학생의  학번, 이름, 생년월일을 출력하기
SELECT studno, NAME, birthday FROM student
WHERE birthday = (SELECT MIN(birthday) FROM student);

-- 9. 학년별  생년월일이 가장 빠른 학생의 학번, 이름, 생년월일,학과명을 출력하기
SELECT s.grade, s.studno,s.NAME,s.birthday, m.name FROM student s, major m
WHERE (grade, birthday) in (SELECT grade, MIN(birthday) FROM student GROUP BY grade)
AND s.major1 = m.code;

-- 10. 학과별 입사일 가장 오래된 교수의 교수번호,이름,입사일,학과명 조회하기
SELECT p.no,p.`name`,p.hiredate,m.`name` FROM professor p, major m
WHERE p.deptno = m.code
AND (p.deptno,p.hiredate) IN (SELECT deptno, MIN(hiredate) FROM professor GROUP BY deptno);

-- 11. 4학년학생 중 키가 제일 작은 학생보다  키가 큰 학생의 학번,이름,키를 출력하기
SELECT studno,NAME,height FROM student
WHERE height > (SELECT MIN(height) FROM student WHERE grade = 4)
order by studno;

-- 12. 학년별로 평균키가 가장 적은 학년의  학년과 평균키를 출력하기
SELECT grade, AVG(height) FROM student GROUP BY grade
HAVING AVG(height) <= ALL(SELECT AVG(height) FROM student GROUP BY grade)

-- 13. 학생의 학번,이름,학년,키,몸무게,학년의 최대키, 최대몸무게 조회하기
SELECT s1.studno,s1.NAME,s1.grade,s1.height, s1.weight,
(SELECT MAX(height) FROM student s2 WHERE s1.grade = s2.grade) 최대키,
(SELECT MAX(weight) FROM student s2 WHERE s1.grade = s2.grade) 최대몸무게
FROM student s1;

-- 14. 교수번호,이름,부서코드,부서명,자기부서의 평균급여, 평균보너스 조회하기
--    보너스가 없으면 0으로 처리한다.
SELECT p1.no,p1.`name`,m.code,m.`name`,
(SELECT AVG(p1.salary) FROM professor p1, professor p2 WHERE p1.deptno = p2.deptno) 평균급,
(SELECT AVG(IFNULL(p1.bonus,0)) FROM professor p1, professor p2 WHERE p1.deptno = p2.deptno) 평균보너스
FROM professor p1, major m
WHERE p1.deptno = m.code

SELECT p.no,p.name, p.deptno,
  (SELECT NAME FROM major m WHERE m.code = p.deptno) 부서명,
  (SELECT AVG(salary) FROM professor p2 WHERE p2.deptno = p.deptno) 평균급여,
  (SELECT AVG(IFNULL(bonus,0)) FROM professor p2 WHERE p2.deptno = p.deptno) 평균보너스
FROM professor p

-- 15. test6 테이블 생성하기
-- 컬럼 : seq : 숫자,기본키,자동증가
--        name : 문자형 20문자
--        birthday : 날짜만
CREATE TABLE test6(
  seq INT PRIMARY KEY AUTO_INCREMENT,
  NAME VARCHAR(20),
  birthday DATE
)
DESC test6

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