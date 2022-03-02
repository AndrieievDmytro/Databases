DROP TABLE Booking;
DROP TABLE Room;
DROP TABLE Guest;
DROP TABLE Category;




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
    Name varchar2(20)  NOT NULL,
    Price numeric(8,2)  NOT NULL,
    CONSTRAINT Category_pk PRIMARY KEY (IdCategory)
) ;

-- Table: Guest
CREATE TABLE Guest (
    IdGuest integer  NOT NULL,
    FirstName varchar2(20)  NOT NULL,
    LastName varchar2(30)  NOT NULL,
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

INSERT INTO Category (IdCategory, Name, Price) VALUES (1, 'Tourist', 30);
INSERT INTO Category (IdCategory, Name, Price) VALUES (2, 'Regular', 60);
INSERT INTO Category (IdCategory, Name, Price) VALUES (3, 'Luxury', 120);

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

INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (1, to_date('2009-07-01', 'YYYY-MM-DD'), to_date('2009-07-05', 'YYYY-MM-DD'), 1, 101, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (2, to_date('2008-01-03', 'YYYY-MM-DD'), to_date('2008-01-15', 'YYYY-MM-DD'), 1, 102, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (3, to_date('2009-07-15', 'YYYY-MM-DD'), to_date('2009-08-02', 'YYYY-MM-DD'), 2, 101, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (4, to_date('2008-12-12', 'YYYY-MM-DD'), to_date('2008-12-14', 'YYYY-MM-DD'), 3, 103, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (5, to_date('2009-05-01', 'YYYY-MM-DD'), to_date('2009-05-05', 'YYYY-MM-DD'), 3, 201, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (6, to_date('2009-04-01', 'YYYY-MM-DD'), to_date('2009-05-01', 'YYYY-MM-DD'), 4, 201, 0);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (7, to_date('2008-11-15', 'YYYY-MM-DD'), to_date('2008-11-20', 'YYYY-MM-DD'), 4, 105, 0);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (8, to_date('2009-10-01', 'YYYY-MM-DD'), to_date('2009-10-07', 'YYYY-MM-DD'), 10, 104, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (9, to_date('2009-07-03', 'YYYY-MM-DD'), to_date('2009-07-20', 'YYYY-MM-DD'), 10, 204, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (10, to_date('2009-03-12', 'YYYY-MM-DD'), to_date('2009-03-20', 'YYYY-MM-DD'), 9, 201, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (11, to_date('2009-12-01', 'YYYY-MM-DD'), to_date('2009-12-02', 'YYYY-MM-DD'), 9, 202, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (12, to_date('2009-12-01', 'YYYY-MM-DD'), to_date('2009-12-10', 'YYYY-MM-DD'), 8, 202, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (13, to_date('2008-03-03', 'YYYY-MM-DD'), to_date('2008-03-12', 'YYYY-MM-DD'), 1, 203, 0);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (14, to_date('2009-08-25', 'YYYY-MM-DD'), to_date('2009-09-01', 'YYYY-MM-DD'), 6, 205, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (15, to_date('2009-04-16', 'YYYY-MM-DD'), to_date('2009-04-21', 'YYYY-MM-DD'), 6, 101, 0);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (16, to_date('2009-04-17', 'YYYY-MM-DD'), to_date('2009-04-20', 'YYYY-MM-DD'), 6, 105, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (17, to_date('2009-02-12', 'YYYY-MM-DD'), to_date('2009-02-14', 'YYYY-MM-DD'), 5, 104, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (18, to_date('2008-11-10', 'YYYY-MM-DD'), to_date('2008-11-20', 'YYYY-MM-DD'), 1, 103, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (19, to_date('2009-06-07', 'YYYY-MM-DD'), to_date('2009-06-15', 'YYYY-MM-DD'), 2, 101, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (20, to_date('2009-07-01', 'YYYY-MM-DD'), to_date('2009-07-05', 'YYYY-MM-DD'), 3, 101, 1);


