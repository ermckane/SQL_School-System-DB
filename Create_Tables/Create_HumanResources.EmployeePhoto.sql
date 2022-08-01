USE SchoolSystem
Go
;

CREATE TABLE HumanResources_EmployeePhoto
  (
   Photo_Id int Identity(10000,5) Primary Key
  ,Employee_Code Char(7) Foreign Key References HumanResources_EmployeePersonalInfo(Employee_Code)
  ,Photo Varbinary(Max)
  ,Date_Modified Datetime2(3)
  )
;

GO
;

CREATE TRIGGER trg_E_Photo_UpdateModifiedDate
ON HumanREsources_EmployeePhoto
AFTER UPDATE
AS
  UPDATE HumanResources_EmployeePhoto
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I
    WHERE HumanResources_EmployeePhoto.Photo_Id = I.Photo_Id
;