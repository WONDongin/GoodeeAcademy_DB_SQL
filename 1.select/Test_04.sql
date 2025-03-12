-- 1. 지도 교수가 지도하는 학생의 인원수를 출력하기.
SELECT p.`name` AS "교수이름", COUNT(*) AS "학생의 인원수"
FROM professor p, student s
WHERE p.no = s.profno
GROUP BY p.`name`;

-- 2. 지도 교수가 지도하는  학생의 인원수가 2명이상인 지도교수 이름를 출력하기.
SELECT p.`name` AS "교수이름", COUNT(*) AS "학생의 인원수"
FROM professor p, student s
WHERE p.no = s.profno
GROUP BY p.`name`
HAVING  COUNT(*) >= 2;

-- 3. 지도 교수가 지도하는  학생의 인원수가 2명이상인 
-- 	지도교수 번호,이름,학과코드,학과명 출력하기.
SELECT p.no, p.`name` AS "교수이름", m.code AS "학과코드", m.`name` AS "학과명",COUNT(s.name) AS "학생의 인원수"
FROM professor p, student s, major m
WHERE p.no = s.profno AND p.deptno = m.code
GROUP BY p.`name`
HAVING COUNT(s.name) >= 2;

-- 4. 학생의 이름과 지도교수 이름 조회하기. 
--    지도 교수가 없는 학생과 지도 학생이  없는 교수도 조회하기
--    단 지도교수가 없는 학생의 지도교수는  '0000' 으로 출력하고
--    지도 학생이 없는 교수의 지도학생은 '****' 로 출력하기
SELECT s.`name` AS "학생 이름", IFNULL(p.`name`, '0000') AS "교수 이름"
FROM student s LEFT JOIN professor p
ON s.profno = p.no
GROUP BY s.`name`
UNION ALL 
SELECT IFNULL(s.`name`,'****') AS "학생 이름", p.`name` AS "교수 이름"
FROM student s RIGHT JOIN professor p
ON p.no = s.profno
GROUP BY p.`name`;

-- 5. 지도 교수가 지도하는 학생의 인원수를 출력하기.
--    단 지도학생이 없는 교수의 인원수 0으로 출력하기
--    지도교수번호, 지도교수이름, 지도학생인원수를 출력하기
SELECT p.no,p.`name`, COUNT(s.name)
FROM professor p LEFT JOIN student s
ON p.no = s.profno
GROUP BY p.no;

-- 6.교수 중 지도학생이 없는 교수의 번호,이름, 학과번호, 학과명 출력하기
SELECT p.no,p.name,p.deptno, m.name
FROM professor p LEFT 
JOIN student s ON p.no = s.profno
JOIN major m ON  m.code = p.deptno
GROUP BY p.no
HAVING COUNT(s.name) = 0;

-- 7. emp 테이블에서 사원번호, 사원명,직급,  상사이름, 상사직급 출력하기
--   	모든 사원이 출력되어야 한다.
--    상사가 없는 사원은 상사이름을 '상사없음'으로  출력하기
SELECT e1.empno,e1.ename,e1.job, IFNULL(e2.ename, '상사없음'), IFNULL(e2.job,'직급없음')
FROM emp e1 LEFT JOIN emp e2
ON e1.mgr = e2.empno;

-- 8. 교수 테이블에서 송승환교수보다 나중에 입사한 
-- 	교수의 이름, 입사일,학과코드,학과명을 출력하기 
SELECT p1.`name`,p1.hiredate,p1.deptno
FROM professor p1, professor p2, major m
WHERE p2.`name` = "송승환" AND p1.hiredate > p2.hiredate
GROUP BY p1.`name`;

-- 9. 학생 중 2학년 학생의 최대 체중보다 
-- 	체중이 큰 1학년 학생의 이름, 몸무게, 키를 출력하기
SELECT s1.`name`,s1.weight, s1.height
FROM student s1, student s2
WHERE s1.grade = 1 AND s2.grade = 2
GROUP BY s1.`name`
HAVING s1.weight > MAX(s2.weight);

-- 10.학생테이블에서 전공학과가 101번인 학과의 평균몸무게보다
--   	몸무게가 많은 학생들의 이름과 몸무게, 학과명 출력
SELECT s.`name`,s.weight, m.name
FROM student s, major m 
WHERE s.major1 = m.code AND s.major1 = 101
GROUP BY s.`name`;

-- 11.이상미 교수와 같은 입사일에 입사한 교수 중 이영택교수 보다 
--    월급을 적게받는 교수의 이름, 급여, 입사일 출력하기
SELECT p1.`name`, p1.salary, p1.hiredate
FROM professor p1, professor p2, professor p3
WHERE p2.`name` = "이상미" AND p3.`name`= "이영택" AND p1.hiredate = p2.hiredate AND p1.salary < p3.salary
GROUP BY p1.`name`;

-- 12.101번 학과 학생들의 평균 몸무게 보다  
--  	몸무게가 적은 학생의 학번과,이름과, 학과번호, 몸무게를 출력하기
SELECT s1.studno AS 학번, s1.`name` AS 이름, s1.major1 AS 전공학과, s1.weight AS 몸무게
FROM student s1, student s2
WHERE s2.major1 = '101' 
GROUP BY s1.studno
HAVING s1.weight < AVG(s2.weight);

-- 13. score 테이블과, scorebase 테이블을 이용하여 학점별 인원수,학점별평균값의 평균  조회하기
SELECT s2.grade, COUNT(*) 인원수, ROUND(AVG(ROUND((s1.kor+eng+math)/3,0)),0) 평균 
FROM score s1, scorebase s2
WHERE ROUND((s1.kor+eng+math)/3,0) BETWEEN s2.min_point AND s2.max_point
GROUP BY s2.grade;

-- 14. 고객의 포인트로 상품을 받을 수 있을때 필요한 상품의 갯수를 조회하기
SELECT g.`name` 이름, g.`point` 포인트, COUNT(*) 상품의갯수
FROM guest g, pointitem p
WHERE g.`point` >= p.spoint
GROUP BY g.name;

SELECT g.`name` 이름, g.`point` 포인트, COUNT(*) 상품의갯수
FROM guest g JOIN pointitem p
ON g.`point` >= p.spoint GROUP BY g.name;

-- 15. 교수번호,이름,입사일, 입사일이 늦은 사람의 인원수 조회하기
--  	 입사일이 늦은 순으로 정렬하여 출력하기
SELECT p1.no, p1.`name`, p1.hiredate, COUNT(p2.hiredate)
FROM professor p1 LEFT JOIN professor p2
ON p1.hiredate < p2.hiredate
GROUP BY p1.no
ORDER BY p1.hiredate DESC;

-- 16. major 테이블에서 학과코드, 학과명, 상위학과코드, 상위학과명 조회하기
-- 	 모든 학과가 조회됨. => 상위학과가 없는 학과도 조회됨.
SELECT m1.code,m1.`name`,m2.code,m2.`name`
FROM major m1 LEFT JOIN major m2
ON  m1.part = m2.code
GROUP BY m1.code;

/*
join 구문 :여러개의 테이블을 연결하여 데이터 조회
	cross join :m*n 개수로 레코드 생성. 사용시 주의요함
	등가조인(enqi join) :조인컬럼을 이용하여 조건에 맞는 레코드만 선택.
								조인 컬럼의 조건문이 = 인 경우
	비등가조인(non enqi join) :조인컬럼을 이용하여 조건에 맞는 레코드만 선택.
										조인컬럼의 조건문이 = 이 아닌 경우
	self join(자기조인) :같은 테이블을 join 하는 경우
								테이블의 별명설정, 컬럼조회시 별명 설정
								
	inner join :조인컬럼을 이용하여 조건에 맞는 레코드만 선택.
	
	outer join :조인컬럼을 이용하여 조건에 맞는 레코드만 선택. 
					한쪽 또는 양쪽 테이블에서 조건이 맞지 않아도 선택
		left outer join	:왼쪽 테이블의 내용은 전부 조회
								left join 예약어
								
		right outer join	:오른쪽 테이블의 내용은 전부 조회
								right join 예약어
		full outer join	:왼/오른쪽 테이블의 내용은 전부 조회
	 							union 사용하여 구현
*/