-- tables
-- Table: Dept
CREATE TABLE Dept (
    Deptno int  NOT NULL,
    Dname varchar(50)  NOT NULL,
    Loc varchar(50)  NOT NULL,
    CONSTRAINT Dept_PK PRIMARY KEY  (Deptno)
);

-- Table: Emp
CREATE TABLE Emp (
    Empno int  NOT NULL,
    Ename varchar(30)  NOT NULL,
    Job varchar(15)  NOT NULL,
    Mgr int  NULL,
    Hiredate date  NOT NULL,
    Sal money  NOT NULL,
    Comm money  NULL,
    Deptno int  NOT NULL,
    CONSTRAINT Emp_PK PRIMARY KEY  (Empno)
);

-- Table: SALGRADE
CREATE TABLE SALGRADE (
    Grade int  NOT NULL,
    Losal money  NOT NULL,
    Hisal money  NOT NULL,
    CONSTRAINT SALGRADE_pk PRIMARY KEY  (Grade)
);

-- foreign keys
-- Reference: Emp_Dept_FK (table: Emp)
ALTER TABLE Emp ADD CONSTRAINT Emp_Dept_FK
    FOREIGN KEY (Deptno)
    REFERENCES Dept (Deptno);

-- Reference: Emp_Mgr_FK (table: Emp)
ALTER TABLE Emp ADD CONSTRAINT Emp_Mgr_FK
    FOREIGN KEY (Mgr)
    REFERENCES Emp (Empno);

-- End of file.

INSERT INTO DEPT(Deptno,Dname,Loc) 
VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT(Deptno,Dname,Loc) 
VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT(Deptno,Dname,Loc) 
VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT(Deptno,Dname,Loc) 
VALUES (40, 'OPERATIONS', 'BOSTON');


INSERT INTO EMP(Empno,Ename,Job,Mgr,Hiredate,Sal,Comm,Deptno)
VALUES (7839, 'KING', 'PRESIDENT', NULL, CONVERT(DATE,'17-11-1981', 105), 5000, NULL, 10);
INSERT INTO EMP(Empno,Ename,Job,Mgr,Hiredate,Sal,Comm,Deptno)
VALUES (7698, 'BLAKE', 'MANAGER', 7839, CONVERT(DATE,'01-05-1981', 105),  2850, NULL, 30);
INSERT INTO EMP(Empno,Ename,Job,Mgr,Hiredate,Sal,Comm,Deptno)
VALUES (7566, 'JONES', 'MANAGER', 7839, CONVERT(DATE,'02-04-1981', 105),  2975, NULL, 20);
INSERT INTO EMP(Empno,Ename,Job,Mgr,Hiredate,Sal,Comm,Deptno)
VALUES (7782, 'CLARK', 'MANAGER', 7839, CONVERT(DATE, '09-12-1982', 105),  2450, NULL, 10);
INSERT INTO EMP(Empno,Ename,Job,Mgr,Hiredate,Sal,Comm,Deptno)
VALUES (7902, 'FORD', 'ANALYST', 7566, CONVERT(DATE,'03-12-1981', 105),  3000, NULL, 20);
INSERT INTO EMP(Empno,Ename,Job,Mgr,Hiredate,Sal,Comm,Deptno)
VALUES (7369, 'SMITH', 'CLERK', 7902, CONVERT(DATE,'17-12-1980', 105),  800, NULL, 20);
INSERT INTO EMP(Empno,Ename,Job,Mgr,Hiredate,Sal,Comm,Deptno)
VALUES (7499, 'ALLEN', 'SALESMAN',  7698, CONVERT(DATE,'20-02-1981', 105), 1600,  300, 30);
INSERT INTO EMP(Empno,Ename,Job,Mgr,Hiredate,Sal,Comm,Deptno)
VALUES (7521, 'WARD', 'SALESMAN', 7698, CONVERT(DATE,'22-02-1981', 105), 1250,  500, 30);
INSERT INTO EMP(Empno,Ename,Job,Mgr,Hiredate,Sal,Comm,Deptno)
VALUES (7654, 'MARTIN', 'SALESMAN', 7698, CONVERT(DATE,'28-09-1981', 105), 1250, 1400, 30);
INSERT INTO EMP(Empno,Ename,Job,Mgr,Hiredate,Sal,Comm,Deptno)
VALUES (7788, 'SCOTT', 'ANALYST', 7566, CONVERT(DATE,'09-12-1982', 105), 3000, NULL, 20);
INSERT INTO EMP(Empno,Ename,Job,Mgr,Hiredate,Sal,Comm,Deptno)
VALUES (7844, 'TURNER', 'SALESMAN',  7698, CONVERT(DATE,'08-09-1981', 105),  1500,    0, 30);
INSERT INTO EMP(Empno,Ename,Job,Mgr,Hiredate,Sal,Comm,Deptno)
VALUES (7876, 'ADAMS', 'CLERK', 7788, CONVERT(DATE,'12-01-1983', 105), 1100, NULL, 20);
INSERT INTO EMP(Empno,Ename,Job,Mgr,Hiredate,Sal,Comm,Deptno)
VALUES (7900, 'JAMES', 'CLERK', 7698, CONVERT(DATE,'03-12-1981', 105),   950, NULL, 30);
INSERT INTO EMP(Empno,Ename,Job,Mgr,Hiredate,Sal,Comm,Deptno)
VALUES (7934, 'MILLER', 'CLERK', 7782, CONVERT(DATE,'23-01-1982', 105), 1300, NULL, 10);

INSERT INTO SALGRADE(Grade, Losal, Hisal)
VALUES (1,  700, 1200);
INSERT INTO  SALGRADE(Grade, Losal, Hisal)
VALUES (2, 1201, 1400);
INSERT INTO  SALGRADE(Grade, Losal, Hisal)
VALUES(3, 1401, 2000);
INSERT INTO  SALGRADE(Grade, Losal, Hisal)
VALUES(4, 2001, 3000);
INSERT INTO  SALGRADE(Grade, Losal, Hisal)
VALUES(5, 3001, 9999);

DROP TABLE Booking;
DROP TABLE Category;
DROP TABLE Guest;
DROP TABLE Room;


SELECT * FROM Dept;
SELECT * FROM Emp;


-- 1.	Write a simple program in Transact-SQL. Declare a variable, assign to the variable number of records in the table Emp and print the result using PRINT statement - for example "There are 10 employees.".



-- 2.	Count the number of employees. If the number is lower than 16, enter a new employee and display a message. Otherwise, display an information that no data has been inserted.

-- 3.	Create a procedure returning employees who earn more than value given in a parameter.

DECLARE @sal MONEY = 2000;
SELECT * 
FROM emp e  
WHERE e.sal > @sal;  

GO

CREATE PROCEDURE Task3 
    @minsal MONEY
AS 
BEGIN 
    SET NOCOUNT ON;
    SELECT * FROM emp e
    WHERE e.sal > @minsal;
END

GO

-- EXEC Task3 2000;


sp_help Dept;
-- 4.	Create a procedure for inserting new departments. The procedure will expect as parameters name and location. Department number will be generated automatically and returned in output parameter. Check if a department with provided name or location already exists. If yes, do not insert a new record and raise an error.

CREATE PROCEDURE Task4
    @loc = 
AS
BEGIN

END;

-- 5.	Create a procedure that allows to enter new employees into the EMP table. In parameters, provide:
-- * department name
-- * employee name
-- Before entering a new record, the procedure should check if there is exactly one department with provided name (if not, then report the error).

-- Find values for remaining columns:
-- •	Job – find name of the job with highest number of employees
-- •	Sal -  calculate salary equal to the minimum wage in provided department
-- •	Empno – current max empno + 1
-- •	Deptno – id of the department with name provided in parameter

-- Display a message about new employee as a result set (selected within the procedure) containing one record:

 
