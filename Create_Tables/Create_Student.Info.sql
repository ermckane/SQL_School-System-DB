CREATE TABLE Student_Info
  (
   Student_Code Char(9) Primary key
  ,Student_Id Char(7) Unique
  ,First_Name Varchar(75)
  ,Middle_Name Varchar(75)
  ,Last_Name Varchar(75)
  ,Birth_Date Date
  ,Social_Security Char(11) Unique
  ,Address Varchar (75)
  ,City Varchar (50)
  ,State Char(2)
  ,ZipCode Varchar (11)
  ,Date_Modified Datetime2(3)
  )
;
go
;

CREATE TRIGGER trg_Student_Info_UpdateModifiedDate
ON Student_Info
AFTER UPDATE
AS
  UPDATE Student_Info
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM inserted as I
    WHERE Student_Info.Date_Modified = i.Date_Modified
;