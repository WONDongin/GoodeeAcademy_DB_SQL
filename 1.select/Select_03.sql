/*
[기타함수]
ifnull(컬럼,기본값) : 컬럼의 값이 null 인 경우 기본값을 치환
*/
-- 교수의 이름,직급,급여,보너스,급여+보너스 컬럼조회
SELECT NAME,POSITION,salary,bonus,salary+bonus FROM professor WHERE bonus IS NOT NULL
UNION
SELECT NAME,POSITION,salary,bonus,salary FROM professor WHERE bonus IS NULL;
-- ifnull 사용
-- ifnull(bonus,0) : bonus 칼럼의 값이 null인경우 0으로 치환
SELECT NAME,POSITION,salary,bonus,salary+IFNULL(bonus,0) FROM professor;
-- ifnull(salary+bonus,salary) : salary+bonus의 결과가 null인 경우 salary를 기본값으로 치환
SELECT NAME,POSITION,salary,bonus,ifnull(salary+bonus,salary) FROM professor;
-- 교수의 이름,직책,급여,보너스 출력, 보너스 없는 경우: 보너스없음 출력하기
SELECT NAME,POSITION,salary,IFNULL(bonus,'보너스 없음') AS 보너스 FROM professor;
-- 학생의 이름과 지도교수의 번호 출력
SELECT NAME,ifnull(profno, '9999') AS '지도교수(9999:없음)' FROM student;

/*
[조건함수] : if, case
if 조건함수 : if(조건문,'참','거짓')
*/
-- 1학년 학생인 경우: 신입생, 아니면 재학생
SELECT NAME,grade,if(grade=1, '신입생','재학생') AS 신입생여부 FROM student;
-- 교수의 이름,학과번호,학과명 출력
-- 학과명: 학과번호가 101: 컴퓨터 공학, 나머지 그외학과 출력
SELECT NAME,deptno,if(deptno=101, '컴퓨터공학','그 외 학과') AS 학과명 FROM professor;
-- 학생의 이름, 주민번호 7번째 자리가 1,3: 남자, 2,4:여자
SELECT NAME,jumin,if(SUBSTR(jumin,7,1) = 1, "남자",
 						if(SUBSTR(jumin,7,1) = 2, "여자",
						if(SUBSTR(jumin,7,1) = 3, "남자", 
						if(SUBSTR(jumin,7,1) = 4, "여자", "주민번호오류")))) FROM student;
-- 학생의 이름, 주민번호 7번째 자리가 1,3: 남자, 2,4:여자 그외: 오류							 
SELECT NAME,jumin,if(SUBSTR(jumin,7,1) IN (1,3), "남자", 
						if(SUBSTR(jumin,7,1) IN (2,4), "여자", "주민번호오류")) FROM student;
-- case 문
SELECT NAME,jumin,
	case 	when SUBSTR(jumin,7,1) IN (1,3) then "남자"	
			when SUBSTR(jumin,7,1) IN (2,4) then "여자"
			ELSE "외계인" END AS "성별"
FROM student;	
								
-- 교수이름,학과번호,학과명 출력
-- 학과명: 101: 컴퓨터공학, 102:멀티미디어공학, 201:기계공학, 그외:그외학과
SELECT NAME AS 이름,deptno AS 학과번호,if(deptno = '101', "컴퓨터공학",
						                     if(deptno = '102', "멀티미디어공학",
						  							if(deptno = '201', "기계공학", "그외학과"))) AS 학과명 FROM professor;	

/*
case 조건문
	case 컬럼명 when 값1 then 문자열
					when 값2 then 문자열
					...
					else 문자열 end
					
	case 	when 조건문1 then 문자열
			when 조건문2 then 문자열
			...
			else 문자열 end;
*/
SELECT NAME AS 이름,deptno AS 학과번호,
	case deptno when '101' then "컴퓨터공학"
	ELSE "" END AS 학과명
	FROM professor;
-- case 구문
-- 학과명: 101: 컴퓨터공학, 102:멀티미디어공학, 201:기계공학, 그외:그외학과
SELECT NAME AS 이름,deptno AS 학과번호,
	case deptno when '101' then "컴퓨터공학"
					when '102' then "멀티미디어공학"
					when '201' then "기계공학"
					ELSE "그외학과명" END AS 학과명
FROM professor;

-- 교수이름,학과번호,대학명 출력
-- 대학명: 101,102,201: 공과대학, 그외 : 그외대학 출력
-- if 조건문
SELECT NAME AS 교수이름,deptno AS 학과번호,if(deptno IN ('101','102','201'), "공과대학", "그외대학") AS 대학명 FROM professor;
-- case 조건문-정상작동
SELECT NAME AS 교수이름,deptno AS 학과번호,
	case deptno when '101' then "공과대학"
					when '102' then "공과대학"
					when '201' then "공과대학"
					ELSE "그외대학" END AS 대학명
FROM professor; 
-- case 조건문-오류발생		
SELECT NAME AS 교수이름,deptno AS 학과번호,
	case deptno when '101','102','201' then "공과대학"
					ELSE "그외대학" END AS 대학명
FROM professor; 
--	case 	when 조건문1 then 문자열 방식
SELECT NAME AS 교수이름,deptno AS 학과번호,
	case  when deptno IN ('101','102','201') then "공과대학"
			ELSE "그외대학" END AS 대학명
FROM professor; 

-- 학생의 이름,주민번호,출생분기 출력
-- 출생분기: 주민번호기준 1 ~ 3: 1분기, 4~6: 2분기, 7~9: 3분기, 10~12: 4분기
SELECT NAME AS 이름,jumin AS 주민번호,
	case when SUBSTR(jumin,3,2) BETWEEN '01' AND '03' then "1분기"
		  when SUBSTR(jumin,3,2) BETWEEN '04' AND '06' then "2분기"
		  when SUBSTR(jumin,3,2) BETWEEN '07' AND '09' then "3분기"
		  when SUBSTR(jumin,3,2) BETWEEN '10' AND '12' then "4분기"
	ELSE "분기오류" END AS 출생분기
FROM student;	

SELECT NAME AS 이름,jumin AS 주민번호,
	case when SUBSTR(jumin,3,2) >= 1 AND SUBSTR(jumin,3,2) <= 3 then "1분기"
		  when SUBSTR(jumin,3,2) >= 4 AND SUBSTR(jumin,3,2) <= 6 then"2분기"
		  when SUBSTR(jumin,3,2) >= 7 AND SUBSTR(jumin,3,2) <= 9 then "3분기"
		  when SUBSTR(jumin,3,2) >= 10 AND SUBSTR(jumin,3,2) <= 12 then "4분기"
	ELSE "분기오류" END AS 출생분기
FROM student;	

-- 학생의 이름,생일,출생분기 출력
-- 출생분기: 생일기준 1 ~ 3: 1분기, 4~6: 2분기, 7~9: 3분기, 10~12: 4분기
SELECT NAME AS 이름,birthday AS 생일,
	case 	when SUBSTR(birthday, (INSTR(birthday,'-')+1), 2) BETWEEN '01' AND '03' then "1분기"
			when SUBSTR(birthday, (INSTR(birthday,'-')+1), 2) BETWEEN '04' AND '06' then "2분기"
			when SUBSTR(birthday, (INSTR(birthday,'-')+1), 2) BETWEEN '07' AND '09' then "3분기"
			when SUBSTR(birthday, (INSTR(birthday,'-')+1), 2) BETWEEN '10' AND '12' then "4분기"
	ELSE "분기오류" END AS 출생분기
FROM student;	
-- month 사용
SELECT NAME AS 이름,birthday AS 생일,
	case 	when MONTH(birthday) BETWEEN '01' AND '03' then "1분기"
			when MONTH(birthday) BETWEEN '04' AND '06' then "2분기"
			when MONTH(birthday) BETWEEN '07' AND '09' then "3분기"
			when MONTH(birthday) BETWEEN '10' AND '12' then "4분기"
	ELSE "분기오류" END AS 출생분기
FROM student;	

/*
그룹함수 : 여러개의 행의 정보 이용하여 결과 리턴 함수
select 칼럼명|* from 테이블명
[where 조건문]
[group by 컬러명]:	레코드를 그룹화 하기위한 기준 컬럼
							group by 구문이 없는 경우 모든 레코드가 하나의 그룹으로 처리
							
[having 조건문]
[order by 컬럼명||별명||컬럼순서 [asc/desc]]
*/
-- count() : 레코드의 건수 리턴, null 값은 건수에서 제외
-- 교수의 전체 인원수, 보너스를 받는 인원수 조회
-- COUNT(bonus) : bonus의 값이 null이 아닌 레코드 수
SELECT COUNT(*), COUNT(bonus) FROM professor;
-- 학생의 전체 인원, 지도교수를 배정받은 학생의 인원수
SELECT  COUNT(*) AS 전체인원, COUNT(profno) AS "지도교수 배정" FROM student;
-- 학생중 전공1 101 인원수
SELECT COUNT(*) AS "전공1" FROM student WHERE major1 = 101;
-- 1학년 학생의 전체 인원수, 지도교수를 배정받은 학생의 인원수
SELECT COUNT(*), COUNT(profno) FROM student WHERE grade = 1;
-- 2학년 
SELECT COUNT(*), COUNT(profno) FROM student WHERE grade = 2;
-- 3,4학년 
SELECT COUNT(*), COUNT(profno) FROM student WHERE grade IN(3,4);
-- 학년별 전체 인원수와 지도교수를 배정받은 학생의 인원수 조회
SELECT grade AS 학년, COUNT(*) AS 전체인원, COUNT(profno) AS 지도교수배정 FROM student 
GROUP BY grade; 
-- 학과별 전체 인원수와 지도교수를 배정받은 학생의 인원수 조회
SELECT major1 AS 학과, COUNT(*) AS 전체인원, COUNT(profno) AS 지도교수배정 FROM student 
GROUP BY major1;
-- 지도교수를 배정되지 않은 학년의 전체학생의 인원수 조회
SELECT grade, COUNT(*) FROM student
GROUP BY grade
HAVING COUNT(profno) = 0;

-- 합계 : sum, 평균: avg
-- null 값인 경우 제외
-- 교수들의 급여 합계, 보너스 합계
SELECT SUM(salary) AS "급여 합계", SUM(bonus) AS "보너스 합계" FROM professor;
-- 교수들의 급여 평균, 보너스 평균
-- avg(bonus) : bonus를 받는 교수들의 평균
SELECT COUNT(*), AVG(salary) AS "급여 평균", AVG(bonus) AS "보너스 평균" FROM professor;
-- avg(ifnull(bonus,0)) : bonus 값이 null인 경우 0을 환산하여 평균처라
SELECT COUNT(*), AVG(salary) AS "급여 평균", AVG(ifnull(bonus,0)) AS "보너스 평균" FROM professor;
-- 교수의 부서코드,부서별,인원수,급여합계,보너스합계,급여평균,보너스평균 출력
-- 단 보너스가 없는 교수도 포함
SELECT deptno, COUNT(*), SUM(salary), SUM(IFNULL(bonus,0)), AVG(salary), AVG(IFNULL(bonus,0)) FROM professor
GROUP BY deptno;
-- 학년별, 학생의 인원수, 키와몸무게의 평균 출력
-- 학년 순으로 정렬
SELECT grade, COUNT(*), AVG(height), AVG(weight) FROM student
GROUP BY grade
-- 부서별 교수의 급여,보너스,연봉,합 과 평균 출력
-- 보너스 없을시 : 0
-- 평균 출력시 소숫점 이하 2자리 반올림
SELECT deptno, COUNT(*),SUM(salary),SUM(IFNULL(bonus,0)),SUM(salary*12+IFNULL(bonus,0)), 
								ROUND(AVG(salary),2),ROUND(AVG(IFNULL(bonus,0)),2),ROUND(AVG(salary*12+IFNULL(bonus,0)),2) FROM professor
GROUP BY deptno;

/*
최소값,최댓값: min,max
*/
-- 전공 1학과별 중 가장큰 키 값 과 작은 키 값 출력
SELECT major1, MAX(height), MIN(height) FROM student
GROUP BY major1;
-- 교수 중 가장 많이/적게 받는 급여
SELECT MAX(salary), MIN(salary) FROM professor;
-- 교수 중 급여와 보너스 합계가 가장많은 값, 가장적은값 과 평균 금액
SELECT  MAX(salary+IFNULL(bonus,0)), MIN(salary+IFNULL(bonus,0)), ROUND(AVG(salary+IFNULL(bonus,0)),1) FROM professor;

/*
표준편차 : stddev
분산 : variance
*/
-- 교수들의 평균급여, 급여의 표준편차,분산 출력
SELECT AVG(salary), STDDEV(salary), VARIANCE(salary) FROM professor;
-- 학생 점수 테이블: 합계 평균, 합계 표준편차, 합계분산 조회
SELECT AVG(kor+eng+math) AS "합계평균", stddev(kor+eng+math) AS "합계 표준편차", VARIANCE(kor+eng+math) AS "합계 표준편차" FROM score;

/*
having : group 조건
*/
-- 학과별 가장 키가 큰 학생의 키와, 가장 작은 학생의 키, 학과별 평균키 출력
-- 평균 키가 170 이상
SELECT major1, MAX(height), MIN(height), avg(height) FROM student 
GROUP BY major1
HAVING  avg(height) >= 170;
-- 교수 테이블에서 학과별 평균 급여가 350이상의 부서의 코드와 평균 급여 출력
SELECT deptno, ROUND(AVG(salary),2) AS "평균급여" FROM professor
GROUP BY deptno
HAVING  AVG(salary) >= 350;
-- 주민번호 기준으로 (971228-10) 남,여학생 최대 키, 최소 키, 평균 키 조회
SELECT SUBSTR(jumin,7,1) 성별, MAX(height), MIN(height), AVG(height) FROM student
GROUP BY SUBSTR(jumin,7,1);

SELECT if(SUBSTR(jumin,7,1) IN (1,3), "남학생","여학생") 성별, MAX(height), MIN(height), AVG(height) FROM student
GROUP BY  if(SUBSTR(jumin,7,1) IN (1,3), "남학생","여학생");

-- group by에서 설정된 컬럼만 select 컬럼으로 사용가능 
SELECT NAME, ROUND(AVG(salary),2) AS "평균급여" FROM professor -- 정상처리 되지만 => name 의미없음, 오라클(오류발생)
GROUP BY deptno;
-- 학생의 생일의 월별 인원수 출력하기
SELECT CONCAT(MONTH(birthday),"월") 월, COUNT(*)  FROM student
GROUP BY MONTH(birthday)
-- 그룹함수 
SELECT CONCAT(COUNT(*)+"", "명") "전체",
	COUNT(if(MONTH(birthday) = 1,1,NULL)) '1월',
	COUNT(if(MONTH(birthday) = 2,1,NULL)) '2월',
	COUNT(if(MONTH(birthday) = 3,1,NULL)) '3월',
	COUNT(if(MONTH(birthday) = 4,1,NULL)) '4월',
	SUM(if(MONTH(birthday) = 5,1,0)) '5월',
	SUM(if(MONTH(birthday) = 6,1,0)) '6월',
	SUM(if(MONTH(birthday) = 7,1,0)) '7월',
	SUM(if(MONTH(birthday) = 8,1,0)) '8월',
	SUM(if(MONTH(birthday) = 9,1,0)) '9월',
	SUM(if(MONTH(birthday) = 10,1,0)) '10월',
	SUM(if(MONTH(birthday) = 11,1,0)) '11월',
	SUM(if(MONTH(birthday) = 12,1,0)) '12월'
FROM student;
-- 그룹함수 전
SELECT NAME,birthday,
	(if(MONTH(birthday) = 1,1,0)) '1월',
	(if(MONTH(birthday) = 2,1,0)) '2월',
	(if(MONTH(birthday) = 3,1,0)) '3월',
	(if(MONTH(birthday) = 4,1,0)) '4월',
	(if(MONTH(birthday) = 5,1,0)) '5월',
	(if(MONTH(birthday) = 6,1,0)) '6월',
	(if(MONTH(birthday) = 7,1,0)) '7월',
	(if(MONTH(birthday) = 8,1,0)) '8월',
	(if(MONTH(birthday) = 9,1,0)) '9월',
	(if(MONTH(birthday) = 10,1,0)) '10월',
	(if(MONTH(birthday) = 11,1,0)) '11월',
	(if(MONTH(birthday) = 12,1,0)) '12월'
FROM student;

/*
순위 지정함수 : randk() over(정렬방식)
누계 함수: sum() over(정렬방식)
*/
-- 교수의 번호,이름,급여,급여를 많은 받는 순위 출력
SELECT NO,NAME,salary, RANK() OVER(ORDER BY salary DESC) AS "급여순위"  FROM professor;
-- 교수의 번호,이름,급여,급여를 오름차순 순위 출력
SELECT NO,NAME,salary, RANK() OVER(ORDER BY salary) AS "급여순위"  FROM professor;
-- score 테이블에서 학번,국어,수학,영어,총점, 총점기준등수 출력
SELECT *, kor+eng+math "총점", RANK() OVER(ORDER BY kor+eng+math DESC) AS "등수" FROM score;
-- 학번,국어,영어,수학,총점,총점기준등수, 과목별 등수출력
SELECT *, kor+eng+math "총점",RANK() OVER(ORDER BY kor+eng+math DESC) AS "총점등수",
										RANK() OVER(ORDER BY kor DESC) AS "국어등수",
										RANK() OVER(ORDER BY math DESC) AS "수학등수",
										RANK() OVER(ORDER BY eng DESC) AS "영어등수"
FROM score;

-- 교수의 이름,급여,보너스,급여의 누계
SELECT NAME,salary,bonus, SUM(salary) OVER(ORDER BY salary DESC) AS "급여누계"  FROM professor;
-- score 테이블, 학번,국어,수학,영어,총점,총점누계,총점등수 조회
SELECT *, kor+eng+math AS "총점", 
SUM(kor+eng+math) OVER(ORDER BY kor+eng+math DESC) AS "총점누계", 
RANK() OVER(ORDER BY kor+eng+math DESC) AS "총점등수" FROM score;

/*
부분합: rollup
*/
-- 국어,수학의 합계의 합
SELECT kor,math, SUM(kor+math) FROM score
GROUP BY kor, math WITH ROLLUP;
-- 학년별,지역, 몸무게 평균, 키평균 조회
SELECT grade, SUBSTR(tel,1,INSTR(tel, ')')-1) 지역, AVG(weight) AS "몸무게평균", AVG(height) AS "키평균" FROM student
GROUP BY grade, SUBSTR(tel,1,INSTR(tel, ')')-1);
-- with rollup
SELECT grade, SUBSTR(tel,1,INSTR(tel, ')')-1) 지역, AVG(weight) AS "몸무게평균", AVG(height) AS "키평균" FROM student
GROUP BY grade, SUBSTR(tel,1,INSTR(tel, ')')-1) WITH ROLLUP;

SELECT grade, AVG(weight) AS "몸무게평균", AVG(height) AS "키평균" FROM student
GROUP BY grade;

-- 학년별,  성별, 몸무게 평균, 키평균, 학년별로도 평균조회
SELECT grade 학년별, if(SUBSTR(jumin,7,1) IN (1,3), "남학생","여학생") 성별,  AVG(weight), AVG(height) FROM student
GROUP BY grade, 성별 WITH ROLLUP;
-- mariadb에서는 실행 안됨, 성별
SELECT grade 학년별, if(SUBSTR(jumin,7,1) IN (1,3), "남학생","여학생") 성별,  AVG(weight), AVG(height) FROM student
GROUP BY grade, 성별 WITH cube;			 