# 🎵 Spotify-Analytics-SQL-Project
## Project Overview

**Project Title:** Spotify & YouTube Data Analysis

**Level:** Beginner to Intermediate

**Database:** SQL Server (`Sql_p3`)

This project explores Spotify and YouTube music streaming data using SQL Server. The objective was to analyze track performance, artist popularity, album statistics, audience engagement, and streaming behavior through SQL queries.

The project focuses on applying SQL concepts such as aggregations, joins, subqueries, Common Table Expressions (CTEs), window functions, ranking functions, and analytical calculations to solve real-world business questions.

---

# Objectives

* Analyze music streaming data from Spotify and YouTube.
* Identify highly streamed and highly viewed tracks.
* Compare platform performance between Spotify and YouTube.
* Analyze artist and album performance.
* Apply window functions for ranking and cumulative calculations.
* Use CTEs to simplify analytical queries.
* Practice business-oriented SQL problem solving.

---

# Dataset Information

The dataset contains information about:

* Track Name
* Artist
* Album
* Album Type
* Streams
* Views
* Likes
* Comments
* Danceability
* Energy
* Liveness
* Licensed Status
* Official Video Status
* Most Played Platform

---

# SQL Concepts Used

### Aggregations

* COUNT()
* SUM()
* AVG()

### Filtering

* WHERE
* HAVING

### Window Functions

* DENSE_RANK()
* SUM() OVER()
* AVG() OVER()

### Advanced SQL

* CTEs
* Subqueries
* CASE Statements
* NULLIF()

### Ranking & Analytics

* Artist Ranking
* Track Ranking
* Running Totals
* Ratio Analysis

---

# Business Problems Solved

## 1. Retrieve the names of all tracks that have more than 1 billion streams.

```sql
SELECT track
FROM cleaned_dataset
WHERE Stream > 1000000000;
```

---

## 2. List all albums along with their respective artists.

```sql
SELECT album, artist
FROM cleaned_dataset;
```

---

## 3. Get the total number of comments for tracks where licensed = TRUE.

```sql
SELECT Comments, track
FROM cleaned_dataset
WHERE Licensed = 1;
```

---

## 4. Find all tracks that belong to the album type 'single'.

```sql
SELECT Track
FROM cleaned_dataset
WHERE Album_type = 'single';
```

---

## 5. Count the total number of tracks by each artist.

```sql
SELECT
    Artist,
    COUNT(track) AS no_of_tracks
FROM cleaned_dataset
GROUP BY Artist
ORDER BY no_of_tracks DESC;
```

---

## 6. Calculate the average danceability of tracks in each album.

```sql
SELECT
    album,
    AVG(Danceability) AS average_danceability
FROM cleaned_dataset
GROUP BY album;
```

---

## 7. Find the top 5 tracks with the highest energy values.

```sql
SELECT TOP 5 *
FROM cleaned_dataset
ORDER BY Energy DESC;
```

---

## 8. List all tracks along with their views and likes where official_video = TRUE.

```sql
SELECT
    track,
    Views,
    Likes,
    official_video
FROM cleaned_dataset
WHERE official_video = 1;
```

---

## 9. For each album, calculate the total views of all associated tracks.

```sql
SELECT
    album,
    SUM(Views) AS total_views
FROM cleaned_dataset
GROUP BY album
ORDER BY total_views DESC;
```

---

## 10. Retrieve the track names that have been streamed on Spotify more than YouTube.

```sql
SELECT
    track,
    COUNT(most_playedon) AS no_of_times,
    COUNT(CASE WHEN most_playedon='Spotify' THEN 1 END) AS Spotify,
    COUNT(CASE WHEN most_playedon='Youtube' THEN 1 END) AS Youtube
FROM cleaned_dataset
GROUP BY track
HAVING COUNT(CASE WHEN most_playedon='Spotify' THEN 1 END)
     > COUNT(CASE WHEN most_playedon='Youtube' THEN 1 END)
ORDER BY no_of_times DESC;
```

---

## 11. Find the Top 3 Most Viewed Tracks for Each Artist.

```sql
WITH cte AS
(
    SELECT
        track,
        artist,
        SUM(Views) AS total_views
    FROM cleaned_dataset
    GROUP BY track, artist
),
vte AS
(
    SELECT
        track,
        artist,
        total_views,
        DENSE_RANK() OVER
        (
            PARTITION BY artist
            ORDER BY total_views DESC
        ) AS rn
    FROM cte
)
SELECT *
FROM vte
WHERE rn < 4;
```

---

## 12. Find Tracks Where the Liveness Score is Above Average.

```sql
WITH cte AS
(
    SELECT
        track,
        liveness,
        AVG(Liveness) OVER() AS total_avg
    FROM cleaned_dataset
)
SELECT
    track,
    liveness
FROM cte
WHERE liveness > total_avg;
```

---

## 13. Calculate the Difference Between Highest and Lowest Energy Values for Each Album.

```sql
WITH cte AS
(
    SELECT
        album,
        MAX(Energy) AS Highest,
        MIN(Energy) AS Lowest
    FROM cleaned_dataset
    GROUP BY album
)
SELECT *,
       (Highest - Lowest) AS diff
FROM cte
ORDER BY diff DESC;
```

---

## 14. Find Tracks Where the Energy-to-Liveness Ratio is Greater Than 1.2.

```sql
SELECT
    track
FROM cleaned_dataset
WHERE Energy / NULLIF(Liveness,0) > 1.2;
```

---

## 15. Calculate the Cumulative Sum of Likes Ordered by Views.

```sql
SELECT
    track,
    Views,
    SUM(Likes) OVER(ORDER BY Views DESC) AS cumulative_likes
FROM cleaned_dataset;
```

---

# Key Learnings

Through this project, I gained practical experience in:

* SQL Aggregations
* Window Functions
* Ranking Functions
* Common Table Expressions (CTEs)
* Analytical Query Writing
* Music Streaming Data Analysis
* Business-Oriented SQL Problem Solving
* Running Totals & Cumulative Metrics
* Ratio Analysis
* SQL Server Query Optimization

---

# Technologies Used

* Microsoft SQL Server
* SQL Server Management Studio (SSMS)

---

# Repository Structure

```text
Spotify-Data-Analysis-SQL-Server
│
├── SQL_p3.sql
├── README.md
└── Dataset
```

---

# Author

**Kruthik Teliseeri**

Aspiring Data Analyst | SQL Server | Power BI | Python | Machine Learning

This project was completed independently to strengthen SQL analytics, window functions, CTEs, and business-oriented problem-solving skills using real-world music streaming data.
