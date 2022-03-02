BEGIN
  FOR c IN ( SELECT table_name FROM user_tables)
  LOOP
    EXECUTE IMMEDIATE 'DROP TABLE ' || c.table_name || ' CASCADE CONSTRAINTS' ;
  END LOOP;
END;
 
/

-- Table: Booking
CREATE TABLE Booking (
    IdBooking integer  NOT NULL,
    DateFrom date  NOT NULL,
    DateTo date  NOT NULL,
    IdGuest integer  NOT NULL,
    RoomNo integer  NOT NULL,
    Paid integer  NOT NULL,
    CONSTRAINT Booking_pk PRIMARY KEY (IdBooking)
) ;

-- Table: Category
CREATE TABLE Category (
    IdCategory integer  NOT NULL,
    Name varchar(20)  NOT NULL,
    Price numeric(8,2)  NOT NULL,
    CONSTRAINT Category_pk PRIMARY KEY (IdCategory)
) ;

-- Table: Guest
CREATE TABLE Guest (
    IdGuest integer  NOT NULL,
    FirstName varchar(20)  NOT NULL,
    LastName varchar(30)  NOT NULL,
    DiscountPercent integer  NULL,
    CONSTRAINT Guest_pk PRIMARY KEY (IdGuest)
) ;

-- Table: Room
CREATE TABLE Room (
    RoomNo integer  NOT NULL,
    IdCategory integer  NOT NULL,
    NumberOfBeds integer  NOT NULL,
    CONSTRAINT Room_pk PRIMARY KEY (RoomNo)
) ;

-- foreign keys
-- Reference: FK_0 (table: Room)
ALTER TABLE Room ADD CONSTRAINT FK_0
    FOREIGN KEY (IdCategory)
    REFERENCES Category (IdCategory);

-- Reference: FK_1 (table: Booking)
ALTER TABLE Booking ADD CONSTRAINT FK_1
    FOREIGN KEY (IdGuest)
    REFERENCES Guest (IdGuest);

-- Reference: FK_2 (table: Booking)
ALTER TABLE Booking ADD CONSTRAINT FK_2
    FOREIGN KEY (RoomNo)
    REFERENCES Room (RoomNo);

-- End of file.

/******************************** Inserts ****************************/

/******************************** Inserts in Guest ****************************/
INSERT INTO Guest (IdGuest, FirstName, LastName, DiscountPercent) VALUES (1, 'Marcin', 'Niewiński', 20);
INSERT INTO Guest (IdGuest, FirstName, LastName, DiscountPercent) VALUES (2, 'Jan', 'Kowalski', NULL);
INSERT INTO Guest (IdGuest, FirstName, LastName, DiscountPercent) VALUES (3, 'Andrzej', 'Nowak', 10);
INSERT INTO Guest (IdGuest, FirstName, LastName, DiscountPercent) VALUES (4, 'Ferdynand', 'Kiepski', 30);
INSERT INTO Guest (IdGuest, FirstName, LastName, DiscountPercent) VALUES (5, 'Arnold', 'Boczek', NULL);
INSERT INTO Guest (IdGuest, FirstName, LastName, DiscountPercent) VALUES (6, 'Marian', 'Paździoch', 5);
INSERT INTO Guest (IdGuest, FirstName, LastName, DiscountPercent) VALUES (7, 'Halina', 'Kiepska', 15);
INSERT INTO Guest (IdGuest, FirstName, LastName, DiscountPercent) VALUES (8, 'Edward', 'Listonosz', 20);
INSERT INTO Guest (IdGuest, FirstName, LastName, DiscountPercent) VALUES (9, 'Helena', 'Paździoch', NULL);
INSERT INTO Guest (IdGuest, FirstName, LastName, DiscountPercent) VALUES (10, 'Alfred', 'Iksiński', 20);

/******************************** Inserts in Category ****************************/
INSERT INTO Category (IdCategory, Name, Price) VALUES (1, 'Tourist', 30);
INSERT INTO Category (IdCategory, Name, Price) VALUES (2, 'Regular', 60);
INSERT INTO Category (IdCategory, Name, Price) VALUES (3, 'Luxury', 120);

/******************************** Inserts in Room ****************************/
INSERT INTO Room (RoomNo, IdCategory, NumberOfBeds) VALUES (101, 1, 2);
INSERT INTO Room (RoomNo, IdCategory, NumberOfBeds) VALUES (102, 1, 2);
INSERT INTO Room (RoomNo, IdCategory, NumberOfBeds) VALUES (103, 1, 3);
INSERT INTO Room (RoomNo, IdCategory, NumberOfBeds) VALUES (104, 2, 2);
INSERT INTO Room (RoomNo, IdCategory, NumberOfBeds) VALUES (105, 2, 2);
INSERT INTO Room (RoomNo, IdCategory, NumberOfBeds) VALUES (201, 1, 2);
INSERT INTO Room (RoomNo, IdCategory, NumberOfBeds) VALUES (202, 3, 4);
INSERT INTO Room (RoomNo, IdCategory, NumberOfBeds) VALUES (203, 3, 2);
INSERT INTO Room (RoomNo, IdCategory, NumberOfBeds) VALUES (204, 3, 2);
INSERT INTO Room (RoomNo, IdCategory, NumberOfBeds) VALUES (205, 2, 3);

/******************************** Inserts in Booking ****************************/
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (1, to_date('2009-07-01','YYYY-MM-DD'), to_date('2009-07-05','YYYY-MM-DD'), 1, 101, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (2, to_date('2008-01-03','YYYY-MM-DD'), to_date('2008-01-15','YYYY-MM-DD'), 1, 102, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (3, to_date('2009-07-15','YYYY-MM-DD'), to_date('2009-08-02','YYYY-MM-DD'), 2, 101, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (4, to_date('2008-12-12','YYYY-MM-DD'), to_date('2008-12-14','YYYY-MM-DD'), 3, 103, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (5, to_date('2009-05-01','YYYY-MM-DD'), to_date('2009-05-05','YYYY-MM-DD'), 3, 201, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (6, to_date('2009-04-01','YYYY-MM-DD'), to_date('2009-05-01','YYYY-MM-DD'), 4, 201, 0);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (7, to_date('2008-11-15','YYYY-MM-DD'), to_date('2008-11-20','YYYY-MM-DD'), 4, 105, 0);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (8, to_date('2009-10-01','YYYY-MM-DD'), to_date('2009-10-07','YYYY-MM-DD'), 10, 104, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (9, to_date('2009-07-03','YYYY-MM-DD'), to_date('2009-07-20','YYYY-MM-DD'), 10, 204, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (10, to_date('2009-03-12','YYYY-MM-DD'), to_date('2009-03-20','YYYY-MM-DD'), 9, 201, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (11, to_date('2009-12-01','YYYY-MM-DD'), to_date('2009-12-02','YYYY-MM-DD'), 9, 202, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (12, to_date('2009-12-01','YYYY-MM-DD'), to_date('2009-12-10','YYYY-MM-DD'), 8, 202, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (13, to_date('2008-03-03','YYYY-MM-DD'), to_date('2008-03-12','YYYY-MM-DD'), 1, 203, 0);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (14, to_date('2009-08-25','YYYY-MM-DD'), to_date('2009-09-01','YYYY-MM-DD'), 6, 203 , 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (15, to_date('2009-04-16','YYYY-MM-DD'), to_date('2009-04-21','YYYY-MM-DD'), 6, 101, 0);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (16, to_date('2009-04-17','YYYY-MM-DD'), to_date('2009-04-20','YYYY-MM-DD'), 6, 105, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (17, to_date('2009-02-12','YYYY-MM-DD'), to_date('2009-02-14','YYYY-MM-DD'), 5, 104, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (18, to_date('2008-11-10','YYYY-MM-DD'), to_date('2008-11-20','YYYY-MM-DD'), 1, 103, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (19, to_date('2009-06-07','YYYY-MM-DD'), to_date('2009-06-15','YYYY-MM-DD'), 2, 101, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (20, to_date('2009-07-01','YYYY-MM-DD'), to_date('2009-07-05','YYYY-MM-DD'), 3, 101, 1);

/******************************** End ****************************/


/****************  Tables check  ******************/
SELECT * from Guest;
where IDGUEST = 1 or IDGUEST = 3 or IDGUEST = 4;

SELECT * from BOOKING
where EXTRACT(Year from DATEFROM ) = 2008;

SELECT * from CATEGORY;

SELECT * FROM ROOM
where IDCATEGORY = 3;

SELECT ROOMNO FROM ROOM;

SELECT * from Guest
where FirstName ='Marian'and lastname ='Paździoch';
/*************** End *********************/



/*******************  Solutions  *********************/

-- Task1
-- List all hotel clients in alphabetical order (sort by last name and first name).
SELECT * from guest 
ORDER BY LastName ASC , FirstName ASC; 

-- Task2
-- Provide, without repetition, all discount values in the table sorted in descending order.
SELECT DISTINCT DiscountPercent from guest
ORDER BY DiscountPercent DESC;


-- 3. List all reservations of guest named Kiepski.
SELECT IdBooking from Booking b
LEFT JOIN Guest g ON b.IdGuest = g.IdGuest 
WHERE g.lastname = 'Kiepski';

-- 4. List guests who do not have a discount. Sort them by first name.
SELECT FirstName , LastName from Guest
WHERE DiscountPercent is NULL
ORDER BY FirstName ASC;


-- 5. List reservations from 2008 for those customers, whose names start with the letter "K" or "L". Display the name, surname and room number.
SELECT g.FirstName , g.LastNAme , b.RoomNo, b.datefrom, g.IDGUEST 
From Guest g , BOOKING b  
where g.IdGuest = b.IdGuest and EXTRACT(Year from DATEFROM ) = 2008 and (g.FirstName like 'A%' or  g.FirstName like 'L%');

-- 6. List clients who haven’t paid yet (field "paid" equal to 0).
SELECT g.FirstName, g.lastname from guest g 
left join booking b on g.idguest = b.idguest 
where b.paid = 0;

-- 7. List clients who have booked a luxury room at least once.
SELECT g.FirstName, g.lastname, r.IdCategory from GUEST g 
left join BOOKING b on g.idguest = b.idguest 
left join ROOM r on r.roomNo = b.roomNo
-- where r.idcategory = 3;
left join CATEGORY c on c.IdCategory = r.IdCategory
where c.name ='Luxury';

-- 8. List the rooms rented by Andrzej Nowak.
SELECT g.FirstName, g.lastname, r.roomno from ROOM r left join 
BOOKING b on b.roomno = r.roomNo left join 
GUEST g on g.idguest = b.idguest 
where g.FirstName = 'Andrzej' and g.lastname = 'Nowak';  

-- 9. List the names of the guests along with the number of reservations made by them. Do not write out guests who have less than 3 reservations.

select g.FirstName, g.lastname,  COUNT(*)
from BOOKING b left join  GUEST g on b.idguest = g.idguest
GROUP by g.FirstName, g.lastname
HAVING  count(*) >= 3;

-- 10. Calculate how many people can stay at the hotel at the same time.
Select SUM(NUMBEROFBEDS) from ROOM;

-- 11. Calculate how many people can stay at the hotel in each category at the same time.
Select c.name, sum(NUMBEROFBEDS) from ROOM r 
right join CATEGORY c 
on r.idcategory = c.idcategory
GROUP BY c.name;

-- 12. Enter the number of rooms in each category.
SELECT c.name, count(*) from ROOM r 
right join CATEGORY c 
on r.idcategory = c.idcategory
GROUP BY c.name;

-- 13. Find a room that has never been booked.
SELECT r.ROOMNO , b.IdBooking from ROOM r 
left join BOOKING b on r.roomno = b.roomno
where b.IDBOOKING is null;


SELECT r.ROOMNO , count(*) from ROOM r 
right join BOOKING b on r.roomno = b.roomno
group by r.ROOMNO 
order by r.ROOMNO ASC;

-- 14. Find customers who have used the hotel services only once.
SELECT g.FirstName , g.lastname, count(*)  from guest g
full join BOOKING b on g.idguest = b.idguest
GROUP by g.FirstName , g.lastname
HAVING count(*) = 1;

-- ORA-00604: error occurred at recursive SQL level 1
-- ORA-02399: exceeded maximum connect time, you are being logged off

-- 15. List clients who slept in room 101 and paid.
SELECT  g.FirstName , g.lastname from guest g
full join BOOKING b on g.idguest = b.idguest
where b.roomno = 101 and b.paid = 1;

-- 16. Count how much the hotel earned on Marian Paździoch considering the price per night, the number of days and the discount.

SELECT  g.FirstName "Client first name" , g.lastname "Client last name",  count(*) "Total number of stays", sum(c.price*(1-g.DISCOUNTPERCENT/100)) "Money spent in total"
from guest g, BOOKING b , ROOM r ,CATEGORY c 
where  g.idguest = b.idguest and r.roomNo = b.roomNo and c.IdCategory = r.IdCategory and g.FirstName ='Marian'and g.lastname ='Paździoch'
GROUP by g.FirstName , g.lastname;






/******************** Appointment at the Doctor DB **************************/
CREATE TABLE Appointment (
    doctor_id int  NOT NULL,
    patient_id integer  NOT NULL,
    appointment_id integer  NOT NULL,
    "date" date  NOT NULL,
    price number(8,2)  NOT NULL,
    description varchar2(250)  NULL,
    CONSTRAINT Appointment_pk PRIMARY KEY (appointment_id)
) ;

-- Table: Doctor
CREATE TABLE Doctor (
    doctor_id int  NOT NULL,
    first_name varchar2(20)  NOT NULL,
    last_name varchar2(20)  NOT NULL,
    salary number(8,2)  NOT NULL,
    spec_id integer  NOT NULL,
    CONSTRAINT Doctor_pk PRIMARY KEY (doctor_id)
) ;

-- Table: Patient
CREATE TABLE Patient (
    patient_id integer  NOT NULL,
    first_name varchar2(20)  NOT NULL,
    last_name varchar2(20)  NOT NULL,
    dateOfBirth date  NOT NULL,
    CONSTRAINT Patient_pk PRIMARY KEY (patient_id)
) ;

-- Table: Specialization
CREATE TABLE Specialization (
    spec_id integer  NOT NULL,
    name varchar2(20)  NOT NULL,
    CONSTRAINT Specialization_pk PRIMARY KEY (spec_id)
) ;

-- foreign keys
-- Reference: Appointment_Doctor (table: Appointment)
ALTER TABLE Appointment ADD CONSTRAINT Appointment_Doctor
    FOREIGN KEY (doctor_id)
    REFERENCES Doctor (doctor_id);

-- Reference: Appointment_Patient (table: Appointment)
ALTER TABLE Appointment ADD CONSTRAINT Appointment_Patient
    FOREIGN KEY (patient_id)
    REFERENCES Patient (patient_id);

-- Reference: Doctor_Specialization (table: Doctor)
ALTER TABLE Doctor ADD CONSTRAINT Doctor_Specialization
    FOREIGN KEY (spec_id)
    REFERENCES Specialization (spec_id);

-- End of file.
DROP TABLE SPECIALIZATION;
DROP TABLE DOCTOR;
DROP TABLE PATIENT;
DROP TABLE APPOINTMENT;

Insert into Specialization(spec_id , name) VALUES (1, 'internist');
Insert into Specialization(spec_id , name) VALUES (2, 'Proctolog');
Insert into Specialization(spec_id , name) VALUES (3, 'dentists');
Insert into Specialization(spec_id , name) VALUES (4, 'orthopedists');


INSERT INTO  Patient (patient_id , first_name , last_name , dateOfBirth) VALUES (1, 'NPatien1' , 'SPatient1',to_date('1990-07-05','YYYY-MM-DD') );
INSERT INTO  Patient (patient_id , first_name , last_name , dateOfBirth) VALUES (2, 'NPatien2' , 'SPatient2',to_date('1991-07-05','YYYY-MM-DD') );
INSERT INTO  Patient (patient_id , first_name , last_name , dateOfBirth) VALUES (3, 'NPatien3' , 'SPatient3',to_date('1992-07-05','YYYY-MM-DD') );
INSERT INTO  Patient (patient_id , first_name , last_name , dateOfBirth) VALUES (4, 'NPatien4' , 'SPatient4',to_date('1993-07-05','YYYY-MM-DD') );
INSERT INTO  Patient (patient_id , first_name , last_name , dateOfBirth) VALUES (5, 'NPatien5' , 'SPatient5',to_date('1994-07-05','YYYY-MM-DD') );
INSERT INTO  Patient (patient_id , first_name , last_name , dateOfBirth) VALUES (6, 'NPatien6' , 'Kowalski',to_date('1995-07-05','YYYY-MM-DD') );
INSERT INTO  Patient (patient_id , first_name , last_name , dateOfBirth) VALUES (7, 'NPatien7' , 'SPatient7',to_date('1996-07-05','YYYY-MM-DD') );
INSERT INTO  Patient (patient_id , first_name , last_name , dateOfBirth) VALUES (8, 'NPatien8' , 'SPatient8',to_date('1997-07-05','YYYY-MM-DD') );
INSERT INTO  Patient (patient_id , first_name , last_name , dateOfBirth) VALUES (9, 'NPatien9' , 'SPatient9',to_date('1998-07-05','YYYY-MM-DD') );
INSERT INTO  Patient (patient_id , first_name , last_name , dateOfBirth) VALUES (10, 'NPatien10','SPatient10',to_date('1999-07-05','YYYY-MM-DD'));


INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (1, 'NDoctor1', 'SDoctor1', 2000, 1);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (2, 'NDoctor2', 'SDoctor2', 3000, 1);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (3, 'NDoctor3', 'SDoctor3', 1000, 1);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (4, 'NDoctor4', 'SDoctor4', 1500, 1);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (5, 'NDoctor5', 'SDoctor5', 3500, 1);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (6, 'NDoctor6', 'SDoctor6', 2000, 2);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (7, 'NDoctor7', 'SDoctor7', 5000, 2);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (8, 'NDoctor8', 'SDoctor8', 3500, 2);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (9, 'NDoctor9', 'SDoctor9', 10000, 2);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (10, 'NDoctor10', 'SDoctor10', 6500, 2);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (11, 'NDoctor11', 'SDoctor11', 3000, 3);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (12, 'NDoctor12', 'SDoctor12', 4000, 3);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (13, 'NDoctor13', 'SDoctor13', 5000, 3);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (14, 'NDoctor14', 'SDoctor14', 6000, 3);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (15, 'NDoctor15', 'SDoctor15', 7000, 3);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (16, 'NDoctor16', 'SDoctor16', 3000, 4);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (17, 'NDoctor17', 'SDoctor17', 4000, 4);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (18, 'NDoctor18', 'SDoctor18', 5000, 4);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (19, 'NDoctor19', 'SDoctor19', 6000, 4);
INSERT INTO Doctor(doctor_id , first_name ,last_name ,salary ,spec_id) VALUES (20, 'NDoctor20', 'SDoctor20', 7000, 4);


INSERT INTO APPOINTMENT(doctor_id , patient_id , appointment_id , "date" , price , description ) VALUES(12,1,1,to_date('2008-07-05','YYYY-MM-DD'), 800, 'Some text'); 
INSERT INTO APPOINTMENT(doctor_id , patient_id , appointment_id , "date" , price , description ) VALUES(12,1,2,to_date('2009-07-05','YYYY-MM-DD'), 1000, 'Some text'); 
INSERT INTO APPOINTMENT(doctor_id , patient_id , appointment_id , "date" , price , description ) VALUES(12,1,3,to_date('2010-07-05','YYYY-MM-DD'), 700, 'Some text'); 
INSERT INTO APPOINTMENT(doctor_id , patient_id , appointment_id , "date" , price , description ) VALUES(12,1,4,to_date('2011-07-05','YYYY-MM-DD'), 500, 'Some text'); 
INSERT INTO APPOINTMENT(doctor_id , patient_id , appointment_id , "date" , price , description ) VALUES(12,1,5,to_date('2012-07-05','YYYY-MM-DD'), 200, ''); 
INSERT INTO APPOINTMENT(doctor_id , patient_id , appointment_id , "date" , price , description ) VALUES(17,1,6,to_date('2007-07-05','YYYY-MM-DD'), 1000,''); 
INSERT INTO APPOINTMENT(doctor_id , patient_id , appointment_id , "date" , price , description ) VALUES(7,7,7,to_date('2003-07-05','YYYY-MM-DD'), 850, ''); 
INSERT INTO APPOINTMENT(doctor_id , patient_id , appointment_id , "date" , price , description ) VALUES(8,8,8,to_date('2012-07-05','YYYY-MM-DD'), 900, 'Some text'); 
INSERT INTO APPOINTMENT(doctor_id , patient_id , appointment_id , "date" , price , description ) VALUES(9,6,9,to_date('2007-07-05','YYYY-MM-DD'), 540, ''); 
INSERT INTO APPOINTMENT(doctor_id , patient_id , appointment_id , "date" , price , description ) VALUES(13,1,10,to_date('2012-07-05','YYYY-MM-DD'), 630, 'Some text'); 
INSERT INTO APPOINTMENT(doctor_id , patient_id , appointment_id , "date" , price , description ) VALUES(1,1,11,to_date('2007-07-05','YYYY-MM-DD'), 980, 'Some text'); 
INSERT INTO APPOINTMENT(doctor_id , patient_id , appointment_id , "date" , price , description ) VALUES(20,6,12,to_date('2012-07-05','YYYY-MM-DD'), 1080, 'Some text'); 
INSERT INTO APPOINTMENT(doctor_id , patient_id , appointment_id , "date" , price , description ) VALUES(1,6,13,to_date('2001-07-05','YYYY-MM-DD'), 2000, 'Some text'); 



/******************** Solutions **************************/

-- 1.For each patient, calculate how much he spent on visits with doctors with the "internist" specialization. Display the name of the patient.
SELECT p.first_name , p.last_name ,SUM(price), s.name 
from PATIENT p , APPOINTMENT ap, DOCTOR d, SPECIALIZATION s  
where  p.patient_id = ap.patient_id and d.doctor_id = ap.doctor_id and d.spec_id = s.spec_id and  s.name = 'internist'
group by  p.first_name , p.last_name,s.name;

-- 2.Display the most expensive visit for each doctor. Show doctor's name and surname. Exclude doctors who had less than three appointments.
SELECT d.first_name, d.last_name, Max(ap.price) , count(ap.appointment_id) from DOCTOR d
left join  APPOINTMENT ap on d.doctor_id = ap.doctor_id
group by d.first_name, d.last_name
having count(*)>3;

-- 3.List first names and last names (without repetitions) of doctors who worked with patient Kowalski (LastName).
select DISTINCT d.first_name, d.last_name , p.last_name 
from Doctor d, APPOINTMENT ap , PATIENT p  
where d.doctor_id = ap.doctor_id and ap.PATIENT_ID = p.PATIENT_ID and p.last_name = 'Kowalski';

-- 4.For each patient, show his last name and date of the first appointment that has no desctiption.
Select DISTINCT p.last_name, ap."date" From PATIENT p 
right join APPOINTMENT ap on ap.PATIENT_ID = p.PATIENT_ID
where  description  is null;

-- 5.Find the total costs of appointments in 2012 for each specialization. Include the name of the specialization in results.
SELECT sp.name ,SUM(ap.price) from SPECIALIZATION sp 
left join DOCTOR d  on sp.spec_id = d.spec_id
left join  APPOINTMENT ap on d.doctor_id = ap.doctor_id
where EXTRACT(Year from ap."date") = 2012
group by sp.name;

-- 6.Remove from the database patients who have never had a visit.

DELETE FROM PATIENT
WHERE PATIENT_ID NOT IN (
    SELECT DiSTINCT PATIENT_ID
    FROM Appointment);

SELECT p.first_name from PATIENT p  
left join APPOINTMENT ap on p.patient_id = ap.patient_id
where ap.appointment_id is null;

-- 7.List the data doctors with salary lower than 3 000, with specializations beginning with the letter "P". The result should have the following form: first and last name of the doctor in one field, labeled with the heading "Doctor".
SELECT ('Doctor' || ' ' || First_Name || ' ' || Last_Name) Doctor
FROM Doctor D, Specialization S
WHERE
    D.spec_id  = S.spec_id AND
    Salary < 3000 AND
    S.Name like 'P%';

-- 8.List all doctors, who had more visits than the average in their specialization.
SELECT d.doctor_id
FROM APPOINTMENT Ap, DOCTOR D
WHERE Ap.doctor_id = d.doctor_id
GROUP BY d.spec_id
HAVING COUNT(APPOINTMENT_ID) > (
    SELECT AVG(COUNT(APPOINTMENT_id))
    FROM Appointment Ap, Doctor D1
    WHERE 
        Ap.doctor_id = D.doctor_id AND
        D.spec_id = D1.spec_id
);


-- 9. Display the total amount spent by patient Kowalski. Show his last name and number of appointments.
SELECT Last_Name, COUNT(APPOINTMENT_ID), SUM(Price)
FROM Patient P, Appointment A
WHERE P.patient_id = A.patient_id
GROUP BY Last_Name
HAVING Last_Name = 'Kowalski';
-- 10. List all patients (first name, last name, date of birth) who meet both requirements:
                                                                                            /*
                                                                                            Had at least 5 appointments with dentists (specialization)
                                                                                            Paid at least 1000 for appointments with orthopedists.
                                                                                            */
SELECT First_Name, Last_Name, dateOfBirth
FROM Patient P
WHERE 
    5 <= (
        SELECT COUNT(APPOINTMENT_ID)
        FROM APPOINTMENT A, DOCTOR D, SPECIALIZATION S
        WHERE 
            P.patient_id = A.patient_id AND
            D.doctor_id = A.doctor_id AND
            D.spec_id = S.spec_id AND
            S.Name like 'dentists') 
    AND
    1000 <= (
        SELECT SUM(Price)
        FROM APPOINTMENT A, DOCTOR D, SPECIALIZATION S
        WHERE 
            P.patient_id = A.patient_id AND
            D.doctor_id = A.doctor_id AND
            D.spec_id = S.spec_id and
            S.Name like 'orthopedists');




/********************* TEST2 *************************/

/*
Tables:
    Grade g
    Student s
    Subject sb

    s.indexNumber = g.indexNumber;
    sb.idSubject = sb.idSubject;

1.List all subjects without grades.

Select sb.name 
from Subject 
where idsubject not in (select idsubject from grade)
2.For each subject find the most recurrent grades (those that were given most often).
(2 Points)
select sb.name, max(count(g.grade))  from Subject sb
left  join Grade g on sb.idSubject = g.idSubject
group by sb.name;
3.Find a subject with the highest average of grades on each year of studies.
(2 Points)
Select sb.name, s.year, MAX(AVG(g.grade)) from Subject sb
left join Grade g on sb.idsubject = g.idsubject
left join Student s on g.IndexNumber = s.indexNumber
group by sb.name, s.year;
4.Find all students who have only one grade for the subject named "Physical education".
(2 Points)
SELECT s.LastName , s.FirstName , count(*)  from Student s
left join Grade g on s.indexNumber = g.indexNumber
left join Subject sb on g.idSubject = sb.idSubject
where sb.name = 'Physical education'
GROUP by s.FirstName , s.lastname
HAVING count(*) = 1;
5.Find names of subjects with grades given in 2012, but without any grades given in 2013. Use function EXTRACT(year FROM data).
(2 Points)
select s.name from 
Subject 
where idsubject in (select idsubject from grade 
                                 where extract (year from dateGiven)=2012)
and idsubject not in (select idsubject from grade
                                  where extract(year from DateGiven)=2013);


*/