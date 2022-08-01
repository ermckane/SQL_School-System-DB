-- Student_Disciplinary


CREATE TABLE Student_Disciplinary
  (
   Disciplinary_Code Char(9) Primary Key
  ,Student_Code Char(9) Foreign Key REFERENCES Student_Info(Student_Code)
  ,Date_Event Date
  ,Event_Type Varchar(25)
  ,Event_Description Text
  ,Discipline Varchar(25)
  ,Duration Varchar(20)
  ,Principle_Code Char(7) Foreign Key REFERENCES HumanResources_EmployeePersonalInfo(Employee_Code)
  ,Teacher_Code Char(7) Foreign Key REFERENCES HumanResources_EmployeePersonalInfo(Employee_Code)
  ,School_Code Char(12) Foreign Key REFERENCES School_Info(School_Code)
  ,Date_Modified Datetime2(3)
  )
;

GO

;

CREATE TRIGGER trg_Student_Disciplinary_UpdateModifiedDate
ON Student_Disciplinary
AFTER UPDATE
AS
  UPDATE Student_Disciplinary
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM inserted as I
    WHERE Student_Disciplinary.Date_Modified = I.Date_Modified
;