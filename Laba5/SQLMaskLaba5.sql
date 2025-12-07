--Part 1
ALTER TABLE dbo.Clients
ALTER COLUMN [Address] ADD MASKED WITH (FUNCTION = 'default()')

ALTER TABLE dbo.Clients
ALTER COLUMN Job_title ADD MASKED WITH (FUNCTION = 'default()')

GRANT UNMASK ON SCHEMA::dbo TO RecUser

--Part 2
GO
CREATE FUNCTION MaskPhone ()
RETURNS TABLE
RETURN 
	SELECT [Address],
	CASE
		WHEN IS_MEMBER('Supervisor') = 0 THEN CASE
			WHEN Phone_number LIKE '+7%' THEN '+7XXXXXX' + RIGHT(Phone_number, 4)
			ELSE '8XXXXXX' + RIGHT(Phone_number, 4)
		END
		ELSE Phone_number
	END Phone_number,
	Gender, Education, Birth_date, Job_title, Surname, [Name], Patronim
	FROM Clients


GO
CREATE PROCEDURE MaskYear AS
BEGIN
	
    SELECT [Address], Phone_number, Gender, Education,
		CASE WHEN IS_MEMBER('Supervisor') = 0 
		THEN DATEADD(YEAR, 2-ABS(CHECKSUM(Id))%4,
		DATEADD(MONTH, 3-ABS(CHECKSUM(Id))%6, DATEADD(DAY, 8-ABS(CHECKSUM(Id))%16, Birth_date)))
		ELSE Birth_date
		END Birth_date,
		Job_title, Surname, [Name], Patronim
    FROM Clients
END

DROP PROCEDURE MaskYear

GO
CREATE VIEW MaskAll
AS
SELECT [Address],
	CASE
		WHEN IS_MEMBER('Supervisor') = 0 THEN CASE
			WHEN Phone_number LIKE '+7%' THEN '+7XXXXXX' + RIGHT(Phone_number, 4)
			ELSE '8XXXXXX' + RIGHT(Phone_number, 4)
		END
		ELSE Phone_number
	END Phone_number,
	Gender, Education, 
	CASE WHEN IS_MEMBER('Supervisor') = 0 
		THEN DATEADD(YEAR, 2-ABS(CHECKSUM(Id))%4,
		DATEADD(MONTH, 3-ABS(CHECKSUM(Id))%6, DATEADD(DAY, 8-ABS(CHECKSUM(Id))%16, Birth_date)))
		ELSE Birth_date
	END Birth_date,
	Job_title, Surname, [Name], Patronim
	FROM Clients

GO
SELECT * FROM Clients

EXECUTE AS USER = 'RecUser1'
SELECT * FROM Clients
REVERT

SELECT name, type_desc 
FROM sys.database_principals 
WHERE name = 'RecUser1';

EXECUTE AS USER = 'RecUser'
SELECT * FROM MaskPhone()
REVERT

EXECUTE AS USER = 'RecUser1'
EXECUTE MaskYear
REVERT

EXECUTE AS USER = 'RecUser1'
SELECT * FROM MaskAll
REVERT
