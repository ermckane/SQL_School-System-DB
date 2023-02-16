DROP TABLE IF EXISTS #Google
;

CREATE TABLE #Google (
	ID char(2),
	zipcode varchar(5)
);

INSERT INTO #Google (ID)
VALUES (1), (2), (3), (4), (5)

UPDATE #Google
SET zipcode = (20000 + ABS(CHECKSUM(NEWID()) % 24))
; 

SELECT *
FROM #Google
;