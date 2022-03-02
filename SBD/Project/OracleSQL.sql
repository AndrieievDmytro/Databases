--
-- Procedure which finds the most popular Travel plans calculating the number of orders 
CREATE OR REPLACE PROCEDURE findMostPopular (res_cursor OUT  SYS_REFCURSOR)
AS
BEGIN
    OPEN res_cursor FOR
    SELECT tp.travel_id , tp.travel_plan_name, COUNT(or1.person_id) orders_count FROM Travel_plans tp 
    JOIN travels_order to1 ON tp.travel_id = to1.travel_id
    JOIN ORders or1 ON to1.order_id= or1.order_id
    WHERE EXISTS (SELECT MAX(COUNT(o.person_id)) 
            FROM  Orders o 
            left join travels_order ot 
            on o.order_id = ot.order_id
            where ot.travel_id = tp.travel_id
            GROUP BY o.person_id)
        GROUP BY tp.travel_id , tp.travel_plan_name
    HAVING  COUNT(or1.person_id) > (
        SELECT TRUNC(AVG(orders_count))
        FROM (SELECT COUNT(or1.person_id) orders_count FROM Travel_plans tp 
        JOIN travels_order to1 ON tp.travel_id = to1.travel_id
        JOIN ORders or1 ON to1.order_id= or1.order_id
        WHERE EXISTS (SELECT MAX(COUNT(o.person_id)) 
                FROM  Orders o 
                left join travels_order ot 
                on o.order_id = ot.order_id
                where ot.travel_id = tp.travel_id
                GROUP BY o.person_id)
            GROUP BY tp.travel_id , tp.travel_plan_name )
    );
END findMostPopular;
/
-- Procedure which finds the less popular Travel plans calculating the number of orders 
CREATE OR REPLACE PROCEDURE findLessPopular (res_cursor OUT  SYS_REFCURSOR)
AS
BEGIN
    OPEN res_cursor FOR
    SELECT tp.travel_id  FROM Travel_plans tp 
    JOIN travels_order to1 ON tp.travel_id = to1.travel_id
    JOIN ORders or1 ON to1.order_id= or1.order_id
    WHERE EXISTS (SELECT MAX(COUNT(o.person_id)) 
            FROM  Orders o 
            left join travels_order ot 
            on o.order_id = ot.order_id
            where ot.travel_id = tp.travel_id
            GROUP BY o.person_id)
        GROUP BY tp.travel_id , tp.travel_plan_name
    HAVING  COUNT(or1.person_id) < (
        SELECT TRUNC(AVG(orders_count))
        FROM (SELECT COUNT(or1.person_id) orders_count FROM Travel_plans tp 
        JOIN travels_order to1 ON tp.travel_id = to1.travel_id
        JOIN ORders or1 ON to1.order_id= or1.order_id
        WHERE EXISTS (SELECT MAX(COUNT(o.person_id)) 
                FROM  Orders o 
                left join travels_order ot 
                on o.order_id = ot.order_id
                where ot.travel_id = tp.travel_id
                GROUP BY o.person_id)
            GROUP BY tp.travel_id , tp.travel_plan_name )
    );
END findLessPopular;
/

-- Procedure which changes the price. For most popular it decreases the price. For less popular increases the price.
CREATE OR REPLACE PROCEDURE changePrice 
IS
    res_cursor SYS_REFCURSOR;
    v_travel_id int;
BEGIN
    findMostPopular (res_cursor);
    LOOP
        FETCH res_cursor INTO v_travel_id/*, travel_plan_name, orders_count*/;
        EXIT WHEN res_cursor%NOTFOUND;
        dbms_output.put_line('Orders with travel plan(s)  ID: ' || v_travel_id || ' were/was updated and the price was decreased by 5%');
        UPDATE travel_plans
        SET price = price * 0.95
        WHERE travel_id = v_travel_id;
    END LOOP;
    CLOSE res_cursor;
    
    findLessPopular (res_cursor);
    LOOP
        FETCH res_cursor INTO v_travel_id;
        EXIT WHEN res_cursor%NOTFOUND;
        dbms_output.put_line('Orders with travel plan(s)  ID: ' || v_travel_id || ' were/was updated and the price was incresead by 5%' );
        UPDATE travel_plans
        SET price = price * 1.05
        WHERE travel_id = v_travel_id;
    END LOOP;
    CLOSE res_cursor;
    
END changePrice;
/

exec changePrice();

Select * from Travel_plans;
UPDATE  Travel_plans SET price = 1500 WHERE Travel_id = 1;
UPDATE  Travel_plans SET price = 2045 WHERE Travel_id = 2;
UPDATE  Travel_plans SET price = 5500 WHERE Travel_id = 3;
UPDATE  Travel_plans SET price = 3450 WHERE Travel_id = 4;



/
set serveroutput on
 
-- TRIGGERS
/

CREATE or replace TRIGGER trBfI 
before insert on Persons 
for each row 
declare
counter INTEGER;
begin 
select count(person_id) into counter from Persons;
    if inserting then
        IF (counter > 34 )  THEN
          RAISE_APPLICATION_ERROR(-20000,'There are only 35 clients possible ');
        END IF;
     end if;
     
end trBfI;


/

CREATE or replace TRIGGER cities_r
before delete or update  on cities 
for each row
declare
routes_counter INTEGER;
begin 
    if deleting then 
      select count(1) into routes_counter from routes r where r.city_id =: old.city_id;
          dbms_output.put_line(routes_counter || ' routes will be deleted.');
        delete from routes where city_id =: old.city_id;
     end if;   
end;

/


select d.Last_Name DoctorLastName , s.name SpecializationName, count(a.Appointment_id) numberOfVisits
from specialization s
left join doctor d on d.spec_id = s.spec_id
left join appointment a on a.doctor_id = d.doctor_id
group by d.Last_Name, s.Spec_id, s.name
having count(a.Appointment_id) = (
    select max(count(a1.Appointment_id))
    from specialization s1
    left join doctor d1 on d1.Spec_id = s1.Spec_id
    left join appointment a1 on a1.doctor_id = d1.doctor_id
    where s1.Spec_id = s.Spec_id
    group by d1.Last_Name, s1.Spec_id
);







