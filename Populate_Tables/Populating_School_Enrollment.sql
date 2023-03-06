-- Plan for populating School_Enrollment. What pieces I need to fill table
-- 1) Take DOB of from each Student in Student_Info and subtract it from current date  **SOLVED**
-- 2) Group zipcodes for middle school and high schools.
-- 3) If they are between certain ages 18-15, they are in High School, 14-12 Middle School, and 11-5 Elementary  **SOLVED**
-- 4) Put them in the correct school based off of correpsonding zipcode.


/*
DROP TABLE IF EXISTS #Enrollment_Temp
;

SELECT si.student_code AS Student_Code, sci.school_code as School_Code, DATEADD(year, 5, si.Birth_Date) as Enrollment_Date
	FROM Student_Info AS si
	INNER JOIN School_Info AS sci
		ON si.ZipCode = sci.Zipcode
;
*/

--Calculate age of of students in Student_Info
SELECT DATEDIFF(year, Birth_Date, GETDATE())
 + 0 AS Age
FROM Student_Info
;

--Determine level of school by subtracting date of birth from current date
WITH Making_School_Type
AS (
	SELECT *,
	CASE 
		WHEN DATEDIFF(year, Birth_Date, GETDATE()) > 18 THEN 'Graduated'
		WHEN DATEDIFF(year, Birth_Date, GETDATE()) <= 18 
			AND DATEDIFF(year, Birth_Date, GETDATE()) >= 15 THEN 'High School'
		WHEN DATEDIFF(year, Birth_Date, GETDATE()) >= 12
			AND DATEDIFF(year, Birth_Date, GETDATE()) <= 14 THEN 'Middle School'
		WHEN DATEDIFF(year, Birth_Date, GETDATE()) >= 5
			AND DATEDIFF(year, Birth_Date, GETDATE()) <= 12 THEN 'Elementary School'
		ELSE 'Error'
		END as School_Type
	FROM Student_Info
)
SELECT mst.*, sci.School_Name
FROM Making_School_Type as mst
LEFT JOIN School_Info as sci
	ON mst.ZipCode = sci.Zipcode
	AND mst.School_Type = sci.School_Type


