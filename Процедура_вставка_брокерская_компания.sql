CREATE DATABASE Broker_company
GO

USE Broker_company
GO 

IF OBJECT_ID('dbo.Customers', 'U') IS NULL 
CREATE TABLE Broker_company.dbo.Customers 
(id INT PRIMARY KEY IDENTITY (1,1), 
 first_name  varchar(30) CHECK(first_name  <> '') NOT NULL,
 second_name varchar(30) CHECK(second_name <> '') NOT NULL,
 email varchar (50),
 phone BIGINT UNIQUE NOT NULL ,
 passport varchar (30) UNIQUE NOT NULL,
 age TINYINT CHECK(age BETWEEN 14 AND 140))
GO

CREATE OR ALTER PROCEDURE dbo.insertion_into_broker_company
(@first_name varchar (30),
 @second_name varchar (30),
 @email varchar (50),
 @phone BIGINT,
 @pass_num varchar (30),
 @age TINYINT)
AS
DECLARE	@msg_err varchar(MAX)
DECLARE @errors_table TABLE (error_list varchar (255))
						   		
IF @phone IN (SELECT phone FROM Broker_company.dbo.Customers)
     INSERT INTO @errors_table  
     VALUES ('Пользователь с таким номером телефона уже зарегистрирован!')  

IF @pass_num IN (SELECT passport FROM Broker_company.dbo.Customers)
     INSERT INTO @errors_table  
     VALUES ('Пользователь с таким номером паспорта уже зарегистрирован!')  
 
IF @age < 14
     INSERT INTO @errors_table  
     VALUES ('Минимально допустимый возраст - 14 лет!')  

SELECT @msg_err = STRING_AGG(error_list, '
')
  FROM @errors_table 

IF EXISTS (SELECT error_list FROM @errors_table)
     THROW 50000, @msg_err, 1

 INSERT INTO Broker_company.dbo.Customers (first_name, second_name, email, phone, passport, age)
 VALUES (@first_name, @second_name, @email, @phone, @pass_num, @age)
GO

EXEC Broker_company.dbo.insertion_into_broker_company
     @first_name = 'George',
     @second_name = 'Michael',
     @email = 'george_michael@gmail.com',
     @phone = 79107771133,
     @pass_num = 'MP0123456789',
     @age = 53
