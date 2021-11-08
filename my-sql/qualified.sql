use sakila;
select distinct customer.customer_id, customer.email, count(payment.payment_id) , sum(payment.amount) from customer 
left join payment
on customer.customer_id = payment.customer_id
group by customer.customer_id
order by sum(payment.amount) desc
limit 10 ;

