-- Create database
CREATE DATABASE ghosoun_movies;

-- Use database
USE ghosoun_movies;

-- Create movie_watchlist table
CREATE TABLE movie_watchlist (
    movie_id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(100) NOT NULL,
    rating DECIMAL(3,2),
    genre VARCHAR(50),  --Movie Category
    watch_date DATE,
    platform VARCHAR(50) NOT NULL,
    duration_minutes INT,
    watched_again BIT,
    
    -- Extra column (we add it now professionally)
     is_favorite BIT
);
-- Insert 8 movies into movie_watchlist
INSERT INTO movie_watchlist 
(title, rating, genre, watch_date, platform, duration_minutes, watched_again, is_favorite)
VALUES
('Inception', 9.0, 'Sci-Fi', '2024-01-10', 'Netflix', 148, 1, 1),
('Interstellar', 9.1, 'Sci-Fi', '2024-02-05', 'Netflix', 169, 1, 1),
('Joker', 8.4, 'Drama', '2024-05-01', 'Shahid', 122, 0, 0),
('The Dark Knight', 7, 'Drama', '2024-03-15', 'Netflix', 152, 1, 1),
('The Hangover', 9.3, 'Comedy', '2024-04-05', 'YouTube', 100, 0, 1),
('Superbad', 7.9, 'Comedy', '2024-04-10', 'Netflix', 113, 0, 0),
('It', 8.2, 'Horror', '2024-03-20', 'Cinema', 135, 0, 0),
('A Quiet Place', 8.3, 'Horror', '2024-03-25', 'Cinema', 90, 1, 1);

SELECT * FROM movie_watchlist ;

SELECT AVG(rating) AS average_rating
FROM movie_watchlist;

SELECT MAX(rating) AS highest_rating
FROM movie_watchlist;

SELECT COUNT(*) AS total_movies
FROM movie_watchlist;

 
 --way2 for select
 SELECT 
    AVG(rating) AS average_rating,
    MAX(rating) AS highest_rating,
    COUNT(*) AS total_movies
FROM movie_watchlist;

-- Increase rating by 0.5 for the top 3 highest rated movies

UPDATE movie_watchlist
SET rating = rating + 0.5
WHERE movie_id  IN (
    SELECT TOP 3 movie_id
    FROM movie_watchlist
    ORDER BY rating DESC
);


-- Show the top 3 movies after update
SELECT * FROM movie_watchlist
ORDER BY rating DESC;


-- Delete 2 movies with the shortest duration
DELETE FROM movie_watchlist
WHERE movie_id IN (
    SELECT TOP 2 movie_id
    FROM movie_watchlist
    ORDER BY duration_minutes ASC
);

SELECT * FROM movie_watchlist
 ORDER BY duration_minutes ASC;


-- Add a new column for user reviews or notes
ALTER TABLE movie_watchlist
ADD review_notes VARCHAR(300);  



--additional part for col. that I add (is_favorite)

SELECT * FROM movie_watchlist
WHERE is_favorite = 1;

-- to count number of favorite movie
SELECT COUNT(*) AS FavoriteCount
FROM movie_watchlist
WHERE is_favorite = 1;














DROP TABLE movie_watchlist; 
DROP DATABASE ghosoun_movies;