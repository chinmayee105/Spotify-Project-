select * from spotify.spotify_dataset

-- EDA
SELECT COUNT(*) FROM spotify.spotify_dataset

SELECT COUNT(DISTINCT ARTIST) FROM spotify.spotify_dataset

SELECT DISTINCT album_type FROM spotify.spotify_dataset

SELECT Max(Album_type) FROM spotify.spotify_dataset;

SELECT * FROM spotify.spotify_dataset
WHERE Duration_min = 0

SELECT DISTINCT Channel FROM spotify.spotify_dataset;

SELECT DISTINCT most_playedon FROM spotify.spotify_dataset;

-- ----------------------------------------------------------------------------------------------------------------------------------------
-- Some Baisc Questions 

-- Q1. Reterieve the names of all tracks that have more than 9 million streams.

SELECT * FROM spotify.spotify_dataset
WHERE stream > 90000000

-- Q2. List all albums along with their respective artist.

SELECT DISTINCT Album, Artist
FROM spotify.spotify_dataset
ORDER BY 1


-- Q.3 Count the Total Number of Tracks by each Artist.

SELECT  Artist,
COUNT(*) as Total_no_songs 
FROM spotify.spotify_dataset
GROUP BY Artist
ORDER BY 2 ASC


-- Q.4. Get the Total Number of Comments for Tracks where Licensed = FALSE.

SELECT * FROM spotify.spotify_dataset
WHERE Licensed  = 'FALSE'

-- Total Commants. 

SELECT SUM(Comments) as Comments
FROM spotify.spotify_dataset
WHERE licensed = 'TRUE'

-- Q.5 Find all Tracks that belongs to the Album type Single. 

SELECT * FROM spotify.spotify_dataset
WHERE album_type = 'single'

-- Q.6 Calcuate the Average Danceability of Tracks in each Album.

SELECT 
	Album, 
    avg(danceability) as avg_danceability
FROM spotify.spotify_dataset
GROUP BY 1
ORDER BY 2 DESC

-- Q.7 Find the Top 5 Tracks with the Highest Energy values

SELECT 
	Track,
    MAX(Energy)
FROM spotify.spotify_dataset
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Q.8 Each Album, Calculate the Total Views of all Assosiated Tracks.

SELECT 
	Album,
    Track,
    SUM(Views)
FROM spotify.spotify_dataset
GROUP BY 1, 2
ORDER BY 3 DESC 

-- Q.9 Reterieve the Track Names that have been Streamed on Spotify more than YouTube.		-- To 'NULL' Then use COALESCE then show '0'.

SELECT * FROM 
(SELECT 
	Track, 
    COALESCE(SUM(CASE WHEN most_playedon = 'YouTube' THEN stream END),0) as streamed_on_youtube,
    COALESCE(SUM(CASE WHEN most_playedon = 'Spotify' THEN stream END),0) as streamed_on_spotify
FROM spotify.spotify_dataset
GROUP BY 1
) as t1
WHERE 
	streamed_on_spotify > streamed_on_youtube


-- Q. 10 Write a query to find Tracks where the Liveness Score is above the Average.

SELECT Track,
	Artist,
    Liveness
FROM spotify.spotify_dataset
WHERE Liveness > (SELECT AVG(Liveness) FROM spotify.spotify_dataset)
