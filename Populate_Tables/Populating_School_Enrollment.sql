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
WITH Grouping_Student_Info
AS (
	SELECT *
		,CASE 
			WHEN DATEDIFF(year, Birth_Date, GETDATE()) > 18 THEN 'Graduated'
			WHEN DATEDIFF(year, Birth_Date, GETDATE()) <= 18 
				AND DATEDIFF(year, Birth_Date, GETDATE()) >= 15 THEN 'High School'
			WHEN DATEDIFF(year, Birth_Date, GETDATE()) >= 12
				AND DATEDIFF(year, Birth_Date, GETDATE()) <= 14 THEN 'Middle School'
			WHEN DATEDIFF(year, Birth_Date, GETDATE()) >= 5
				AND DATEDIFF(year, Birth_Date, GETDATE()) <= 12 THEN 'Elementary School'
			ELSE 'Error'
		END as School_Type
		,CASE	
			WHEN (Zipcode >= 23501 AND Zipcode <= 23505) THEN 'Group 1'
			WHEN (Zipcode >= 23506 AND Zipcode <= 23510) THEN 'Group 2'
			WHEN (Zipcode >= 23511 AND Zipcode <= 23515) THEN 'Group 3'
			WHEN (Zipcode >= 23516 AND Zipcode <= 23520) THEN 'Group 4'
			WHEN (Zipcode >= 23521 AND Zipcode <= 23525) THEN 'Group 5'
			ELSE 'Other'
		END as Zipcode_Group
	FROM Student_Info
)
, Grouping_School_Info
AS (
	SELECT *
		,CASE	
			WHEN (Zipcode >= 23501 AND Zipcode <= 23505) THEN 'Group 1'
			WHEN (Zipcode >= 23506 AND Zipcode <= 23510) THEN 'Group 2'
			WHEN (Zipcode >= 23511 AND Zipcode <= 23515) THEN 'Group 3'
			WHEN (Zipcode >= 23516 AND Zipcode <= 23520) THEN 'Group 4'
			WHEN (Zipcode >= 23521 AND Zipcode <= 23525) THEN 'Group 5'
			ELSE 'Other'
		END as Zipcode_Group 
	FROM School_Info
   )
, 

/*
SELECT mst.*, sci.School_Name
FROM Making_School_Type as mst
LEFT JOIN School_Info as sci
	ON mst.ZipCode = sci.Zipcode
	AND mst.School_Type = sci.School_Type
*/

