/*
Join : 여러개의 테이블에서 조회
*/
-- cross join : 두개 테이블을 조인. m*n개의 레코드가 생성됨, 사용시 주의 요망
SELECT * FROM emp  -- 14r 9c
SELECT * FROM dept -- 5r, 3c
-- mariadb 방식
SELECT * FROM emp, dept -- 14*5 = 70r / 9+3= 12c
-- ansi 방식
SELECT * FROM emp CROSS JOIN dept -- 14*5 = 70r / 9+3= 12c
-- 사원번호(emp.empno), 사원명(emp.ename), 직책(emp.job), 부서코드(emp.deptno),부서명(dept.dname) cross join 하기
-- 중복된 컬럼은 테이블명을 표시해야함
-- 중복된 컬럼은 테이블병 표시하지 않아도됨.
SELECT empno,ename,job,emp.deptno,dname FROM emp,dept;
SELECT empno,ename,job,e.deptno,dname FROM emp e,dept d; -- 테이블명에 별명 설정
SELECT e.empno,e.ename,e.job,e.deptno,d.deptno,d.dname FROM emp e,dept d; -- 테이블명에 별명 설정

/*
등가조인 : equi join
	조인컬럼을 이용해서 필요한 레코드만 조회.
	조인컬럼의 조건을 = 인 경우
*/
-- 사원번호,사원명,직책,부서코드,부서명 조회하기
-- mariadb 방식
SELECT e.empno, e.ename, e.job, e.deptno, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno -- 조인 컬럼
-- ansi 방식
SELECT e.empno, e.ename, e.job, e.deptno, d.deptno, d.dname
FROM emp e join dept d
on e.deptno = d.deptno  -- 조인컬럼
-- 학생 테이블과 학과(amjor) 테이블을 사용하여, 학생이름, 전공학과번호,전공학과 이름 조회
DESC student 
DESC major
-- mariadb 방식
SELECT s.name, s.major1, m.name
FROM student s, major m
WHERE s.major1 = m.code
-- ansi 방식
SELECT s.name, s.major1, m.name
FROM student s join major m
on s.major1 = m.code

-- 학생의 이름과 지도교수번호, 지도교수 이름 출력
-- mariadb 방식
SELECT s.name AS 학생, s.major1 AS 지도교수번호, p.name AS 지도교수
FROM student s, professor p
WHERE s.profno = p.no
-- ansi 방식
SELECT s.name AS 학생, s.major1 AS 지도교수번호, p.name AS 지도교수
FROM student s join professor p
on s.profno = p.no

-- 학생 테이블, 학번,이름,score 테이블, 학번에 해당하는 국어,수학,영어,총점 조회
-- 총점이 많은 순
-- mariadb 방식
SELECT s.studno,s.name, e.kor, e.eng, e.math, (kor+eng+math) AS 총점
FROM student s, score e
WHERE s.studno = e.studno
ORDER BY 총점 DESC;
-- ansi 방식
SELECT s.studno,s.name, e.kor, e.eng, e.math, (kor+eng+math) AS 총점
FROM student s join score e
on s.studno = e.studno
ORDER BY 총점 DESC;

-- 학생의 이름, 학과이름, 지도교수
SELECT s.name,m.name,p.name AS 지도교수
FROM student s, major m, professor p 
WHERE s.major1 = m.code AND s.profno = p.no
-- ansi 방식
SELECT s.name,m.name,p.name AS 지도교수
FROM student s 
JOIN major m ON s.major1 = m.code 
JOIN professor p on s.profno = p.no

-- emp 테이블과 p_grade 테이블 조회, 사원이름,직급,현재연봉,해당직급의 연봉하한, 연봉상한 금액 출력
-- 현재 연봉 (급여*12+보너스) * 10000
SELECT * FROM p_grade
-- mariadb 방식
SELECT e.ename,e.job AS 직급, (salary * 12 + IFNULL(bonus,0)) * 10000 AS 연봉, p.s_pay AS 연봉하한, p.e_pay AS 연봉상한
FROM emp e, p_grade p WHERE e.job = p.position;
-- ansi 방식
SELECT e.ename,e.job AS 직급, (salary * 12 + IFNULL(bonus,0)) * 10000 AS 연봉, p.s_pay AS 연봉하한, p.e_pay AS 연봉상한
FROM emp e join p_grade p 
on e.job = p.position;

-- 장성태 학생의 학번,이름,전공1학과번호,전공1학과이름,학과위치
SELECT s.studno "학번", s.`name` AS "이름", s.major1 AS "전공1학과번호", m.`name` AS "전공1학과이름", m.build AS 학과위치
FROM student s, major m
WHERE s.major1 = m.code AND s.name = "장성태"
-- ansi 방식
SELECT s.studno "학번", s.`name` AS "이름", s.major1 AS "전공1학과번호", m.`name` AS "전공1학과이름", m.build AS 학과위치
FROM student s JOIN major m
ON s.major1 = m.code where s.name = "장성태"

-- 몸무게 80키로 이상인 학생의학번,이름,체중,학과이름,학과위치 출력
SELECT s.studno, s.`name`, s.weight, m.`name`, m.build
FROM student s, major m
WHERE s.major1 = m.code AND s.weight >= 80; 
-- ansi 방식
SELECT s.studno, s.`name`, s.weight, m.`name`, m.build
FROM student s join major m
on s.major1 = m.code WHERE s.weight >= 80; 

-- 학생의 학번,이름,score 테이블에서 학번에 해당하는 점수조회
-- 1학년 학생의 정보 조회
SELECT s.studno, s.`name`, s2.*
FROM student s, score s2
WHERE s.studno = s2.studno AND grade = 1;
-- ansi 방식
SELECT s.studno, s.`name`, s2.*
FROM student s join score s2
ON s.studno = s2.studno where grade = 1;

/*
비등가 조인 : non equi join
	조인컬럼의 조건이 = 이 아닌 경우. 범위값으로 조인함	
*/
SELECT * FROM guest -- 고객 테이블
SELECT * FROM pointitem -- 상품 테이블
-- 고객명과 고객 포인트, 포인트로 받을 수 있는 상품명 조회
SELECT g.name, g.point, p.name
FROM guest g, pointitem p
WHERE g.point BETWEEN p.spoint AND p.epoint
-- ansi 방식
SELECT g.name, g.point, p.name
FROM guest g join pointitem p
on g.point BETWEEN p.spoint AND p.epoint;

-- 고객은 자기 포인트 보다 낮은 포인트의 상품을  선택 할수있다. (가정)
-- 외장 하드를 선택할수있는 고객의 이름.포인트,포인트로 받을수있는 상품명,시작포인트,종료상품명
SELECT g.`name`, g.`point`, p.`name`, p.spoint, p.epoint
FROM guest g, pointitem p
WHERE g.`point` >=  p.spoint AND p.name = "외장하드"
-- ansi 방식
SELECT g.`name`, g.`point`, p.`name`, p.spoint, p.epoint
FROM guest g join pointitem p
on g.`point` >=  p.spoint where p.name = "외장하드"

-- 낮은 포인트의 상품을 선택할 수 있다고 할때, 개인별로 가져갈수 있는 상품의 갯수 조회
-- 상품의 갯수로 정렬
SELECT g.`name`,COUNT(*) "상품의 갯수"
FROM guest g, pointitem p
WHERE g.`point` >=  p.spoint
GROUP BY NAME
ORDER BY COUNT(*) DESC, g.`name`
-- ansi 방식
SELECT g.`name`,COUNT(*) "상품의 갯수"
FROM guest g JOIN pointitem p
ON  g.`point` >=  p.spoint
GROUP BY NAME
ORDER BY COUNT(*) DESC, g.`name`;

-- 상품의 갯수가 2개의 이상인 정보 조회
SELECT g.`name`,COUNT(*) "상품의 갯수"
FROM guest g, pointitem p
WHERE g.`point` >=  p.spoint 
GROUP BY NAME
HAVING COUNT(*) >= 2
ORDER BY COUNT(*) DESC, g.`name`;

SELECT * FROM scorebase -- 등급
-- 학생의 학번,이름,국어,수학,영어,총점,평균,학점 츨력
-- 평균 : 반올림 정수
SELECT s.studno AS "학번", s.`name` AS "이름", s2.kor, s2.eng,s2.math, s2.kor+eng+math AS "총점", ROUND((s2.kor+eng+math)/3,0) AS "평균", s3.grade AS "등급"
FROM student s, score s2, scorebase s3
WHERE s.studno = s2.studno AND ROUND((s2.kor+eng+math)/3,0) BETWEEN s3.min_point AND s3.max_point
GROUP BY NAME
ORDER BY s3.grade;
-- ansi 방식
SELECT s.studno AS "학번", s.`name` AS "이름", s2.kor, s2.eng,s2.math, s2.kor+eng+math AS "총점", ROUND((s2.kor+eng+math)/3,0) AS "평균", s3.grade AS "등급"
FROM student s 
JOIN score s2 ON s.studno = s2.studno 
JOIN scorebase s3 ON ROUND((s2.kor+eng+math)/3,0) BETWEEN s3.min_point AND s3.max_point
GROUP BY NAME
ORDER BY s3.grade;

/*
self join : 같은 테이블의 다른컬럼들을 조인 컬럼으로 사용함
				반드시 테이블의 별명을 설정해야함
				반드시 모든 컬럼에 테이블의 별명을 설정해야함			
*/
SELECT * FROM emp
-- mgr : 상사의 사원번호(empno)
-- 사원 테이블에서 사원번호,이름,상사의 사원번호, 상사의 이름조회
SELECT e1.empno, e1.ename, e2.empno, e2.ename
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno;

SELECT e1.empno, e1.ename, e2.empno, e2.ename
FROM emp e1 join emp e2 
on e1.mgr = e2.empno;

SELECT * FROM major;
-- code : 전공학과 코드
-- part : 상위학부 코드
-- major 테이블에서 학과코드,학과명,상위학과코드,상위학과명 조회
SELECT m1.code, m1.`name`,m1.part,m2.`name`
FROM major m1, major m2
WHERE m1.part = m2.code

-- 교수번호,이름,입사일,입사일이 빠른 사람을 조회
-- 입사일 빠른 순
SELECT p1.no,  p1.`name`,p1.hiredate, p2.no,p2.`name`,p2.hiredate
FROM professor p1, professor p2
WHERE p1.hiredate > p2.hiredate
ORDER BY p1.name

-- 교수번호,이름,입사일,입사일이 빠른 사람의 인원수
-- 입사일 빠른 순
SELECT p1.no, p1.`name`,p1.hiredate, COUNT(*)
FROM professor p1, professor p2
WHERE p1.hiredate > p2.hiredate
GROUP BY p1.no
ORDER BY p1.hiredate

-- 교수번호,이름,입사일,입사일이 같은 사람의 인원수 조회
SELECT p1.no, p1.`name`,p1.hiredate, COUNT(*)
FROM professor p1, professor p2
WHERE p1.hiredate = p2.hiredate
GROUP BY p1.no
ORDER BY p1.hiredate

/*
inner join : 조인컬럼의 조건과 맞는 레코드만 조회
- equi join
- non equi join
- self join
*/
SELECT * FROM major -- 11r

SELECT m1.code, m1.`name`,m1.part,m2.`name` -- 9r
FROM major m1, major m2
WHERE m1.part = m2.code

/*
outer join : 조인컬럼의 조건이 맞지 않아도, 한쪽, 양쪽 레코드 조회
	left outer join : 왼쪽 테이블의 모든 레코드 조회 
	right outer join : 오른쪽 테이블의 모든 레코드 조회 
	full outer join : 양쪽 테이블의 모든 레코드 조회. union 방식으로 구현 
*/
-- 학생의 이름과 지도교수 이름 출력
SELECT s.name,p.`name` AS 지도교수 -- inner join 15r
FROM student s, professor p
WHERE s.profno = p.no

-- 학생의 학번,이름,지도교수이름 조회
-- 지도교수가 없는 학생도 조회
SELECT s.name,p.`name` AS 지도교수 -- left outer join 20r(null 값 포함출력)
FROM student s LEFT OUTER join professor p
ON s.profno = p.no

-- 학생의 학번,이름,지도교수이름 조회
-- 지도교수가 없는 학생까지 조회, 없을시: 지도교수 없음 출력
SELECT s.studno,s.`name`,ifnull(p.`name`, "지도교수 없음")
FROM student s LEFT OUTER JOIN professor p -- outer 생략가능
ON s.profno = p.no 

-- 학생의 학번,이름,지도교수이름 조회
-- 지도학생이 없는 교수도 조회
-- 지도학생이 없을시 : 지도학생 없음 내용출력
SELECT s.studno, IFNULL(s.`name`, "지도학생 없음"), p.`name`
FROM student s RIGHT OUTER JOIN professor p -- outer 생략가능
ON s.profno = p.no  

-- 오라클 구현 방식
---- left outer join
SELECT s.studno, IFNULL(s.`name`, "지도학생 없음"), p.`name`
FROM student s, professor p
where s.profno = p.no(+)  -- 왼쪽의 테이블의 모든조회
---- right outer join
SELECT s.studno, IFNULL(s.`name`, "지도학생 없음"), p.`name`
FROM student s, professor p
where s.profno(+) = p.no  -- 오른쪽의 테이블의 모든조회

-- full outer join : union으로 구현
-- 학생의 이름,지도교수 이름 조회
-- 지도교수가 없는 학생 정보 + 지도학생이 없는 교수 정보 조회
SELECT s.name, p.name
FROM student s FULL OUTER JOIN professor p -- => 오류발생
ON s.profno = p.no

SELECT s.name, p.name
FROM student s LEFT JOIN professor p
ON s.profno = p.no
UNION 
SELECT s.name, p.name
FROM student s RIGHT JOIN professor p
ON s.profno = p.no

-- 문제1
--  emp, p_grade 테이블을 조인하여
-- 사원이름, 직급, 현재연봉, 해당직급의 연봉하한,연봉상한 조회하기
-- 연봉 : (급여*12+보너스)*10000. 보너스가 없는 경우 0으로 처리하기
-- 단 모든 사원을 출력하기
SELECT e.ename, e.job, (salary *12 + ifnull(bonus,0))*1000, p.s_pay, p.e_pay
FROM emp e LEFT JOIN p_grade p
on e.job = p.position
ORDER BY e.empno

-- 문제 2
-- emp, p_grade 테이블을 조인하여
-- 사원이름, 입사일,직급, 근속년도, 현재직급,근속년도 기준 예상직급 출력하기
-- 근속년도는 오늘을 기준으로 입사일의 일자/365 나눈후 
-- 소숫점이하는 버림으로
-- 단 모든 사원을 출력하기
SELECT * FROM p_grade
SELECT e.ename, e.hiredate, e.job, TRUNCATE(DATEDIFF(NOW(),e.hiredate)/365,0) 근속년수, p.`position`
FROM emp e LEFT JOIN p_grade p
ON TRUNCATE(DATEDIFF(NOW(),e.hiredate)/365,0) BETWEEN p.s_year AND p.e_year

-- 문제 3
-- 사원이름, 생일,나이, 현재직product급,나이 기준 예상직급 출력하기
-- 나이는 오늘을 기준으로 생일까지의 일자/365 나눈후 소숫점이하는 버림
-- 단 모든 사원을 출력하기
SELECT e.ename, e.birthday, TRUNCATE(DATEDIFF(NOW(),e.birthday)/365,0) 나이, e.job, p.`position`
FROM emp e LEFT JOIN p_grade p
ON TRUNCATE(DATEDIFF(NOW(),e.birthday)/365,0) BETWEEN p.s_age AND p.e_age