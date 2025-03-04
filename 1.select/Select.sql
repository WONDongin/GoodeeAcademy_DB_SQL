-- desc : 테이블의 구조(스키마) 조회
-- desc 테이블명 
DESC dept
-- SQL : structured Query language : 관계형 데이터 베이스(RDBMS)에서 데이터 처리를 위한 언어

-- select : 데이터 조회를 위한 언어
-- emp 테이블의 모든 데이터를 조회하기
SELECT * FROM emp;

-- emp 테이블의 empo, ename,deptno 칼럼의 모든 레코드 조회하기
SELECT empno,ename,deptno FROM emp 

-- 리터널 컬럼 사용하기 : 상수값을 사용하기
-- 학생(student)의 이름 뒤에 학생 문자열을 붙여서 조회
SELECT NAME, '학생' FROM student

-- 1. 교수 테이블(professor)의 구조 조회하기
DESC professor
-- 2. 교수 테이블(professor)의 교수번호(no),교수이름(name),'교수' 문자열을 붙여서 조회하기
-- 문자열형 상수: 작은따옴표, 큰따옴표 동일하다.
-- 오라클db에서는 작은따옴표만 가능함.
SELECT NO,NAME,'교수' FROM professor;
SELECT NO,NAME,"교수" FROM professor;

-- 컬럼에 별명(alias)설정하기 : 조회되는 컬럼명을 변경하기
SELECT NO 교수번호,NAME 교수이름,'교수' FROM professor;
SELECT NO '교수번호',NAME 교수이름,'교수' FROM professor;
SELECT NO '교수번호',NAME '교수이름','교수' FROM professor; -- 공백표기시 문자열''
SELECT NO AS '교수 번호',NAME AS '교수 이름','교수' FROM professor; -- AS 생략가능

-- 컬럼에 연산자(+-*/) 사용가능
-- emp 테이블에서 사원이름(ename), 현재급여(salary), 10% 인상예상급여 조회하기
SELECT ename,salary,salary*1.1 FROM emp

-- distinct : 중복을 제거하고 하나만  조회
--            컬럼의 처음에 한번만 구현해야 함
-- 교수(professor)테이블에서 교수가 속한 부서코드(deptno)를 조회하기
SELECT distinct deptno FROM professor;
-- 교수(professor)테이블에서 교수가 속한 직급(position)를 조회하기
SELECT distinct POSITION FROM professor;
-- 교수(professor)테이블에서 부서별 교수가 속한 직급(position)를 조회하기
-- 여러개의 컬럼앞의 distinct는 기술된 컬럼의 값들이 중복되지 않도록 조회함
SELECT DISTINCT deptno,DISTINCT POSITION FROM professor -- (오류발생)
SELECT DISTINCT deptno,POSITION FROM professor;
/*
select 칼럼명(컬럼, 리터널값('뉴스'), 연산된 컬럼(result*1.1),*(모든컬럼), 별명(NO '별명'), distinct(중복값제거)) 
from   테이블명
where  레코드 선택 조건
       조건문이 없는 경우: 모든 레코드 조회
       조건문이 있는 경우: 조건문의 결과가 참인 레코드만 조회
*/

-- 학생테이블(student)에서 1학년 학생의 모든 칼럼을 조회하기
SELECT * FROM student WHERE grade = 1;
-- 학생테이블(student)에서 3학년 학생 중 전공1코드(major1)가 101인 학생의
-- 학번(studno), 이름(name), 학년(grade), 전공1학과(major1) 칼럼 조회하기
-- 논리연산 : and, or
SELECT studno,NAME,grade,major1 FROM student WHERE grade=3 AND major1=101; 
-- 학생테이블(student)에서 3학년 학생이거나 전공1코드(major1)가 101인 학생의
-- 학번(studno), 이름(name), 학년(grade), 전공1학과(major1) 칼럼 조회하기
SELECT studno,NAME,grade,major1 FROM student WHERE grade=3 OR major1=101;

-- 부서코드:10, 사원의 이름, 급여
SELECT ename,salary,deptno FROM emp WHERE deptno = 10;
-- 급여:800 이상,  사원의 이름, 급여
SELECT ename,salary FROM emp WHERE salary >= 800;
-- 직급:정교수,  사원의 이름, 부서코드, 직급
SELECT NAME,deptno,POSITION FROM professor WHERE POSITION = '정교수';

-- where 조건문에 연산처리하기
-- 인상급여가 1000 미만, 사원의 이름,현재급여,예상인상급여
SELECT ename,salary,salary*1.1 FROM emp WHERE salary*1.1 < 1000;
-- 급여가 700이하 5%인상, 사원의 이름,예상급여,부서코드
SELECT ename 사원이름,salary 현재급여,salary*0.05+salary 인상예상급여,deptno 부서코드  FROM emp WHERE salary <= 700;
-- 생일이 2005-06-30 이후 출생한 1학년, 학생의 이름, 학과코드,생일,학년
SELECT NAME,major1,birthday,grade From student WHERE grade=1 AND birthday > '1995-06-30 00:00:00'; 

/*
where 조건문에서 사용되는 연산자 : 
between : 범위 지정 연산자
where 컬럼명 between A and B : 컬럼의 값이 A 이상 B이하인 레코드 선택
*/
-- 학생 중 1,2 학생의 모든 컬럼을 조회하기
SELECT * FROM student WHERE grade = 1 OR grade = 2;
SELECT * FROM student WHERE grade >= 1 AND grade <= 2;
SELECT * FROM student WHERE grade BETWEEN 1 AND 2;
-- 1학년 학생중 몸주게(weight) 70 <= ? <=80, 학생의 이름,학년,몸무게,1전공학과코드 조회
SELECT NAME,weight FROM student WHERE weight BETWEEN 70 AND 80 AND grade=1;
SELECT NAME,weight FROM student WHERE weight >= 70 AND weight <= 80 AND grade=1;
-- 전공1학과 101 + 50 <= 몸무게 <= 80, 학생의 몸무게, 1전공학과코드 조회
SELECT NAME,weight,major1 FROM student WHERE weight >= 50 AND weight <= 80 AND major1 = 101;
/*
where 조건문에서 사용되는연산자 : 
in : 
or : 조건문으로 표현이 가능
*/
-- 전공1 : 101,201, 학생의 이름,전공코드,학년 출력
SELECT NAME,major1,grade FROM student WHERE major1 = 101 OR major1 = 201;
SELECT NAME,major1,grade FROM student WHERE major1 IN (101,201);
-- 학과코드:101,201, 교수이름,학과코드,입사일 출력
SELECT NAME,deptno,hiredate FROM professor WHERE deptno IN (101,201);
-- 전공1 : 101,201 + 키 170이상, 학번,이름,몸무게,키.학과코드
SELECT studno,NAME,weight,height,major1 FROM student WHERE major1 IN (101,201) AND height >= 170;

/*
like 연산자 : 일부분 일치
% : 0개 이상의 임의의 문자
_ : 1개의 임의의 문자
*/
-- 성: 김씨, 이름, 전공코드 출력
SELECT NAME,major1 FROM student WHERE NAME LIKE '김%';
-- 이름 중 '진', 이름, 학년, 전공코드 
SELECT NAME,grade,major1 FROM student WHERE NAME LIKE '%진%';
-- 이름 2글자,  이름, 학년, 전공코드 
SELECT NAME,grade,major1 FROM student WHERE NAME LIKE '__';
-- 이름끝자리: 훈, 이름, 전공코드
SELECT studno,NAME,major1 FROM student WHERE NAME LIKE '%훈';
-- 전화번호 : 02, 이름, 학번, 전화번호 
SELECT NAME,studno,tel FROM student WHERE tel LIKE '02%';
-- id : k(o), 교수 이름,id,직급
-- like : 대소문자 구분 안함.
SELECT NAME,id,POSITION FROM professor WHERE id LIKE '%k%';
SELECT NAME,id,POSITION FROM professor WHERE id LIKE '%K%';
-- 대소문자 구분 : binary
SELECT NAME,id,POSITION FROM professor WHERE id LIKE binary '%k%';
SELECT NAME,id,POSITION FROM professor WHERE id LIKE binary '%K%';

-- not like 연산자 : like 반대
-- 성: 이x, 이름, 전공코드 
-- 101,201 학과x + 김씨x , 교수이름, 학과코드,직급
SELECT NAME,deptno,POSITION FROM professor WHERE deptno NOT IN (101,201) AND NAME NOT LIKE '김%';
-- 이씨x, 학생 학급,이름,번호
SELECT grade,NAME,studno FROM student WHERE NAME NOT LIKE '이%';

/*
null 의미: 값이 없다.
is null : 컬럼의 값이 null 인경우
is not null : 칼럼이 값이 null이 아닌경우
bonus =  null 은 비교 대상이 아님
         null 값과의 연산은 결과:  null임.
*/
-- 성과금x, 사원번호, 이름, 급여
SELECT empno,ename,bonus FROM emp WHERE bonus IS NULL; 
-- 성과금o, 사원번호,이름,급여,보너스 
SELECT empno,ename,salary,bonus FROM emp WHERE bonus IS NOT NULL;
-- 교수이름,급여,보너스,연봉(salary*12+bonus)
SELECT NO,name,bonus,salary*12+bonus 연봉 FROM professor;
-- 보너스o, 교수이름,급여,보너스,연봉
SELECT NAME,salary,bonus,salary*12+bonus 연봉  FROM professor WHERE bonus IS NOT NULL;
-- 지도교수 x
SELECT studno,NAME,major1,profno FROM student WHERE profno IS NULL;

/*
select *(모든컬럼) || 컬럼명1, 컬럼명..
from 테이블명 
[wherer 조건문]
		 where 조건문이 생략되면 모든 레코드를 선택
		 where 조건문의 결과가 참인 레코드만 선택
[order by 컬럼명|조회된 컬럼순서|별명 (desc: 내림차순/asc : 오름차순)]
													select 문장의 마지막에 작성
order by : 정렬관련 구문
	오름차순정렬: 작은 값부터 큰값으로 asc 에약어.기본값.생략가능
	내림차순정렬: 큰값에서 작은값으로 desc 예약어. 생략불가
*/
-- 1학년: 키 오름차순
SELECT NAME,height FROM student WHERE grade = 1 ORDER BY height;
-- 2: 컬럼 순서 2번째
SELECT NAME,height FROM student WHERE grade = 1 ORDER BY 2;
-- 정렬기준: 컬럼명(오룸차순)
SELECT NAME 이름,height 키  FROM student WHERE grade = 1 ORDER BY 키;
-- 정렬기준: 컬럼명(내림차순)
SELECT NAME 이름,height 키  FROM student WHERE grade = 4 ORDER BY 키 DESC;
-- 학년,키 내림차순 정렬
SELECT NAME 이름,grade 학년,height 키 FROM student WHERE grade ORDER BY 학년,키 DESC; 
-- 학과코드순 + 예상급여의 역순
SELECT NO,NAME,deptno,salary,salary*1.1 예상급여 FROM professor ORDER BY deptno,예상급여 DESC; 
-- 지도교수x + 학과코드 순
SELECT studno,NAME,profno,major1 FROM student WHERE profno IS NULL ORDER BY studno;
-- 컬럼의 순서, 별명으로 정렬시 반드시 해당 컬럼이 조회되어야한다.
-- 컬럼명으로 정렬시 조회된 컬럼이 아니어도 가능함
SELECT NAME FROM student WHERE grade = 1 ORDER BY 1 DESC;
-- 1학년+키 작은순, 몸무게 큰순
SELECT NAME,height,weight FROM student WHERE grade = 1 ORDER BY height,weight DESC;

-- 합집합 중복가능(union all)
SELECT studno,NAME,major1 FROM student WHERE major1 = 202 
UNION ALL SELECT studno,NAME,major1 FROM student WHERE major2 = 101;
-- 합집합 중복제거 (union)
SELECT studno,NAME,major1 FROM student WHERE major1 = 202 
UNION SELECT studno,NAME,major1 FROM student WHERE major2 = 101;

SELECT NO,NAME,salary,salary*1.05 인상예정급여 FROM professor WHERE salary >= 450  UNION ALL
SELECT NO,NAME,salary,salary*1.1 인상예정급여 FROM professor WHERE salary < 450 ORDER BY 인상예정급여 DESC;