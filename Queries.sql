USE Project;

--
-- Choosing from table `Apartments` only that located on South avenue and have 2 bd
--

SELECT *
FROM Apartments
WHERE street_adres='1536 South Ave' AND number_of_bd=2;

--
-- Choosing from table `Realtors` whose name started with 'J' and omission more than 0.10
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
-- Select some apartments, which have 2 bedrooms
--
SELECT TOP 3 * 
FROM Apartments
WHERE number_of_bd=2;

SELECT TOP 50 PERCENT *
FROM Apartments
WHERE number_of_bd=2;

--
-- Select the most expensive and the cheapest apartments on 10 Street
--
SELECT MAX(Home_value) as the_most_expensive_ap, MIN(Home_value) as the_cheapest_ap
FROM Apartments
WHERE street_adres LIKE '%10th ST';

--
-- Select apartments with specific adreses
--
SELECT * 
FROM Apartments
WHERE street_adres IN ('100 Pierce St', '6151 Orange St', '988 Fulton St');


--
-- Select apartments , which was sold in period from 2020-02-01 to 2020-02-10
--
SELECT a.*, s.sale_date
FROM Sales_transactions AS s
LEFT JOIN Apartments as a
ON s.apartment_id=a.apartment_id
WHERE sale_date BETWEEN '2020-02-01' AND '2020-02-10'
ORDER BY s.sale_date;

--
-- Choosing 1 bd-room appartments which home value in range from 500000 to 700000
--
SELECT *
FROM Apartments
WHERE number_of_bd=1 AND home_value>500000 and home_value<700000;

--
-- Calculating realtor's amount of profit for each sales transaction.
--
SELECT Realtors.full_name, Sales_transactions.sale_date, Apartments.home_value, Realtors.comission, Apartments.home_value*Realtors.comission as profit
FROM Apartments
JOIN Sales_transactions
ON Apartments.apartment_id=Sales_transactions.apartment_id
JOIN Realtors
ON Sales_transactions.realtor_id=Realtors.realtor_id
ORDER BY Realtors.full_name;

--
-- Grouping apartments by number of bedrooms and calculating averge footage for each group.
--
SELECT number_of_bd, AVG(square_footage) as average_footage
FROM Apartments
GROUP BY number_of_bd
ORDER BY number_of_bd;

--
-- Grouping apartments by square footage and calculating minimum and maximum  number of bedrooms for each group.
--
SELECT square_footage, MIN(number_of_bd) as min_number_of_bd, MAX(number_of_bd) as max_number_of_bd
FROM Apartments
GROUP BY square_footage
ORDER BY square_footage; 

--
--Creating new table with information about 3 bedroom's apartments.
--

SELECT apartment_id  AS Three_bd_apartments_id,
	   street_adres,
	   apartment,
	   number_of_bd,
	   square_footage,
	   home_value
INTO Three_bd_apartments
FROM Apartments
WHERE number_of_bd=3;

--
-- Create a backup of the table 'Apartment'
--
SELECT *  INTO Apartments_backup
FROM Apartments;

--
-- Delete rows in  the table 'Apartment' which located on W State street.
--
DELETE
FROM Apartments_backup
WHERE street_adres LIKE '%State%'; 

--
--Update the row.
--
UPDATE Apartments SET home_value=348500
WHERE home_value=34800;





--
--Find realtors who has 2 and more transactions.
--
SELECT r.full_name, COUNT(s.sales_transaction_id) AS number_of_transactions
FROM Sales_transactions AS s
RIGHT JOIN Realtors AS r
ON s.realtor_id=r.realtor_id
GROUP BY r.full_name
HAVING COUNT(s.sales_transaction_id)=2 OR COUNT(s.sales_transaction_id)>2
ORDER BY number_of_transactions;

--
--Find realtors who sold though one 3-bd aparment.
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



