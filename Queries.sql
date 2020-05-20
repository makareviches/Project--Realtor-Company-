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
-- Choosing from table `Apartments` whose name started with 'J' and omission more than 0.10
--
SELECT *
FROM Apartments
WHERE number_of_bd=1 AND home_value>500000 and home_value<700000;