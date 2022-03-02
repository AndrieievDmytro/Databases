-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-01-23 17:31:06.834

-- tables
-- Table: Cities
DROP TABLE Cities;
DROP TABLE Copy_of_Connection_type;
DROP TABLE Countries;
DROP TABLE Documents;
DROP TABLE Documents_type;
DROP TABLE Groups;
DROP TABLE Leader_Person;
DROP TABLE Orders;
DROP TABLE Persons;
DROP TABLE Routes;
DROP TABLE Travel_plans;
DROP TABLE groups_travel;
DROP TABLE travels_order;
DROP TABLE trustees_person;

CREATE TABLE Cities (
    city_name varchar(50)  NOT NULL,
    country int  NOT NULL,
    city_id int  NOT NULL,
    CONSTRAINT Cities_pk PRIMARY KEY  (city_id)
);

-- Table: Copy_of_Connection_type
CREATE TABLE Copy_of_Connection_type (
    type_id int  NOT NULL,
    type_name varchar(50)  NOT NULL,
    CONSTRAINT Copy_of_Connection_type_pk PRIMARY KEY  (type_id)
);

-- Table: Countries
CREATE TABLE Countries (
    country_id int  NOT NULL,
    country_name varchar(50)  NOT NULL,
    CONSTRAINT Countries_pk PRIMARY KEY  (country_id)
);

-- Table: Documents
CREATE TABLE Documents (
    document_num varchar(50)  NOT NULL,
    type_id int  NOT NULL,
    document_id int  NOT NULL,
    person_id int  NOT NULL,
    expired_date DATE,
    CONSTRAINT Documents_pk PRIMARY KEY  (document_id)
);

-- Table: Documents_type
CREATE TABLE Documents_type (
    type_id int  NOT NULL,
    type_name varchar(15)  NOT NULL,
    CONSTRAINT Documents_type_pk PRIMARY KEY  (type_id)
);

-- Table: Groups
CREATE TABLE Groups (
    groups_id int  NOT NULL,
    group_name varchar(15)  NOT NULL,
    CONSTRAINT Groups_pk PRIMARY KEY  (groups_id)
);

-- Table: Leader_Person
CREATE TABLE Leader_Person (
    leader_person_id int  NOT NULL,
    date_from date  NOT NULL,
    date_to date  NOT NULL,
    person_id int  NOT NULL,
    group_id int  NOT NULL,
    CONSTRAINT Leader_Person_pk PRIMARY KEY  (leader_person_id)
);

-- Table: Orders
CREATE TABLE Orders (
    order_id int  NOT NULL,
    order_number varchar(50)  NOT NULL,
    person_id int  NOT NULL,
    CONSTRAINT Orders_pk PRIMARY KEY  (order_id)
);

-- Table: Persons
CREATE TABLE Persons (
    person_id int  NOT NULL,
    telephone_number varchar(20)  NOT NULL,
    email varchar(50)  NOT NULL,
    first_name varchar(50)  NOT NULL,
    second_name varchar(50)  NOT NULL,
    CONSTRAINT Persons_pk PRIMARY KEY  (person_id)
);

CREATE INDEX Persons_name_idx on Persons (first_name ASC)
;

CREATE INDEX Persons_second_idx on Persons (second_name ASC)
;

-- Table: Routes
CREATE TABLE Routes (
    route_id int  NOT NULL,
    route_name varchar(50)  NOT NULL,
    city_id int  NOT NULL,
    id_travel int  NOT NULL,
    travel_days int NOT NULL,
    CONSTRAINT Routes_pk PRIMARY KEY  (route_id)
);

-- Table: Travel_plans
CREATE TABLE Travel_plans (
    travel_id int  NOT NULL,
    travel_name varchar(50)  NOT NULL,
    price money,
    CONSTRAINT Travel_plans_pk PRIMARY KEY  (travel_id)
);

-- Table: groups_travel
CREATE TABLE groups_travel (
    group_id int  NOT NULL,
    travel_id int  NOT NULL,
    CONSTRAINT groups_travel_pk PRIMARY KEY  (group_id,travel_id)
);

-- Table: travels_order
CREATE TABLE travels_order (
    order_id int  NOT NULL,
    travel_id int  NOT NULL,
    start_day DATE NOT NULL,
    CONSTRAINT travels_order_pk PRIMARY KEY  (order_id,travel_id)
);

CREATE INDEX travels_order_idx_1 on travels_order (order_id ASC)
;

-- Table: trustees_person
CREATE TABLE trustees_person (
    trustees_person_id int  NOT NULL,
    person_id int  NOT NULL,
    person2_id int  NOT NULL,
    type_id int  NOT NULL,
    CONSTRAINT trustees_person_pk PRIMARY KEY  (trustees_person_id)
);

-- foreign keys
-- Reference: Cities_Countries (table: Cities)
ALTER TABLE Cities ADD CONSTRAINT Cities_Countries
    FOREIGN KEY (country)
    REFERENCES Countries (country_id);

-- Reference: Connection_type (table: trustees_person)
ALTER TABLE trustees_person ADD CONSTRAINT Connection_type
    FOREIGN KEY (type_id)
    REFERENCES Copy_of_Connection_type (type_id);

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
    REFERENCES Groups (groups_id);

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
    FOREIGN KEY (group_id)
    REFERENCES Groups (groups_id);

-- Reference: groups_travel_Travel_plans (table: groups_travel)
ALTER TABLE groups_travel ADD CONSTRAINT groups_travel_Travel_plans
    FOREIGN KEY (travel_id)
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

--Countries

INSERT INTO Countries (country_id,country_name)
VALUES(1,'Poland');
INSERT INTO Countries (country_id,country_name)
VALUES(2 ,'Ukraine');
INSERT INTO Countries (country_id,country_name)
VALUES (3,'Danmark');
INSERT INTO Countries (country_id,country_name)
VALUES (4,'Germany');


-- Ukraine(Cities) 
--SELECT country_id into country_id from countries where country_name='Ukraine';
INSERT INTO Cities (city_id,city_name,country)
VALUES (1,'Kharkiv',(select country_id from countries where country_name='Ukraine'));
INSERT INTO Cities (city_id,city_name,country)
VALUES (2,'Kiev',(select country_id from countries where country_name='Ukraine'));
INSERT INTO Cities (city_id,city_name,country)
VALUES (3,'Dnipro',(select country_id from countries where country_name='Ukraine'));


-- Poland(Cities)
--SELECT country_id into country_id from countries where country_name='Poland';
INSERT INTO Cities (city_id,city_name,country)
VALUES (4,'Warsaw',(select country_id from countries where country_name='Poland'));
INSERT INTO Cities (city_id,city_name,country)
VALUES (5,'Gdansk',(select country_id from countries where country_name='Poland'));
INSERT INTO Cities (city_id,city_name,country)
VALUES (6,'Krakow',(select country_id from countries where country_name='Poland'));

-- Danmark(Cities)
--SELECT country_id into country_id from countries where country_name='Danmark';
INSERT INTO Cities (city_id,city_name,country)
VALUES (7,'Kobenhavh',(select country_id from countries where country_name='Danmark'));
INSERT INTO Cities (city_id,city_name,country)
VALUES (8,'Arhus',(select country_id from countries where country_name='Danmark'));
INSERT INTO Cities (city_id,city_name,country)
VALUES (9,'Odens',(select country_id from countries where country_name='Danmark'));

-- Germany(Cities)
--SELECT country_id into country_id from countries where country_name='Germany';
INSERT INTO Cities (city_id,city_name,country)
VALUES (10,'Berlin',(select country_id from countries where country_name='Germany'));
INSERT INTO Cities (city_id,city_name,country)
VALUES (11,'Munich',(select country_id from countries where country_name='Germany'));
INSERT INTO Cities (city_id,city_name,country)
VALUES (12,'Flensburg',(select country_id from countries where country_name='Germany'));

--Documents_type

INSERT INTO Documents_type(type_id,type_name)
VALUES (1, 'Int. Passport');

INSERT INTO Documents_type(type_id,type_name)
VALUES (2 ,'Driver License');

INSERT INTO Documents_type(type_id,type_name)
VALUES (3, 'ID card');

SELECT * FROM Documents_type;

--Persons

INSERT INTO Persons (person_id, telephone_number ,email, first_name,second_name )
VALUES (1, '+489120043203', 'smb@email.com', 'Ahmet', 'Duzduran');

INSERT INTO Persons (person_id, telephone_number ,email, first_name,second_name )
VALUES (2, '+380668340221', 'bohdan@email.com', 'Bohdan', 'Cordon');

INSERT INTO Persons (person_id, telephone_number ,email, first_name,second_name )
VALUES (3, '+430219300331', 'belarus.vpered@email.com', 'Vova', 'Belarus');

INSERT INTO Persons (person_id, telephone_number ,email, first_name,second_name )
VALUES (4, '+758203282092', 'smith.agent@email.com', 'John', 'Smith');

INSERT INTO Persons (person_id, telephone_number ,email, first_name,second_name )
VALUES (5, '+329859489385', 'sheiko@email.com', 'Masha', 'Sheika');

INSERT INTO Persons (person_id, telephone_number ,email, first_name,second_name )
VALUES (6, '+843748375854', 'serhii@email.com', 'Serhii', 'Ponomariov');

SELECT * FROM Persons;

--Documents

INSERT INTO Documents(document_num,document_id,type_id,person_id, expired_date)
VALUES ('AH12T3' ,1, (select type_id from Documents_type where type_name='Int. Passport'),1, '30-MAY-2019' );

INSERT INTO Documents(document_num,document_id,type_id,person_id, expired_date)
VALUES ( 'BN542F' ,2 ,(select type_id from Documents_type where type_name='Driver License'),2, '15-MAR-2019');

INSERT INTO Documents(document_num,document_id,type_id,person_id, expired_date)
VALUES ('JYT51A' ,3, (select type_id from Documents_type where type_name='ID card'),6, '21-SEP-2021');

INSERT INTO Documents(document_num,document_id,type_id,person_id, expired_date)
VALUES ('UYQW31Q'  ,4, (select type_id from Documents_type where type_name='Int. Passport'),4, '25-APR-2022');

INSERT INTO Documents(document_num,document_id,type_id,person_id, expired_date)
VALUES ('POQW43G' ,5 ,(select type_id from Documents_type where type_name='Driver License'),5, '09-FEB-2015');

INSERT INTO Documents(document_num,document_id,type_id,person_id, expired_date)
VALUES ('POYT61A' ,6, (select type_id from Documents_type where type_name='ID card'),3, '05-JUL-2017');

SELECT * FROM Documents;


--Connection type 
INSERT INTO Copy_of_Connection_type(type_id, type_name)
VALUES (1, 'Family' );

INSERT INTO Copy_of_Connection_type(type_id, type_name)
VALUES (2, 'Friends' );

INSERT INTO Copy_of_Connection_type(type_id, type_name)
VALUES (3, 'Colleagues' );

--Trustees persons 
INSERT INTO trustees_person( trustees_person_id, person_id,  person2_id ,type_id )
VALUES(1, 1, 2, (select type_id from Copy_of_Connection_type where type_name='Colleagues' ) );

INSERT INTO trustees_person( trustees_person_id, person_id,  person2_id ,type_id )
VALUES(2, 5, 6, (select type_id from Copy_of_Connection_type where type_name='Family' ) );

INSERT INTO trustees_person( trustees_person_id, person_id,  person2_id ,type_id )
VALUES(3, 1, 3, (select type_id from Copy_of_Connection_type where type_name='Colleagues' ) );

INSERT INTO trustees_person( trustees_person_id, person_id,  person2_id ,type_id )
VALUES(4, 2, 3, (select type_id from Copy_of_Connection_type where type_name='Friends' ) );

SELECT * FROM trustees_person;

--Groups 
INSERT INTO Groups ( groups_id, group_name)
VALUES (1, 'Polish_group');

INSERT INTO Groups ( groups_id, group_name)
VALUES (2, 'Ukraine_group');

INSERT INTO Groups ( groups_id, group_name)
VALUES (3, 'Danmark_group');

INSERT INTO Groups ( groups_id, group_name)
VALUES (4, 'Germany_group');

SELECT * FROM Groups;

--Leader person
INSERT INTO Leader_Person (leader_person_id, date_from, date_to, person_id, group_id)
VALUES ( 1,'23-MAY-2019', '30-MAY-2019', 4, (select groups_id from Groups where group_name='Germany_group' )  );

INSERT INTO Leader_Person (leader_person_id, date_from, date_to, person_id, group_id)
VALUES ( 2,'10-APR-2020', '15-APR-2020', 6, (select groups_id from Groups where group_name='Ukraine_group' )  );

INSERT INTO Leader_Person (leader_person_id, date_from, date_to, person_id, group_id)
VALUES ( 3,'10-DEC-2018', '20-DEC-2018', 3, (select groups_id from Groups where group_name='Polish_group' )  );

INSERT INTO Leader_Person (leader_person_id, date_from, date_to, person_id, group_id)
VALUES ( 4,'21-JAN-2021', '28-JAN-2021', 1, (select groups_id from Groups where group_name='Danmark_group' )  );

SELECT * FROM Leader_Person;

--Order

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (1, 'SJG123', 1);

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (2, 'ERTG543', 1);

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (3, 'GQFTYDI56', 2);

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (4, 'KIOAHS87', 3);

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (5, 'TQUDLWHWI1', 3);

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (6, 'YUQOPSB56', 3);

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (7, 'SJG123', 4);

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (8, 'GQFTYDI56', 4);

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (9, 'YTWUQO6575', 6);

INSERT INTO  Orders (order_id, order_number,  person_id )
VALUES (10, 'KAOHFFMF891', 5);

SELECT * FROM Orders;




--Travel Plan
INSERT INTO Travel_plans (travel_id, travel_name, price)
VALUES (1, 'Mount Travel', 1500);

INSERT INTO Travel_plans (travel_id, travel_name, price)
VALUES (2, 'Capital Tour',6421);

INSERT INTO Travel_plans (travel_id, travel_name, price)
VALUES (3, 'Sea Tour', 1234);

INSERT INTO Travel_plans (travel_id, travel_name, price)
VALUES (4, 'Canoe Tour', 9121);

SELECT * FROM Travel_plans;

--Travel Orders

INSERT INTO travels_order (order_id, travel_id, start_day)
VALUES (1,3, '12-JUL-2020');

INSERT INTO travels_order (order_id, travel_id, start_day)
VALUES (1,2, '13-JUN-2018');

INSERT INTO travels_order (order_id, travel_id, start_day)
VALUES (1,4, '31-AUG-2016');

INSERT INTO travels_order (order_id, travel_id, start_day)
VALUES (2,1, '11-SEP-2021');

INSERT INTO travels_order (order_id, travel_id, start_day)
VALUES (3,3, '01-FEB-2022');

INSERT INTO travels_order (order_id, travel_id, start_day)
VALUES (3,1, '17-DEC-2019');

INSERT INTO travels_order (order_id, travel_id, start_day)
VALUES (4,3, '21-MAY-2017');

INSERT INTO travels_order (order_id, travel_id, start_day)
VALUES (5,1, '30-MAY-2019');

INSERT INTO travels_order (order_id, travel_id, start_day)
VALUES (6,2, '30-MAY-2019');

INSERT INTO travels_order (order_id, travel_id, start_day)
VALUES (6,1, '30-MAY-2018');

INSERT INTO travels_order (order_id, travel_id, start_day)
VALUES (7,2, '30-MAY-2017');

INSERT INTO travels_order (order_id, travel_id, start_day)
VALUES (7,3, '30-MAY-2016');

INSERT INTO travels_order (order_id, travel_id, start_day)
VALUES (8,2, '30-MAY-2021');

INSERT INTO travels_order (order_id, travel_id, start_day)
VALUES (9,4, '30-MAY-2018');

INSERT INTO travels_order (order_id, travel_id, start_day)
VALUES (5,3, '30-MAY-2018');


SELECT * FROM travels_order;

--Groups_travel

INSERT INTO groups_travel(group_id, travel_id)
VALUES (1,1);

INSERT INTO groups_travel(group_id, travel_id)
VALUES (1,2);

INSERT INTO groups_travel(group_id, travel_id)
VALUES (1,3);

INSERT INTO groups_travel(group_id, travel_id)
VALUES (1,4);

INSERT INTO groups_travel(group_id, travel_id)
VALUES (2,1);

INSERT INTO groups_travel(group_id, travel_id)
VALUES (2,2);

INSERT INTO groups_travel(group_id, travel_id)
VALUES (2,3);

INSERT INTO groups_travel(group_id, travel_id)
VALUES (3,1);

INSERT INTO groups_travel(group_id, travel_id)
VALUES (3,2);

INSERT INTO groups_travel(group_id, travel_id)
VALUES (4,4);

SELECT * FROM groups_travel;


--Routes
INSERT INTO Routes (route_id, route_name, travel_days, city_id, id_travel)
VALUES (1,'Danmark-Poland-Ukraine', 14,(select city_id from Cities where city_name = 'Kiev'),( select travel_id from Travel_plans where travel_name = 'Capital Tour' ) );

INSERT INTO Routes (route_id, route_name, travel_days, city_id, id_travel)
VALUES (2,'Poland-Ukraine', 7,(select city_id from Cities where city_name = 'Warsaw'),( select travel_id from Travel_plans where travel_name = 'Capital Tour' )  );

INSERT INTO Routes (route_id, route_name, travel_days, city_id, id_travel)
VALUES (3,'Danmark-Poland', 30,(select city_id from Cities where city_name = 'Kobenhavh'),( select travel_id from Travel_plans where travel_name = 'Capital Tour' ) );

INSERT INTO Routes (route_id, route_name, travel_days, city_id, id_travel)
VALUES (4,'Danmark-Ukraine', 90,(select city_id from Cities where city_name = 'Kiev'),( select travel_id from Travel_plans where travel_name = 'Mount Travel' ) );

INSERT INTO Routes (route_id, route_name, travel_days, city_id, id_travel)
VALUES (5,'Ukraine-Germany', 15,(select city_id from Cities where city_name = 'Munich'),( select travel_id from Travel_plans where travel_name = 'Mount Travel' )  );

INSERT INTO Routes (route_id, route_name, travel_days, city_id, id_travel)
VALUES (6,'Danmark-Germany', 17,(select city_id from Cities where city_name = 'Berlin'),( select travel_id from Travel_plans where travel_name = 'Canoe Tour' ) );

INSERT INTO Routes (route_id, route_name, travel_days, city_id, id_travel)
VALUES (7,'Poland-Germany', 60,(select city_id from Cities where city_name = 'Berlin'),( select travel_id from Travel_plans where travel_name = 'Canoe Tour' ) );

INSERT INTO Routes (route_id, route_name, travel_days, city_id, id_travel)
VALUES (8,'Germany-Danmark', 25,(select city_id from Cities where city_name = 'Odens'),( select travel_id from Travel_plans where travel_name = 'Sea Tour' )  );

SELECT
    *
FROM Routes;


-- (1p) 1 TABLE or SCALAR function
-- Function which calculate the difference between travel start date and expired date of international passport or id 
-- DROP  FUNCTION travel_Days;
go

CREATE FUNCTION travel_Days(@doc_id int, @start_date DATE)
RETURNS INTEGER
AS
BEGIN	
    DECLARE @dayC int;

    SELECT @dayC = DATEDIFF(DAY,  @start_date, expired_date) FROM Documents  WHERE document_id = @doc_id;  
	
    RETURN @dayC ;
END

GO

/*Example:
Expired day of passport 2019-03-15
Returns -26 as the possible number of days for the travel that will be set up on 10th of April 2019  => so such a travel is not possible for Bohdan
*/

Declare
@doc_id int;
Select @doc_id = document_id FROM Documents d left join Persons p on d.person_id = p.person_id where p.first_name = 'Bohdan';  
SELECT s21353.travel_Days(@doc_id,'10-APR-2019'); 


-- (1p) 1 procedure with output parameter(s)
-- Procedure which returns all possible routes according to the chosen by customer travel plan and expired date of his/her travel document 

-- DROP PROCEDURE ValidDoc
GO
CREATE PROCEDURE ValidDoc
@person_id INT, 
@travel_plan_id int, 
@start_date DATE, 
@Cursor CURSOR VARYING OUTPUT
AS
BEGIN 
    DECLARE @DocValidDays INT;

    SET NOCOUNT ON;  

    SELECT @DocValidDays = s21353.travel_Days(document_id, @start_date ) 
    from Documents where person_id = @person_id;

    SET @Cursor = CURSOR  
    FORWARD_ONLY STATIC FOR  
        Select t.travel_id, SUM(r.travel_days) from Travel_plans t 
        left join Routes r ON t.travel_id = r.id_travel
        WHERE @travel_plan_id = travel_id
        Group by t.travel_id
        HAVING @DocValidDays < SUM(r.travel_days)
    OPEN @Cursor;  
END;

GO

SELECT * FROM Persons ;
SELECT * FROM Travel_plans ;

/*Example: Choses the number of possible travel days for Bohdan in travel plan "Sea tour" 
 according to expired day of his travel documents if the start of trevel is 10 May of 2019. */
DECLARE @persId int,
@Mycursor CURSOR,
@travelid int, 
@chosenTravelplan int,
@days int;
SELECT @persId =  person_id FROM Persons where first_name = 'Bohdan';
SELECT @chosenTravelplan = travel_id FROM Travel_plans WHERE travel_name = 'Sea Tour'
EXEC ValidDoc  @persId, @chosenTravelplan, '10-MAY-2019', @Cursor = @MyCursor OUTPUT
FETCH NEXT FROM @MyCursor INTO @travelid, @days; 
WHILE (@@FETCH_STATUS = 0)  
BEGIN;  
     PRINT 'There is travel plan with id ' + CAST(@travelid AS VARCHAR) + ' with max number of days in tour ' + CAST(@days AS VARCHAR);
     FETCH NEXT FROM @MyCursor INTO @travelid, @days; 
END;  
CLOSE @MyCursor;  
DEALLOCATE @MyCursor;  


GO
-- (1p) 1 trigger
-- Trigger which not allow to add the route to order if customers' document is expired within the travel 
-- DROP TRIGGER insertOrder 
CREATE TRIGGER insertOrder 
ON travels_order
FOR INSERT
AS 
BEGIN
    DECLARE 
    @MyCursor CURSOR,
    @InsCursor CURSOR,
    @travelid int, 
    @days int,
    @instravelid int,
    @insstartday DATE;

    SET @InsCursor = CURSOR  
    FORWARD_ONLY STATIC FOR 
    SELECT travel_id, start_day FROM inserted;
    OPEN @InsCursor;
    FETCH NEXT FROM @InsCursor INTO @instravelid, @insstartday; 
    WHILE (@@FETCH_STATUS = 0)  
    BEGIN;  
        EXEC ValidDoc 1, @instravelid, @insstartday, @Cursor = @MyCursor OUTPUT
        FETCH NEXT FROM @MyCursor INTO @travelid, @days; 
        IF (@@FETCH_STATUS <> 0) BEGIN
            RAISERROR('Expired documents', 13, -1)
        END;
        FETCH NEXT FROM @InsCursor INTO @instravelid, @insstartday;
        DEALLOCATE @MyCursor; 
    END;  
    CLOSE @InsCursor;  
    DEALLOCATE @InsCursor; 
END
    
/* 
Example: Insert into order additional travel plan 

*/
-- Not allow to insert because the travel documents was expired before travel start day
DELETE from travels_order
where start_day = '30-MAY-2018';

INSERT INTO travels_order (order_id, travel_id, start_day)
VALUES (5,3, '30-MAY-2018');

-- Allow
DELETE from travels_order
where start_day = '30-MAY-2019';

INSERT INTO travels_order (order_id, travel_id, start_day)
VALUES (6,3, '30-MAY-2019');