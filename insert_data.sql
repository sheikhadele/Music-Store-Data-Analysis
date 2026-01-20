Creating the tables as per the raw data csv file which are 11 are related to each other via various functional key.

Columns:
1. employee
2. customer
3. invoice
4. invoice_line
5. track
6. media_type
7. genre
8. playlist_track
9. album
10. playlist
11. artist


--album
CREATE TABLE album 
(album_id INT PRIMARY KEY, title VARCHAR(100), artist_id INT);

--artist
CREATE TABLE artist 
(artist_id INT PRIMARY KEY, name BLOB(2550));

ALTER TABLE artist 
ADD FOREIGN KEY (artist_id) REFERENCES album(artist_id);

--track
CREATE TABLE track (track_id INT PRIMARY KEY,
name VARCHAR (200), album_id INT, media_type_id INT, 
genre_id INT, composer BLOB(500), milliseconds INT, bytes INT, unit_price DECIMAL(3,2));

--genre
CREATE table genre 
(genre_id INT PRIMARY KEY, genre VARCHAR (50));

--media_type
CREATE Table media_type 
(media_type_id INT PRIMARY KEY, name VARCHAR (100));

--playlist_track
CREATE TABLE playlist_track
(playlist_id INT, track_id INT,
 PRIMARY KEY (playlist_id , track_id),
FOREIGN KEY (track_id) REFERENCES track(track_id));

--playlist
CREATE TABLE playlist 
(playlist_id INT PRIMARY KEY, name VARCHAR(100));

--invoice_line
CREATE TABLE invoice_line 
(invoice_line_id INT PRIMARY KEY, 
invoice_id INT, track_id INT, unit_price DECIMAL(3,2), quantity INT,
FOREIGN KEY (track_id) REFERENCES track(track_id));

--invoice
CREATE TABLE invoice 
(invoice_id INT PRIMARY KEY, customer_id INT, invoice_date TIMESTAMP, billing_address BLOB(255), 
billing_city BLOB(255), billing_state VARCHAR(255), billing_country VARCHAR(255), 
billing_postal_code BLOB(255), total DECIMAL(4,2));


--customer
CREATE TABLE customer
(customer_id INT PRIMARY KEY, first_name VARCHAR(255), last_name VARCHAR(255), 
company VARCHAR(255), address VARCHAR(255), city VARCHAR(255), state VARCHAR(100), 
country VARCHAR(50), postal_code VARCHAR(100), phone VARCHAR(100), fax VARCHAR(100), 
email VARCHAR(100), support_rep_id INT);

ALTER TABLE invoice 
ADD FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

--employee
CREATE TABLE employee 
(employee_id INT PRIMARY KEY, last_name VARCHAR(100), first_name VARCHAR(100), title VARCHAR(100), 
reports_to VARCHAR(10), levels VARCHAR(50), birthdate DATE, hire_date DATE, address VARCHAR(100), 
city VARCHAR(50), state VARCHAR(50), country VARCHAR(50), postal_code VARCHAR(50), phone VARCHAR(100), 
fax VARCHAR(100), email VARCHAR(100));

--Inserting the data into these tables from csv files.

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\file_name.csv'
INTO TABLE employee 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
