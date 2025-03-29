

-- Create Little Lemon Database
CREATE DATABASE LittleLemon;
USE LittleLemon;

-- Create Tables
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(20)
);

CREATE TABLE Bookings (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    BookingDate DATETIME,
    NumberOfGuests INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Menu (
    DishID INT AUTO_INCREMENT PRIMARY KEY,
    DishName VARCHAR(100),
    Price DECIMAL(10,2),
    AvailableQuantity INT
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    BookingID INT,
    DishID INT,
    Quantity INT,
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
    FOREIGN KEY (DishID) REFERENCES Menu(DishID)
);

-- Stored Procedures
DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT DishID, MAX(AvailableQuantity) AS MaxQuantity FROM Menu;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ManageBooking(IN BookingID INT, IN NewDate DATETIME, IN Guests INT)
BEGIN
    UPDATE Bookings 
    SET BookingDate = NewDate, NumberOfGuests = Guests
    WHERE BookingID = BookingID;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE UpdateBooking(IN BookingID INT, IN NewGuests INT)
BEGIN
    UPDATE Bookings SET NumberOfGuests = NewGuests WHERE BookingID = BookingID;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AddBooking(IN CustID INT, IN BookDate DATETIME, IN Guests INT)
BEGIN
    INSERT INTO Bookings (CustomerID, BookingDate, NumberOfGuests) 
    VALUES (CustID, BookDate, Guests);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE CancelBooking(IN BookingID INT)
BEGIN
    DELETE FROM Bookings WHERE BookingID = BookingID;
END //
DELIMITER ;

-- Insert Sample Data
INSERT INTO Customers (FullName, Email, PhoneNumber) 
VALUES ('Alice Johnson', 'alice@example.com', '123-456-7890');

INSERT INTO Bookings (CustomerID, BookingDate, NumberOfGuests) 
VALUES (1, '2025-04-10 18:30:00', 4);

INSERT INTO Menu (DishName, Price, AvailableQuantity) 
VALUES ('Pasta Primavera', 12.99, 10);

INSERT INTO Orders (BookingID, DishID, Quantity) 
VALUES (1, 1, 2);

