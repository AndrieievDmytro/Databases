SELECT * FROM Booking;

SELECT * from Guest;

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
Inner JOIN Guest g ON( b.IdGuest = g.IdGuest)
WHERE FirstName = 'Kiepski';

-- 4. List guests who do not have a discount. Sort them by first name.
SELECT FirstName , LastName from Guest
WHERE DiscountPercent is NULL
ORDER BY FirstName ASC;


-- 5. List reservations from 2008 for those customers, whose names start with the letter "K" or "L". Display the name, surname and room number.
SELECT g.FirstName , g.LastNAme , RoomNo From Guest g 
Inner join   


-- 6. List clients who haven’t paid yet (field "paid" equal to 0).
-- 7. List clients who have booked a luxury room at least once.
-- 8. List the rooms rented by Andrzej Nowak.
-- 9. List the names of the guests along with the number of reservations made by them. Do not write out guests who have less than 3 reservations.
-- 10. Calculate how many people can stay at the hotel at the same time.
-- 11. Calculate how many people can stay at the hotel in each category at the same time.
-- 12. Enter the number of rooms in each category.
-- 13. Find a room that has never been booked.
-- 14. Find customers who have used the hotel services only once.
-- 15. List clients who slept in room 101 and paid.
-- 16. Count how much the hotel earned on Marian Paździoch considering the price per night, the number of days and the discount.