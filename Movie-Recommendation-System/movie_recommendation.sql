
CREATE DATABASE MovieAnalytics;
USE MovieAnalytics;

-- 2. CREATE TABLES
-- Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    age INT
);

-- Movies Table
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    genre VARCHAR(50)
);

-- Ratings Table
CREATE TABLE Ratings (
    user_id INT,
    movie_id INT,
    rating DECIMAL(2,1),

    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

-- Watch History Table
CREATE TABLE Watch_History (
    user_id INT,
    movie_id INT,
    watch_date DATE,

    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

-- 3. INSERT SAMPLE DATA

-- Users Data
INSERT INTO Users (name, age) VALUES
('Rahul', 22),
('Sneha', 24),
('Arjun', 27),
('Priya', 23),
('Kiran', 29),
('Meena', 21),
('Ravi', 26),
('Anjali', 25);

-- Movies Data
INSERT INTO Movies (title, genre) VALUES
('Inception', 'Sci-Fi'),
('Titanic', 'Romance'),
('Avengers', 'Action'),
('Interstellar', 'Sci-Fi'),
('3 Idiots', 'Comedy'),
('Bahubali', 'Action'),
('The Notebook', 'Romance'),
('Drishyam', 'Thriller');

-- Ratings Data
INSERT INTO Ratings (user_id, movie_id, rating) VALUES
(1, 1, 5.0),
(2, 2, 4.5),
(3, 3, 4.8),
(4, 1, 4.7),
(5, 4, 5.0),
(6, 5, 4.6),
(7, 6, 4.9),
(8, 8, 4.8),
(1, 3, 4.5),
(2, 1, 4.9);

-- Watch History Data
INSERT INTO Watch_History (user_id, movie_id, watch_date) VALUES
(1, 1, '2026-04-01'),
(2, 2, '2026-04-02'),
(3, 3, '2026-04-03'),
(4, 1, '2026-04-05'),
(5, 4, '2026-04-06'),
(6, 5, '2026-04-08'),
(7, 6, '2026-04-10'),
(8, 8, '2026-04-11'),
(1, 3, '2026-04-12'),
(2, 1, '2026-04-14');

-- 4. TOP RATED MOVIES

SELECT m.title,AVG(r.rating) AS AverageRating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.title
ORDER BY AverageRating DESC;


-- 5. MOST POPULAR GENRES
-- Based on watch count

SELECT m.genre,COUNT(*) AS TotalViews
FROM Movies m
JOIN Watch_History w ON m.movie_id = w.movie_id
GROUP BY m.genre
ORDER BY TotalViews DESC;


-- 6. RECOMMEND MOVIES BASED ON SIMILAR USERS
-- Movies rated 4.5 and above

SELECT DISTINCT m.title,m.genre
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
WHERE r.rating >= 4.5
ORDER BY m.title;

-- 7. USER BEHAVIOR PATTERNS
-- Total movies watched by each user

SELECT u.name,COUNT(w.movie_id) AS MoviesWatched
FROM Users u
JOIN Watch_History w ON u.user_id = w.user_id
GROUP BY u.name
ORDER BY MoviesWatched DESC;


-- 8. TRENDING MOVIES
-- Most watched in last 30 days
SELECT m.title,COUNT(*) AS Views
FROM Movies m
JOIN Watch_History w ON m.movie_id = w.movie_id
WHERE w.watch_date >= DATE_SUB('2026-04-18', INTERVAL 30 DAY)
GROUP BY m.title
ORDER BY Views DESC;


-- 9. VIEW TABLE DATA
SELECT * FROM Users;
SELECT * FROM Movies;
SELECT * FROM Ratings;
SELECT * FROM Watch_History;

