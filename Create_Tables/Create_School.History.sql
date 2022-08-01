--School_Histoty


CREATE TABLE School_History
  (
   History_Code Char(7) Primary Key
  ,School_Code Char(12) Foreign Key REFERENCES School_Info(School_Code)
  ,Renovation_Start Date
  ,Renovation_End Date
  ,Reno_Description Text
  ,Donation_Date Date
  ,Donation_Start Date
  ,Donation_Amount BigInt
  ,Donation_Description Text
  ,Date_Modified Datetime2(3)
  )
;

GO

;

CREATE TRIGGER trg_School_History_UpdateModifiedDate
ON School_History
AFTER UPDATE
AS
	UPDATE School_History
	SET Date_Modified = CURRENT_TIMESTAMP
	FROM Inserted AS I
	  WHERE School_History.Date_Modified = I.Date_Modified