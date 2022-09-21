CREATE DATABASE Broker_company
GO

USE Broker_company
GO 

CREATE TABLE Broker_company.dbo.Customers 
(id INT PRIMARY KEY IDENTITY (1,1), 
 first_name varchar (30) NOT NULL,
 second_name varchar (30) NOT NULL,
 email varchar (50),
 phone BIGINT NOT NULL UNIQUE)
GO


CREATE OR ALTER PROCEDURE insertion_into_broker_company
(@first_name varchar (30),
 @second_name varchar (30),
 @email varchar (50),
 @phone BIGINT)
AS

 BEGIN TRY
INSERT INTO Broker_company.dbo.Customers (first_name, second_name, email, phone)
VALUES (@first_name, @second_name, @email, @phone)
   END TRY

 BEGIN CATCH
    IF ERROR_NUMBER() = 2627
       RAISERROR('Пользователь с таким номером телефона уже зарегистрирован!', 16, 1)
   END CATCH
GO


EXEC [Broker_company].[dbo].[insertion_into_broker_company]
     @first_name = 'George',
	 @second_name = 'Michael',
	 @email = 'george_michael@gmail.com',
	 @phone = 79107771133
