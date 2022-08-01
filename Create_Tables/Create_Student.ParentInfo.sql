--Student_ParentInfo


CREATE TABLE Student_ParentInfo
  (
   Parental_Code Char(9) Primary Key
  ,Parental_ID Char(7) Unique
  ,Student_Code Char(9) Foreign Key REFERENCES Student_Info(Student_Code)
  ,First_Name Varchar(75)
  ,Last_Name Varchar(75)
  ,Parent_Type Varchar(20)
  ,Birth_Date Date
  ,Social_Security Char(11) Unique
  ,Work_Phone Varchar(16)
  ,Personal_Phone Varchar(16)
  ,Email Varchar(50) Unique 
  ,Work_Place Varchar(50)
  ,Address Varchar (75)
  ,City Varchar (50)
  ,State Char(2)
  ,ZipCode Varchar (11)
  ,Drivers_License Varbinary(Max)
  ,Date_Modified Datetime2(3)
  )
;

GO
;

CREATE TRIGGER trg_Student_ParentInfo_UpdateModifiedDate
ON Student_ParentInfo
AFTER UPDATE
AS
  UPDATE Student_ParentInfo
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I
    WHERE Student_ParentInfo.Date_Modified = I.Date_Modified
;