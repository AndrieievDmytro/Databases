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

INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (1, ('2009-07-01'), ('2009-07-05'), 1, 101, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (2, ('2008-01-03'), ('2008-01-15'), 1, 102, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (3, ('2009-07-15'), ('2009-08-02'), 2, 101, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (4, ('2008-12-12'), ('2008-12-14'), 3, 103, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (5, ('2009-05-01'), ('2009-05-05'), 3, 201, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (6, ('2009-04-01'), ('2009-05-01'), 4, 201, 0);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (7, ('2008-11-15'), ('2008-11-20'), 4, 105, 0);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (8, ('2009-10-01'), ('2009-10-07'), 10, 104, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (9, ('2009-07-03'), ('2009-07-20'), 10, 204, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (10, ('2009-03-12'), ('2009-03-20'), 9, 201, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (11, ('2009-12-01'), ('2009-12-02'), 9, 202, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (12, ('2009-12-01'), ('2009-12-10'), 8, 202, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (13, ('2008-03-03'), ('2008-03-12'), 1, 203, 0);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (14, ('2009-08-25'), ('2009-09-01'), 6, 205, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (15, ('2009-04-16'), ('2009-04-21'), 6, 101, 0);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (16, ('2009-04-17'), ('2009-04-20'), 6, 105, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (17, ('2009-02-12'), ('2009-02-14'), 5, 104, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (18, ('2008-11-10'), ('2008-11-20'), 1, 103, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (19, ('2009-06-07'), ('2009-06-15'), 2, 101, 1);
INSERT INTO Booking (IdBooking, DateFrom, DateTo, IdGuest, RoomNo, Paid) VALUES (20, ('2009-07-01'), ('2009-07-05'), 3, 101, 1);


