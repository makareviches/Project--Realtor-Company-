USE Project;

--------------------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------------------


--
--Create a new table with information about 3 bedroom's apartments.
--

SELECT apartment_id  AS Three_bd_apartments_id,
	   street_address,
	   apartment,
	   number_of_bd,
	   square_footage,
	   home_value
INTO Three_bd_apartments
FROM Apartments
WHERE number_of_bd=3;


--
-- Create a backup for the table 'Apartment'
--
SELECT *  INTO Apartments_backup
FROM Apartments;


--------------------------------------------------------------------------------------------
-- READ
--------------------------------------------------------------------------------------------

--
-- Choose from the table `Apartments` only apartments that are located on South avenue and have 2 bd
--

SELECT *
FROM Apartments
WHERE street_address='1536 South Ave' AND number_of_bd=2;


--
-- Choose from table `Realtors` whose name started with 'J' and who has the commission more than 0.10
--

SELECT *
FROM Realtors
WHERE full_name LIKE 'J%' AND comission>0.10;


--
-- Calculate how many days are included in the report
--

SELECT COUNT(sale_date)
FROM (SELECT DISTINCT sale_date FROM Sales_transactions) AS dist;	


--
-- SHOW all realtors except David Martin
--

SELECT *
FROM Realtors
WHERE NOT full_name='David Martin'
ORDER BY full_name;


--
-- Select some apartments which have 2 bedrooms
--
SELECT TOP 3 * 
FROM Apartments
WHERE number_of_bd=2;

SELECT TOP 50 PERCENT *
FROM Apartments
WHERE number_of_bd=2;


--
-- Select the most expensive and the cheapest apartments on 10th Street
--
SELECT MAX(Home_value) as the_most_expensive_ap, MIN(Home_value) as the_cheapest_ap
FROM Apartments
WHERE street_address LIKE '%10th ST';


--
-- Select apartments with specific addresses
--
SELECT * 
FROM Apartments
WHERE street_address IN ('100 Pierce St', '6151 Orange St', '988 Fulton St');


--
-- Select apartments , which were sold in between 2020-02-01 and 2020-02-10
--
SELECT a.*, s.sale_date
FROM Sales_transactions AS s
LEFT JOIN Apartments as a
ON s.apartment_id=a.apartment_id
WHERE sale_date BETWEEN '2020-02-01' AND '2020-02-10'
ORDER BY s.sale_date;


--
-- Choose 1 bedroom apartments that value in range from 500000 to 700000
--
SELECT *
FROM Apartments
WHERE number_of_bd=1 AND home_value>500000 and home_value<700000;


--
-- Calculate realtor's profit for each sales transaction.
--
SELECT Realtors.full_name, Sales_transactions.sale_date, Apartments.home_value, Realtors.comission, Apartments.home_value*Realtors.comission as profit
FROM Apartments
JOIN Sales_transactions
ON Apartments.apartment_id=Sales_transactions.apartment_id
JOIN Realtors
ON Sales_transactions.realtor_id=Realtors.realtor_id
ORDER BY Realtors.full_name;


--
-- Combine apartments by number of bedrooms and calculate average square footage for each group
--
SELECT number_of_bd, AVG(square_footage) as average_footage
FROM Apartments
GROUP BY number_of_bd
ORDER BY number_of_bd;


--
-- Combine apartments by square footage and calculate minimum and maximum  number of bedrooms for each group.
--
SELECT square_footage, MIN(number_of_bd) as min_number_of_bd, MAX(number_of_bd) as max_number_of_bd
FROM Apartments
GROUP BY square_footage
ORDER BY square_footage; 


--
--Find realtors who have two and more transactions.
--
SELECT r.full_name, COUNT(s.sales_transaction_id) AS number_of_transactions
FROM Sales_transactions AS s
INNER JOIN Realtors AS r
ON s.realtor_id=r.realtor_id
GROUP BY r.full_name
HAVING COUNT(s.sales_transaction_id)=2 OR COUNT(s.sales_transaction_id)>2
ORDER BY number_of_transactions;


--
--Find realtors who sold at least one 3-bd apartment.
--
SELECT r.full_name,COUNT(s.sales_transaction_id) AS num_of_sold_ap
FROM Realtors AS r
INNER JOIN Sales_transactions AS s
ON r.realtor_id=s.sales_transaction_id
WHERE r.realtor_id = ANY (SELECT s.realtor_id
						  FROM Sales_transactions AS s 
						  LEFT JOIN Apartments AS a
						  ON s.apartment_id=a.apartment_id
						  WHERE a.number_of_bd =3) 
GROUP BY r.full_name;




--------------------------------------------------------------------------------------------
-- UPDATE
--------------------------------------------------------------------------------------------

--
--Update the row.
--
UPDATE Apartments SET home_value=348500
WHERE home_value=34800;

--
--Add column 'Phone column' to the table 'Realtors'.
--
ALTER TABLE Realtors
ADD Phone_number varchar(255);


--
--Add column 'Phone number' to the table 'Realtors'.
--
ALTER TABLE Realtors
ADD Phone_number varchar(255);


--
--Change the data type of the column 'Phone number'  the table 'Realtors'.
--
ALTER TABLE Realtors
ALTER COLUMN Phone_number varchar(50);



--------------------------------------------------------------------------------------------
-- DELETE
--------------------------------------------------------------------------------------------

--
-- Delete rows in  the table 'Apartment' which is located on W State street.
--
DELETE
FROM Apartments_backup
WHERE street_address LIKE '%State%'; 


--
--Delete the column 'Phone number'  in the table 'Realtors'.
--
ALTER TABLE Realtors
DROP COLUMN Phone_number;


--
--Delete the data inside the table 'Three_bd_apartments'.
--
TRUNCATE TABLE Three_bd_apartments;

--
--Delete the table 'Three_bd_apartments'.
--
DROP TABLE Three_bd_apartments;


--
--Drop the existing SQL database 'Project'
--
DROP DATABASE Project;


