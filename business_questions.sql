--Business questions

-Basic level questions

Who is the most senior employee based on job title?

SELECT * FROM employee
ORDER BY levels DESC
LIMIT 1;

Which country have the most invoice?

SELECT billing_country, COUNT(invoice_id) FROM invoice
GROUP BY billing_country
ORDER BY COUNT(invoice_id) DESC
LIMIT 1;

Write a query which gives email, first name, last name and genre of all Rock listeners ordered alphabetically by email.

SELECT email, first_name, last_name, g.genre FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il on i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
Join genre g on t.genre_id = g.genre_id
where genre = 'Rock'
order by email;


-Moderate Level Questions

Write a query to return the email, first_name, last_name, & Genre of all Rock music listeners. Return your list ordered alphabetically by email stating with A.

SELECT email, first_name, last_name, g.genre FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il on i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
Join genre g on t.genre_id = g.genre_id
where genre = 'Rock'
order by email;

Lets invite the artists who have written the most rock music in our dataset. Write a query that returns the artist name and total track count of the top 10 rock bands.

SELECT COUNT(a.artist_id) as total_tracks, r.name, g.genre from genre g
JOIN track t on g.genre_id = t.genre_id
JOIN album a ON t.album_id = a.album_id
JOIN artist r ON a.artist_id = r.artist_id
WHERE g.genre = 'Rock'
GROUP BY r.name, g.genre
order by COUNT(a.artist_id) DESC
LIMIT 10;

Return all the track names that have a song length longer than the average song length. Return the name and millisecond for each track. Order by the song length with the longest songs listed first.

SELECT name, milliseconds, av.avg_length FROM track
JOIN(SELECT AVG(milliseconds) as avg_length
from track
) av
WHERE milliseconds>avg_length
order by milliseconds DESC;

-Advanced Level Questions.

Find How much amount spend by each customer on artists? Write a query to return a customer name, artist name and total spend?

I have used two queries but have got two different results.

SELECT c.first_name, c.last_name, a.name, SUM(il.quantity*il.unit_price) as total_amount_spent 
FROM artist a
JOIN album b ON a.artist_id = b.artist_id
JOIN track t ON b.album_id = t.album_id
JOIN invoice_line il ON t.track_id = il.track_id
JOIN invoice i ON il.invoice_id = i.invoice_id
JOIN customer c ON i.customer_id = c.customer_id
GROUP BY c.first_name, c.last_name, a.name
order by total_amount_spent DESC;

Find the customer who spend most on the most selling artist.

WITH best_selling_artist AS (
SELECT a.artist_id, a.name, SUM(il.unit_price*il.quantity) as Total_value
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN album b ON t.album_id = b.album_id
JOIN artist a ON b.artist_id = a.artist_id 
GROUP BY a.artist_id, a.name
ORDER BY Total_value DESC
LIMIT 1)

SELECT c.first_name, c.last_name, c.customer_id, SUM(il.unit_price*il.quantity) as total_spend
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN album b ON t.album_id = b.album_id
JOIN best_selling_artist bsa ON b.artist_id = bsa.artist_id
GROUP BY c.first_name, c.last_name, c.customer_id
ORDER BY total_spend DESC;

The query consists of two queries CTE query and Main query, in CTE query we first got the most selling artist, and then we got customer names along the amount they spend and joined with most selling artist by bringing only one value from artist table which is most selling artist.
 
Find the most popular music genre based on highest purchases for each country, get a table that has country along with top genre based on purchases?

WITH ALL_table AS(
SELECT c.country, g.genre, COUNT(quantity) as Highest_purchase, 
ROW_NUMBER() OVER (Partition by c.country order by COUNT(quantity) DESC) as row_no
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
Group by country, g.genre
order BY 1,3 DESC)

SELECT * FROM ALL_table
WHERE row_no=1;

Find the customer that spend the most on music country wise, run a query that returns Customer, Country and total spend(Top).

WITH alt AS(
SELECT c.customer_id, i.billing_country, SUM(total) 
as total_spend,
ROW_NUMBER() OVER(Partition by i.billing_country order by SUM(total) DESC) as rwn 
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
Group by 2,1)

SELECT * from alt WHERE rwn = 1;

Another way to resolve the query

WITH ONE AS(
SELECT c.customer_id, i.billing_country, SUM(total) 
as total_spend FROM customer c
JOIN invoice i on i.customer_id = c.customer_id
group by 2,1),

TWO AS(
SELECT billing_country, MAX(total_spend) 
as max_spend FROM ONE
group by 1
ORDER BY billing_country)

SELECT one.billing_country, one.customer_id, one.total_spend
FROM ONE
JOIN TWO on one.billing_country = two.billing_country
WHERE one.total_spend = two.max_spend
ORDER BY one.billing_country;

In the first part we got the sum of the value, and in the second we got the maximum value, and then making them a CTE, we compared by a common billing country column, and put a condition , select only where total spend = max spend, that will get max value grouped by country only.
