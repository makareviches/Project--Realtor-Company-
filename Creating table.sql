--------------------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------------------

CREATE DATABASE Project;
USE Project;

CREATE TABLE Realtors (
  realtor_id int NOT NULL IDENTITY(1,1) PRIMARY KEY, 
  full_name varchar(255) NOT NULL,
  comission float, 
 ); 


CREATE TABLE Apartments (
  apartment_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  street_addres VARCHAR(255) NOT NULL,
  apartment INT NOT NULL,
  number_of_bd INT NOT NULL,
  square_footage FLOAT NOT NULL,
  home_value money NOT NULL,
  ); 


 CREATE TABLE Sales_transactions (
  sales_transaction_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  sale_date DATE NOT NULL,
  realtor_id INT NOT NULL FOREIGN KEY REFERENCES realtors(realtor_id ), 
  apartment_id INT NOT NULL FOREIGN KEY REFERENCES apartments(apartment_id),
  ); 

	
	
	
	
	
	
	
	
	
	
	

	