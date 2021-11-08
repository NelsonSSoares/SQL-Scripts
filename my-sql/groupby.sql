use sakila;

select amount as Preço from payment order by amount desc limit 10;

select * from country;

select first_name as Nome, `active` as `Status` from customer where `active` = 0;

select city from city where country_id = 15;

############################################################################################


## SOMA E AGRUPA POR ID DE CLIENTE
select customer_id, sum(amount) as faturamento_total from payment
group by customer_id;



