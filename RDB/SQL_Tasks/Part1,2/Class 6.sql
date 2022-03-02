--2
SELECT *
FROM emp;

--1
SELECT ename, empno, mgr
FROM emp;

--6
SELECT ename, sal * 12 "annual salary" 
FROM emp;

--7
SELECT empno || ' ' || ename hired
FROM emp;

--8
SELECT 'Employee with number ' || empno || ' works in department ' || deptno || ' and earns ' || sal || ' per month' "Information about Employee"
FROM emp;

--9
SELECT ename, sal * 12 + NVL(comm, 0) "annual salary with comm" , NVL(comm, 0), comm
FROM emp;

--10
SELECT deptno 
FROM emp;

--12
SELECT DISTINCT deptno, job
FROM emp;

SELECT deptno--, AVG(sal) 
FROM emp
GROUP BY deptno;

--15
SELECT empno, sal, deptno
FROM emp
ORDER BY 3, sal DESC;

--Part II
SELECT *
FROM emp, dept;

--1 
SELECT *
FROM emp e, dept d
WHERE e.deptno = d.deptno;

--2
SELECT *
--FROM emp e INNER JOIN dept d ON e.deptno = d.deptno;
FROM emp e JOIN dept d ON e.deptno = d.deptno;


SELECT * --all employees and only matching departments
FROM emp e LEFT JOIN dept d ON e.deptno = d.deptno;

SELECT * --all departments and only matching employees
FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno;
SELECT e.*, d.*
FROM dept d LEFT JOIN emp e ON e.deptno = d.deptno;

SELECT * --all departments and employees
FROM emp e FULL JOIN dept d ON e.deptno = d.deptno;

--4
SELECT e.empno, d.dname
FROM emp e JOIN dept d ON e.deptno = d.deptno;

--5
SELECT e.ename, e.job, d.dname, e.sal
FROM emp e JOIN dept d ON e.deptno = d.deptno
WHERE e.sal > 1500;

--6
SELECT e.ename, e.job, d.dname, e.sal, s.*
--FROM emp e JOIN salgrade s ON e.sal >= s.losal AND e.sal <= s.hisal;
FROM emp e 
    JOIN dept d ON e.deptno = d.deptno
    JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

--12
SELECT *
FROM emp e
--WHERE e.deptno = 20 OR e.deptno =30;
WHERE e.deptno IN (20, 30);

--13
SELECT job FROM emp WHERE deptno = 10
INTERSECT
SELECT job FROM emp WHERE deptno = 30;

--The statement below returns different result!
SELECT job 
FROM emp 
WHERE deptno = 10 OR deptno = 30;

--14
SELECT job FROM emp WHERE deptno = 10
UNION --ALL
SELECT job FROM emp WHERE deptno = 30;

--15
SELECT job FROM emp WHERE deptno = 10
MINUS
SELECT job FROM emp WHERE deptno = 30;
