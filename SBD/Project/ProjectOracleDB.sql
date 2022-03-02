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


/

-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-04-01 08:35:20.165
-- tables
-- Table: Cities
CREATE TABLE Cities (
    city_name varchar2(50)  NOT NULL,
    country integer  NOT NULL,
    city_id integer  NOT NULL,
    CONSTRAINT Cities_pk PRIMARY KEY (city_id)
) ;

-- Table: Connection_type
CREATE TABLE Connection_type (
    type_id integer  NOT NULL,
    type_name varchar2(50)  NOT NULL,
    CONSTRAINT Connection_type_pk PRIMARY KEY (type_id)
) ;

-- Table: Countries
CREATE TABLE Countries (
    country_id integer  NOT NULL,
    country_name varchar2(50)  NOT NULL,
    CONSTRAINT Countries_pk PRIMARY KEY (country_id)
) ;

-- Table: Documents
CREATE TABLE Documents (
    document_num varchar2(50)  NOT NULL,
    type_id integer  NOT NULL,
    document_id integer  NOT NULL,
    person_id integer  NOT NULL,
    CONSTRAINT Documents_pk PRIMARY KEY (document_id)
) ;

-- Table: Documents_type
CREATE TABLE Documents_type (
    type_id integer  NOT NULL,
    type_name varchar2(50)  NOT NULL,
    CONSTRAINT Documents_type_pk PRIMARY KEY (type_id)
) ;

-- Table: Groups
CREATE TABLE Travel_Groups (
    groups_id integer  NOT NULL,
    group_name varchar2(15)  NOT NULL,
    CONSTRAINT Groups_pk PRIMARY KEY (groups_id)
) ;

-- Table: Leader_Person
CREATE TABLE Leader_Person (
    leader_person_id integer  NOT NULL,
    date_from date  NOT NULL,
    date_to date  NOT NULL,
    person_id integer  NOT NULL,
    groups_id integer  NOT NULL,
    CONSTRAINT Leader_Person_pk PRIMARY KEY (leader_person_id)
) ;

-- Table: Orders
CREATE TABLE Orders (
    order_id integer  NOT NULL,
    order_number varchar2(50)  NOT NULL,
    person_id integer  NOT NULL,
    price int NOT NULL,
    CONSTRAINT Orders_pk PRIMARY KEY (order_id)
) ;

-- Table: Persons
CREATE TABLE Persons (
    person_id integer  NOT NULL,
    telephone_number varchar2(20)  NOT NULL,
    email varchar2(50)  NOT NULL,
    first_name varchar2(50)  NOT NULL,
    second_name varchar2(50)  NOT NULL,
    CONSTRAINT Persons_pk PRIMARY KEY (person_id)
) ;

CREATE INDEX Persons_name_idx 
on Persons 
(first_name ASC)
;

CREATE INDEX Persons_second_idx 
on Persons 
(second_name ASC)
;

-- Table: Routes
CREATE TABLE Routes (
    route_id integer  NOT NULL,
    route_name varchar2(50)  NOT NULL,
    order_number integer  NOT NULL,
    city_id integer  NOT NULL,
    id_travel integer  NOT NULL,
    CONSTRAINT Routes_pk PRIMARY KEY (route_id)
) ;


CREATE TABLE audits (
      audit_id       integer NOT NULL,
      table_name     VARCHAR2(255),
      operation_name VARCHAR2(10),
      operation_date DATE
);


-- Table: Travel_plans
CREATE TABLE Travel_plans (
    travel_id integer  NOT NULL,
    travel_plan_name varchar2(50)  NOT NULL,
    price number NOT NULL,
  --  travel_plane_route integer  NOT NULL,
    CONSTRAINT Travel_plans_pk PRIMARY KEY (travel_id)
) ;

-- Table: groups_travel
CREATE TABLE groups_travel (
    groups_id integer  NOT NULL,
    travels_id integer  NOT NULL,
    CONSTRAINT groups_travel_pk PRIMARY KEY (groups_id,travels_id)
) ;

-- Table: travels_order
CREATE TABLE travels_order (
    order_id integer  NOT NULL,
    travel_id integer  NOT NULL,
    CONSTRAINT travels_order_pk PRIMARY KEY (order_id,travel_id)
) ;

CREATE INDEX travels_order_idx_1 
on travels_order 
(order_id ASC)
;

-- Table: trustees_person
CREATE TABLE trustees_person (
    trustees_person_id integer  NOT NULL,
    person_id integer  NOT NULL,
    person2_id integer  NOT NULL,
    type_id integer  NOT NULL,
    CONSTRAINT trustees_person_pk PRIMARY KEY (trustees_person_id)
) ;

-- foreign keys
-- Reference: Cities_Countries (table: Cities)
ALTER TABLE Cities ADD CONSTRAINT Cities_Countries
    FOREIGN KEY (country)
    REFERENCES Countries (country_id);

-- Reference: Connection_type (table: trustees_person)
ALTER TABLE trustees_person ADD CONSTRAINT Connection_type
    FOREIGN KEY (type_id)
    REFERENCES Connection_type (type_id);

-- Reference: Documents_Documents_type (table: Documents)
ALTER TABLE Documents ADD CONSTRAINT Documents_Documents_type
    FOREIGN KEY (type_id)
    REFERENCES Documents_type (type_id);

-- Reference: Documents_Persons (table: Documents)
ALTER TABLE Documents ADD CONSTRAINT Documents_Persons
    FOREIGN KEY (person_id)
    REFERENCES Persons (person_id);

-- Reference: Leader_Person_Groups (table: Leader_Person)
ALTER TABLE Leader_Person ADD CONSTRAINT Leader_Person_Groups
    FOREIGN KEY (groups_id)
    REFERENCES Travel_Groups (groups_id);

-- Reference: Leader_Person_Persons (table: Leader_Person)
ALTER TABLE Leader_Person ADD CONSTRAINT Leader_Person_Persons
    FOREIGN KEY (person_id)
    REFERENCES Persons (person_id);

-- Reference: Orders_Persons (table: Orders)
ALTER TABLE Orders ADD CONSTRAINT Orders_Persons
    FOREIGN KEY (person_id)
    REFERENCES Persons (person_id);

-- Reference: Routes_Cities (table: Routes)
ALTER TABLE Routes ADD CONSTRAINT Routes_Cities
    FOREIGN KEY (city_id)
    REFERENCES Cities (city_id);

-- Reference: Routes_Travel_plans (table: Routes)
ALTER TABLE Routes ADD CONSTRAINT Routes_Travel_plans
    FOREIGN KEY (id_travel)
    REFERENCES Travel_plans (travel_id);

-- Reference: groups_travel_Groups (table: groups_travel)
ALTER TABLE groups_travel ADD CONSTRAINT groups_travel_Groups
    FOREIGN KEY (groups_id)
    REFERENCES Travel_Groups (groups_id);

-- Reference: groups_travel_Travel_plans (table: groups_travel)
ALTER TABLE groups_travel ADD CONSTRAINT groups_travel_Travel_plans
    FOREIGN KEY (travels_id)
    REFERENCES Travel_plans (travel_id);

-- Reference: travels_order_Orders (table: travels_order)
ALTER TABLE travels_order ADD CONSTRAINT travels_order_Orders
    FOREIGN KEY (order_id)
    REFERENCES Orders (order_id);

-- Reference: travels_order_Travel_plans (table: travels_order)
ALTER TABLE travels_order ADD CONSTRAINT travels_order_Travel_plans
    FOREIGN KEY (travel_id)
    REFERENCES Travel_plans (travel_id);

-- Reference: trustees_person_Persons (table: trustees_person)
ALTER TABLE trustees_person ADD CONSTRAINT trustees_person_Persons
    FOREIGN KEY (person_id)
    REFERENCES Persons (person_id);

-- Reference: trustees_person_Persons2 (table: trustees_person)
ALTER TABLE trustees_person ADD CONSTRAINT trustees_person_Persons2
    FOREIGN KEY (person2_id)
    REFERENCES Persons (person_id);

-- End of file.
CREATE SEQUENCE city_seq
START WITH 1
INCREMENT BY 1;


CREATE SEQUENCE country_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE documents_type_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE documents_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE persons_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE connection_type_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE trustees_person_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE leader_person_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE group_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE orders_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE travel_poland_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE route_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE audit_seq
START WITH 1
INCREMENT BY 1;

--Countries

INSERT INTO Countries (country_id,country_name)
VALUES (country_seq.nextval,'Poland');
INSERT INTO Countries (country_id,country_name)
VALUES (country_seq.nextval,'Ukraine');
INSERT INTO Countries (country_id,country_name)
VALUES (country_seq.nextval,'Danmark');
INSERT INTO Countries (country_id,country_name)
VALUES (country_seq.nextval,'Germany');

-- delete from Countries where country_id > 20;

SELECT * FROM Countries; 

-- Ukraine(Cities) 
--SELECT country_id into country_id from countries where country_name='Ukraine';
INSERT INTO Cities (city_id,city_name,country)
VALUES (city_seq.nextval,'Kharkiv',(select country_id from countries where country_name='Ukraine'));
INSERT INTO Cities (city_id,city_name,country)
VALUES (city_seq.nextval,'Kiev',(select country_id from countries where country_name='Ukraine'));
INSERT INTO Cities (city_id,city_name,country)
VALUES (city_seq.nextval,'Dnipro',(select country_id from countries where country_name='Ukraine'));


-- Poland(Cities)
--SELECT country_id into country_id from countries where country_name='Poland';
INSERT INTO Cities (city_id,city_name,country)
VALUES (city_seq.nextval,'Warsaw',(select country_id from countries where country_name='Poland'));
INSERT INTO Cities (city_id,city_name,country)
VALUES (city_seq.nextval,'Gdansk',(select country_id from countries where country_name='Poland'));
INSERT INTO Cities (city_id,city_name,country)
VALUES (city_seq.nextval,'Krakow',(select country_id from countries where country_name='Poland'));

-- Danmark(Cities)
--SELECT country_id into country_id from countries where country_name='Danmark';
INSERT INTO Cities (city_id,city_name,country)
VALUES (city_seq.nextval,'Kobenhavh',(select country_id from countries where country_name='Danmark'));
INSERT INTO Cities (city_id,city_name,country)
VALUES (city_seq.nextval,'Arhus',(select country_id from countries where country_name='Danmark'));
INSERT INTO Cities (city_id,city_name,country)
VALUES (city_seq.nextval,'Odens',(select country_id from countries where country_name='Danmark'));

-- Germany(Cities)
--SELECT country_id into country_id from countries where country_name='Germany';
INSERT INTO Cities (city_id,city_name,country)
VALUES (city_seq.nextval,'Berlin',(select country_id from countries where country_name='Germany'));
INSERT INTO Cities (city_id,city_name,country)
VALUES (city_seq.nextval,'Munich',(select country_id from countries where country_name='Germany'));
INSERT INTO Cities (city_id,city_name,country)
VALUES (city_seq.nextval,'Flensburg',(select country_id from countries where country_name='Germany'));


SELECT * FROM Cities;



--Documents_type

INSERT INTO Documents_type(type_id,type_name)
VALUES (documents_type_seq.nextval, 'Int. Passport');

INSERT INTO Documents_type(type_id,type_name)
VALUES (documents_type_seq.nextval ,'Driver License');

INSERT INTO Documents_type(type_id,type_name)
VALUES (documents_type_seq.nextval, 'ID card');

SELECT * FROM Documents_type;

--Persons

INSERT INTO Persons (person_id, telephone_number ,email, first_name,second_name )
VALUES (persons_seq.nextval, '+489120043203', 'smb@email.com', 'Ahmet', 'Duzduran');

INSERT INTO Persons (person_id, telephone_number ,email, first_name,second_name )
VALUES (persons_seq.nextval, '+380668340221', 'bohdan@email.com', 'Bohdan', 'Cordon');

INSERT INTO Persons (person_id, telephone_number ,email, first_name,second_name )
VALUES (persons_seq.nextval, '+430219300331', 'belarus.vpered@email.com', 'Vova', 'Belarus');

INSERT INTO Persons (person_id, telephone_number ,email, first_name,second_name )
VALUES (persons_seq.nextval, '+758203282092', 'smith.agent@email.com', 'John', 'Smith');

INSERT INTO Persons (person_id, telephone_number ,email, first_name,second_name )
VALUES (persons_seq.nextval, '+329859489385', 'sheiko@email.com', 'Masha', 'Sheika');

INSERT INTO Persons (person_id, telephone_number ,email, first_name,second_name )
VALUES (persons_seq.nextval, '+843748375854', 'serhii@email.com', 'Serhii', 'Ponomariov');

SELECT * FROM Persons;

--Documents

INSERT INTO Documents(document_num,document_id,type_id,person_id)
VALUES ('AH12T3' ,documents_seq.nextval, (select type_id from Documents_type where type_name='Int. Passport'),1);

INSERT INTO Documents(document_num,document_id,type_id,person_id)
VALUES ( 'BN542F' ,documents_seq.nextval ,(select type_id from Documents_type where type_name='Driver License'),2);

INSERT INTO Documents(document_num,document_id,type_id,person_id)
VALUES ('JYT51A' ,documents_seq.nextval, (select type_id from Documents_type where type_name='ID card'),6);

INSERT INTO Documents(document_num,document_id,type_id,person_id)
VALUES ('UYQW31Q'  ,documents_seq.nextval, (select type_id from Documents_type where type_name='Int. Passport'),4);

INSERT INTO Documents(document_num,document_id,type_id,person_id)
VALUES ('POQW43G' ,documents_seq.nextval ,(select type_id from Documents_type where type_name='Driver License'),5);

INSERT INTO Documents(document_num,document_id,type_id,person_id)
VALUES ('POYT61A' ,documents_seq.nextval, (select type_id from Documents_type where type_name='ID card'),3);

SELECT * FROM Documents;


--Connection type 
INSERT INTO Connection_type(type_id, type_name)
VALUES (connection_type_seq.nextval, 'Family' );

INSERT INTO Connection_type(type_id, type_name)
VALUES (connection_type_seq.nextval, 'Friends' );

INSERT INTO Connection_type(type_id, type_name)
VALUES (connection_type_seq.nextval, 'Colleagues' );

--Trustees persons 
INSERT INTO trustees_person( trustees_person_id, person_id,  person2_id ,type_id )
VALUES(trustees_person_seq.nextval, 1, 2, (select type_id from Connection_type where type_name='Colleagues' ) );

INSERT INTO trustees_person( trustees_person_id, person_id,  person2_id ,type_id )
VALUES(trustees_person_seq.nextval, 5, 6, (select type_id from Connection_type where type_name='Family' ) );

INSERT INTO trustees_person( trustees_person_id, person_id,  person2_id ,type_id )
VALUES(trustees_person_seq.nextval, 1, 3, (select type_id from Connection_type where type_name='Colleagues' ) );

INSERT INTO trustees_person( trustees_person_id, person_id,  person2_id ,type_id )
VALUES(trustees_person_seq.nextval, 2, 3, (select type_id from Connection_type where type_name='Friends' ) );

SELECT * FROM trustees_person;

--Groups 
INSERT INTO Travel_Groups ( groups_id, group_name)
VALUES (group_seq.nextval, 'Polish_group');

INSERT INTO Travel_Groups ( groups_id, group_name)
VALUES (group_seq.nextval, 'Ukraine_group');

INSERT INTO Travel_Groups ( groups_id, group_name)
VALUES (group_seq.nextval, 'Danmark_group');

INSERT INTO Travel_Groups ( groups_id, group_name)
VALUES (group_seq.nextval, 'Germany_group');

SELECT * FROM Travel_Groups;

--Leader person
INSERT INTO Leader_Person (leader_person_id, date_from, date_to, person_id, groups_id)
VALUES ( leader_person_seq.nextval,'23-MAY-2019', '30-MAY-2019', 4, (select groups_id from Travel_Groups where group_name='Germany_group' )  );

INSERT INTO Leader_Person (leader_person_id, date_from, date_to, person_id, groups_id)
VALUES ( leader_person_seq.nextval,'10-APR-2020', '15-APR-2020', 6, (select groups_id from Travel_Groups where group_name='Ukraine_group' )  );

INSERT INTO Leader_Person (leader_person_id, date_from, date_to, person_id, groups_id)
VALUES ( leader_person_seq.nextval,'10-DEC-2018', '20-DEC-2018', 3, (select groups_id from Travel_Groups where group_name='Polish_group' )  );

INSERT INTO Leader_Person (leader_person_id, date_from, date_to, person_id, groups_id)
VALUES ( leader_person_seq.nextval,'21-JAN-2021', '28-JAN-2021', 1, (select groups_id from Travel_Groups where group_name='Danmark_group' )  );

SELECT * FROM Leader_Person;

--Order

INSERT INTO  Orders (order_id, order_number,  person_id)
VALUES (orders_seq.nextval, 'SJG123', 1);

INSERT INTO  Orders (order_id, order_number,  person_id)
VALUES (orders_seq.nextval, 'ERTG543', 1);

INSERT INTO  Orders (order_id, order_number,  person_id)
VALUES (orders_seq.nextval, 'GQFTYDI56', 2);

INSERT INTO  Orders (order_id, order_number,  person_id)
VALUES (orders_seq.nextval, 'KIOAHS87', 3);

INSERT INTO  Orders (order_id, order_number,  person_id)
VALUES (orders_seq.nextval, 'TQUDLWHWI1', 3);

INSERT INTO  Orders (order_id, order_number,  person_id)
VALUES (orders_seq.nextval, 'YUQOPSB56', 3);

INSERT INTO  Orders (order_id, order_number,  person_id)
VALUES (orders_seq.nextval, 'SJG123', 4);

INSERT INTO  Orders (order_id, order_number,  person_id)
VALUES (orders_seq.nextval, 'GQFTYDI56', 4);

INSERT INTO  Orders (order_id, order_number,  person_id)
VALUES (orders_seq.nextval, 'YTWUQO6575', 6);

INSERT INTO  Orders (order_id, order_number,  person_id)
VALUES (orders_seq.nextval, 'KAOHFFMF891', 5);

SELECT * FROM Orders;



UPDATE  Orders SET price = 1500 WHERE order_number = 'SJG123' AND person_id = 1;
UPDATE  Orders SET price = 2000 WHERE order_number = 'ERTG543';
UPDATE  Orders SET price = 1300 WHERE order_number = 'GQFTYDI56' AND person_id = 2;
UPDATE  Orders SET price = 6500 WHERE order_number = 'KIOAHS87';
UPDATE  Orders SET price = 7200 WHERE order_number = 'TQUDLWHWI1';
UPDATE  Orders SET price = 2340 WHERE order_number = 'YUQOPSB56';
UPDATE  Orders SET price = 5683 WHERE order_number = 'SJG123' AND person_id = 4;
UPDATE  Orders SET price = 3021 WHERE order_number = 'GQFTYDI56' AND person_id = 4;
UPDATE  Orders SET price = 500 WHERE order_number = 'YTWUQO6575';
UPDATE  Orders SET price = 1291 WHERE order_number = 'KAOHFFMF891';




--Travel Plan
INSERT INTO Travel_plans (travel_id, travel_plan_name, price)
VALUES (travel_poland_seq.nextval, 'Mount Travel', 1202);

INSERT INTO Travel_plans (travel_id, travel_plan_name, price)
VALUES (travel_poland_seq.nextval, 'Capital Tour', 2312);

INSERT INTO Travel_plans (travel_id, travel_plan_name, price)
VALUES (travel_poland_seq.nextval, 'Sea Tour', 6032);

INSERT INTO Travel_plans (travel_id, travel_plan_name, price)
VALUES (travel_poland_seq.nextval, 'Canoe Tour', 8643);

SELECT * FROM Travel_plans;

--Travel Orders

INSERT INTO travels_order (order_id, travel_id)
VALUES (1,3);

INSERT INTO travels_order (order_id, travel_id)
VALUES (1,2);

INSERT INTO travels_order (order_id, travel_id)
VALUES (1,4);

INSERT INTO travels_order (order_id, travel_id)
VALUES (2,1);

INSERT INTO travels_order (order_id, travel_id)
VALUES (3,3);

INSERT INTO travels_order (order_id, travel_id)
VALUES (3,1);

INSERT INTO travels_order (order_id, travel_id)
VALUES (4,3);

INSERT INTO travels_order (order_id, travel_id)
VALUES (5,1);

INSERT INTO travels_order (order_id, travel_id)
VALUES (6,2);

INSERT INTO travels_order (order_id, travel_id)
VALUES (6,1);

INSERT INTO travels_order (order_id, travel_id)
VALUES (7,2);

INSERT INTO travels_order (order_id, travel_id)
VALUES (7,3);

INSERT INTO travels_order (order_id, travel_id)
VALUES (8,2);

INSERT INTO travels_order (order_id, travel_id)
VALUES (9,4);

SELECT * FROM travels_order;

--Groups_travel

INSERT INTO groups_travel(groups_id, travels_id)
VALUES (1,1);

INSERT INTO groups_travel(groups_id, travels_id)
VALUES (1,2);

INSERT INTO groups_travel(groups_id, travels_id)
VALUES (1,3);

INSERT INTO groups_travel(groups_id, travels_id)
VALUES (1,4);

INSERT INTO groups_travel(groups_id, travels_id)
VALUES (2,1);

INSERT INTO groups_travel(groups_id, travels_id)
VALUES (2,2);

INSERT INTO groups_travel(groups_id, travels_id)
VALUES (2,3);

INSERT INTO groups_travel(groups_id, travels_id)
VALUES (3,1);

INSERT INTO groups_travel(groups_id, travels_id)
VALUES (3,2);

INSERT INTO groups_travel(groups_id, travels_id)
VALUES (4,4);

SELECT * FROM groups_travel;


--Routes
INSERT INTO Routes (route_id, route_name, order_number, city_id, id_travel)
VALUES (route_seq.nextval,'Danmark-Poland-Ukraine', 3,(select city_id from Cities where city_name = 'Kiev'),( select travel_id from Travel_plans where travel_plan_name = 'Capital Tour' ) );

INSERT INTO Routes (route_id, route_name, order_number, city_id, id_travel)
VALUES (route_seq.nextval,'Poland-Ukraine', 3,(select city_id from Cities where city_name = 'Warsaw'),( select travel_id from Travel_plans where travel_plan_name = 'Capital Tour' )  );

INSERT INTO Routes (route_id, route_name, order_number, city_id, id_travel)
VALUES (route_seq.nextval,'Danmark-Poland', 2,(select city_id from Cities where city_name = 'Kobenhavh'),( select travel_id from Travel_plans where travel_plan_name = 'Capital Tour' ) );

INSERT INTO Routes (route_id, route_name, order_number, city_id, id_travel)
VALUES (route_seq.nextval,'Danmark-Ukraine', 6,(select city_id from Cities where city_name = 'Kiev'),( select travel_id from Travel_plans where travel_plan_name = 'Mount Travel' ) );

INSERT INTO Routes (route_id, route_name, order_number, city_id, id_travel)
VALUES (route_seq.nextval,'Ukraine-Germany', 8,(select city_id from Cities where city_name = 'Munich'),( select travel_id from Travel_plans where travel_plan_name = 'Mount Travel' )  );

INSERT INTO Routes (route_id, route_name, order_number, city_id, id_travel)
VALUES (route_seq.nextval,'Danmark-Germany', 10,(select city_id from Cities where city_name = 'Berlin'),( select travel_id from Travel_plans where travel_plan_name = 'Canoe Tour' ) );

INSERT INTO Routes (route_id, route_name, order_number, city_id, id_travel)
VALUES (route_seq.nextval,'Poland-Germany', 4,(select city_id from Cities where city_name = 'Berlin'),( select travel_id from Travel_plans where travel_plan_name = 'Canoe Tour' ) );

INSERT INTO Routes (route_id, route_name, order_number, city_id, id_travel)
VALUES (route_seq.nextval,'Germany-Danmark', 5,(select city_id from Cities where city_name = 'Odens'),( select travel_id from Travel_plans where travel_plan_name = 'Sea Tour' )  );

SELECT
    *
FROM Routes;


/
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




