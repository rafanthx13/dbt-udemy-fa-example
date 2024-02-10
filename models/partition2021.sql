select * from {{ref('joins')}}
where EXTRACT(YEAR FROM order_date) = 2021