--1
SELECT ROUND(AVG(sal),2) AvgSalary, COUNT(1)
FROM emp;

--2
SELECT MIN(sal)
FROM emp
WHERE job = 'CLERK';
 
--3
SELECT COUNT(1) --, deptno
FROM emp
WHERE deptno = 20;
--GROUP BY deptno;

--4
SELECT AVG(sal), job
FROM emp
GROUP BY job;

--6
SELECT AVG(sal), job, deptno
FROM emp
GROUP BY job, deptno;

--8
SELECT AVG(e.sal), d.dname
FROM emp e JOIN dept d ON e.deptno = d.deptno
GROUP BY d.dname
HAVING COUNT('sdasdasdsa') >= 3;

--10
SELECT avg(sal), SUM(sal *12 + NVL(comm, 0)) SummarizedSalary, job
FROM emp
GROUP BY job;
/*

*/
--12
SELECT empno, COUNT(1)
FROM emp
GROUP BY empno
HAVING COUNT(1) > 1;

--13
SELECT m.ename, MIN(s.sal)
FROM emp s JOIN emp m ON s.mgr = m.empno
GROUP BY m.ename
ORDER BY MIN(s.sal);

--14
SELECT d.loc, COUNT(1)
FROM emp e JOIN dept d ON e.deptno = d.deptno
WHERE d.loc = 'DALLAS'
GROUP BY d.loc;

--16
SELECT SAL,COUNT(412412) 
FROM EMP 
GROUP BY SAL 
HAVING COUNT(EMPNO)>1;

