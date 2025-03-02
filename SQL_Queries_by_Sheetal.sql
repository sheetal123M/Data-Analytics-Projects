create database project;

use project;

select* 
from zomato;

/*1. Display country code and country name*/
select distinct CountryCode,Country
from zomato;

/*2. Find the Number of Restaurants based on City and Country*/
select Country,City,count(RestaurantID) as No_Of_Restaurants
from zomato
group by City,Country
order by Country, City;

/*3. Number of Restaurants Opening Based on Year, Quarter, Month*/
select year(Datekey_Opening) as Year, quarter(Datekey_Opening) as Quarter, monthname(Datekey_Opening) as Month,count(RestaurantID) as No_Of_Restaurants
from zomato
group by Year,Quarter,month
order by Year,Quarter,Month;

/*4. Count of Restaurants Based on Average Ratings*/
SELECT 
    CASE
        WHEN Rating<2 THEN '1.00 - 1.99'
        WHEN Rating<3 THEN '2.00 - 2.99'
        WHEN Rating<4 THEN '3.00 - 3.99'
        WHEN Rating<5 THEN '4.00 - 4.99'
        ELSE 5
    END AS rating_range,
    count(RestaurantID) as No_Of_Restaurants
FROM zomato
GROUP BY rating_range
ORDER BY rating_range;

/*5. Create Buckets Based on Average Price and Count Restaurants in Each Bucket*/
SELECT 
    CASE
        WHEN Average_Cost_for_two<201 THEN '0-200'
        WHEN Average_Cost_for_two<401 THEN '201-400'
        WHEN Average_Cost_for_two<1001 THEN '401-1000'
        WHEN Average_Cost_for_two<2001 THEN '1001-2000'
        WHEN Average_Cost_for_two<5001 THEN '2001-5000'
        WHEN Average_Cost_for_two<10001 THEN '5001-10000'
        ELSE '10000-MORE'
    END AS Average_Price,
    count(RestaurantID) as No_Of_Restaurants
FROM zomato
GROUP BY Average_Price
ORDER BY Average_Price;

/*6. Percentage of Restaurants Based on "Has_Table_booking"*/
select Has_Table_booking, ROUND(COUNT(RestaurantID) * 100 / (SELECT COUNT(RestaurantID) FROM zomato), 2) AS percentage
from zomato
group by Has_Table_booking;

/*7. Percentage of Restaurants Based on "Has_Online_delivery"*/
select Has_Online_delivery, ROUND(COUNT(RestaurantID) * 100 / (SELECT COUNT(RestaurantID) FROM zomato), 2) AS percentage
from zomato
group by Has_Online_delivery;

/*8. Number of Restaurants by Cuisine*/
select Cuisines, count(RestaurantID) as No_Of_Restaurants
from zomato
group by Cuisines;

/*9. Number of Restaurants by City*/
select City,count(RestaurantID) as No_Of_Restaurants
from zomato
group by City;

/*10. Number of Restaurants by Rating and City*/
select Rating,City,count(RestaurantID) as No_Of_Restaurants
from zomato
group by Rating,City;


