-- Plan for populating School_Enrollment. What pieces I need to fill table
-- 1) Take DOB of from each Student in Student_Info and subtract it from current date  **SOLVED**
-- 2) Group zipcodes for middle school and high schools.
-- 3) If they are between certain ages 18-15, they are in High School, 14-12 Middle School, and 11-5 Elementary  **SOLVED**
-- 4) Put them in the correct school based off of correpsonding zipcode.


--Calculate age of of students in Student_Info
SELECT DATEDIFF(year, Birth_Date, GETDATE())
 + 0 AS Age
FROM Student_Info
;

--Determine level of school by subtracting date of birth from current date
WITH Grouping_Student_Info
AS (
	SELECT Student_Code, Birth_Date, ZipCode AS St_ZipCode
		,CASE 
			WHEN DATEDIFF(year, Birth_Date, GETDATE()) > 18 THEN 'Graduated'
			WHEN DATEDIFF(year, Birth_Date, GETDATE()) <= 18 
				AND DATEDIFF(year, Birth_Date, GETDATE()) >= 15 THEN 'High School'
			WHEN DATEDIFF(year, Birth_Date, GETDATE()) >= 12
				AND DATEDIFF(year, Birth_Date, GETDATE()) <= 14 THEN 'Middle School'
			WHEN DATEDIFF(year, Birth_Date, GETDATE()) >= 5
				AND DATEDIFF(year, Birth_Date, GETDATE()) <= 12 THEN 'Elementary School'
			ELSE 'Error'
		END AS St_School_Type
		,CASE	
			WHEN (Zipcode >= 23501 AND Zipcode <= 23505) THEN 'Group 1'
			WHEN (Zipcode >= 23506 AND Zipcode <= 23510) THEN 'Group 2'
			WHEN (Zipcode >= 23511 AND Zipcode <= 23515) THEN 'Group 3'
			WHEN (Zipcode >= 23516 AND Zipcode <= 23520) THEN 'Group 4'
			WHEN (Zipcode >= 23521 AND Zipcode <= 23525) THEN 'Group 5'
			ELSE 'Other'
		END AS St_Zipcode_Group
	FROM Student_Info
	)
, Grouping_School_Info
AS (
	SELECT School_Type AS Sch_School_Type, Zipcode AS Sch_Zipcode, School_Code
		,CASE	
			WHEN (Zipcode >= 23501 AND Zipcode <= 23505) THEN 'Group 1'
			WHEN (Zipcode >= 23506 AND Zipcode <= 23510) THEN 'Group 2'
			WHEN (Zipcode >= 23511 AND Zipcode <= 23515) THEN 'Group 3'
			WHEN (Zipcode >= 23516 AND Zipcode <= 23520) THEN 'Group 4'
			WHEN (Zipcode >= 23521 AND Zipcode <= 23525) THEN 'Group 5'
			ELSE 'Other'
		END AS Sch_Zipcode_Group 
	FROM School_Info
   )
, Combining_Student_School
AS (
	SELECT Student_Code, Birth_Date, St_School_Type, St_Zipcode_Group, St_ZipCode, Sch_School_Type, School_Code, Sch_Zipcode, Sch_Zipcode_Group
	FROM Grouping_Student_Info AS st
	LEFT JOIN Grouping_School_Info AS sch
		ON St_Zipcode_Group = Sch_Zipcode_Group
		AND St_School_Type = Sch_School_Type
	WHERE (St_School_Type = 'Elementary School' AND St_Zipcode = Sch_Zipcode)
		OR (St_School_Type IN ('Middle School', 'High School', 'Graduated', 'Error'))
		OR St_School_Type IS NULL
	)
, Creating_Enrollment_Date
AS (
	SELECT *
		,CASE
			WHEN St_School_Type = 'Elementary School' THEN DATEADD(year, 5, DATEADD(MONTH, (9 - MONTH(Birth_Date)), Birth_Date))
			WHEN St_School_Type = 'Middle School' THEN DATEADD(year, 11, DATEADD(MONTH, (9 - MONTH(Birth_Date)), Birth_Date))
			WHEN St_School_Type = 'High School' THEN DATEADD(year, 15, DATEADD(MONTH, (9 - MONTH(Birth_Date)), Birth_Date))
			ELSE NULL
		END as Enrollment_Date
	FROM Combining_Student_School
   )

SELECT *
	FROM Creating_Enrollment_Date

	
/*JOIN Creating_Enrollment_Date as ced
	ON st.student_code = ced.student_code*/


 