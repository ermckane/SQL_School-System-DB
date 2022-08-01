--Student_History


CREATE TABLE Student_History
  (
   Student_History_Code Char(9) Primary Key
  ,Student_Code Char(9) Foreign Key REFERENCES Student_Info(Student_Code)
  ,School_Code Char(12) Foreign Key REFERENCES School_Info(School_Code)
  ,Start_Date Date
  ,End_Date Date
  ,Transferred_In Bit
  ,Transferred_Out Bit
  ,Year_Retaken Int
  ,Retaken_Type Varchar(25)
  ,Date_Modified Datetime2(3)
  )
;

GO

;

CREATE TRIGGER trg_Student_History_UpdateModifiedDate
ON Student_History
AFTER UPDATE
AS
  UPDATE Student_History
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I
	WHERE Student_History.Date_Modified = I.Date_Modified
