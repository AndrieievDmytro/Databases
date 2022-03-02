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
/*
-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-04-01 08:35:20.165
tables
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

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (orders_seq.nextval, 'SJG123', 1);

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (orders_seq.nextval, 'ERTG543', 1);

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (orders_seq.nextval, 'GQFTYDI56', 2);

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (orders_seq.nextval, 'KIOAHS87', 3);

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (orders_seq.nextval, 'TQUDLWHWI1', 3);

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (orders_seq.nextval, 'YUQOPSB56', 3);

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (orders_seq.nextval, 'SJG123', 4);

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (orders_seq.nextval, 'GQFTYDI56', 4);

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (orders_seq.nextval, 'YTWUQO6575', 6);

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (orders_seq.nextval, 'KAOHFFMF891', 5);

SELECT * FROM Orders;




--Travel Plan
INSERT INTO Travel_plans (travel_id, travel_plan_name)
VALUES (travel_poland_seq.nextval, 'Mount Travel');

INSERT INTO Travel_plans (travel_id, travel_plan_name)
VALUES (travel_poland_seq.nextval, 'Capital Tour');

INSERT INTO Travel_plans (travel_id, travel_plan_name)
VALUES (travel_poland_seq.nextval, 'Sea Tour');

INSERT INTO Travel_plans (travel_id, travel_plan_name)
VALUES (travel_poland_seq.nextval, 'Canoe Tour');

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



--1 SELECT statements that joins at least two tables and contains WHERE clause

select p.first_name, p.second_name, d.document_num , o.order_number
from Persons p 
join Documents d on p.person_id = d.person_id
join Orders o on p.person_id = o.person_id
where p.person_id = 1;

--1 SELECT statements that joins at least two tables and contains GROUP BY and HAVING clauses

select co.country_name  , ci.city_name, listagg(r.route_name, ', ' ) within group(order by r.route_name) "Routs Description", count('Routes')
from Countries co
join Cities ci on co.country_id = ci.country  
join Routes r on ci.city_id = r.city_id
 having count('Routes') >= 1
 group by co.country_name, ci.city_name;


--1 SELECT statement with subquery

select tp.type_id, tp.person_id
from trustees_person tp
where tp.type_id in ( select ct.type_id from connection_type ct where ct.type_name in ('Colleagues', 'Friends'));


--1 SELECT statement with correlated subquery
select ci.city_name, 
(select listagg(r.route_name, ', ' ) within group(order by r.route_name)from routes r where r.city_id = ci.city_id ) "routes"
from Cities ci
where (select count(r.route_id) rcount from Routes r where r.city_id = ci.city_id group by r.city_id ) > 1;



-----------------------Trigger Before---------------------------------------

--1st trigger

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

ALTER TRIGGER trBfI ENABLE;
ALTER TABLE Persons ENABLE ALL TRIGGERS;

INSERT INTO Persons (person_id, telephone_number ,email, first_name,second_name )
VALUES (persons_seq.nextval, '+489203423551', 'akshdkla@email.com', 'Bat', 'Man');

INSERT INTO Persons (person_id, telephone_number ,email, first_name,second_name )
VALUES (persons_seq.nextval, '+489646776213', 'dadsfagr@email.com', 'Spider', 'Man');

UPDATE 
    Persons  
SET 
    telephone_number = '+4787509293202'
WHERE person_id = 8;

select count(person_id) from persons;
select* from persons;
/
--2nd before trigger
SET TERMOUT on
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

delete from cities where city_id = 10;

select * from routes where city_id = 10;

drop trigger cities_r;

commit;

/

Create trigger before_update
before update  on Documents 
for each row 
declare counter_x int;
begin 
 select count(1) into counter_x from persons p where p.person_id =: new.person_id;
end;

UPDATE 
    Documents
SET 
    person_id = 3
WHERE document_id = 4;

select * from persons;
select * from documents;
--Trigger After
/
CREATE or replace TRIGGER after_trigger
    AFTER
    INSERT OR UPDATE OR DELETE 
    ON Documents
    FOR EACH ROW
DECLARE
    changes varchar2(50);
BEGIN 
    changes := CASE 
    WHEN UPDATING THEN 'UPDATE'
    WHEN DELETING THEN 'DELETE'
    WHEN INSERTING THEN 'INSERT'
    end;   
    INSERT INTO audits (audit_id ,table_name, operation_name, operation_date)
    VALUES(audit_seq.nextval ,'Documents', changes, SYSDATE);    
END;
   
UPDATE 
    Documents 
SET 
    document_num = 'AB456111'
WHERE document_id = 6;

DELETE FROM Documents 
WHERE document_id =1;

select document_num from 
Persons p join Documents d on p.person_id = d.person_id  
WHERE p.person_id = 6;

select * from audits;

/
*/




-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-06-23 11:10:18.634

-- tables
-- Table: Appointment
CREATE TABLE Appointment (
    idAppointment integer  NOT NULL,
    "date" date  NOT NULL,
    price number(10,2)  NOT NULL,
    description varchar2(250)  NOT NULL,
    idPatient integer  NOT NULL,
    idDoctor integer  NOT NULL,
    CONSTRAINT Appointment_pk PRIMARY KEY (idAppointment)
) ;

-- Table: Doctor
CREATE TABLE Doctor (
    idDoctor integer  NOT NULL,
    firstName varchar2(30)  NOT NULL,
    secondName varchar2(40)  NOT NULL,
    salary number(10,2)  NOT NULL,
    idSpecialization integer  NOT NULL,
    CONSTRAINT Doctor_pk PRIMARY KEY (idDoctor)
) ;

-- Table: Patient
CREATE TABLE Patient (
    idPatient integer  NOT NULL,
    FirstName varchar2(30)  NOT NULL,
    lastName varchar2(30)  NOT NULL,
    dateOfbir DATE  NOT NULL,
    CONSTRAINT Patient_pk PRIMARY KEY (idPatient)
) ;

-- Table: Spec
CREATE TABLE Spec (
    idSpecialization integer  NOT NULL,
    name varchar2(50)  NOT NULL,
    CONSTRAINT Spec_pk PRIMARY KEY (idSpecialization)
) ;

-- foreign keys
-- Reference: Appointment_Doctor (table: Appointment)
ALTER TABLE Appointment ADD CONSTRAINT Appointment_Doctor
    FOREIGN KEY (idDoctor)
    REFERENCES Doctor (idDoctor);

-- Reference: Appointment_Patient (table: Appointment)
ALTER TABLE Appointment ADD CONSTRAINT Appointment_Patient
    FOREIGN KEY (idPatient)
    REFERENCES Patient (idPatient);

-- Reference: Doctor_Spec (table: Doctor)
ALTER TABLE Doctor ADD CONSTRAINT Doctor_Spec
    FOREIGN KEY (idSpecialization)
    REFERENCES Spec (idSpecialization);

-- End of file.
insert 
into Spec (
    idSpecialization ,
    name )
values (1,'Occulist');

insert 
into Spec (
    idSpecialization ,
    name )
values (2,'Lor');

insert 
into Spec (
    idSpecialization ,
    name )
values (3,'Dentist');


insert 
into  Doctor (
    idDoctor ,
    firstName ,
    secondName,
    salary ,
    idSpecialization)
values(1, 'Mr', 'Smith',200, 2);

insert 
into  Doctor (
    idDoctor ,
    firstName ,
    secondName,
    salary ,
    idSpecialization)
values(2, 'Mr', 'Grant',100, 2);

insert 
into  Doctor (
    idDoctor ,
    firstName ,
    secondName,
    salary ,
    idSpecialization)
values(3, 'Mr', 'Ralf',500, 3);


insert 
into  Doctor (
    idDoctor ,
    firstName ,
    secondName,
    salary ,
    idSpecialization)
values(4, 'Mr', 'Torn',200, 1);


insert 
into  Doctor (
    idDoctor ,
    firstName ,
    secondName,
    salary ,
    idSpecialization)
values(5, 'Mr', 'Young',200, 1);



insert
into patient    (idPatient, 
                FirstName,
                lastName ,
                dateOfbir)
    values(1, 'Peter', 'Parker', '10-AUG-2018' ); 

insert
into patient    (idPatient, 
                FirstName,
                lastName ,
                dateOfbir)
    values(2, 'Ben', 'Parker', '10-AUG-2012' ); 



insert 
into Appointment (
    idAppointment,
    "date",  
    price ,
    description ,
    idPatient ,
    idDoctor )
values (1,'10-APR-2018',300,'some text', 1,1 );

insert 
into Appointment (
    idAppointment,
    "date",  
    price ,
    description ,
    idPatient ,
    idDoctor )
values (2,'10-DEC-2011',150,'some text', 1,2 );

insert 
into Appointment (
    idAppointment,
    "date",  
    price ,
    description ,
    idPatient ,
    idDoctor )
values (3,'10-APR-2013',300,'some text', 1,2 );


insert 
into Appointment (
    idAppointment,
    "date",  
    price ,
    description ,
    idPatient ,
    idDoctor )
values (4,'10-APR-2015',300,'some text', 1,2 );


insert 
into Appointment (
    idAppointment,
    "date",  
    price ,
    description ,
    idPatient ,
    idDoctor )
values (5,'10-APR-2016',300,'some text', 1,2 );

insert 
into Appointment (
    idAppointment,
    "date",  
    price ,
    description ,
    idPatient ,
    idDoctor )
values (6,'10-APR-2017',300,'some text', 1,2 );

insert 
into Appointment (
    idAppointment,
    "date",  
    price ,
    description ,
    idPatient ,
    idDoctor )
values (7,'10-APR-2019',300,'some text', 1,1 );

insert 
into Appointment (
    idAppointment,
    "date",  
    price ,
    description ,
    idPatient ,
    idDoctor )
values (8,'10-APR-2020',300,'some text', 1,1 );

insert 
into Appointment (
    idAppointment,
    "date",  
    price ,
    description ,
    idPatient ,
    idDoctor )
values (9,'10-APR-2018',300,'some text', 1,1 );
insert 
into Appointment (
    idAppointment,
    "date",  
    price ,
    description ,
    idPatient ,
    idDoctor )
values (10,'10-APR-2021',300,'some text', 2,3 );




--1
SELECT FirstName || ' ' || LastName Patient
FROM Patient
WHERE EXTRACT (YEAR FROM 
TO_DATE(DateOfBir,'DD-MON-RR')) = 2018
ORDER BY FirstName ASC;

--2
SELECT p.FirstName, p.LastName, d.FirstName, d.secondname
FROM Patient p left JOIN Appointment a ON a.idPatient = p.idPatient
JOIN Doctor d ON d.IdDoctor = a.IdDoctor;

--3
SELECT AVG (Salary), COUNT (1), s.Name
FROM Doctor d JOIN Spec s ON d.idSpecialization = s.idSpecialization
GROUP BY s.Name;
--HAVING COUNT (1) > 1;

--4
SELECT d.FirstName, d.secondname, COUNT (1)
FROM Doctor d JOIN Appointment a ON d.IdDoctor = a.IdDoctor
		JOIN Spec s ON d.idSpecialization = s.idSpecialization
where s.Name != 'dentist' AND EXTRACT(YEAR FROM TO_DATE( a."date",'DD-MON-RR')) = 2018 
GROUP BY d.FirstName, d.secondname
HAVING (count(1))<4;

--5
SELECT distinct d.FirstName, d.secondname
FROM Doctor d join appointment a on a.iddoctor = d.iddoctor
Minus
SELECT distinct d.FirstName, d.secondname
FROM Doctor d join appointment a on a.iddoctor = d.iddoctor
where  EXTRACT(YEAR FROM TO_DATE( "date", 'DD-MON-RR')) = 2011;

--6
select  firstname, secondname, apps_cnt 
from (
select d.firstname, d.secondname ,count(a.idappointment) apps_cnt, s.name
from Doctor d join Appointment a  ON d.IdDoctor = a.IdDoctor
              join Spec s         ON d.idSpecialization = s.idSpecialization
group by d.firstname, d.secondname, s.name
) dr_apps
where rownum = 1
order by apps_cnt desc;


select sp.name, d.FirstName, d.secondname
from spec sp inner join Doctor d on sp.IdSpecialization = d.IdSpecialization
             inner join Appointment a on d.IdDoctor = a.idDoctor
group by sp.name, d.FirstName, d.secondname
having count(1)  = (select max(count(1))
          from Appointment app
          group by app.IdAppointment);



--7
UPDATE Appointment
SET price = 50
WHERE IdDoctor = 2 AND IdPatient = (SELECT IdPatient
					FROM Patient
					WHERE FirstName = 'Peter');

--group by  d.firstname, d.secondname;
                    
--8  
--delete from appointment where iddoctor IN (Select d.iddoctor from doctor d join spec s on d.idSpecialization = s.idSpecialization where  s.Name LIKE 'L%');
--delete from doctor where idSpecialization IN (Select s.idSpecialization from spec s  where  s.Name LIKE 'L%');
--DELETE FROM Spec WHERE Name like 'L%';


--9 
select sp.name, d.FirstName, d.secondname, 12*d.salary
from spec sp inner join Doctor d on sp.IdSpecialization = d.IdSpecialization
             inner join Appointment a on d.IdDoctor = a.idDoctor
group by sp.name, d.FirstName, d.secondname, 12*d.salary
having count(1)  = (select min(count(1))
          from spec s
          group by s.IdSpecialization);


--10
SELECT EXTRACT (YEAR FROM TO_DATE( DateOfBir,'DD-MON-RR'))DateOfB, idpatient , count(1)
FROM Patient
GROUP BY IdPatient,EXTRACT (YEAR FROM TO_DATE( DateOfBir,'DD-MON-RR'))
having count(1)>0;


select * from Patient;
select * from Appointment;
select * from Spec;
select * from Doctor;

