BEGIN
  FOR c IN ( SELECT table_name FROM user_tables)
  LOOP
    EXECUTE IMMEDIATE 'DROP TABLE ' || c.table_name || ' CASCADE CONSTRAINTS' ;
  END LOOP;
END;
 
/

BEGIN
  FOR c IN ( SELECT sequence_name FROM user_sequences WHERE sequence_name NOT LIKE '%$%')
  LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE ' || c.sequence_name;
  END LOOP;
END;




ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD'; 

DROP TABLE EMP;
DROP TABLE DEPT;
DROP TABLE SALGRADE;

CREATE TABLE EMP
       (EMPNO NUMBER(4) NOT NULL,
        ENAME VARCHAR2(10) NOT NULL,
        JOB VARCHAR2(9) NOT NULL,
        MGR NUMBER(4),
        HIREDATE DATE NOT NULL,
        SAL NUMBER(7, 2) NOT NULL,
        COMM NUMBER(7, 2),
        DEPTNO NUMBER(2),
        CONSTRAINT EMP_PK PRIMARY KEY (EMPNO));


CREATE TABLE DEPT
       (DEPTNO NUMBER(2),
        DNAME VARCHAR2(14),
        LOC VARCHAR2(13),
        CONSTRAINT DEPT_PK PRIMARY KEY (DEPTNO));

CREATE TABLE budget (currentValue INT NOT NULL);

ALTER TABLE EMP ADD CONSTRAINT EMP_DEPT_FK FOREIGN KEY (DEPTNO) 
REFERENCES DEPT (DEPTNO);


INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');


INSERT INTO EMP VALUES
        (7369, 'SMITH',  'CLERK',     7902,
        TO_DATE('1980-12-17','YYYY-MM-DD'),  800, NULL, 20);
INSERT INTO EMP VALUES
        (7499, 'ALLEN',  'SALESMAN',  7698,
        TO_DATE('1981-02-20','YYYY-MM-DD'), 1600,  300, 30);
INSERT INTO EMP VALUES
        (7521, 'WARD',   'SALESMAN',  7698,
        TO_DATE('1981-02-22','YYYY-MM-DD'), 1250,  500, 30);
INSERT INTO EMP VALUES
        (7566, 'JONES',  'MANAGER',   7839,
        TO_DATE('1981-04-02','YYYY-MM-DD'),  2975, NULL, 20);
INSERT INTO EMP VALUES
        (7654, 'MARTIN', 'SALESMAN',  7698,
        TO_DATE('1981-09-28','YYYY-MM-DD'), 1250, 1400, 30);
INSERT INTO EMP VALUES
        (7698, 'BLAKE',  'MANAGER',   7839,
        TO_DATE('1981-05-01','YYYY-MM-DD'),  2850, NULL, 30);
INSERT INTO EMP VALUES
        (7782, 'CLARK',  'MANAGER',   7839,
        TO_DATE('1981-06-09','YYYY-MM-DD'),  2450, NULL, 10);
INSERT INTO EMP VALUES
        (7788, 'SCOTT',  'ANALYST',   7566,
        TO_DATE('1982-12-09','YYYY-MM-DD'), 3000, NULL, 20);
INSERT INTO EMP VALUES
        (7839, 'KING',   'PRESIDENT', NULL,
        TO_DATE('1981-11-17','YYYY-MM-DD'), 5000, NULL, 10);
INSERT INTO EMP VALUES
        (7844, 'TURNER', 'SALESMAN',  7698,
        TO_DATE('1981-09-08','YYYY-MM-DD'),  1500,    0, 30);
INSERT INTO EMP VALUES
        (7876, 'ADAMS',  'CLERK',     7788,
        TO_DATE('1983-01-12','YYYY-MM-DD'), 1100, NULL, 20);
INSERT INTO EMP VALUES
        (7900, 'JAMES',  'CLERK',     7698,
        TO_DATE('1981-12-03','YYYY-MM-DD'),   950, NULL, 30);
INSERT INTO EMP VALUES
        (7902, 'FORD',   'ANALYST',   7566,
        TO_DATE('1981-12-03','YYYY-MM-DD'),  3000, NULL, 20);
INSERT INTO EMP VALUES
        (7934, 'MILLER', 'CLERK',     7782,
        TO_DATE('1982-01-13','YYYY-MM-DD'), 1300, NULL, 10);
INSERT INTO EMP VALUES
        (7935, 'GHOST', 'MANAGER',     7782,
        TO_DATE('1982-01-13','YYYY-MM-DD'), 1300, NULL, NULL);
		
CREATE TABLE SALGRADE
        (GRADE NUMBER,
         LOSAL NUMBER,
         HISAL NUMBER);

INSERT INTO SALGRADE VALUES (1,  700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);




-- Tutorial 7
/*

Write a simple script in PL/SQL. Declare a variable to store number of records from table EMP. 
Display the result as “There are N records in table EMP”. 

*/

DECLARE v_counter INT;
BEGIN
    SELECT COUNT(1) INTO v_counter
    FROM emp;
    
    dbms_output.put_line('There are ' || v_counter || ' records in table emp.');
END;



/

-- Task 2

/*

Using PL/SQL, find number of departments with assigned employees. If result is lower than 4, 
find  first department without employees and add a new employee to that department. 
If there are 4 or more departments with employees display a message that no records were added.

*/

DECLARE dep_count INT; dep_no_emp INT;
BEGIN
    SELECT count(1) into dep_count
    from dept d 
    where EXISTS(SELECT 1 
                    from emp e 
                    where e.deptno = d.deptno);

    if dep_count < 4   then 
        select d.deptno into dep_no_emp
        from dept d 
        left join emp e on d.deptno = e.deptno
        where e.deptno IS NULL;
        
        INSERT Into emp (empno, ename, hiredate, job, deptno, sal)
        VALUES (353, 'Name', SYSDATE, 'Manager', dep_no_emp, 10000); 
    else 
    dbms_output.put_line ('The number of emp is  >= 4 ');
    end if;
    -- dbms_output.put_line('There are ' || dep_count || ' records in table Department.');
END;

/

--Task 3
/*
Create a procedure for adding new departments into table DEPT. The procedure will expect parameters: departmentNo, name and location. 
Check if a department with this number, name or location already exists.
If exists, do not insert a new record. 
*/

create or REPLACE procedure addNewDep
(dep_numb INTEGER,
dep_name VARCHAR2,
location VARCHAR2)
as
v_count INTEGER := 0;
 
 begin
     select COUNT(*) into v_count
     from dept d
     where
         (d.deptno = dep_numb) or
         (d.dname = dep_name) or
         (d.loc = location);
     if v_count = 0 then
         INSERT INTO dept (deptno, dname, loc)
         VALUES (dep_numb, dep_name, location);
     else
         dbms_output.put_line('Already exists');
     end if;
 END ;

/

call addNewDep(15, 'ldsap', 'asdsda');
DELETE from dept 
where DEPTNO = 15;
-- drop procedure addNewDep;

/*
4. Create a procedure for inserting employees. The procedure will expect paremeters: department number and employee’s name. 
The procedure should check whether the given department exists (otherwise we report an error) and calculate the employee's salary equal to the minimum wage in his department. 
Assign current system date as hiredate. The procedure should also assign a new EMPNO calculated as a maximum EMPNO in table + 1.

*/

create or replace procedure insertEmp
(dno dept.deptno%type,
empname emp.ename%type)
as
nonExistingDept exception;
pragma exception_init(nonExistingDept, -6530);
dept_exists integer;
min_sal emp.sal%type;
emp_id integer;
begin
select count(1) into dept_exists
from dept
where dno = deptno;
if dept_exists = 0 then
raise nonExistingDept;
else
select (max(empno)+1) into emp_id
from emp;
select min(e.sal) into min_sal
from dept d join emp e on d.deptno = e.deptno
where d.deptno = dno;
insert into emp
(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values
(emp_id, empname, 'job', null, sysdate, min_sal, null, dno);
DBMS_OUTPUT.PUT_LINE('new employee is inserted' || ', with id: ' || emp_id || ', with sal: ' || min_sal || ', with hire date: ' || sysdate);
end if;

end insertEmp;

/
/*
5. Create a function, which given a parameter deptno will return number of employees hired in this department. 
   Display a value received from function in output.

*/
create or replace function numOfEmployee
(dno dept.deptno%type)
return integer
as
e_number integer;
begin
select count(1) into e_number
from emp
where deptno = dno;
return e_number;
end;

/
/*

6. Create table Warehouse (IdItem, ItemName, Quantity) containing the quantities of individual items in the warehouse and insert some sample records into it.
Create a function, find the most-stocked item and reduce the amount of this item by 5 (if the status is greater than or equal to 5, otherwise report an error).

*/

create or replace function reduceIfMoreThanFive
return warehouse.itemname%type
is
counter integer;
item_name warehouse.itemname%type;
begin
select itemname, quantity into item_name, counter
from warehouse
where quantity = (select distinct max(quantity)
from warehouse)
fetch first 1 row only;
if counter >= 5 then
update warehouse
set quantity = quantity - 5
where itemname = item_name;
else
DBMS_OUTPUT.PUT_LINE(item_name || ' is an item with max quantity and it cannot be reduced anymore');
end if;
return item_name;
end reduceIfMoreThanFive;


/


-- *************************************************************** --


-- Tutor 9 

-- 1.	Create a trigger that prevents removing records from table EMP. 
CREATE OR REPLACE TRIGGER EMP_DEL_PREV
BEFORE DELETE ON emp
BEGIN
    raise_application_error(-20001, 'Records cannot be deleted');
END;

/
/*
2.	Create a trigger that, in case of inserting or modifying data in the table EMP, will check if the new earnings (inserted or modified) are greater than 1000. 
Otherwise, the trigger should report an error and prevent inserting the record. 
Note: The same effect can be obtained more easily using CHECK consistency constraints. Let's use the trigger for training purposes. 
*/

create or replace trigger moreThan1000
before insert or update on emp
for each row
begin
if inserting and :new.sal <= 1000 then
raise_application_error(-20001, 'given earning is not > 1000');
elsif updating and :new.sal <= 1000 then
:new.sal := :old.sal;
end if;
end;


/
/*
3.	Create a table BUDGET: 

CREATE TABLE budget (currentValue INT NOT NULL);

The table will keep a total salary of all employees. The table will always contain only one row. You must first calculate the initial earnings value: 

INSERT INTO budget (currentValue) 
SELECT SUM(sal) FROM emp; 

Create a trigger that will make sure that the value in the BUDGET table is always up to date, so for all operations updating the EMP table (INSERT, UPDATE, DELETE), the trigger will update the record in the BUDGET table 
*/

create or replace trigger upToDate
after insert or delete or update on emp
declare
sal_budget integer;
begin
select sum(sal) into sal_budget
from emp;

update budget
set currentValue = sal_budget;
end;

/
/*
4.	Create a single trigger that: 
•	Will not allow you to remove an employee whose salary is greater than 0. 
•	Will not allow you to change the employee's name. 
•	Will not allow you to insert an employee who already exists (checking by name). 
*/
create or replace trigger checking
before update or insert or delete on emp
for each row
declare
counter integer;
begin
if deleting then
if :old.sal > 0 then
raise_application_error(-20001, 'emp with sal > 0 cannot be deleted');
end if;
elsif updating then
if :old.ename <> :new.ename then
raise_application_error(-20001, 'name cannot be changed');
end if;
else
select count(1) into counter
from emp
where ename = :new.ename;

if counter > 0 then
raise_application_error(-20001, 'employee already exists');
end if;
end if;
end;


/
/*
5.	Create a single trigger that: 
•	Will not allow you to reduce the salary. 
•	Will not allow you to remove employees. 
*/
/
CREATE OR REPLACE TRIGGER prevent_reduction_deleting
BEFORE UPDATE OR DELETE ON EMP 
FOR EACH ROW 
BEGIN 
        IF UPDATING AND :OLD.sal > :new.sal then 
            raise_application_error(-20001, 'sal cannot be reduced');
        ELSIF DELETING THEN 
            raise_application_error(-20001, 'emps cannnot be deleted');
        END IF;
END;

SELECT * FROM emp;

