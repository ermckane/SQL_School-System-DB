

CREATE TABLE HumanResources_JobInfo
  (
   Job_Code Char(7) Primary Key
  ,Job_Title Varchar(50)
  ,Department Varchar(25)
  ,Group_Name Varchar(25)
  ,Date_Modified Datetime2(3)
  )
;



GO
;


CREATE TRIGGER trg_HR_JobInfo_UpdateModifiedDate
ON HumanREsources_JobInfo
AFTER UPDATE
AS
  UPDATE HumanResources_JobInfo
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I
    WHERE HumanResources_JobInfo.Job_Code = I.Job_Code
;

