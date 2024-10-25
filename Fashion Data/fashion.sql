--Selling price of all products
select customer_id,invoice_date,item_purchased,sell_price,rating,shipping_type
from customer 
join price on price_id = customer_id
join shipping on shipping_id = price_id
group by customer_id,invoice_date,item_purchased,sell_price,rating,shipping_type
order by sell_price desc
limit 30;

--low rating
select customer_id,invoice_date,item_purchased,sell_price,gender, max(rating)
as low_rating
from customer 
left join price on price_id = customer_id
left join shipping on price_id = shipping_id
group by customer_id,invoice_date,item_purchased,sell_price,gender
order by low_rating desc
limit 10;

--Oldest buyer
select customer_id,invoice_date,item_purchased,category, max(age)as oldest_age
from customer 
left join price on price_id = customer_id
left join shipping on price_id = shipping_id
group by customer_id,invoice_date,item_purchased,category
order by oldest_age desc

--total price after discount
select customer_id,invoice_date,item_purchased,sell_price,gender,total_discount 
from customer
join price on price_id = customer_id
join shipping on price_id = shipping_id
group by customer_id,invoice_date,item_purchased,sell_price,gender,total_discount 
order by total_discount desc

--
select * from customer 
left join price on price_id = customer_id
left join shipping on price_id = shipping_id
order by age desc;

--most size
SELECT size_clothing, COUNT(*) AS total_cloth
FROM customer
GROUP BY size_clothing
order by total_cloth desc

--most color and category
select color,category, count (*)as most_colors
from customer 
group by color,category 
order by most_colors desc

--average age
select avg(rating)as average_rate
from price

--average age
select avg (age)as average_age
from customer

--total price
SELECT sum(sell_price) AS total_sell_price
FROM price;

--most category with most season
SELECT category, COUNT(*) AS most_category,season, COUNT(season) AS season_count
FROM customer
GROUP BY category,season
ORDER BY most_category DESC;

--most clothing with size
select category,count (*)as most_category,size_clothing,count(*)as most_size
from customer 
group by category,size_clothing 
order by most_size desc

--most buyer from the city
select region, count(*)as most_region_buyer 
from price 
group by region 
order by most_region_buyer desc