/*
USE SchoolSystem
GO

DROP TABLE IF EXISTS HumanResources_EmployeePersonalInfo
GO
*/

CREATE TABLE HumanResources_EmployeePersonalInfo
  (
   Employee_Code Char(7) Primary Key
  ,Employee_Id Char(5) Unique
  ,First_Name Varchar(75)
  ,Middle_Name Varchar(75)
  ,Last_Name Varchar(75)
  ,Birth_Date Date
  ,Social_Security Char(11) Unique
  ,Sex TinyINT
  ,Cell_Phone Varchar(12)
  ,Home_Phone Varchar(12) 
  ,Work_Phone Varchar(16)
  ,Personal_Email Varchar(50) Unique 
  ,Work_Email Varchar(50) Unique
  ,Address Varchar (75)
  ,City Varchar (50)
  ,State Char(2)
  ,ZipCode Varchar (11)
  ,Username Char(5)
  ,Password Varchar(75)
  ,Date_Modified Datetime2(3)
  )
;

CREATE TABLE Gender
  (
   Sex_Code TinyINT Primary Key
  ,Sex Varchar(10)
  )
;

ALTER TABLE HumanResources_EmployeePersonalInfo
ADD CONSTRAINT FK_SexCode Foreign Key (Sex) references Gender(Sex_Code)
;

Go
;

CREATE TRIGGER trg_HR_EmployeePersonalInfo_UpdateModifiedDate
ON HumanResources_EmployeePersonalInfo
AFTER UPDATE
AS 
  UPDATE HumanResources_EmployeePersonalInfo
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I 
    WHERE HumanResources_EmployeePersonalInfo.Employee_Code = i.Employee_Code
;


SELECT *
FROM HumanResources_EmployeePersonalInfo
;


