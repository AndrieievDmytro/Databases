--1
SELECT *
FROM emp e
WHERE e.sal = ( SELECT MIN(sal)
                FROM emp);


--3
SELECT *
FROM emp e
WHERE e.sal IN (SELECT MIN(sal)
                FROM emp
                GROUP BY deptno);
       
--4
SELECT *
FROM emp e
WHERE (e.sal, e.deptno) IN (SELECT MIN(sal), deptno
                            FROM emp
                            GROUP BY deptno);
--5
SELECT *
FROM emp e
WHERE e.sal >  ANY (SELECT sal
                    FROM emp
                    WHERE deptno = 30);
     
  
                
--9
SELECT d.dname
FROM emp e JOIN dept d ON e.deptno = d.deptno
GROUP BY d.deptno, d.dname
HAVING AVG(e.sal) > (SELECT avg(sal) 
                     FROM emp 
                     WHERE deptno = 30);

--10
SELECT e.job
FROM emp e
GROUP BY e.job
HAVING AVG(sal)=( SELECT MAX(AVG(sal))
                  FROM emp
                  GROUP BY job);


--PART V
--1
SELECT *
FROM emp e
WHERE e.sal = (SELECT MAX(e2.sal)
               FROM emp e2
               WHERE e2.deptno = e.deptno);
               
--4
SELECT *
FROM emp m
WHERE EXISTS (SELECT 1
              FROM emp e
              WHERE e.mgr = m.empno);


--6
SELECT *
FROM dept d LEFT JOIN emp e ON d.deptno = e.deptno
WHERE e.empno IS NULL;

SELECT d.loc, d.dname
FROM dept d 
WHERE NOT EXISTS (SELECT 1 
                  FROM emp e 
                  WHERE e.deptno = d.deptno);

