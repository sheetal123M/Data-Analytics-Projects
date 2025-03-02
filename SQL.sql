/* 1.Total Revenue*/
select concat(round(sum(revenue_realized)/1000000,0)," M")  as TotalRevenue from fact_bookings;

/*2.Utilize capacity */
select format(sum(capacity),0) as UtilizeCapacity from fact_aggregated_bookings;

/* 3.Occupancy */
select round(sum(successful_bookings)/sum(capacity)*100,2) as "Occupancy Rate" from fact_aggregated_bookings;

/* 4. Total Bookings */
select format(count(booking_id),0) as Total_Bookings from fact_bookings;

/* 5. Cancellation Rate*/
select round((sum(case when booking_status="cancelled" then 1 else 0 end)*100/ count(*)),2) as 
"CancellationRate"
from fact_bookings;

/* 6 Weekday  & Weekend  Revenue and Booking */  
select
    dim_date.day_type,
    concat(round(sum(fact_bookings.revenue_realized)/1000000,0)," M") AS TotalRevenue,
    format(count(fact_bookings.booking_id),0) AS TotalBookings
    from dim_date inner join
    fact_bookings on fact_bookings.check_in_date=dim_date.check_in_date
	group by dim_date.day_type;
    
/* 7 Revenue by Platform */      
select booking_platform , concat(round(sum(revenue_realized)/1000000,0)," M") as Total_revenue
from fact_bookings
group by booking_platform
order by total_revenue desc;

/* 8 Revenue by Category*/
select category , concat(round(sum(revenue_realized)/1000000,0)," M") as Total_revenue
from dim_hotels
join fact_bookings using (property_id)
group by category ;

/*9  Total revenue and bookings by city*/
select city, concat(round(sum(revenue_realized)/1000000,0 )," M") as Total_revenue,
format(count(fact_bookings.booking_id),0) AS TotalBookings
from fact_bookings
join dim_hotels using (property_id)
group by city;

/* 10.Capacity and successful Booking*/
SELECT property_name,
format(SUM(successful_bookings),0) AS Total_successful_bookings,
format(SUM(capacity),0) AS Total_capacity
FROM fact_aggregated_bookings
inner join dim_hotels on fact_aggregated_bookings.property_id=dim_hotels.property_id
GROUP BY property_name
ORDER BY total_successful_bookings DESC;



    



