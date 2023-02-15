DROP TABLE IF EXISTS #Google
;

CREATE TABLE #Google (
	ID char(2),
	zipcode varchar(5)
);

UPDATE #Google
SET zipcode = (20000 + ABS(CHECKSUM(NEWID()) % 24)
; 

SELECT *
FROM Student_Info