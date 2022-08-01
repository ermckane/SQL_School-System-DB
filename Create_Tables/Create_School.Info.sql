
CREATE TABLE School_Info
  (
   School_Code Char(12) Primary Key
  ,School_Name Varchar(75)
  ,School_Type Varchar(25)
  ,Street Varchar(25)
  ,City Varchar(50)
  ,State Char(2)
  ,Zipcode Varchar (11)
  ,Description Text
  ,Date_Modified Datetime2(3)
  )
;

GO

;

CREATE TRIGGER trg_School_Info_UpdateModifiedDate
ON School_Info
AFTER UPDATE
AS
  UPDATE School_Info
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I
    WHERE School_Info.School_Code = I.School_Code
;