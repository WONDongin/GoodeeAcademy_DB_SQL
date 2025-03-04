-- 1. emp 테이블에서 empno는 사원번호로, ename 사원명, job는 직급으로 별칭을 설정하여 조회하기 
SELECT empno 사원번호,ename 사원명,job 직급 FROM emp;
-- 2. dept 테이블에서 deptno 부서#, dname 부서명, loc 부서위치로 별칭을 설정하여 조회하기
SELECT deptno '부서#',dname 부서명,loc 부서위치 FROM dept;
-- 3. 학생들을 지도하는 지도교수번호(profno) 조회하기
SELECT profno FROM student WHERE profno IS NOT null;
/*
4. 학생테이블에서 name, birthday,height,weight 컬럼을 조회하기 
     단 name은 이름, birthday는 생년월일 ,height 키(cm),weight 몸무게(kg) 으로 변경하여 조회하기 
*/ 
SELECT NAME 이름,birthday 생년월일,height '키(cm)',weight '몸무게(kg)' FROM student;     
-- 5.  emp 테이블에서 급여가 800보다 큰사람의 이름, 급여(salary), 부서코드(deptno) 조회하기
SELECT ename,salary,deptno FROM emp WHERE salary > 800;
-- 6.  professor 테이블에서 직급(position)이 정교수인 교수의 이름(name),부서코드(deptno),직급(position) 조회하기 
SELECT NAME,deptno,POSITION FROM professor WHERE POSITION = '정교수';       
-- 7. 전공1이 101번,201 학과의 학생 중 몸무게가 50이상 80이하인 학생의 이름(name), 몸무게(weight), 학과코드(major1)를 조회하기 
SELECT NAME 이름,weight 몸무게,major1 학과코드 FROM student WHERE major1 IN (101,201) AND weight >= 50 AND weight <= 80;
-- 8. 사원의 급여가 700이상인 사원들만 급여를 5% 인상하기로 한다.    인상되는 사원의 이름, 현재급여, 예상인상급여, 부서코드 출력하기
SELECT ename 이름,salary 현재급여,salary*0.5+salary 예상인상급여,deptno 부서코드 FROM emp WHERE salary >= 700;
/*
9. 학생테이블에서 생일이 1998년 6월 30일 이후에 출생한 학생 중 
  1학년 학생인, 이름(name), 전공코드(major1), 생일(birthday), 학년(grade) 컬럼 조회하기
  날짜는 '2024-06-30' 로 표시 한다.
*/
SELECT NAME 이름,major1 전공코드,birthday 생일,grade 학년 FROM student WHERE birthday > '1998/06/30 00:00:00' AND grade = 1;
/*
10. 학생테이블에서 생일이 1998년 6월 30일 이후에 출생한 학생 이거나, 1학년 학생인 학생의
 이름(name), 전공코드(major1), 생일(birthday), 학년(grade) 컬럼 조회하기
 날짜 표시는 '1998-06-30' 한다.
*/ 
SELECT NAME, major1,birthday,grade FROM student WHERE birthday > '1998/06/30 00:00:00' OR grade = 1;
-- 11. 전공학과 101이거나 201인학과 학생 중 키가 170이상인    학생의 학번, 이름, 몸무게, 키, 학과코드  조회하기
SELECT studno 학번,NAME 이름,weight 몸무게,height 키,major1 학과코드 FROM student WHERE major1 IN (101,201) AND height >= 170; 
/*
12. 학생 테이블에 1학년 학생의 이름과 주민번호, 기준생일, 키와 몸무게를 출력하기. 
    단 생일이 빠른 순서대로 정렬
*/
SELECT NAME 이름,jumin 주민번호,birthday 생일,height 키,weight 몸무게 FROM student WHERE grade = 1 ORDER BY birthday; 
/*
13. 학생 중 전화번호가 서울지역이 아닌 학생의 학번, 이름, 학년, 전화번호를 출력하기  
    단 학년 순으로 정렬하기
*/
SELECT studno 학번,NAME 이름,grade 학년,tel 전화번호 FROM student WHERE tel NOT LIKE '02%' ORDER BY grade;
/*
14. 학생 테이블에서 id에 kim 이 있는 학생의 학번, 이름, 학년, id 를 출력하기.  
    단 kim은 대소문자를 구분한다.
*/
SELECT studno 학번,NAME 이름,grade 학년,id FROM student WHERE id LIKE BINARY '%kim%';
-- 15. 학생 중 이름의 끝자가 '훈'인 학생의 학번, 이름, 전공1코드 조회하기.  학년 순으로 정렬하기
SELECT studno 학번,NAME 이름,major1 전공1코드 FROM student WHERE NAME LIKE '%훈' ORDER BY grade;
-- 16. 교수 중 교수의 성이 ㅈ이 포함된 교수의 이름을 출력하기
SELECT NAME FROM professor WHERE POSITION LIKE '%교수' AND NAME BETWEEN '자%' AND '즈';