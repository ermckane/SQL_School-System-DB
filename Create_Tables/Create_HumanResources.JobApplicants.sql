Use SchoolSystem
GO
;

CREATE TABLE HumanResources_JobApplicants
  (
   Application_Code Char(7) Primary Key
  ,Date_Applied Date
  ,First_Name Varchar(75)
  ,Last_Name Varchar(75)
  ,Phone Char(12)
  ,Email Char(50)
  ,Resume Varbinary(Max)
  ,Cover_Letter Varbinary(Max)
  ,Other_Documents Varbinary(Max)
  ,Granted_Interview Bit
  ,Interview_Date Date
  ,Acceptance Bit
  ,Date_Modified Datetime2(3)
  )
;
GO
;
--For the BIT data types, 0 is 'NO' and 1 is 'YES'

CREATE TRIGGER trg_HR_JobApplicants_UpdateDateModified
ON HumanResources_JobApplicants
AFTER UPDATE
AS
  UPDATE HumanResources_JobApplicants
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I
    WHERE HumanResources_JobAPplicants.Application_Code = I.Application_Code
;