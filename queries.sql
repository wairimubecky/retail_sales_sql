         --Section A — SQL fundamentals
--1. Retrieve all customer records.
select * from customers;
       
--2. Display customer names, cities, and segments.    
 select customer_name, city, customer_segment
 from customers;
       
--3. Find customers living in Nairobi.
 select customer_name, city
 from customers c 
 where city = 'Nairobi';
 
--4. Find customers registered after January 1, 2025.
select customer_name, registration_date
from customers c 
where registration_date > '2025-01-01';

--5. Display all unique customer cities.
select distinct city from customers;   

--6. Retrieve the 10 most recent orders.
select * from orders;

select * from orders 
order by order_date desc
limit 10;

--7. Find orders with unit prices above KSh 10,000.
 select * from orders o 
 where unit_price > 10000;

--8. Find customers whose names start with A.
select customer_name, left(customer_name, 1) as name_start
from customers c
where left(customer_name, 1) = 'A';

--9. Retrieve orders with quantities between 2 and 5.
select * from orders o 
where quantity between 2 and 5;

--10. Find orders paid through M-Pesa.
select * from orders o 
where payment_method in ('M-Pesa');

        --Section B — Aggregation and grouping
--11. Count all customers.
select count(*) as all_customers
from customers;

--12. Count all orders.
select count(*) as all_orders
from orders;

--13. Calculate completed-order revenue.
select * from orders;

select sum(quantity*unit_price*(1-discount/100)) as revenue
from orders
where order_status = 'Completed';

--14. Calculate the average completed-order value.
select avg(quantity*unit_price*(1-discount/100)) as avg_revenue
from orders
where order_status = 'Completed';

--15. Find the highest and lowest product prices.
select max(unit_price) as highest_price, min(unit_price) as lowest_price
from orders;

--16. Calculate revenue by product category.
select product_category, sum(quantity*unit_price*(1-discount/100)) as revenue
from orders
where order_status = 'Completed'
group by product_category
order by revenue desc;

--17. Count customers by city.
select city, count(customer_name)
from customers c 
group by city;

--18. Calculate quantity sold by product.
select product_name, sum(quantity) as quantity_sold
from orders 
group by product_name;

--19. Find categories generating more than KSh 100,000 in revenue.
select product_category, sum(quantity*unit_price*(1-discount/100)) as revenue
from orders
where order_status = 'Completed'
group by product_category
having sum(quantity*unit_price*(1-discount/100)) > 100000;

--20. Calculate the percentage of cancelled orders.
select count(*) filter (where order_status = 'Cancelled') *100.00
/count(*) as cancelled_ord_perc
from orders;

           --Section C — Joins and customer analytics
--21. Display orders with customer names and cities.
select o.order_id, o.product_name, c.customer_name, c.city
from orders o
inner join customers c
on c.customer_id = o.customer_id;

--22. Calculate total spending by customer.
select c.customer_name, sum(o.quantity*o.cost_price)filter(where order_status = 'Completed') as total_cost
from orders o
inner join customers c
on o.customer_id = c.customer_id
group by c.customer_name;

--23. Identify customers who have never ordered.
select customer_id from customers
except 
select customer_id from orders;

--24. Find the 10 highest-spending customers.
select c.customer_name, sum(o.quantity*o.cost_price) as total_cost
from orders o
inner join customers c
on o.customer_id = c.customer_id
group by c.customer_name
order by total_cost desc
limit 10;

--25. Calculate revenue by customer city.
select c.city, sum(o.quantity*o.unit_price*(1-o.discount/100)) as revenue
from orders o
inner join customers c
on o.customer_id = c.customer_id
where order_status = 'Completed'
group by c.city
order by revenue desc;

--26. Identify customers with more than five orders.
select customer_id, count(customer_id) as orders
from orders o 
group by customer_id
having count(customer_id) > 5
order by customer_id;

--27. Calculate average customer spending by segment.
select c.customer_segment, avg(o.quantity*o.cost_price) as avg_cust_spending
from orders o
inner join customers c
on o.customer_id = c.customer_id
group by customer_segment;

--28. Identify the most popular category among VIP customers.
select o.product_category, c.customer_segment, count(o.product_category)
from orders o
inner join customers c
on o.customer_id = c.customer_id
where c.customer_segment = 'VIP' 
group by o.product_category,c.customer_segment
order by count(o.product_category) desc
limit 1;

            --Subqueries and CTEs
select * from customers;
select * from orders;

--29. Find customers spending above the average total spending per purchasing customer.
select customer_id, sum(quantity*cost_price) as customer_spending from orders  
group by customer_id
having sum(quantity*cost_price) >
(select avg(quantity*cost_price) as avg_total_spending from orders);

--30. Find products priced above the overall average unit price.
select product_name, unit_price from orders o 
where unit_price >
(select avg(unit_price) from orders)
group by product_name, unit_price;

--31. Use a CTE to identify the three highest-revenue months.
with highest_revenue_months as (
select to_char(order_date, 'YYYY-MM') as month, sum(quantity*unit_price*(1-discount/100)) as total_revenue
from orders
where order_status = 'Completed'
group by to_char(order_date, 'YYYY-MM')
order by sum(quantity*unit_price*(1-discount/100)) desc
limit 3)
select * from highest_revenue_months;

--32. Find customers purchasing from at least three categories.
with customer_summary as
(select customer_id, count(product_category)
from orders
group by customer_id 
having count(product_category) >= 3)
select * from customer_summary;

--33. Use a CTE to calculate category revenue, cost, profit, and profit margin.
with category_summary as(
select product_category, sum(quantity*unit_price*(1-discount/100)) as revenue, sum(quantity*cost_price) as cost,
(sum(quantity*unit_price*(1-discount/100))-sum(quantity*cost_price)) as profit,
(sum(quantity*unit_price*(1-discount/100))-sum(quantity*cost_price))/NULLIF(sum(quantity*unit_price*(1-discount/100)),0)*100 as profit_margin
from orders
where order_status = 'Completed'
group by product_category)
select * from category_summary;

--34. Find customers whose latest completed order is more than 90 days before the latest order date in the dataset.
with latest_date as (
    select max(order_date) as latest_date
    from orders
),
customer_last_order as (
    select customer_id, max(order_date) as last_completed_order
    from orders
    where order_status = 'Completed'
    group by customer_id
)
select c.customer_id, c.customer_name, clo.last_completed_order, ld.latest_date
from customer_last_order clo
join customers c
on clo.customer_id = c.customer_id
cross join latest_date ld
where clo.last_completed_order < ld.latest_date - interval '90 days';

            -- Window functions
--35. Rank customers by spending using RANK().
select customer_id, sum(quantity*cost_price) as total_spent,
rank()over(order by sum(quantity*cost_price) desc) as customer_rank
from orders
group by customer_id;

--36. Number each customer's orders by recency using ROW_NUMBER().
select customer_id, order_date,
row_number()over(order by order_date desc) as recency
from orders o 
group by customer_id, order_date;

--37. Rank products within categories using DENSE_RANK().
select product_name, product_category, sum(quantity*cost_price) as cost,
dense_rank() over(partition by product_category order by sum(quantity*cost_price) desc) as product_rank
from orders
group by product_name, product_category;

--38. Calculate cumulative monthly revenue.
select to_char(order_date, 'YYYY-MM') as month,
sum(quantity*unit_price*(1-discount/100)) over (partition by to_char(order_date, 'MM'))
from orders
where order_status = 'Completed';

--39. Compare monthly revenue using LAG().
with monthly_revenue as(
 select to_char(order_date, 'YYYY-MM') as y_month, sum(quantity*unit_price*(1-discount/100)) as revenue
 from orders where order_status = 'Completed' group by to_char(order_date, 'YYYY-MM')
)
select y_month, revenue,
lag(revenue) over(order by y_month) as previous_revenue
from monthly_revenue;

--40. Calculate month-over-month revenue growth (%).
with monthly_revenue as(
 select to_char(order_date, 'YYYY-MM') as y_month, sum(quantity*unit_price*(1-discount/100)) as revenue
 from orders where order_status = 'Completed' group by to_char(order_date, 'YYYY-MM')
)
select y_month, revenue, lag(revenue) over(order by y_month) as prev_revenue,
((revenue - lag(revenue) over(order by y_month))/lag(revenue) over(order by y_month))*100 as revenue_growth
from monthly_revenue;

--41. Divide customers into four spending groups using NTILE(4).
select customer_id, sum(quantity*cost_price) as total_cost,
ntile(4) over(order by sum(quantity*cost_price) desc) as spending_group
from orders
group by customer_id;

--42. Calculate each category's share of total revenue using window functions.
with category_revenue as(
 select product_category, sum(quantity*unit_price*(1-discount/100)) as revenue
 from orders group by product_category)
select product_category, revenue,
sum(revenue) over() as total_revenue,
(revenue/sum(revenue)over())*100 as share
from category_revenue 
group by product_category, revenue;

          --Advanced business intelligence
select * from customers;
select * from orders;

--43. Create a monthly_sales_summary view (month, orders, revenue, cost, profit), then select from it.
create view monthly_sales_summary as
select to_char(order_date, 'YYYY-MM') as month, order_id,  sum(quantity*unit_price*(1-discount/100)) as revenue,
sum(quantity*cost_price) as cost,
(sum(quantity*unit_price*(1-discount/100))-sum(quantity*cost_price)) as profit
from orders
group by to_char(order_date, 'YYYY-MM'), order_id;

select * from monthly_sales_summary;

--44. Create a PL/pgSQL function that returns completed-order revenue for a supplied customer ID
   --show it for one customer and for an ID that does not exist (it must return 0).
create or replace function completed_order_revenue_summary(
    f_customer_id int
)
returns numeric
language plpgsql
as $$
begin
 return(
  select sum(quantity*unit_price*(1-discount/100)) as revenue
  from orders
  where customer_id = f_customer_id and order_status = 'Completed');
end;
$$;

select * from completed_order_revenue_summary(3);

--45. Segment customers into High, Medium and Low Value, and explain why you chose your thresholds.
with customer_spending as (
 select c.customer_id, sum(o.quantity*o.unit_price*(1-o.discount/100)) filter(where o.order_status = 'Completed') as total_spending
 from customers c
 left join orders o
 on c.customer_id = o.customer_id
 group by c.customer_id
),
customer_ranking as (
    select total_spending,
    ntile(3) over (order by total_spending desc) as spending_group
    from customer_spending
)
select case spending_group
        when 1 then 'High value'
        when 2 then 'Medium value'
        when 3 then 'Low value'
  end as customer_value,
count(*) as customer_count, min(total_spending) as minimum_spending, max(total_spending) as maximum_spending
from customer_ranking
group by spending_group
order by spending_group;

--46. Produce a management report: top five customers, top five products, the most profitable category, and the lowest-revenue month.
--Top 5 customers
select c.customer_id, c.customer_name,sum(o.quantity*o.cost_price) as total_spent
from customers c
inner join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
order by total_spent desc
limit 5;

--Top 5 products
select product_name, product_category, sum(quantity) as sold_units, sum(quantity*unit_price*(1-discount/100)) as revenue
from orders
where order_status = 'Completed'
group by product_name,product_category
order by revenue desc
limit 5;

--Most Profitable Category
select product_category,sum(quantity*unit_price*(1-discount/100)) as revenue, sum(quantity*cost_price) as cost,
(sum(quantity*unit_price*(1-discount/100))-sum(quantity*cost_price)) as profit
from orders
group by product_category 
order by profit desc 
limit 1;

--Lowest Revenue month
select to_char(order_date, 'YYYY-MM') as y_month, sum(quantity*unit_price*(1-discount/100)) as revenue
from orders
group by to_char(order_date, 'YYYY-MM')
order by revenue asc
limit 1;

       
