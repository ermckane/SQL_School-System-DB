
CREATE TABLE HumanResources_EmployeeJobInfo
  (
   Employee_Job_Code Char(9) Primary Key
  ,Job_Code Char (7) Foreign Key REFERENCES HumanResources_JobInfo(Job_Code)
  ,Employee_Code Char(7) Foreign Key REFERENCES HumanResources_EmployeePersonalInfo(Employee_Code)
  ,School_Code Char(12) Foreign Key REFERENCES School_Info(School_Code)
  ,Hire_Date Date
  ,End_Date Date
  ,Reason_Left Varchar(255) 
  ,Date_Modified Datetime2(3)
  )
;


GO
;

CREATE TRIGGER trg_HR_EmployeeJobInfo_UpdateModifiedDate
ON HumanREsources_EmployeeJobInfo
AFTER UPDATE
AS
  UPDATE HumanResources_EmployeeJobInfo
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I
    WHERE HumanResources_EmployeeJobInfo.Employee_Job_Code = I.Employee_Job_Code
;

