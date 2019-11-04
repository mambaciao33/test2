#1.查询工资大于1200的员工姓名和工资
SELECT e.ENAME, e.SAL FROM emp e WHERE e.SAL>1200;

#2.查询员工号为7521的员工的姓名和部门号
SELECT e.ENAME, e.EMPNO FROM emp e WHERE e.EMPNO IN(7521);

#3.选择工资不在5000到12000的员工的姓名和工资
SELECT e.ENAME, e.SAL FROM emp e WHERE e.SAL<5000 OR e.SAL>12000;

#4.选择雇用时间在1981-02-01到1981-05-01之间的员工姓名，job  和雇用时间
SELECT e.ENAME, e.JOB, e.HIREDATE FROM emp e WHERE e.HIREDATE BETWEEN '1981-02-01' AND '1981-05-01';

#5.选择在20或50号部门工作的员工姓名和部门号
SELECT e.ENAME, e.DEPTNO FROM emp e WHERE e.DEPTNO IN(20,50);

#6.选择在1981年雇用的员工的姓名和雇用时间
SELECT e.ENAME, e.HIREDATE FROM emp e WHERE YEAR(e.HIREDATE) IN(1981);

#7.选择公司中没有管理者的员工姓名及job
SELECT e.ENAME, e.JOB FROM emp e WHERE e.MGR IS NULL;

#8.选择公司中有奖金的员工姓名，工资和奖金级别
SELECT e.ENAME, e.SAL, t.GRADE FROM emp e, salgrade t 
WHERE e.COMM BETWEEN t.LOSAL AND t.HISAL 
AND  e.COMM > 0;

#9.选择员工姓名的第三个字母是a的员工姓名
SELECT e.ENAME FROM emp e WHERE e.ENAME LIKE '__a%';

#10.选择姓名中有字母a和e的员工姓名
SELECT e.ENAME FROM emp e WHERE e.ENAME LIKE '%a%' '%e%';

#11.显示系统时间
SELECT NOW();

#12.查询员工号，姓名，工资，以及工资提高百分之20%后的结果
SELECT e.EMPNO, e.ENAME, e.SAL, e.SAL+(e.SAL*0.2) FROM emp e; 

#13.将员工的姓名按首字母排序，并写出姓名的长度（length）
SELECT e.ENAME, CHAR_LENGTH(e.ENAME) FROM emp e ORDER BY e.ENAME ASC;

#14.查询各员工的姓名，并显示出各员工在公司工作的月份数
SELECT e.ENAME, TIMESTAMPDIFF (MONTH,e.HIREDATE,NOW()) FROM emp e ;

#15.查询员工的姓名，以及在公司工作的月份数（worked_month），并按月份数降序排列
SELECT e.ENAME, TIMESTAMPDIFF (MONTH,e.HIREDATE,NOW()) ss FROM emp e ORDER BY ss ASC;

#16.查询公司员工工资的最大值，最小值，平均值，总和
SELECT MAX(e.SAL), MIN(e.SAL), AVG(e.SAL), SUM(e.SAL) FROM emp e;

#17.查询各工种（job）的员工工资的最大值，最小值，平均值，总和
SELECT e.JOB, MAX(e.SAL), MIN(e.SAL), AVG(e.SAL), SUM(e.SAL) FROM emp e GROUP  BY e.JOB;

#18.查询各个工种（job）的员工人数
SELECT e.JOB, COUNT(e.JOB) FROM emp e GROUP BY e.JOB;

#19.查询员工最高工资和最低工资的差距（DIFFERENCE）
SELECT MAX(e.SAL)-MIN(e.SAL) FROM emp e;

#20.查询各个管理者手下员工的最低工资，其中最低工资不能低于1600，没有管理者的员工不计算在内
SELECT e.MGR, MIN(e.SAL) FROM emp e WHERE e.MGR>0 AND e.SAL>1600 GROUP BY e.MGR;

#21.查询所有部门的名字，工作地点，员工数量和工资平均值.
SELECT d.DNAME,d.LOC, COUNT(e.DEPTNO), AVG(e.SAL) FROM emp e,dept d WHERE e.DEPTNO=d.DEPTNO GROUP BY d.DEPTNO;

#22.	查询和scott相同部门的员工姓名和雇用日期
SELECT e.ENAME, e.HIREDATE FROM emp e,emp p WHERE p.ENAME='scott' AND e.DEPTNO=p.DEPTNO ;

#23.	查询工资比 公司平均工资高的员工  的员工号，姓名和工资。
SELECT e.EMPNO, e.ENAME, e.SAL FROM emp e WHERE e.SAL > (SELECT AVG(p.SAL) FROM emp p);

SELECT e.EMPNO, e.ENAME, e.SAL FROM emp e,(SELECT AVG(SAL) sal FROM emp) p WHERE e.SAL > p.sal;

#24.	查询各部门中工资比本部门平均工资高的员工的员工号, 姓名和工资
SELECT p.EMPNO, p.ENAME, p.SAL, p.DEPTNO FROM emp p ,
(SELECT e.DEPTNO, AVG(e.SAL) a FROM emp e GROUP BY e.DEPTNO) s
WHERE p.DEPTNO= s.DEPTNO
 AND p.SAL> s.a;

#25.查询姓名中包含字母a的员工   在相同部门的员工 的 员工号和姓名
SELECT GROUP_CONCAT(e.EMPNO,'-',e.ENAME) FROM emp e WHERE e.ENAME LIKE '%a%' GROUP BY e.DEPTNO HAVING COUNT(*)>1 ;

SELECT e.EMPNO, e.ENAME, e.DEPTNO FROM emp e
WHERE e.DEPTNO IN((SELECT p.DEPTNO FROM emp p WHERE p.ENAME LIKE '%a%' GROUP BY p.DEPTNO HAVING COUNT(*)>1))
AND e.ENAME LIKE '%a%'; 

#26查询和姓名中包含字母u的员工   在相同部门的员工 的 员工号和姓名
SELECT m.EMPNO, m.ENAME ,m.DEPTNO FROM emp m WHERE m.DEPTNO IN(SELECT e.DEPTNO FROM emp e WHERE e.ENAME LIKE '%u%' )
AND m.ENAME LIKE '%u%';

#27. 查询管理者是King的员工姓名和工资
SELECT e.ENAME, e.SAL FROM emp e,emp p  WHERE e.MGR=p.EMPNO AND p.ENAME='King' ;
  
#--1列出至少有一个员工的所有部门。
SELECT e.DEPTNO,COUNT(e.DEPTNO)>0 FROM emp e GROUP BY e.DEPTNO;

#--2．列出薪金比“SMITH”多的所有员工。
SELECT e.ENAME FROM emp e, emp p WHERE p.ENAME='SMITH' AND e.SAL>p.SAL ;

#--3．列出所有员工的姓名及其直接上级的姓名。
SELECT e.ENAME, p.ENAME FROM emp e,emp p  WHERE e.MGR=p.EMPNO ;

#--4．列出受雇日期早于其直接上级的所有员工。(同上,日期可直接拿来比较)
SELECT e.ENAME, p.ENAME FROM emp e,emp p WHERE e.MGR=p.EMPNO AND e.HIREDATE<p.HIREDATE ;

#--5．列出部门名称和这些部门的员工信息，同时列出那些没有员工的部门(以emp表为主，左连接查询)
SELECT d.DNAME, e.* FROM dept d
LEFT JOIN emp e 
ON e.DEPTNO=d.DEPTNO
ORDER BY d.DEPTNO;

SELECT d.DNAME, e.* FROM emp e
RIGHT JOIN dept d 
ON e.DEPTNO=d.DEPTNO
ORDER BY d.DEPTNO;
#--6．列出所有“CLERK”（办事员）的姓名及其部门名称。(域，注意())
SELECT e.ENAME, d.DNAME FROM emp e, dept d WHERE e.JOB='CLERK' AND e.DEPTNO=d.DEPTNO;

#--7．列出最低薪金大于1500的各种工作。
SELECT e.JOB FROM emp e GROUP BY e.JOB HAVING MIN(sal) > 1500;

#--8．列出在部门“SALES”（销售部）工作的员工的姓名，假定不知道销售部的部门编号。
SELECT e.ENAME FROM emp e, dept d WHERE e.DEPTNO=d.DEPTNO AND d.DNAME='sales';  

#--9．列出薪金高于公司平均薪金的所有员工。
SELECT e.ENAME FROM emp e,(SELECT AVG(SAL)sal FROM emp) s WHERE e.SAL>s.sal ; 

#--11．列出薪金 等于 部门30中员工的薪金 的所有员工的姓名和薪金。
SELECT DISTINCT e.ENAME,e.SAL FROM emp e WHERE e.SAL IN ((SELECT emp.SAL FROM emp WHERE emp.DEPTNO='30')) AND e.DEPTNO<>'30';

#--12．列出薪金 高于 在部门30工作的所有员工的薪金的员工姓名和薪金。(MAX的用法)
SELECT e.ENAME, e.SAL FROM emp e,(SELECT MAX(SAL)sal FROM emp WHERE emp.DEPTNO='30') s WHERE e.SAL>s.sal ;

#--13．列出在每个(每个是关键字,对此GROUP BY)部门工作的员工数量、平均工资和平均服务年期限。
SELECT COUNT(e.ENAME),AVG(e.SAL),AVG(TIMESTAMPDIFF (YEAR,e.HIREDATE,NOW())) FROM emp e GROUP BY e.DEPTNO;

#--14．列出所有员工的姓名、部门名称和工资.
SELECT e.ENAME,e.DEPTNO,e.SAL FROM emp e;

#--15．列出所有部门的详细信息和部门人数。
SELECT d.*, COUNT(e.ENAME) FROM emp e,dept d WHERE d.DEPTNO = e.DEPTNO GROUP BY d.DEPTNO;

   
#--1、选择部门30中的雇员
SELECT p.ENAME FROM emp p WHERE p.DEPTNO IN(30);

#--2、列出所有办事员的姓名、编号和部门
SELECT p.EMPNO, p.ENAME, p.DEPTNO FROM emp p;

#--3、找出佣金高于薪金的雇员
SELECT * FROM emp p WHERE p.COMM > p.SAL;

#--4、找出佣金高于薪金60%的雇员
SELECT * FROM emp p WHERE p.COMM>p.SAL*0.6; 

#--5、找出部门10中所有经理和部门20中的所有办事员的详细资料
SELECT * FROM emp e WHERE e.JOB = 'manager' AND e.DEPTNO = '10' OR e.JOB = 'clerk' AND e.DEPTNO = '20' ORDER BY e.DEPTNO;

#--6、找出部门10中所有经理、部门20中所有办事员，既不是经理又不是办事员但其薪金>=1000的所有雇员的详细资料
SELECT * FROM emp e WHERE e.JOB = 'manager' AND e.DEPTNO = '10' AND e.SAL>=1000 OR e.JOB = 'clerk' AND e.DEPTNO = '20' AND e.SAL>=1000 ORDER BY e.DEPTNO;

#--7、找出收取佣金的雇员的不同工作
SELECT DISTINCT e.JOB FROM emp e WHERE e.COMM IS NOT NULL;

#--8、找出不收取佣金或收取的佣金低于1000的雇员
SELECT * FROM emp e WHERE e.COMM <1000 OR e.COMM IS NULL;

#--9、找出各月最后一天受雇的所有雇员
SELECT * FROM emp e WHERE e.HIREDATE = LAST_DAY(e.HIREDATE);

#--10、找出早于25年之前受雇的雇员
SELECT p.ENAME FROM emp p WHERE TIMESTAMPDIFF (YEAR,p.HIREDATE,NOW())>25;

#--11、显示只有首字母大写的所有雇员的姓名


#--12、显示正好为6个字符的雇员姓名
SELECT e.ENAME FROM emp e WHERE LENGTH(ename) = 6;

#--13、显示不带有'R'的雇员姓名
SELECT e.ENAME FROM emp e WHERE e.ENAME NOT LIKE '%r%';

#--14、显示所有雇员的姓名的前三个字符
SELECT LEFT(e.ENAME,3) AS ENAME FROM emp e;

#--15、显示所有雇员的姓名，用a替换所有'A'
SELECT REPLACE(ename,'A','a') FROM emp;

#--16、显示所有雇员的姓名以及满10年服务年限的日期
SELECT e.ENAME,e.HIREDATE,DATE_ADD(e.HIREDATE,INTERVAL 10 YEAR) AS '十年' FROM emp e;

#--17、显示雇员的详细资料，按姓名排序
SELECT * FROM emp p ORDER BY p.ENAME;

#--18、显示雇员姓名，根据其服务年限，将最老的雇员排在最前面
SELECT p.ENAME FROM emp p ORDER BY p.HIREDATE ;

#--19、显示所有雇员的姓名、工作和薪金，按工作的降序顺序排序，而工作相同时按薪金升序
SELECT p.ENAME, p.JOB, p.SAL FROM emp p ORDER BY p.HIREDATE DESC ,p.SAL;

#--20、显示所有雇员的姓名和加入公司的年份和月份，按雇员受雇日所在月排序，将最早年份的项目排在最前面
SELECT p.ENAME,DATE_FORMAT(p.HIREDATE,'%Y') AS hireyear , DATE_FORMAT(p.HIREDATE,'%m') AS hiremonth FROM emp p ORDER BY hireyear,hiremonth;

#--21、显示在一个月为30天的情况下所有雇员的日薪金
SELECT p.ENAME, p.SAL , p.SAL/30 AS '日薪' FROM emp p;

#--22、找出在（任何年份的）2月受聘的所有雇员
SELECT p.ENAME ,p.HIREDATE FROM emp p WHERE DATE_FORMAT(p.HIREDATE,'%m') = '02';

#--23、对于每个雇员，显示其加入公司的天数
SELECT p.ENAME, TIMESTAMPDIFF (DAY,p.HIREDATE,NOW()) FROM emp p;

#--24、显示姓名字段的任何位置，包含 "A" 的所有雇员的姓名
SELECT e.ENAME FROM emp e WHERE e.ENAME LIKE '%a%';

#--25、以年、月和日显示所有雇员的服务年限
SELECT p.HIREDATE,p.HIREDATE, TIMESTAMPDIFF(YEAR,p.HIREDATE,NOW()) AS '加入年限' ,TIMESTAMPDIFF(MONTH,p.HIREDATE,NOW()) AS '加入月',TIMESTAMPDIFF(DAY,p.HIREDATE,NOW()) AS '加入天数' FROM emp p;


#练习四：   
#--1、列出至少有一个雇员的所有部门
SELECT DISTINCT d.DNAME FROM dept d INNER JOIN emp p ON d.DEPTNO = p.DEPTNO;

#--2、列出薪金比"SMITH"多的所有雇员
SELECT p.ENAME FROM emp p,emp e WHERE e.ENAME='smith' AND p.SAL>e.SAL;


#--3、列出所有雇员的姓名及其直接上级的姓名
SELECT p.ENAME,e.ENAME FROM emp p,emp e WHERE e.EMPNO=p.MGR;

#--4、列出入职日期早于其直接上级的所有雇员
SELECT p.ENAME FROM emp p,emp e WHERE e.EMPNO=p.MGR AND p.HIREDATE>e.HIREDATE;

#--5、列出部门名称和这些部门的雇员,同时列出那些没有雇员的部门
SELECT d.DNAME,e.ENAME FROM dept d LEFT JOIN emp e ON d.deptno = e.deptno;

#--6、列出所有“CLERK”（办事员）的姓名及其部门名称
SELECT p.ENAME, d.DNAME FROM emp p,dept d WHERE p.DEPTNO=d.DEPTNO AND p.JOB='clerk';

#--7、列出各种工作类别的最低薪金，显示最低薪金大于1500的记录
SELECT p.JOB, p.SAL, MIN(p.SAL)>1500 FROM emp p; 

#--8、列出从事“SALES”（销售）工作的雇员的姓名，假定不知道销售部的部门编号
SELECT p.ENAME FROM emp p WHERE p.DEPTNO = (SELECT d.DEPTNO FROM dept d WHERE d.DNAME = 'SALES' );

#--9、列出薪金高于公司平均水平的所有雇员
SELECT e.ENAME FROM emp e WHERE e.SAL > (SELECT AVG(SAL) FROM emp );

#--10、列出与“SCOTT”从事相同工作的所有雇员
SELECT e.ENAME FROM emp e WHERE e.JOB = (SELECT job FROM emp WHERE ename = 'scott');

#--11、列出某些雇员的姓名和薪金，条件是他们的薪金等于部门30中任何一个雇员的薪金
SELECT p.ENAME ,p.SAL FROM emp p WHERE p.SAL IN (SELECT sal FROM emp WHERE deptno = '30') AND p.DEPTNO != '30';

#--12、列出某些雇员的姓名和薪金，条件是他们的薪金高于部门30中所有雇员的薪金
SELECT p.ENAME,p.SAL FROM emp p WHERE p.SAL > (SELECT MAX(sal) FROM emp WHERE deptno = '30' );

#--13、列出每个部门的信息以及该部门中雇员的数量
SELECT d.* , b.cnumb FROM dept d LEFT JOIN (SELECT deptno,COUNT(deptno) AS cnumb FROM emp GROUP BY deptno) b ON d.DEPTNO = b.deptno;

#--14、列出所有雇员的雇员名称、部门名称和薪金
SELECT p.ENAME,p.SAL,c.dptname FROM emp p LEFT JOIN (SELECT deptno AS dep,dname AS dptname FROM dept) c ON p.DEPTNO = c.dep;

#--15、列出从事同一种工作但属于不同部门的雇员的不同组合
SELECT p.ENAME AS a,e.ENAME AS b FROM emp p, emp e WHERE p.JOB= e.JOB AND p.DEPTNO != e.DEPTNO;

#--16、列出分配有雇员数量的所有部门的详细信息，即使是分配有0个雇员
SELECT d.* , b.cnumb FROM dept d LEFT JOIN (SELECT deptno,COUNT(deptno) AS cnumb FROM emp GROUP BY deptno) b ON d.DEPTNO = b.deptno;

#--17、列出各种类别工作的最低工资
SELECT e.JOB,MIN(e.SAL) FROM emp e GROUP BY e.JOB;

#--18、列出各个部门的MANAGER（经理）的最低薪金
SELECT e.* FROM emp e, (SELECT deptno, MIN(sal) AS sal FROM emp WHERE job='manager' GROUP BY deptno) t2 WHERE e.DEPTNO=t2.deptno AND e.SAL = t2.sal AND e.JOB='manager';

#--19、列出按年薪排序的所有雇员的年薪
SELECT e.ENAME, e.SAL*12 AS '年薪' FROM emp e ORDER BY e.SAL;

#--20、列出薪金水平处于第四位的雇员
SELECT ename,sal FROM emp ORDER BY sal DESC LIMIT 3,1;
