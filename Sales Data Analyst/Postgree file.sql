select * from online 

--high revenue--
select invoice_date, product_name, product_category,unit_sold,total_revenue 
from online 
where extract (year from invoice_date) in (2024, 2025, 2026)
group by invoice_date, product_name, product_category,unit_sold,total_revenue
order by total_revenue desc 
limit 10;

--highest unit price
select invoice_date,product_category,product_name,unit_price,unit_sold
from online 
where extract (year from invoice_date) in (2024, 2025, 2026)
group by invoice_date,product_category,product_name,unit_price,unit_sold
order by unit_price desc
limit 10;


--average age--
select avg(age)as average_age 
from online 

--highest total unit sold--
select invoice_date, product_name,product_category,unit_price,unit_sold
from online 
where extract (year from invoice_date) in (2024, 2025, 2026)
group by invoice_date, product_name,product_category,unit_price,unit_sold
order by unit_sold desc 
limit 20;

--total region--
SELECT region, product_category, COUNT(*) AS total_region
FROM online
WHERE region IN ('Europe', 'Asia', 'North America')
GROUP BY region,product_category 
order by total_region desc

--total segmentation--
SELECT segmentation , COUNT(*) AS total_segment
FROM online
WHERE segmentation  IN ('Consumer', 'Corporate', 'Home Office')
GROUP BY segmentation
order by total_segment asc

--sales category
select invoice_date,product_name,product_category,unit_sold,
CASE	
	when unit_sold <=5 then 'Low Sales'
	when unit_sold <=13 then 'Medium Sales'
	else 'High Sales'	
end as Sales_category 
from online
order by 
case 
	when unit_sold <=5 then 3
	when unit_sold <=13 then 2
	else 1	
end,
unit_sold desc;


--total purchase gender with product category
select product_category,gender, count(*)as total_purchase
from online 
group by product_category,gender
order by total_purchase desc

--total payment method with product category
select product_category,payment_method, count(*)as total_payment_method
from online 
group by product_category,payment_method
order by total_payment_method desc

--oldest age with gender male
select product_category,gender,max(age)as oldest_age
from online 
where gender = 'Male'
group by product_category,gender 
order by oldest_age desc

select product_category,gender,max(age)as oldest_age
from online 
where gender = 'Female'
group by product_category,gender 
order by oldest_age desc












