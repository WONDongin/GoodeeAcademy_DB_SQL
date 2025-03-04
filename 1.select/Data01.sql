create table dept (
  deptno   integer(2) primary key, 
  dname    varchar(14),
  loc      varchar(20));

insert into dept values
(10,'대표이사','서울'),
(20,'기획부','서울'),
(30,'기술부','서울'),
(40,'영업부','서울'),
(50,'운용팀','울산');


create table emp ( 
  empno     integer(4) primary key, 
  ename     varchar(10), 
  job       varchar(9), 
  mgr       integer(4), 
  birthday  date,
  hiredate  date, 
  salary    integer(7),
  bonus     integer(7), 
  deptno    integer(2));

insert into emp values 
(1000,'나영민','대표',NULL,'1992-10-01','2022-01-01',1800,500,10),
(1002,'김수영','이사',1000,'1993-11-10','2023-01-03',1000,300,30),
(2001,'박진택','차장',1000,'1992-01-12','2022-01-01',900,200,20),
(2002,'송선호','차장',1000,'1994-02-19','2024-10-01',900,200,40),
(2003,'주영희','주임',2001,'1993-03-14','2022-10-01',700,100,20),
(2004,'김영혜','사원',2002,'2000-04-20','2022-10-01',600,150,40),
(2005,'이신주','사원',2001,'2001-05-21','2024-09-01',500,150,20),
(2006,'박연희','사원',1000,'2000-06-30','2024-10-01',600,150,50),
(2007,'김지애','사원',2002,'1999-07-11','2024-11-01',550,NULL,40),
(2008,'김경선','과장',1002,'1995-08-23','2025-01-03',650,200,30),
(2009,'이영국','과장',1002,'1992-09-08','2025-01-03',650,200,30),
(2010,'강성진','사원',1002,'1990-10-06','2024-06-01',600,NULL,30),
(2011,'김명수','사원',1002,'1992-11-22','2024-06-01',500,NULL,30),
(2012,'김민엽','사원',2002,'2002-12-16','2024-10-01',550,150,40);


create table major
( code integer(3) primary key , 
  name varchar(20) not null,
  part integer(3),
  build  varchar(14));

insert into major values
(101,'컴퓨터공학과',100,'정보관'),
(102,'멀티미디어공학과',100,'멀티미디어관'),
(103,'소프트웨어공학과',100,'소프트웨어관'),
(201,'전자공학과',200,'전자제어관'),
(202,'기계공학과',200,'기계실험관'),
(301,'문헌정보학과',300,'인문관'),
(100,'컴퓨터정보학부',10,null),
(200,'전기전자학부',10,null),
(300,'인문사회학부',20,null),
(10,'공과대학',null,null),
(20,'인문대학',null,null);

commit;

create table professor
(no integer(4) primary key,
 name  varchar(10) not null, 
 id  varchar(15) not null,
 position varchar (10) not null,
 salary integer(3) not null,
 hiredate  date not null,
 bonus integer(4) ,
 deptno  integer(3),
 email  varchar(50),
 url  varchar(50));deptemp

insert into professor values
(1001,'김유태','kyt','정교수',550,str_to_date('2017-10-01','%Y-%m-%d'),200,101,'kyt@abc.net','http://www.kytpage.net'),
(1002,'김경빈','kkb','정교수',450,str_to_date('2020-01-01','%Y-%m-%d'),100,102,'kkb@abc.net','http://www.kkbpage.net'),
(1003,'이영택','lyt','정교수',400,str_to_date('2020-01-01','%Y-%m-%d'),100,103,'lyt@abc.net','http://www.lytpage.net'),
(1004,'이복영','lby','조교수',350,str_to_date('2022-10-01','%Y-%m-%d'),100,101,'lby@abc.net','http://www.lbypage.net'),
(1005,'조황섭','chs','조교수',300,str_to_date('2023-03-01','%Y-%m-%d'),100,102,'chs@abc.net','http://www.chspage.net'),
(1006,'송승환','ssh','조교수',350,str_to_date('2020-03-01','%Y-%m-%d'),100,103,'ssh@abc.net','http://www.sshpage.net'),
(1007,'이상미','lsm','조교수',400,str_to_date('2020-03-01','%Y-%m-%d'),100,201,'lsm@abc.net','http://www.lsmpage.net'),
(1008,'조미영','cmy','조교수',430,str_to_date('2020-03-01','%Y-%m-%d'),100,202,'cmy@abc.net','http://www.cmypage.net'),
(1009,'박인숙','pis','조교수',512,str_to_date('2020-03-01','%Y-%m-%d'),100,101,'pis@abc.net','http://www.pispage.net'),
(5010,'김옥남','kon','시간강사',280,str_to_date('2020-03-01','%Y-%m-%d'),NULL,102,'kon@abc.net','http://www.konpage.net'),
(5011,'김현정','khj','시간강사',355,str_to_date('2024-03-01','%Y-%m-%d'),NULL,103,'khj@abc.net','http://www.khjpage.net'),
(5013,'이명정','lmj','시간강사',200,str_to_date('2024-03-01','%Y-%m-%d'),NULL,301,'lmj@abc.net','http://www.lmjpage.net'),
(5014,'이정미','ljm','시간강사',250,str_to_date('2023-03-01','%Y-%m-%d'),NULL,201,'ljm@abc.net','http://www.ljmpage.net'),
(5015,'박성신','pss','시간강사',150,str_to_date('2025-03-01','%Y-%m-%d'),NULL,202,'pss@abc.net','http://www.psspage.net');


create table student
( studno integer(4) primary key,
  name   varchar(10) not null,
  id varchar(20) not null unique,
  grade integer check(grade between 1 and 6),
  jumin char(13) not null,
  birthday  date,
  tel varchar(15),
  height  integer(4),
  weight  integer(3),
  major1 integer(3),
  major2 integer(3),
  profno  integer(4));


insert into student values
(240111,'강진','kangjin2702',1,'0502233234567',str_to_date('1998-02-23','%Y-%m-%d'),'055)333-1234',183,71,101,null,null),
(240212,'곽종인','kwakjong',1,'0508023234567',str_to_date('1998-08-02','%Y-%m-%d'),'051)426-2345',178,65,102,null,null),
(240313,'박동인','kimdongin',1,'0510023234567',str_to_date('1998-10-02','%Y-%m-%d'),'053)566-3456',173,75,103,null,null),
(241113,'최정현','kimjunghyun',1,'0602084234567',str_to_date('1998-02-08','%Y-%m-%d'),'02)6122-4567',170,80,201,null,null),
(241213,'장영','kimyoung',1,'0512083234567',str_to_date('1998-12-08','%Y-%m-%d'),'031)122-5678',183,95,202,null,null),
(230111,'진영훈','kimyounghun',2,'0305233234567',str_to_date('1997-05-23','%Y-%m-%d'),'02)1220-6789',173,65,101,null,1001),
(230212,'이용','kimyong',2,'0312133234567',str_to_date('1997-12-13','%Y-%m-%d'),'055)222-6789',175,67,102,null,1002),
(230313,'김종연','kimyongyoun',2,'0311033234567',str_to_date('1997-11-03','%Y-%m-%d'),'051)356-9876',175,67,103,null,1003),
(231115,'하진석','hajinsuk',2,'0311033234567',str_to_date('1997-11-03','%Y-%m-%d'),'02)2212-6547',170,67,201,null,1007),
(231211,'유진성','youjinsung',2,'0303033234567',str_to_date('1997-03-03','%Y-%m-%d'),'031)567-5475',170,67,202,null,1008),
(220111,'이충연','leechungyun',3,'0203033234567',str_to_date('1996-03-03','%Y-%m-%d'),'032)3256-5445',169,67,101,301,1009),
(220212,'김태훈','kimtaehoon',3,'0203303234567',str_to_date('1996-03-30','%Y-%m-%d'),'02)5487-2345',189,63,102,null,1005),
(220315,'이철이','leechulri',3,'0212303234567',str_to_date('1996-12-30','%Y-%m-%d'),'02)2547-2345',180,67,103,null,1006),
(221115,'이여은','leeyueun',3,'0202254234567',str_to_date('1996-02-25','%Y-%m-%d'),'032)548-1445',159,48,201,103,1007),
(221215,'박재원','parkjewon',3,'0110273234567',str_to_date('1996-10-27','%Y-%m-%d'),'032)2582-9345',169,58,202,null,1008),
(210115,'이준희','leejunhee',4,'0110204234567',str_to_date('1994-10-20','%Y-%m-%d'),'02)2254-2645',163,59,101,null,1001),
(210211,'김희도','kimheedo',4,'0101203234567',str_to_date('1995-01-20','%Y-%m-%d'),'053)622-2459',173,69,102,null,1002),
(210315,'박동익','parkdongik',4,'0105213234567',str_to_date('1995-05-21','%Y-%m-%d'),'02)2152-2453',183,79,103,301,1003),
(211115,'장성태','jangsungtae',4,'9907211234567',str_to_date('1995-07-21','%Y-%m-%d'),'055)629-2475',178,73,201,301,1007),
(211215,'하정환','hajunghwan',4,'0108273234567',str_to_date('1995-08-27','%Y-%m-%d'),'02)6122-2554',176,71,202,101,1008);

commit;


create table pointitem 
( no  integer(3) ,
  name varchar(15) ,
  spoint  integer(8) ,
  epoint  integer(8) );


insert into pointitem values
(1,'데이터케이블',100,1000),
(2,'가정용충전기',1001,2000),
(3,'이어폰',2001,3000),
(4,'프린트잉크',3001,4000),
(5,'무선마우스',4001,5000),
(6,'무선키보드',5001,6000),
(7,'외장충전기',6001,7000),
(8,'외장하드',7001,8000),
(9,'프린트',8001,9000),
(10,'모니터',9001,10000);

commit ;


create table guest 
(no  integer(8) primary key,
 name varchar(12) ,
 point integer) ;

insert into guest values
(20240001,'강동균',980),
(20240002,'성건민',730),
(20240003,'이용주',320),
(20240004,'김수영',6500),
(20240005,'남소희',1800),
(20240006,'김윤영',1530),
(20240007,'신은지',273),
(20240008,'오민수',3150),
(20240009,'박준희',5420),
(20240010,'임현식',2650),
(20240011,'최규민',1100),
(20240012,'박정현',9900),
(20240013,'안훈',4700),
(20240014,'김병민',2900),
(20240015,'노인우',4200),
(20240016,'이나진',5980),
(20240017,'박수진',6250),
(20240018,'송민지',6700),
(20240019,'주영인',7700),
(20240020,'허용진',7300);
commit ;

create table scorebase
(grade char(3) ,
 min_point  integer ,
 max_point  integer );

insert into scorebase values 
('a+',96,100),
('a0',90,95),
('b+',86,89),
('b0',80,85),
('c+',76,79),
('c0',70,75),
('d',0,69);

commit;

create table p_grade
( position  varchar(10) ,
  s_age integer,
  e_age int ,
  s_year int ,
  e_year int ,
  s_pay  int ,
  e_pay  int );

insert into p_grade values 
('주임',0,24,1,2,12000000,29990000),
('대리',25,28,3,5,30000000,45000000),
('과장',29,32,6,8,45010000,51000000),
('차장',33,36,9,10,51010000,60000000),
('부장',37,40,11,13,60010000,75000000),
('이사',41,55,14,99,75010000,100000000);

commit ;


create table score (
  studno integer(4) primary key,
  kor int,
  math int,
  eng int
);

insert into score values 
(240111,65,75,76),
(240212,75,65,87),
(240313,85,95,78),
(241113,65,75,87),
(241213,95,95,97),
(230111,66,55,70),
(230212,75,100,90),
(230313,80,55,80),
(231115,58,56,88),
(231211,67,87,86),
(220111,70,65,75),
(220212,90,85,84),
(220315,87,95,82),
(221115,78,69,65),
(221215,88,59,58),
(210115,99,89,88),
(210211,76,68,90),
(210315,75,87,70),
(211115,80,78,97),
(211215,76,85,100);

commit;