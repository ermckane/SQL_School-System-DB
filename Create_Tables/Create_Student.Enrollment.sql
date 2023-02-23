DROP TABLE IF EXISTS School_Enrollment
;

CREATE TABLE School_Enrollment 
(
  Student_Code CHAR(9) Not Null
 ,School_Code CHAR(12) Not Null
 ,Enrollment_Date DATE Not Null
 ,Unenrollment_Date DATE
 ,Date_Modified DATETIME2(3) null
 ,FOREIGN KEY (Student_Code) REFERENCES Student_Info(Student_Code)
 ,FOREIGN KEY (School_Code) REFERENCES School_Info(School_Code)
 ,PRIMARY KEY (Student_Code, School_Code, Enrollment_Date)
)
;

CREATE TRIGGER trg_SchoolEnrollment_UpdateModifiedDate
ON dbo.School_Enrollment
AFTER UPDATE
AS
	UPDATE dbo.School_Enrollment
	SET Date_Modified = CURRENT_TIMESTAMP
	FROM inserted AS I
		WHERE School_Enrollment.School_Code = I.School_Code
;
