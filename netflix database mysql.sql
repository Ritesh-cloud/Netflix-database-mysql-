create database netflixdb;
drop database netflixdb;
use netflixdb;

-- DATA DESIGN
-- Users
Create Table Users (
	UsersID int auto_increment PRIMARY KEY,
    UsersName varchar(100) Not Null,
    email varchar(100) Not Null,
    passwordHarsh varchar(225) Not Null,
    subscriptionID int,
    createdAt datetime  default current_timestamp
    );
    
-- Movies/Tv Shows
Create Table Content (
	ContentID int auto_increment primary key,
    Title varchar(225) Not Null,
    ReleaseDate Date,
    Duration int, 
    Description Text,
    genreID int,
    Rating decimal(3,1),
    CreatedAt datetime default current_timestamp
    );
    
-- Genres
create table Genres (
	GenresID int auto_increment primary key,
    Genres varchar(100) Not Null
    );

 -- Rating   
create table Rating (
	RatingID int auto_increment primary key,
    UserID int,
    ContentID int,
    Rating Decimal(3,1),
    Review text,
    CretedAt datetime default current_timestamp
);

-- watch history
create table WatchHistory (
	WatchID int auto_increment primary key,
    UserID int,
    ContentID int,
    WatchedAt datetime default current_timestamp
);

-- subscription
CREATE TABLE Subscriptions (
    SubscriptionID INT AUTO_INCREMENT PRIMARY KEY,
    PlanName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    DurationMonths INT 
);

-- DATA POPULATION
-- Insert genres
INSERT INTO Genres (Genres)
VALUES ('Action'), ('Comedy'), ('Drama'), ('Horror'), ('Sci-Fi');

-- Insert subscriptions
INSERT INTO Subscriptions (PlanName, Price, DurationMonths) 
VALUES ('Basic', 8.99, 1), ('Standard', 12.99, 1), ('Premium', 15.99, 1);

-- Insert content
-- Insert content with different dates and years
INSERT INTO Content (Title, ReleaseDate, Duration, Description, GenreID, Rating) 
VALUES 
('Deadpool and Wolverine', '2023-05-15', 120, 'Description of Deadpool and Wolverine', 1, 8.7),
('Avengers: Secret Wars', '2022-08-20', 90, 'Description of Avengers: Secret Wars', 2, 7.4),
('Guardians of the Galaxy Vol. 3', '2025-01-10', 130, 'Description of Guardians of the Galaxy Vol. 3', 3, 8.1),
('Spider-Man: No Way Home', '2026-04-25', 150, 'Description of Spider-Man: No Way Home', 1, 9.0),
('The Batman', '2024-11-14', 140, 'Description of The Batman', 4, 8.5),
('The Matrix Resurrections', '2023-06-18', 100, 'Description of The Matrix Resurrections', 5, 7.9),
('Wonder Woman 1984', '2022-09-22', 120, 'Description of Wonder Woman 1984', 1, 7.0),
('Black Panther: Wakanda Forever', '2025-03-30', 135, 'Description of Black Panther: Wakanda Forever', 2, 8.3),
('Doctor Strange in the Multiverse of Madness', '2026-10-12', 145, 'Description of Doctor Strange in the Multiverse of Madness', 1, 8.2),
('Thor: Love and Thunder', '2024-12-05', 110, 'Description of Thor: Love and Thunder', 1, 7.5);


-- Insert users
INSERT INTO Users (UsersName, Email, passwordHarsh, SubscriptionID) VALUES 
('Ritesh Murmu', 'ritesh.murmu1@example.com', 'hashedpassword1', 1),
('John Doe', 'john.doe@example.com', 'hashedpassword2', 2),
('Jane Smith', 'jane.smith@example.com', 'hashedpassword3', 1),
('Emily Johnson', 'emily.johnson@example.com', 'hashedpassword4', 2),
('Michael Brown', 'michael.brown@example.com', 'hashedpassword5', 3);

-- Insert ratings
INSERT INTO Rating (UserID, ContentID, Rating, Review)
VALUES 
(1, 1, 9.0, 'Great movie!'),
(2, 2, 6.5, 'It was okay.'),
(1, 3, 8.0, 'Loved it!'),
(2, 4, 9.5, 'Amazing!'),
(1, 5, 8.3, 'Good movie.'),
(2, 6, 7.8, 'Interesting.'),
(1, 7, 6.9, 'Not bad.'),
(2, 8, 8.5, 'Impressive.'),
(1, 9, 8.4, 'Entertaining.'),
(2, 10, 7.4, 'Enjoyed it.');

-- Insert watch history
INSERT INTO WatchHistory (UserID, ContentID) 
VALUES 
(1, 1),
(2, 2),
(1, 3),
(2, 4),
(1, 5),
(2, 6),
(1, 7),
(2, 8),
(1, 9),
(2, 10);

-- queries
SELECT * FROM Users;

SELECT * FROM Content;

SELECT * FROM Genres;

SELECT * FROM Subscriptions;

SELECT u.UsersName, r.Rating, r.Review
FROM Rating r
JOIN Users u ON r.UserID = u.UsersID
WHERE r.ContentID = 1;  -- Replace with the ContentID you want to query

SELECT c.Title, wh.WatchedAt
FROM WatchHistory wh
JOIN Content c ON wh.ContentID = c.ContentID
WHERE wh.UserID = 1;  -- Replace with the UserID you want to query

SELECT c.Title, g.Genres
FROM Content c
JOIN Genres g ON c.genreID = g.GenresID
WHERE g.Genres = 'Action';  -- Replace with the genre you want to query

SELECT c.Title, AVG(r.Rating) AS AverageRating
FROM Rating r
JOIN Content c ON r.ContentID = c.ContentID
GROUP BY c.Title;

SELECT u.UsersName
FROM WatchHistory wh
JOIN Users u ON wh.UserID = u.UsersID
WHERE wh.ContentID = 1;  -- Replace with the ContentID you want to query

SELECT u.UsersName, s.PlanName
FROM Users u
JOIN Subscriptions s ON u.SubscriptionID = s.SubscriptionID;

SELECT Title, ReleaseDate
FROM Content
WHERE YEAR(ReleaseDate) = 2024;  -- Replace with the year you want to query

SELECT u.UsersName, s.PlanName, s.Price
FROM Users u
JOIN Subscriptions s ON u.SubscriptionID = s.SubscriptionID;

SELECT c.Title, wh.WatchedAt
FROM WatchHistory wh
JOIN Content c ON wh.ContentID = c.ContentID
WHERE wh.UserID = 1;  -- Replace with the UserID you want to query

SELECT g.Genres, c.Title
FROM Content c
JOIN Genres g ON c.genreID = g.GenresID;

SELECT u.UsersName, r.Rating
FROM Rating r
JOIN Users u ON r.UserID = u.UsersID
WHERE r.ContentID = 1;  -- Replace with the ContentID you want to query




