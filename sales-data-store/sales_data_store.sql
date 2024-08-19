--high sell in 2016,2017,2018
select invoice_date,gender,age,category,quantity,purchase_price,max(selling_price) as high_sell 
from data_shop 
where extract (year from invoice_date) in (2016, 2017, 2018)
group by invoice_date,gender,age,category,quantity,purchase_price 
order by high_sell desc;

--high purchase in 2016,2017,2018
select invoice_date,gender,age,category,quantity,selling_price,max(purchase_price)as high_purchase 
from data_shop 
where extract (year from invoice_date) in (2016, 2017, 2018)
group by invoice_date,gender,age,category,quantity,selling_price 
order by high_purchase desc

select invoice_date,gender,age,category,quantity,purchase_price,max(selling_price) as high_sell 
from data_shop 
where gender ='Male' and extract (year from invoice_date) in (2016, 2017, 2018)
group by invoice_date,gender,age,category,quantity,purchase_price 
order by high_sell desc;

select invoice_date,gender,age,category,quantity,selling_price,max(purchase_price)as high_purchase 
from data_shop 
where gender ='Female' and extract (year from invoice_date) in (2016,2017,2018)
group by invoice_date,gender,age,category,quantity,selling_price 
order by high_purchase desc

--looking high_price and gender male
select invoice_no,invoice_date,gender,age,category,max(purchase_price) as high_price
from data_shop 
where gender ='Male' and age <=50
group by invoice_no,invoice_date,gender,age,category
order by high_price desc;
--limit 3;



--Looking high sell, from province East java
select invoice_no,invoice_date,category,city,province,max(selling_price)as high_sell
from data_shop 
where province = 'East Java'
group by invoice_no,invoice_date,category,city,province
order by high_sell desc;

--looking high price in 2016 years
select invoice_no,invoice_date,category,gender,age,max(purchase_price)as high_purchase
from data_shop 
where extract(year from invoice_date) = 2016
group by invoice_no,invoice_date,category,gender,age
order by high_purchase desc;

--looking category clothing and gender female
select invoice_no,invoice_date,category,gender,purchase_price,city,max(selling_price)as high_price
from data_shop 
group  by invoice_no,invoice_date,category,gender,purchase_price,city
having category ='Clothing' and gender ='Female'
order by high_price desc;

--looking for the highest selling price in the toy category and age less than or equal to 40
select invoice_no,invoice_date,category,age,max(selling_price)as highest_price
from data_shop ds 
group by invoice_no,invoice_date,category,age
having category ='Toys' and age <=40
order by highest_price desc;

--looking for age less than equal to forty, book category and gender male 
select invoice_no,invoice_date,gender,age,category,province,selling_price,max(quantity)high_sell
from data_shop 
group by invoice_no,invoice_date,gender,age,category,province,selling_price
having age <=40 and category ='Books' and gender ='Male'
order by high_sell desc;
