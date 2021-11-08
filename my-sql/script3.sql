use sakila;
select customer_id, count(*) from payment group by customer_id having count(*) > 30 and count(*) < 33;

select * from payment;

select actor_id, count(film_id) from film_actor group by actor_id
having count(film_id) >= 15; 

select customer_id, count(customer_id) from rental
group by customer_id having count(customer_id) >= 29;

select release_year, count(release_year) from film group by release_year
having count(film_id) > 5;

select customer_id, sum(amount) from payment group by customer_id 
having sum(amount) between 70.00 and 100.00;

select film_id , count(film_id) from inventory group by film_id
having count(film_id) >  5;


#############################################################################

select * from film order by film_id limit 100, 500;

SELECT CUSTOMER_ID, CASE
	WHEN
		count(*) > 30
	THEN 	
		'SUPER CLIENTE'
	WHEN
		count(*) > 15 
	THEN 
		'CLIENTE FIEL'
	WHEN 
		count(*) > 0
	THEN 
		'ClIENTE EVENTUAL'
	END AS tipo_cliente
FROM payment
GROUP BY customer_id
HAVING tipo_cliente = 'CLIENTE EVENTUAL';

#########################################################################################

select customer_id , sum(amount) as TOTAL , case
when sum(amount) > 100
then 'Pai do torro' 
when sum(amount) between 70 and 100
then 'Cliente Bom'
when sum(amount) < 70
then 'Cliente Eventual'
end as categoria_cliente from payment group by customer_id order by total;

