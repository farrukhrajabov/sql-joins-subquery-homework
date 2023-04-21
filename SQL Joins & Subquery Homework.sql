-- Question 1: List all customers who live in Texas (use JOINs) - Jeniffer Davis, Kim Cruz, Richard Mccrary, Bryan Hardison, Ian Still
select first_name,last_name
from customer 
inner join address
on address.address_id = customer.address_id and address.district = 'Texas';

-- Question 2: Get all payments above $6.99 with the Customer's Full Name
select first_name, last_name,payment.payment_id, payment.amount
from customer 
inner join payment
on payment.customer_id = customer.customer_id
and payment.amount > 6.99;

-- Question 3: Show all customers names who have made payments over $175(use subqueries) - Douglas Graf, Mary Smith
select first_name, last_name
from customer
where customer_id in (
    select customer_id
    from payment
    where payment.amount > 175
);

-- Question 4: List all customers that live in Nepal (use the city table)
SELECT store_id, first_name, last_name, address, country
FROM customer 
INNER JOIN address 
ON customer.address_id = address.address_id 
INNER JOIN city 
ON address.city_id = city.city_id 
INNER JOIN country 
ON city.country_id = country.country_id 
WHERE country = 'Nepal'; 

-- Question 5: Which staff member had the most transactions?
select first_name, last_name, COUNT(payment_id)  
from staff
join payment on  staff.staff_id = payment.staff_id
group by staff.staff_id
order by COUNT(payment_id) desc 
limit 1;

-- Question 6: How many movies of each rating are there?
select rating, COUNT(film_id) as movie_count
from film
group by rating 
order by COUNT(film_id) desc;

-- Question 7: Show all customers who have made a single payment above $6.99 (Use Subqueries)
select customer_id, first_name, last_name
from customer 
where customer_id in (
	select customer_id
	from payment 
	where amount > 6.99
	group by customer_id 
	having COUNT(payment_id) = 1
);

-- Question 8: How many free rentals did our store give away?
select COUNT(rental_id)
from rental
where rental_id in (
select rental.rental_id
from rental 
left join payment 
on payment.rental_id = rental.rental_id 
where payment.rental_id is null
);