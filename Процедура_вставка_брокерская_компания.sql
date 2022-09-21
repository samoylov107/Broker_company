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

CREATE PROCEDURE insertion_into_broker_company
(@first_name varchar (30),
@second_name varchar (30),
@email varchar (50),
@phone BIGINT)
AS
BEGIN
IF 
@phone NOT IN (SELECT [phone] FROM [Broker_company].[dbo].[Customers])
INSERT INTO [Broker_company].[dbo].[Customers] ([first_name], [second_name], [email], [phone])
VALUES (@first_name, @second_name, @email, @phone)
ELSE
PRINT 'Пользователь с таким номером телефона уже зарегистрирован.'
END
GO

EXEC [Broker_company].[dbo].[insertion_into_broker_company]
@first_name = 'George',
@second_name = 'Michael',
@email = 'george_michael@gmail.com',
@phone = 79107771133
GO

SELECT * 
FROM [Broker_company].[dbo].[Customers]
