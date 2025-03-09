-- 1. 학생의 이름과 지도교수번호 조회하기
--    지도교수가 없는 경우 지도교수배정안됨 출력하기
SELECT NAME,profno, IFNULL(profno,"지도교수 배정안됨") FROM student; 

-- 2. major 테이블에서 코드, 코드명, build 조회하기
--    build 값이 없는 경우 '단독 건물 없음' 출력하기
SELECT CODE,NAME,build, IFNULL(build,"단독 건물 없음") FROM major;

-- 3. 학생의 이름, 전화번호, 지역명 조회하기
--    지역명 : 지역번호가 02 : 서울, 031:경기, 032:인천 그외 기타지역
SELECT NAME AS 이름,tel AS "전화번호",
	case  SUBSTR(tel,1,INSTR(tel,')')-1)
	when '02' then "서울" 
	when '031' then "경기" 
	when '032' then "인천" 
	ELSE "그외 기타지역" END AS "지역명"
FROM student;

SELECT NAME AS 이름,tel AS "전화번호", 
if(SUBSTR(tel,1,INSTR(tel,')')-1) = '02','서울',
if(SUBSTR(tel,1,INSTR(tel,')')-1) = '031','경기',
if(SUBSTR(tel,1,INSTR(tel,')')-1) = '032','인천', "그외 기타지역" ))) AS '지역명'
FROM student;

-- 4. 학생의 이름, 전화번호, 지역명 조회하기
--    지역명 : 지역번호가 02,031,032: 수도권, 그외 기타지역 
SELECT NAME AS "이름",tel AS "전화번호",
	case  when SUBSTR(tel,1,INSTR(tel,')')-1) IN (02,031,032) then "수도권"
			ELSE "그외 기타지역" END AS "지역명"
FROM student;

SELECT NAME AS "이름",tel AS "전화번호",
	if(LEFT(tel, INSTR(tel, ')')-1) IN('02','031','032'), '수도권','그외기타지역')
FROM student;

-- 5. 학생을 3개 팀으로 분류하기 위해 학번을 3으로 나누어 
--    나머지가 0이면 'A팀', 
--    1이면 'B팀', 
--    2이면 'C팀'으로 
--    분류하여 학생번호, 이름, 학과번호, 팀 이름을 출력하여라
SELECT studno,NAME,major1,
	case (studno % 3) when 0 then "A팀"
							when 1 then "B팀"
							when 2 then "C팀"
							ELSE "오류" END AS "학과번호"
FROM student;     
      
-- 6. score 테이블에서 학번, 국어,영어,수학, 학점, 인정여부 을 출력하기
--    학점은 세과목 평균이 95이상이면 A+,90 이상 A0
--                         85이상이면 B+,80 이상 B0
--                         75이상이면 C+,70 이상 C0
--                         65이상이면 D+,60 이상 D0
--    인정여부는 평균이 60이상이면 PASS로 미만이면 FAIL로 출력한다.                   
--    으로 출력한다.
SELECT *, if(ROUND((kor+eng+math)/3,0) >= 60, "PASS","FAIL") AS "인정여부",
	case  when ROUND((kor+eng+math)/3,0) >= 95 then "A+"
			when ROUND((kor+eng+math)/3,0) >= 94 then "A0"
			when ROUND((kor+eng+math)/3,0) >= 85 then "B+"
			when ROUND((kor+eng+math)/3,0) >= 80 then "B0"
			when ROUND((kor+eng+math)/3,0) >= 75 then "C+"
			when ROUND((kor+eng+math)/3,0) >= 70 then "C0"
			when ROUND((kor+eng+math)/3,0) >= 65 then "D+"
			when ROUND((kor+eng+math)/3,0) >= 60 then "D0"
			ELSE "F" END AS "학점"
FROM score;    

-- 7. 학생 테이블에서 이름, 키, 키의 범위에 따라 A, B, C ,D그룹을 출력하기
--    160 미만 : A그룹
--    160 ~ 169까지 : B그룹
--    170 ~ 179까지 : C그룹
--    180이상       : D그룹
SELECT NAME,height,
	case  when height >= 180 then "D그룹" 
			when height >= 170 then "C그룹" 
			when height >= 160 then "B그룹"
			ELSE "A그룹" END AS "키의 범위"
FROM student;

-- 8. 교수테이블에서 교수의 급여액수를 기준으로 200이하는 4급, 201~300 : 3급, 301~400:2급
--    401 이상은 1급으로 표시한다. 교수의 이름, 급여, 등급을 출력하기
--    단 등급의 오름차순으로 정렬하기
SELECT NAME,salary,
	case  when salary >= 410 then "1급"
			when salary >= 301 then "2급"
			when salary >= 201 then "3급"			
			ELSE "4급" END AS "등급"
FROM professor
ORDER BY "등급";

-- 9. 학생의 학년별 키와 몸무게 평균 출력하기.
--    학년별로 정렬하기. 
--    평균은 소숫점2자리 반올림하여 출력하기
SELECT grade AS "학년", ROUND(AVG(height),2) AS "키 평균", ROUND(AVG(weight),2) AS "몸무게 평균" FROM student
GROUP BY grade
ORDER BY grade;

-- 10. 평균키가 170이상인  전공1학과의 
--     가장 키가 큰키와, 가장 작은키, 키의 평균을 구하기 
SELECT major1 AS "전공1학과", MAX(height) AS "가장 키가 큰키", MIN(height) AS "가장 작은 키", AVG(height) AS "키의 평균" FROM student
GROUP BY major1
HAVING AVG(height) >= 170;  

-- 11. 사원의 직급(job)별로 평균 급여를 출력하고, 
--     평균 급여가 1000이상이면 '우수', 작으면 '보통'을 출력하여라
SELECT job AS "직급", ROUND(AVG(salary),0) AS "평균 급여", if(ROUND(AVG(salary),0) >= 1000, "우수","보통") AS "등급" FROM emp
GROUP BY job;  

-- 12. 학과별로 학생의 평균 몸무게와 학생수를 출력하되 
--     평균 몸무게의 내림차순으로 정렬하여 출력하기
SELECT major1 AS "학과", ROUND(AVG(weight),0) AS "평균 몸무게", COUNT(*) AS "학생수"  FROM student 
GROUP BY major1
ORDER BY ROUND(AVG(weight),0) DESC;

-- 13. 학과별 교수의 수가 2명 이하인 학과번호, 인원수를 출력하기
SELECT deptno, COUNT(*)
FROM professor 
GROUP BY deptno
HAVING COUNT(*) <= 2;

-- 14. 전화번호의 지역번호가 02서울 031 경기, 051 부산, 052 경남, 나머지 그외지역
--     학생의 인원수를 조회하기
SELECT 
	case LEFT(tel,INSTR(tel,')')-1) when '02' then '서울'
	when '031' then '경기'
	when '051' then '부산'
	when '052' then '경남'
	ELSE '그외지역' END AS 지역번호
	,COUNT(*)
FROM student
GROUP BY 지역번호;

-- 15. 전화번호의 지역번호가 02서울 031 경기, 051 부산, 052 경남, 나머지 그외지역
--     학생의 인원수를 조회하기. 가로출력
SELECT CONCAT(COUNT(*)+"", "명") AS '총합',
	SUM(if(LEFT(tel,INSTR(tel,')')-1) = '02',1,0)) AS '서울',
	SUM(if(LEFT(tel,INSTR(tel,')')-1) = '031',1,0)) AS '경기',
	SUM(if(LEFT(tel,INSTR(tel,')')-1) = '051',1,0)) AS '부산',
	SUM(if(LEFT(tel,INSTR(tel,')')-1) = '052',1,0)) AS '경남',
	SUM(if(LEFT(tel,INSTR(tel,')')-1) not IN ('02','031','051','052'),1,0)) AS '그외지역'
FROM student;

-- 16. 교수들의 번호,이름,급여,보너스, 총급여(급여+보너스)
--     급여많은순위,보너스많은순위,총급여많은 순위 조회하기
--     총급여순위로 정렬하여 출력하기. 보너스없는 경우 0으로 함
SELECT NO 번호,NAME 이름,salary 급여,IFNULL(bonus,0) 보너스,salary+IFNULL(bonus,0) 총급여, 
RANK() OVER(ORDER BY salary DESC) 급여많은순위, 
RANK() OVER(ORDER BY IFNULL(bonus,0) DESC) 보너스많은순위,
RANK() OVER(ORDER BY salary+IFNULL(bonus,0) DESC) 총급여많은순위
FROM professor
ORDER BY salary+IFNULL(bonus,0) DESC;

-- 17. 교수의 직급,직급별 인원수,급여합계,보너스합계,급여평균,보너스평균 출력하기
--     단 보너스가 없는 교수도 평균에 포함되도록 한다.
--     급여평균이 높은순으로 정렬하기
SELECT POSITION, COUNT(*) 인원수, SUM(salary) 급여합계, SUM(ifnull(bonus,0)) 보너스합계, ROUND(AVG(salary)) 급여평균, ROUND(AVG(ifnull(bonus,0))) 보너스평균
FROM professor
GROUP BY POSITION
ORDER BY ROUND(AVG(salary)) DESC;

-- 18. 1학년 학생의 인원수,키와 몸무게의 평균 출력하기
SELECT COUNT(*) 인원수, ROUND(AVG(height)) 키평균, ROUND(AVG(weight)) 몸무게평균
FROM student
WHERE grade = '1';

-- 19. 학생의 점수테이블(score)에서 수학 평균,수학표준편차,수학분산 조회하기
SELECT AVG(math), STDDEV(math), VARIANCE(math) 
FROM score 
-- 20. 교수의 월별 입사 인원수를 출력하기
SELECT CONCAT(MONTH(hiredate), "월") 월별, COUNT(*) 인원수
FROM professor
GROUP BY MONTH(hiredate);

SELECT CONCAT(COUNT(*)+"", "명") 전체,
SUM(if(MONTH(hiredate) = 1,1,0)) '1월',
SUM(if(MONTH(hiredate) = 2,1,0)) '2월',
SUM(if(MONTH(hiredate) = 3,1,0)) '3월',
SUM(if(MONTH(hiredate) = 4,1,0)) '4월',
SUM(if(MONTH(hiredate) = 5,1,0)) '5월',
SUM(if(MONTH(hiredate) = 6,1,0)) '6월',
SUM(if(MONTH(hiredate) = 7,1,0)) '7월',
SUM(if(MONTH(hiredate) = 8,1,0)) '8월',
SUM(if(MONTH(hiredate) = 9,1,0)) '9월',
SUM(if(MONTH(hiredate) = 10,1,0)) '10월',
SUM(if(MONTH(hiredate) = 11,1,0)) '11월',
SUM(if(MONTH(hiredate) = 12,1,0)) '12월'
FROM professor;
/*
단일행 함수
	기타함수
	- ifnull(칼럼, 기본값) :컬럼의 값이 null인 경우 기본값으로 치환
									오라클 : nvl(칼럼,기본값)
	- 조건함수 : if, case
		if(조건문,참,거짓) : 중첩가능
									오라클 : decode(조건문,참,거짓)
		case 컬럼명 when 값 then 출려값...
			[else 값] end
		case when 조건문 then 출력값...
			[else 값] end
			
	그룹함수:여러개의 레코드에서 정보 얻어 리턴
		건수 :count(*) => 조회된 레코드의 건수
				count(컬럼명) => 컬럼의 값이 null이 아닌 레코드의 건수
		합계 :sum(컬럼명)
		평균 :avg(컬럼명) => 컬럼의 값이 null이 아닌 경우만 평균의 대상이됨.
									avg(ifnull(bonus,0)) 함수 이용 전체 평균으로 처리
		가장큰값, 작은값 :max(컬럼).min(컬럼)
		표춘편차,분산 :stddev(컬럼),variance(컬럼명)		
		
	순위,누계 지정함수
		- rank() over(정렬방식)
		- sum(컬럼) over(정렬방식)
		
	group by	:	그룹 함수 사용시, 그룹화 되는 기준의 컬럼.
					group by에서 사용된 컬럼을 select 구문에서 조회해야함.
	having 조건문 : 그룹함수의 조건문 
	
	rollup : 부분함수
	
	select 구문 구조
	select 컬럼명 || * || 상수값 || 연산 || 단일행함수
	from 테이블명
	where 조건문 => 레코드의 선택
	group by => 그룹화의 기준이 되는 컬럼
	having 조건문 => 그룹함수 조건문
	order by 컬럼명 || 별명 || 조회되는 컬럼의 순서
*/