--CREATING FIRST_NAME, MIDDLE_NAME, LAST_NAME,  Student_Code, and Student_ID

--Performing the creation of Student_Names in a practice database so that the data can be manipulated without interfering with main database.
--Will then INSERT INTO main database after.

--Randomly selecting last_names for cross join later. 

SELECT TOP 10000 name INTO #Name_Last
FROM sql_practice.dbo.last_names
ORDER BY newid()
;

--Randomly selecting first_names for cross join later. 

SELECT TOP 5000 first_name INTO #Name_First
FROM sql_practice.dbo.first_names
ORDER BY newid()
;

--Randomly selecting middle_names for cross join later. 

SELECT TOP 10000 name AS  Middle_Name INTO #Name_Middle
FROM sql_practice.dbo.last_names
ORDER BY newid()
;

--Combining First_Name and Last_Name only because creating 500,000,000,000 combinations is an resource and time demanding process.
--Combine with Middle_Name later.

SELECT top 10000 name AS Last_Name, first_name AS First_Name INTO #First_Last_Name
FROM #Name_First
CROSS JOIN #Name_Last
ORDER BY newid()
;

--Formtatting data so presentation is consistent.

UPDATE #Name_Middle
SET Middle_Name=UPPER(LEFT(Middle_Name,1))+LOWER(SUBSTRING(Middle_Name,2,LEN(Middle_Name)))
;



UPDATE #First_Last_Name
SET Last_Name=UPPER(LEFT(Last_Name,1))+LOWER(SUBSTRING(Last_Name,2,LEN(Last_Name)))
;

--Deleting and recreating temp table in order to run script again in same session.

DROP TABLE IF EXISTS #Student_Name
CREATE TABLE #Student_Name
  (
   Student_Code Char(9)
  ,First_Name Varchar(75)
  ,Middle_Name Varchar(75)
  ,Last_Name Varchar(75)
  )
 ;

--Creating table of student name combined from first, middle, and last name.

WITH Firstlast 
AS
  (
   SELECT First_name, Last_name, ROW_NUMBER() OVER(ORDER BY NEWID()) AS Rank_Fl
   FROM #First_Last_Name 
  ) 
,Middle 
AS
  (
   SELECT Middle_Name, ROW_NUMBER() OVER(ORDER BY NEWID()) AS Rank_M
   FROM #Name_Middle
  )
INSERT INTO #Student_Name (First_Name, Middle_Name, Last_Name)
SELECT Fl.First_Name, M.Middle_Name as Middle_Name, Fl.Last_Name 
FROM Firstlast AS Fl
INNER JOIN Middle AS M
	ON Fl.Rank_Fl = M.Rank_M
;


--Joing the names with randomly generated student codes. 
--If duplicate is made, rerun again until works. 
--Unfortunately this method is not duplicate proof.


WITH Uncleaned_Code 
AS
   (
    SELECT  
	 ABS(CAST(CAST(NEWID() AS varbinary) AS int)) AS Student_Code_Unfixed
	,ROW_NUMBER() OVER(ORDER BY NEWID()) AS Rank_C
    FROM #Student_Name
   )
,Cleaned_Code
AS
   (
    SELECT
	 Rank_C
	,CASE
		WHEN LEN(Student_Code_Unfixed) > 9 THEN Student_Code_Unfixed / 4	--This isnures all the student codes are the same length
		WHEN LEN(Student_Code_Unfixed) = 8 THEN Student_Code_Unfixed * 10
		WHEN LEN(Student_Code_Unfixed) = 7 THEN Student_Code_Unfixed * 100
		ELSE Student_Code_Unfixed
	 END AS Student_Code
    FROM Uncleaned_Code
   )
,Names
AS
   (
    SELECT
		 First_Name
        ,Middle_Name
        ,Last_name
        ,ROW_NUMBER() OVER(ORDER BY NEWID()) AS Rank_N
    FROM #Student_Name
   )
,SocialSecurity
AS
  (
   SELECT  
      CONCAT(
		LEFT(ABS(CAST(CAST(NEWID() AS varbinary) AS int)), 3) 					--Selecting random numbers from NEWID() for Social Security #
		,'-'
		,SUBSTRING(CAST(ABS(CAST(CAST(NEWID() AS varbinary) AS int)) AS Char),3, 2)
        ,'-'
		,SUBSTRING(CAST(ABS(CAST(CAST(NEWID() AS varbinary) AS int)) AS Char),4, 4)
        ) AS Social_Security
      ,ROW_NUMBER() OVER(ORDER BY NEWID()) AS Rank_S
    FROM #Student_Name
   )
,Collection
AS
  (
   SELECT 
   	CAST(Student_Code as Char) as Student_Code
       ,LOWER(CONCAT(LEFT(First_Name, 1), LEFT(Middle_Name, 1), LEFT(Last_Name, 1), SUBSTRING(CAST(Student_Code as Char),3, 3), RIGHT(Last_Name, 1))) as Student_ID
       ,Social_Security
       ,First_Name
       ,Middle_Name
       ,Last_Name
   FROM Cleaned_Code as C
   INNER JOIN Names as N
	 ON C.Rank_C = N.Rank_N
   INNER JOIN SocialSecurity as S
	 ON S.Rank_S = N.Rank_N
  )
INSERT INTO Student_Info (Student_Code, Student_Id, First_Name, Middle_Name, Last_Name, Social_Security)
SELECT Student_Code, Student_Id, First_Name, Middle_Name, Last_Name, Social_Security
FROM Collection
;


--ADDING BIRTHDAYS
--Divides NEWID value by 6570, and then adds that many days to beginning date, to create random birthday

UPDATE Student_Info
SET Birth_Date = DATEADD(Day, ABS(CHECKSUM(NEWID()) % 6570), '2000-01-01')
;

--This database is pretending it is for Norfolk Public School Systems in Virginia.

UPDATE Student_Info
SET City = 'Norfolk'
;

--Norfolk is in VA, so all students get VA as state

UPDATE Student_Info
SET StateID = 'VA'
;