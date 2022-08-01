
CREATE TABLE Student_EmergencyContact
  (  
   EmergencyContact_Code Char(7) Primary key
  ,Student_Code Char(9) Foreign Key REFERENCES Student_Info(Student_Id)
  ,First_Name Varchar(75)
  ,Last_Name Varchar(75)
  ,Contact_Type Varchar(25)
  ,Birth_Date Date
  ,Social_Security Char(11) Unique
  ,Address Varchar (75)
  ,City Varchar (50)
  ,State Char(2)
  ,ZipCode Varchar (11)
  ,Home_Phone Varchar(12)
  ,Cell_Phone Varchar(12)
  ,Work_Phone Varchar(16)
  ,Work_Place Varchar(30)
  ,Email Varchar(50)
  ,Drivers_Licence Varbinary(Max)
  ,Date_Modified Datetime2(3)
  )
;

Go

;

CREATE TRIGGER trg_Student_EmergencyContact_UpdateModifiedDate
ON Student_EmergencyContact
AFTER UPDATE
AS 
  UPDATE Student_EmergencyContact
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM inserted as I
    WHERE Student_EmergencyContact.Date_Modified = I.Date_Modified
;