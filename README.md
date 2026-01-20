🎵 Music Store Analysis (SQL Project)
📌 Project Overview

This project analyzes a digital music store database using MySQL to answer real-world business questions.
The raw data is provided in 11 relational tables, which were first loaded into MySQL and then queried to extract meaningful insights for decision-making.

The project focuses on:

Data understanding and schema design
Writing optimized SQL queries
Business problem solving using SQL
Analytical thinking with relational data

🗂 Database Tables

The database consists of the following 11 tables:

album	- Album information
artist - Artist details
customer - Customer data
employee - Employee records
genre - Music genres
invoice	- Customer invoices
invoice_line	- Invoice line items
track -	Track details
media_type	- Media format types
playlist	- Playlist information
playlist_track	- Tracks in playlists

These tables together form a complete music store data warehouse–style schema.

⚙️ Tools & Technologies Used

Database: MySQL
Language: SQL


📥 Data Loading Process

Raw data was available in CSV format for all 11 tables
Data was imported into MySQL using table creation scripts
Proper data types and primary/foreign key relationships were defined
Data integrity was maintained before analysis

🧠 Business Questions Solved

Who is the most senior employee based on job title?
Which country has the highest number of invoices?
Write a query that returns the email, first name, last name, and genre of all Rock music listeners, ordered alphabetically by email.
Write a query that returns the email, first name, last name, and genre of all Rock music listeners whose email starts with the letter “A”, ordered alphabetically by email.
Let’s invite the artists who have written the most Rock music in our dataset.
Write a query that returns the artist name and total track count of the top 10 Rock bands.
Return all track names that have a song length longer than the average song length.
Return the track name and duration in milliseconds, ordered by song length with the longest songs listed first.
Find the total amount spent by each customer on each artist.
Write a query that returns the customer name, artist name, and total amount spent.
Find the customer who spent the most on the best-selling artist.
Find the most popular music genre for each country based on the highest number of purchases.
Return a table showing the country and its top genre.
Find the customer who spent the most on music in each country.
Write a query that returns the customer name, country, and total amount spent (top customer per country).

(Full queries are available in the SQL files)

📁 Project Structure
music_store_analysis/
│
├── schema/
│   └── create_tables.sql
│
├── data/
│   └── raw_data.csv (optional / source data)
│
├── queries/
│   ├── basic_queries.sql
│   ├── intermediate_queries.sql
│   └── advanced_queries.sql
│
├── analysis/
│   └── business_questions.sql
│
└── README.md

📊 Skills Demonstrated

SQL Joins (INNER, LEFT, RIGHT)
Aggregations & Group By
Subqueries & CTEs
Window Functions
Data Analysis using SQL
Database schema understanding
Business-focused problem solving

📌 Conclusion

This project demonstrates how SQL can be used to transform raw transactional data into business insights.
It reflects real-world scenarios faced by data analysts and data engineers in music, retail, and e-commerce domains.
