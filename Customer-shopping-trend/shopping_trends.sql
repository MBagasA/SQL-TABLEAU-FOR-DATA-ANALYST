--select * from brand;
--select * from customer;
--select * from purchased;


--1 total transaction with payment method--
SELECT 
    b.category, 
    p.payment_method,
    COUNT(*) AS total_transaksi
FROM 
    purchased p
JOIN 
    brand b 
    ON p.brand_id = b.brand_id 
    AND p.purchased_id = b.purchased_id 
GROUP BY 
    b.category, p.payment_method
HAVING 
    COUNT(*) = (
        SELECT 
            MAX(jumlah)
        FROM (
            SELECT 
                COUNT(*) AS jumlah
            FROM 
                purchased p2
            JOIN 
                brand b2 
                ON p2.brand_id = b2.brand_id 
                AND p2.purchased_id = b2.purchased_id
            WHERE 
                b2.category = b.category
            GROUP BY 
                p2.payment_method
        ) AS tab
    )
ORDER BY 
    total_transaksi DESC;



--2 Promotion Status--
SELECT 
    b.category,
    CASE 
        WHEN p.promotion = 'Yes' THEN 'Menggunakan Promo'
        ELSE 'Tidak Menggunakan Promo'
    END AS status_promo,
    COUNT(p.promotion) AS total_transaksi
FROM brand b
JOIN purchased p 
    ON b.brand_id = p.brand_id
GROUP BY 
    b.category,
    status_promo
ORDER BY 
    total_transaksi DESC;

 --3 total transaction with location customer--
SELECT 
    b.category,c.location_cust ,
    COUNT(p.purchased_id) AS total_transaksi
FROM customer c
join purchased p ON c.customer_id = p.customer_id
join brand b on c.customer_id = b.customer_id 
	GROUP BY b.category,c.location_cust 
ORDER BY total_transaksi DESC
limit 10  
   
   
 --4 total transaction with shipping type and avg purchase--
SELECT 
    p.shipping_type,
    COUNT(p.purchased_id) AS total_transaksi,
    ROUND(AVG(p.purchased_amount), 2) AS avg_pembelian
FROM purchased p
GROUP BY p.shipping_type
ORDER BY total_transaksi DESC; 
   
   
--total purchase amount--
select 
b.category, c.gender, b.item_purchased, p.purchased_amount
from brand b 
join purchased p on p.brand_id = b.brand_id 
join customer c on c.purchased_id = p.purchased_id 
group by b.category, c.gender, b.item_purchased, p.purchased_amount
order by p.purchased_amount desc;


--Payment methods based on gender--
select  b.item_purchased, b.category, p.payment_method,
COUNT(CASE WHEN c.gender = 'Male' THEN p.payment_method END) AS male_total_payment,
COUNT(CASE WHEN c.gender = 'Female' THEN p.payment_method END) AS female_total_payment
from customer c 
join brand b on c.brand_id = b.brand_id 
join purchased p on b.purchased_id = p.purchased_id 
where c.gender in ('Male','Female')
group by c.gender, b.item_purchased, b.category, p.payment_method
ORDER BY 
    COUNT(CASE WHEN c.gender = 'Male' THEN p.payment_method END) + 
    COUNT(CASE WHEN c.gender = 'Female' THEN p.payment_method END) DESC;
   

-- total promotion--
select b.category, p.promotion,
count (p.promotion)as total_promotion
from brand b 
join purchased p on b.brand_id = p.brand_id 
where p.promotion  = 'Yes'
group by b.category, p.promotion
order by total_promotion desc;


--frequency shipping--
select b.item_purchased, b.category, p.frequency_purchased,
	case 
		when p.frequency_purchased = 'Weekly' then  'fast Moving'
		when p.frequency_purchased = 'Fortnightly' OR p.frequency_purchased = 'Bi Weekly' then  'Quick Moving'
		when p.frequency_purchased = 'Monthly' then  'Standard'
		when p.frequency_purchased = 'Every Three Month' OR p.frequency_purchased = 'Quaterly' then  'Slow Moving'
		when p.frequency_purchased = 'anually' then  'Death Stock'
		else 'Other'
	end as clasification,
	count(*)as number_frequency
from brand b 
join purchased p on b.brand_id = p.brand_id 
group by b.item_purchased, b.category, p.frequency_purchased
order by number_frequency desc;


--age classification--
select b.item_purchased, b.category, c.age_cust,
	case 
		when c.age_cust between 18 and 29 then 'Teenagers'
		when c.age_cust between 30 and 59 then 'Adult'
		else 'Old People'
	end as classification_age,
	count(*) as number_age_categories
	from brand b 
	join customer c on b.brand_id = c.brand_id
	group by b.item_purchased, b.category, c.age_cust
	order by number_age_categories desc;

	
--percentage payment method--
select b.category, p.payment_method,
count(*)as total_item,
  CONCAT(ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY p.payment_method), 2), '%')
as percentage
from brand b  
join purchased p on b.brand_id = p.brand_id
group by b.category, p.payment_method
order by total_item desc
limit 10;

--percentage payment method--
WITH transaksi_per_kategori AS (
    SELECT
        b.category,
        p.payment_method,
        COUNT(*) AS total_item,
        SUM(COUNT(*)) OVER (PARTITION BY b.category) AS total_per_category
    FROM
        brand b
    JOIN
        purchased p ON b.brand_id = p.brand_id AND b.purchased_id = p.purchased_id
    GROUP BY
        b.category, p.payment_method
),
ranking AS (
    SELECT
        *,
        RANK() OVER (PARTITION BY category ORDER BY total_item DESC) as rn
    FROM
        transaksi_per_kategori
)
SELECT
    category,
    payment_method,
    total_item,
    CONCAT(ROUND(total_item * 100.0 / total_per_category, 2), '%') as percentage
FROM
    ranking
WHERE
    rn = 1
ORDER BY
    total_item DESC;


--percentage shipping method--
select b.category, p.shipping_type,
count(*)as total_shipping,
concat (round(count(*) * 100.0/sum(count(*))over (partition by p.shipping_type),2), '%')
as percentage_shipping
from brand b 
join purchased p on b.brand_id = p.brand_id 
group by b.category,p.shipping_type
order by total_shipping desc
limit 10;

--percentage season with gender and categroy--
select b.category,c.gender,b.season,
count(*)as total_category_Season,
concat(round(count(*)* 100.0/sum(count(*))over(partition by c.gender),2), '%')
as percentage_season 
from brand b 
join customer c on b.brand_id = c.brand_id 
group by b.category ,c.gender,b.season 
order by total_category_season desc;







