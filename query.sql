select * from orders;

create view pizza_details as
select p.pizza_id,p.pizza_type_id,pt.name,pt.category,p.size,p.price,pt.ingredients
from pizzas p
join pizza_types pt on pt.pizza_type_id=p.pizza_type_id;

select * from pizza_details;

alter table orders
modify date date;

alter table orders
modify time time;



-- Total Revenue 

select concat('$ ' ,round(sum(od.quantity * p.price),2)) as Total_revenue from order_details od
join pizza_details p on od.pizza_id=p.pizza_id;

-- Total no of pizzas sold

select sum(quantity) as Total_pizzas_sold from order_details;

-- Total Orders

select count(distinct order_id) as Total_orders from order_details;

-- Avg order values

select round(sum(od.quantity * p.price)/count(distinct od.order_id),2) as Avg_order_value
from order_details od
join pizza_details p on od.pizza_id=p.pizza_id;

-- Avg no pizza per order

select sum(quantity)/count(distinct order_id) as avg_pizzas_per_order 
from order_details;

-- total revenue and no of orders by category

select p.category,sum(od.quantity * p.price) as Total_revenue,
count(distinct od.order_id) as No_of_orders
from order_details od
join pizza_details p on od.pizza_id=p.pizza_id
group by 1;

-- total revenue and no of orders per size

select p.size,sum(od.quantity * p.price) as Total_revenue,
count(distinct od.order_id) as No_of_orders
from order_details od
join pizza_details p on od.pizza_id=p.pizza_id
group by 1;

-- Hourly trend of no of orders and revenue

select case
 when Hour(o.time) between 9 and 12 then 'Late Morning'
 when Hour(o.time) between 12 and 15 then 'Lunch'
 when Hour(o.time) between 15 and 18 then 'Late Afternoon'
 when Hour(o.time) between 18 and 21 then 'Dinner'
  else 'Late Night'
  end as meal_time , count(distinct od.order_id) as total_orders,
  round(sum(od.quantity * p.price),2) as total_revenue
  from order_details od
  join orders o on o.order_id=od.order_id
  join pizza_details p on p.pizza_id=od.pizza_id
  group by meal_time;


  -- weekdays trend
  
  select dayname(o.date) as Day, count(distinct od.order_id) as total_orders,
  round(sum(od.quantity * p.price),2) as Total_revenue
  from order_details od
  join orders o on o.order_id=od.order_id
  join pizza_details p on p.pizza_id=od.pizza_id
  group by 1;
  
  -- Monthly trend
  
  select monthname(o.date) as Month, count(distinct od.order_id) as total_orders,
  round(sum(od.quantity * p.price),2) as Total_revenue
  from order_details od
  join orders o on o.order_id=od.order_id
  join pizza_details p on p.pizza_id=od.pizza_id
  group by 1
  order by 3 desc;
  
  -- Most ordered pizza
  
  select p.name , p.size, count(od.order_id) from order_details od
  join pizza_details p on p.pizza_id=od.pizza_id
  group by 1,2
  order by 3 desc;
  
  -- Top 5 pizzas by revenue
  
  select p.name as Pizza_name,round(sum(od.quantity * p.price),2) as Revenue
  from order_details od
  join pizza_details p on p.pizza_id=od.pizza_id
  group by 1
  order by 2 desc
  limit 5;
  
  -- Botton 5 pizzas by revenue
  
  select p.name as Pizza_name,round(sum(od.quantity * p.price),2) as Revenue
  from order_details od
  join pizza_details p on p.pizza_id=od.pizza_id
  group by 1
  order by 2
  limit 5;
  
  -- Top pizzas by sales
  
  select p.name as Pizza_name,sum(od.quantity) as Pizzas_sold
  from order_details od
  join pizza_details p on p.pizza_id=od.pizza_id
  group by 1
  order by 2 desc
  limit 5;
  
  -- Pizza analysis
  
  select name , price from pizza_details
  order by 2;
  
  -- most used ingredients
  
  create temporary table numbers as (
  select 1 as n union all
  select 2 union all select 3 union all select 4 union all
  select 5 union all select 6 union all select 7 union all
  select 8 union all select 9 union all select 10
  );
  
  select ingredients , count(ingredients) as Ingredients_count
  from (
      select substring_index(substring_index(ingredients , ',' , n), ',' ,-1) as ingredients
      from order_details od
      join pizza_details p on p.pizza_id=od.pizza_id
      join numbers on char_length(ingredients) - char_length(replace(ingredients, ',' ,'')) >= n-1
      ) as sq
 group by 1
 order by 2 desc;
      
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  















 




