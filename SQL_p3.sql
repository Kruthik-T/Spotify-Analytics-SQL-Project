create database Sql_p3
use Sql_p3
select top 5 * from cleaned_dataset;
--1.Retrieve the names of all tracks that have more than 1 billion streams.
select track from cleaned_dataset 
where Stream > 1000000000 

--2.List all albums along with their respective artists.
select album, artist from cleaned_dataset

--3.Get the total number of comments for tracks where licensed = TRUE.
select Comments ,track from cleaned_dataset
where Licensed=1;

--4.Find all tracks that belong to the album type single.
select Track from cleaned_dataset
where Album_type='single';

--5.Count the total number of tracks by each artist.
select Artist ,count(track) as no_of_tracks from cleaned_dataset
group by Artist
order by no_of_tracks desc ,Artist asc;

--6.Calculate the average danceability of tracks in each album.
select album ,avg(Danceability) as average from cleaned_dataset
group by Album

--7.Find the top 5 tracks with the highest energy values
select top 5 * from cleaned_dataset
order by Energy desc ;

--8.List all tracks along with their views and likes where official_video = TRUE
select track,Views,likes,official_video from cleaned_dataset 
where official_video=1;

--9.For each album, calculate the total views of all associated tracks.
select album ,sum(Views) as total_views from cleaned_dataset
group by album 
order by total_views desc ;

--10.Retrieve the track names that have been streamed on Spotify more than YouTube.
select track, count(most_playedon) as no_of_times ,count(case when most_playedon='Spotify' then 1 end)as Spotify ,count(case when most_playedon='Youtube'then 1 end)as Youtube from cleaned_dataset
group by track 
having count(case when most_playedon='Spotify' then 1 end) >count(case when most_playedon='Youtube'then 1 end)
order by no_of_times desc;

--11.Find the top 3 most-viewed tracks for each artist using window functions.
--using window function 
with cte as (
select  track,artist ,sum(Views)as total_views from cleaned_dataset
group by Track,Artist
),
  vte as (
 select track,artist,total_views,dense_rank() over(partition by artist order by total_views desc) as rn from cte 
 
 )
 select * from vte 
 where rn<4;

 --12.Write a query to find tracks where the liveness score is above the average
 SELECT
    track,
    liveness
FROM cleaned_dataset
WHERE liveness >
(
    SELECT AVG(liveness)
    FROM cleaned_dataset
);
 --using window function
 with cte as (
 select track,liveness ,avg(Liveness) over()as total_avg from cleaned_dataset
 )
 select track,liveness from cte 
 where Liveness>total_avg;
 --both gives the same ouput 

 --13.use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
 with cte as (
 select album,max(Energy)as Highest,min(Energy) as lowest 
 from cleaned_dataset
 group by album 
 )
 select *,(Highest-lowest)as diff from cte 
 order by diff desc;

 --14.Find tracks where the energy-to-liveness ratio is greater than 1.2
 select track from cleaned_dataset
 where (Energy/nullif(Liveness,0))>1.2;

 --15.Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.

select track,sum(likes) over(order by Views desc)as cumulative_likes,Views from cleaned_dataset
--end 