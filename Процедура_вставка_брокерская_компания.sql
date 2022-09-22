CREATE DATABASE Broker_company
GO

USE Broker_company
GO 

CREATE TABLE Broker_company.dbo.Customers 
(id INT PRIMARY KEY IDENTITY (1,1), 
 first_name varchar (30) NOT NULL,
 second_name varchar (30) NOT NULL,
 email varchar (50),
 phone BIGINT UNIQUE NOT NULL ,
 passport varchar (30) UNIQUE NOT NULL)
GO


CREATE OR ALTER PROCEDURE dbo.insertion_into_broker_company
(@first_name varchar (30),
 @second_name varchar (30),
 @email varchar (50),
 @phone BIGINT,
 @pass_num varchar (30))
AS
BEGIN 
     IF @phone IN (SELECT phone FROM Broker_company.dbo.Customers)
    AND @pass_num IN (SELECT passport FROM Broker_company.dbo.Customers)
	RAISERROR('Пользователь с таким номером паспорта и номером телефона уже зарегистрирован!', 16, 1)

ELSE IF @pass_num IN (SELECT passport FROM Broker_company.dbo.Customers)
        RAISERROR('Пользователь с таким номером паспорта уже зарегистрирован!', 16, 1)

ELSE IF @phone IN (SELECT phone FROM Broker_company.dbo.Customers)
        RAISERROR('Пользователь с таким номером телефона уже зарегистрирован!', 16, 1)
END
GO


EXEC Broker_company.dbo.insertion_into_broker_company
     @first_name = 'George',
     @second_name = 'Michael',
     @email = 'george_michael@gmail.com',
     @phone = 79107771133,
     @pass_num = 'MP0123456789'
