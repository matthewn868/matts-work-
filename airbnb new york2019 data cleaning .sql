SELECT *
FROM ny_airbnb_2019;

CREATE TABLE ny_airbnb_2019_staging
LIKE ny_airbnb_2019;

INSERT ny_airbnb_2019_staging
SELECT *
FROM ny_airbnb_2019;

SELECT *,
ROW_NUMBER() OVER(PARTITION BY id, name, host_id, neighbourhood_group, neighbourhood, latitude, longitude, room_type,
price, minimum_nights, number_of_reviews, last_review, reviews_per_month, calculated_host_listings_count, availability_365) AS row_num
FROM ny_airbnb_2019_staging;

WITH duplicate_cte AS

(SELECT *,
ROW_NUMBER() OVER(PARTITION BY id, name, host_id, neighbourhood_group, neighbourhood, latitude, longitude, room_type,
price, minimum_nights, number_of_reviews, last_review, reviews_per_month, calculated_host_listings_count, availability_365) AS row_num
FROM ny_airbnb_2019_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;



SELECT *
FROM ny_airbnb_2019_staging
WHERE name = 'Clean & quiet apt home by the park';


CREATE TABLE `ny_airbnb_2019_staging2` (
  `id` int DEFAULT NULL,
  `name` text,
  `host_id` int DEFAULT NULL,
  `host_name` text,
  `neighbourhood_group` text,
  `neighbourhood` text,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `room_type` text,
  `price` int DEFAULT NULL,
  `minimum_nights` int DEFAULT NULL,
  `number_of_reviews` int DEFAULT NULL,
  `last_review` text,
  `reviews_per_month` text,
  `calculated_host_listings_count` int DEFAULT NULL,
  `availability_365` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT *
FROM ny_airbnb_2019_staging2
WHERE row_num > 1;


INSERT INTO ny_airbnb_2019_staging2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY id, name, host_id, neighbourhood_group, neighbourhood, latitude, longitude, room_type,
price, minimum_nights, number_of_reviews, last_review, reviews_per_month, calculated_host_listings_count, availability_365) AS row_num
FROM ny_airbnb_2019_staging;


DELETE
FROM ny_airbnb_2019_staging2
WHERE row_num > 1;

SELECT DISTINCT neighbourhood
FROM ny_airbnb_2019_staging2;

SELECT * 
FROM ny_airbnb_2019_staging2;


SELECT * 
FROM ny_airbnb_2019_staging2
ORDER BY reviews_per_month DESC;




