--1--
select customer_id,customer_name,order_date,order_quantity,price,product_sub_category,city from customer
inner join item on item_id = customer_id 
inner join sales on sales_id = item_id
where extract(year from cast (order_date as date )) = 2009
group by customer_id,customer_name,order_date,order_quantity,price,product_sub_category,city
order by price desc,order_quantity desc

--2--
select customer_id,customer_name,order_date,order_quantity,price,product_sub_category,city from customer
inner join item on item_id = customer_id 
inner join sales on sales_id = item_id
where extract(year from cast (order_date as date )) = 2010
group by customer_id,customer_name,order_date,order_quantity,price,product_sub_category,city
order by price desc

--3--
select customer_id,customer_name,order_date,order_quantity,price,product_category,product_sub_category 
from customer 
join item on item_id = customer_id 
join sales on sales_id = item_id
where extract (year from cast(order_date as date)) = 2011
group by customer_id,customer_name,order_date,order_quantity,price,product_category,product_sub_category 
order by order_quantity desc;

select customer_id,customer_name,city,order_date,product_sub_category,order_quantity,max(price)as high_price
from customer 
left join item on item_id = customer_id 
left join sales on sales_id = item_id 
where extract (year from cast(order_date as date)) = 2012
group by customer_id,customer_name,city,order_date,product_sub_category,order_quantity
order by order_quantity  desc,
high_price desc;


select customer_id,customer_name,city,order_status,order_quantity,price,product_sub_category, 
order_date
from customer 
inner join item on item_id = customer_id 
inner join sales on sales_id = item_id
where order_status = 'Returned' and extract (year from cast(order_date as date)) in (2009,2010,2011,2012)
group by customer_id,customer_name,city,order_status,order_quantity,price,product_sub_category,order_date
order by order_quantity desc;

select customer_id,customer_name,city,product_category,order_quantity,price,discount from customer 
inner join item on item_id = customer_id 
inner join sales on sales_id = item_id
where product_category = 'Office Supplies' and city ='Greenville'
group by customer_id,customer_name,city,product_category,order_quantity,price,discount
order by order_quantity desc;

--categorize order quantity with product subcategory paper with the most expensive price
select customer_id,customer_name,city,product_sub_category,order_quantity,order_date,price,
case 
	when order_quantity <=10 then 'Small'
	when order_quantity <=30 then 'Medium'
	when order_quantity >30  then 'Large' 
end
from customer 
inner join item on item_id = customer_id 
inner join sales on sales_id = item_id
where product_sub_category ='Paper'
order by price desc;





