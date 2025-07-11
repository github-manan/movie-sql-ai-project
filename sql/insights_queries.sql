create database bollywood_db;
use bollywood_db;
CREATE TABLE movies (
  movie_id INT PRIMARY KEY,
  title VARCHAR(255),
  genre VARCHAR(100),
  release_year INT,
  budget BIGINT,
  revenue BIGINT
);
select * from movies;
CREATE TABLE reviews (
  review_id INT PRIMARY KEY,
  movie_id INT,
  review_text TEXT,
  user_rating FLOAT,
  FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);
select * from reviews;

-- Profit 
select movie_id, title, genre, revenue - budget AS profit
from movies
order by profit desc
limit 5;

-- Genre-wise Average Revenue
select genre, round(avg(revenue), 0) as avg_revenue
from movies
group by genre
order by avg_revenue desc;

-- Revenue vs Rating
select m.title, m.revenue, round(avg(r.user_rating), 2) as avg_rating
from movies m
join reviews r on m.movie_id = r.movie_id
group by m.title, m.revenue
order by avg_rating desc;

-- Year wise revenue
select release_year, sum(revenue) as total_revenue
from movies
group by release_year
order by total_revenue;

-- Top rated movies
select m.title, round(avg(r.user_rating), 2) as avg_rating
from movies m
join reviews r on m.movie_id = r.movie_id
group by m.title
having avg_rating >= 4.5
order by avg_rating desc;

