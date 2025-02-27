--Задача 1. Время активности объявления
WITH limits AS (
    SELECT  
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY total_area) AS total_area_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY rooms) AS rooms_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY balcony) AS balcony_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY ceiling_height) AS ceiling_height_limit_h,
        PERCENTILE_DISC(0.01) WITHIN GROUP (ORDER BY ceiling_height) AS ceiling_height_limit_l
    FROM real_estate.flats     
),
--Найдем id объявлений, которые не содержат выбросов:
filtered_id AS(
    SELECT id
    FROM real_estate.flats  
    WHERE 
        total_area < (SELECT total_area_limit FROM limits)
        AND (rooms < (SELECT rooms_limit FROM limits) OR rooms IS NULL)
        AND (balcony < (SELECT balcony_limit FROM limits) OR balcony IS NULL)
        AND ((ceiling_height < (SELECT ceiling_height_limit_h FROM limits)
            AND ceiling_height > (SELECT ceiling_height_limit_l FROM limits)) OR ceiling_height IS NULL)
    ),
--Группируем данные по количеству дней до снятия объявления и по областям
counts AS(
	   SELECT id,
	   	      last_price,
			  total_area,
			  rooms,
			  balcony,
			  CEILING_height,
			  floors_total,
			  floor,
			  is_apartment,
	   CASE WHEN days_exposition<=30
			THEN '1. less then 1 month'
			WHEN days_exposition>30 AND days_exposition<=90
			THEN '2. 1-3 months'
			WHEN days_exposition>90 AND days_exposition<=180
			THEN '3. 3-6 months'
			WHEN days_exposition>180 AND days_exposition<=270
			THEN '4. 6-9 months'
			WHEN days_exposition>270
			THEN '5. over 9 months' END AS exposition_categories,
		CASE WHEN city = 'Санкт-Петербург' 
		THEN 'Saint-Petersburg' ELSE 'Leningrad area' END AS area
FROM real_estate.advertisement a 
JOIN real_estate.flats f using(id) 
JOIN real_estate.city c using(city_id)
JOIN real_estate.TYPE t using(type_id)
WHERE id IN (SELECT * FROM filtered_id) AND days_exposition IS NOT NULL AND TYPE = 'город')
-- Основной запрос, считающий средние параметры продаваемых квартир в рамках заданных групп
SELECT exposition_categories,
       area,
       count(id) AS ad_count,
       round(count(id)::numeric/(SELECT count(id) FROM real_estate.flats f)) AS ad_share,
       round(avg(last_price)) AS avg_price,
	   round(avg(last_price/total_area::numeric)) AS avg_price_per_sqr_mtr,
	   round(avg(total_area)::numeric, 2) AS avg_total_area,
	   percentile_disc(0.5) WITHIN GROUP(ORDER by rooms) AS median_rooms,
	   percentile_disc(0.5) WITHIN GROUP(ORDER by balcony) AS median_balcony,
	   round(avg(ceiling_height)::numeric, 2) AS avg_ceiling_height,
	   percentile_disc(0.5) WITHIN GROUP(ORDER BY floors_total) AS floors_total_median,
	   percentile_disc(0.5) WITHIN GROUP(ORDER BY floor) AS floor_median,
	   round((SELECT count(id) FROM counts WHERE is_apartment = 1)/count(id)::NUMERIC,2) AS apartment_share
FROM counts
GROUP BY exposition_categories, area
ORDER BY area desc, exposition_categories;

--Задача 2. Сезонность объявлений
WITH limits AS (
    SELECT  
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY total_area) AS total_area_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY rooms) AS rooms_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY balcony) AS balcony_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY ceiling_height) AS ceiling_height_limit_h,
        PERCENTILE_DISC(0.01) WITHIN GROUP (ORDER BY ceiling_height) AS ceiling_height_limit_l
    FROM real_estate.flats     
),
filtered_id AS(
    SELECT id
    FROM real_estate.flats  
    WHERE 
        total_area < (SELECT total_area_limit FROM limits)
        AND (rooms < (SELECT rooms_limit FROM limits) OR rooms IS NULL)
        AND (balcony < (SELECT balcony_limit FROM limits) OR balcony IS NULL)
        AND ((ceiling_height < (SELECT ceiling_height_limit_h FROM limits)
            AND ceiling_height > (SELECT ceiling_height_limit_l FROM limits)) OR ceiling_height IS NULL)
    ),
 f_m AS (SELECT 
 		EXTRACT(YEAR FROM first_day_exposition) AS year,
 		EXTRACT(MONTH FROM first_day_exposition) AS publish_month,
 	    count(a.id) AS published_advertisments,
 	    round(avg(total_area)::NUMERIC, 2) AS avg_area,
	    round(avg(last_price/total_area::numeric)) AS avq_price_per_sqr_m
	    FROM real_estate.advertisement a 
	    JOIN real_estate.flats using(id)
	    JOIN real_estate.type USING(type_id) 
	    WHERE id IN (SELECT * FROM filtered_id) AND TYPE = 'город'
	    AND EXTRACT(YEAR FROM first_day_exposition)>2014 
	    AND EXTRACT(YEAR FROM first_day_exposition)<2019
	    GROUP BY EXTRACT(MONTH FROM first_day_exposition), EXTRACT(YEAR FROM first_day_exposition)
 ),
 l_m as(SELECT 
 		extract(YEAR FROM FIRST_day_exposition+days_exposition::int) AS year,
 		extract(MONTH FROM FIRST_day_exposition+days_exposition::int) AS removed_month,
 	    count(days_exposition) AS removed_advertisments
 	    FROM real_estate.advertisement a 
 	    JOIN real_estate.flats f using(id)
 	    JOIN real_estate.TYPE using(type_id)
 	    WHERE days_exposition IS NOT NULL AND id IN (SELECT * FROM filtered_id) AND TYPE = 'город'
 	    AND EXTRACT(YEAR FROM first_day_exposition)>2014
 	    AND EXTRACT(YEAR FROM first_day_exposition)<2019
 	    GROUP BY EXTRACT(MONTH FROM first_day_exposition+days_exposition::int), extract(YEAR FROM FIRST_day_exposition+days_exposition::int)
 )
 SELECT publish_month AS month,
 CASE WHEN publish_month = 1 THEN 'january'
		WHEN publish_month = 2 THEN 'february'
		WHEN publish_month = 3 THEN 'march'
		WHEN publish_month = 4 THEN 'april'
		WHEN publish_month = 5 THEN 'may'
		WHEN publish_month = 6 THEN 'june'
		WHEN publish_month = 7 THEN 'july'
		WHEN publish_month = 8 THEN 'august'
		WHEN publish_month = 9 THEN 'september'
		WHEN publish_month = 10 THEN 'october'
		WHEN publish_month = 11 THEN 'november'
		WHEN publish_month = 12 THEN 'december' END AS month_name,
		CASE WHEN publish_month =12 THEN 'winter'
		WHEN  publish_month <=2 THEN 'winter'
		WHEN publish_month >2 and publish_month<=5  THEN 'spring'
		WHEN publish_month >5 and publish_month<=8 THEN 'summer'
		ELSE 'autumn' END AS season,
		DENSE_RANK () over(ORDER BY round(avg(published_advertisments)) desc) AS published_rank,
 	    round(avg(published_advertisments)) AS avg_published_advertisments,
 	    DENSE_RANK () over(ORDER BY round(avg(removed_advertisments)) desc) AS removed_rank,
 	    round(avg(removed_advertisments)) as avg_removed_advertisments,
 	    round(avg(avg_area)::NUMERIC, 2) AS avg_area,
 	    round(avg(f_m.avq_price_per_sqr_m)) AS avg_price_per_sqr_m
 FROM f_m JOIN l_m ON f_m.publish_month = l_m.removed_month
 GROUP BY publish_month, removed_month
 ORDER BY DENSE_RANK () over(ORDER BY round(avg(published_advertisments)) desc);

--Задача 3. Анализ рынка недвижимости Ленобласти
WITH limits AS (
    SELECT  
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY total_area) AS total_area_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY rooms) AS rooms_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY balcony) AS balcony_limit,
        PERCENTILE_DISC(0.99) WITHIN GROUP (ORDER BY ceiling_height) AS ceiling_height_limit_h,
        PERCENTILE_DISC(0.01) WITHIN GROUP (ORDER BY ceiling_height) AS ceiling_height_limit_l
    FROM real_estate.flats     
),
filtered_id AS(
    SELECT id
    FROM real_estate.flats  
    WHERE 
        total_area < (SELECT total_area_limit FROM limits)
        AND (rooms < (SELECT rooms_limit FROM limits) OR rooms IS NULL)
        AND (balcony < (SELECT balcony_limit FROM limits) OR balcony IS NULL)
        AND ((ceiling_height < (SELECT ceiling_height_limit_h FROM limits)
            AND ceiling_height > (SELECT ceiling_height_limit_l FROM limits)) OR ceiling_height IS NULL)
    )
SELECT city,
	   count(id) AS published_ads,
	   round(count(days_exposition)::numeric/count(id),2) AS removed_ads_share,
	   round(avg(total_area)::NUMERIC, 2) AS avg_area,
	   round(avg(last_price/total_area::numeric)) AS avq_price_per_sqr_m,
	   percentile_disc(0.5) WITHIN GROUP(ORDER by rooms) AS median_rooms,
	   percentile_disc(0.5) WITHIN GROUP(ORDER by balcony) AS median_balcony,
	   round(avg(ceiling_height)::numeric, 2) AS avg_ceiling_height,
	   percentile_disc(0.5) WITHIN GROUP(ORDER BY floors_total) AS floors_total_median,
	   percentile_disc(0.5) WITHIN GROUP(ORDER BY floor) AS floor_median,
	   round(avg(days_exposition)) AS avg_days_expositin
FROM real_estate.advertisement a 
JOIN real_estate.flats f USING (id)
JOIN real_estate.city c USING (city_id)
WHERE city <> 'Санкт-Петербург' AND id IN (SELECT * FROM filtered_id)
GROUP BY city
ORDER BY count(id) DESC
LIMIT 15;

 	    
    
    

	   
