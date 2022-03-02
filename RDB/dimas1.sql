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
    docummrnt_id integer  NOT NULL,
    person_id integer  NOT NULL,
    CONSTRAINT Documents_pk PRIMARY KEY (docummrnt_id)
) ;

-- Table: Documents_type
CREATE TABLE Documents_type (
    type_id integer  NOT NULL,
    type_name varchar2(15)  NOT NULL,
    CONSTRAINT Documents_type_pk PRIMARY KEY (type_id)
) ;

-- Table: Groups
CREATE TABLE Groups (
    group_id integer  NOT NULL,
    group_name varchar2(15)  NOT NULL,
    CONSTRAINT Groups_pk PRIMARY KEY (group_id)
) ;

-- Table: Leader_Person
CREATE TABLE Leader_Person (
    leader_person_id integer  NOT NULL,
    date_from date  NOT NULL,
    date_to date  NOT NULL,
    person_id integer  NOT NULL,
    group_id integer  NOT NULL,
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
    Id_travel_pland integer  NOT NULL,
    CONSTRAINT Routes_pk PRIMARY KEY (route_id)
) ;

-- Table: Travel_plans
CREATE TABLE Travel_plans (
    travel_poland_id integer  NOT NULL,
    travel_plan_name varchar2(50)  NOT NULL,
    travel_plane_route integer  NOT NULL,
    CONSTRAINT Travel_plans_pk PRIMARY KEY (travel_poland_id)
) ;

-- Table: groups_travel
CREATE TABLE groups_travel (
    group_id integer  NOT NULL,
    polan_travel_id integer  NOT NULL,
    CONSTRAINT groups_travel_pk PRIMARY KEY (group_id,polan_travel_id)
) ;

-- Table: travels_order
CREATE TABLE travels_order (
    order_id integer  NOT NULL,
    travel_poland_id integer  NOT NULL,
    CONSTRAINT travels_order_pk PRIMARY KEY (order_id,travel_poland_id)
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
    FOREIGN KEY (group_id)
    REFERENCES Groups (group_id);

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
    FOREIGN KEY (Id_travel_pland)
    REFERENCES Travel_plans (travel_poland_id);

-- Reference: groups_travel_Groups (table: groups_travel)
ALTER TABLE groups_travel ADD CONSTRAINT groups_travel_Groups
    FOREIGN KEY (group_id)
    REFERENCES Groups (group_id);

-- Reference: groups_travel_Travel_plans (table: groups_travel)
ALTER TABLE groups_travel ADD CONSTRAINT groups_travel_Travel_plans
    FOREIGN KEY (polan_travel_id)
    REFERENCES Travel_plans (travel_poland_id);

-- Reference: travels_order_Orders (table: travels_order)
ALTER TABLE travels_order ADD CONSTRAINT travels_order_Orders
    FOREIGN KEY (order_id)
    REFERENCES Orders (order_id);

-- Reference: travels_order_Travel_plans (table: travels_order)
ALTER TABLE travels_order ADD CONSTRAINT travels_order_Travel_plans
    FOREIGN KEY (travel_poland_id)
    REFERENCES Travel_plans (travel_poland_id);

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

INSERT INTO Cities (city_id,city_name)
VALUES (city_seq.nextval,'Kharkiv');
INSERT INTO Cities (city_id,city_name)
VALUES (city_seq.nextval,'Kiev');
INSERT INTO Cities (city_id,city_name)
VALUES (city_seq.nextval,'Dnipro');

SELECT *FROM Cities;

CREATE SEQUENCE country_seq
START WITH 1
INCREMENT BY 1;

INSERT INTO Countries (country_id,country_name)
VALUES (country_seq.nextval,'Poland');
INSERT INTO Countries (country_id,country_name)
VALUES (country_seq.nextval,'Ukraine');

SELECT *FROM Countries; 
 
--FILL THE TABLES 3-4 RECORDS  
 
UPDATE 
SET 
WHERE
