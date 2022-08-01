
CREATE TABLE HumanResources_Salary
  (
   Salary_Code Char(9) Primary Key
  ,Employee_Code Char(7) Foreign Key REFERENCES HumanResources_EmployeePersonalInfo(Employee_Code)
  ,Amount Varchar(8)
  ,Rate_Change_Date Date
  ,Date_Modified Datetime2(3)
  )
;

GO
;

CREATE TRIGGER trg_Salary_UpdateModifiedDate
ON HumanResources_Salary
AFTER UPDATE
AS
  UPDATE HumanResources_Salary
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I
    WHERE HumanResources_Salary.Salary_Code = I.Salary_Code
;