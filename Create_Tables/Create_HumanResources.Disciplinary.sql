USE SchoolSystem
go
;

CREATE TABLE HumanResources_Disciplinary
  (
   Disciplinary_Code Char(7) Primary Key
  ,Employee_Code Char(7) Foreign Key REFERENCES HumanResources_EmployeePersonalInfo(Employee_Code)
  ,Date_Of_Action Date
  ,Description Text
  ,Discipline Varchar(20)
  ,Duration TinyInt
  ,Supervisor_Code Char(7) Foreign Key REFERENCES HumanResources_EmployeePersonalInfo(Employee_Code)
  ,Date_Modified Datetime2(3)
  )
;

GO
;

CREATE TRIGGER trg_HR_Disciplinary_UpdateDate
ON HumanResources_Disciplinary
AFTER UPDATE
AS
  UPDATE HumanResources_Disciplinary
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I
    WHERE HumanResources_Disciplinary.Disciplinary_Code = I.Disciplinary_Code
	;