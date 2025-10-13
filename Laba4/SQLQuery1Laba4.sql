--Создать 4 различных хранимых процедуры
--a
CREATE PROCEDURE FindUnemployed AS
BEGIN
	WITH EntVac AS
	(SELECT ent.Name, vac.Job_title, vac.Salary, vac.Gender, vac.Education, vac.Work_format, vac.MIN_age, vac.MAX_age, vac.City
	FROM Enterprises AS ent JOIN HR_departaments AS hr ON ent.Id = hr.Id_enterprise JOIN Vacancies AS vac ON vac.Id_HR_departament = hr.Id)

	SELECT cl.Surname, cl.Name, cl.Patronim, cl.Birth_date, cl.Gender, cl.Education, vac.Name, vac.Job_title, vac.Salary
	FROM Clients AS cl JOIN EntVac AS vac ON (Cl.Gender = vac.Gender OR vac.Gender IS NULL) 
	AND (cl.Education = vac.Education)
	AND ((Cl.Birth_date >= DATEADD(YEAR, vac.MIN_age, GETDATE()) OR MIN_age IS NULL) AND (Cl.Birth_date <= DATEADD(YEAR, vac.MAX_age, GETDATE()) OR MAX_age IS NULL))
	AND (SUBSTRING(cl.Address, 0, CHARINDEX(',', cl.Address)) = vac.City OR vac.Work_format IN ('Удаленно', 'Разъезды'))
END;

EXECUTE FindUnemployed

DROP PROCEDURE FindUnemployed

--b
GO
CREATE PROCEDURE FindBiggerSalaryVacancies
	@Salary INT
AS
BEGIN
	SELECT * FROM Vacancies WHERE Salary >= @Salary
END

EXECUTE FindBiggerSalaryVacancies 50000

DROP PROCEDURE FindBiggerSalaryVacancies

--c
GO
CREATE PROCEDURE FindVacanciesForUnemployed
	@Surname NVARCHAR(50),
	@Name NVARCHAR(50),
	@Patronim NVARCHAR(50),
	@Job_title NVARCHAR(50) OUTPUT
AS
BEGIN
	SELECT @Job_title = MAX(vac.Salary)
	FROM Clients AS cl JOIN Vacancies AS vac ON (Cl.Gender = vac.Gender OR vac.Gender IS NULL) 
	AND (cl.Education = vac.Education)
	AND ((2025 - YEAR(Cl.Birth_date) >= vac.MIN_age OR MIN_age IS NULL) AND (2025 - YEAR(Cl.Birth_date) <= vac.MAX_age OR MAX_age IS NULL))
	AND (SUBSTRING(cl.Address, 0, CHARINDEX(',', cl.Address)) = vac.City OR vac.Work_format IN ('Удаленно', 'Разъезды'))
	WHERE cl.Surname = @Surname AND cl.Name = @Name AND (cl.Patronim = @Patronim OR (cl.Patronim IS NULL AND @Patronim IS NULL))
END

DECLARE @Best_job NVARCHAR(50)

EXECUTE FindVacanciesForUnemployed 'Петрова', 'Ольга', 'Сергеевна', @Best_job OUTPUT

PRINT @Best_job

DROP PROCEDURE FindVacanciesForUnemployed

--d
GO
CREATE PROCEDURE AVGSalary
	@AvgSalary INT OUTPUT
AS
BEGIN
	SELECT @AvgSalary = AVG(Salary)
	FROM Vacancies
END

GO
CREATE PROCEDURE FindVacanciesBiggerAvgSalary AS
BEGIN
	DECLARE @AvgSalary INT
	EXECUTE AVGSalary @AvgSalary OUTPUT

	SELECT *
	FROM Vacancies
	WHERE Salary > @AvgSalary
END

EXECUTE FindVacanciesBiggerAvgSalary

DROP PROCEDURE FindVacanciesBiggerAvgSalary
DROP PROCEDURE AVGSalary

--3 пользовательских функции
GO
CREATE FUNCTION func1 (@Salary INT)
RETURNS INT
BEGIN
	DECLARE @Result INT
	SELECT @Result = COUNT(Id) FROM Vacancies WHERE Salary >= @Salary
	RETURN @Result
END
GO
PRINT dbo.func1(50000)

DROP FUNCTION dbo.func1

GO
CREATE FUNCTION func2 (@ClientId INT)
RETURNS TABLE
RETURN 
	SELECT vac.*
	FROM Clients AS cl JOIN Vacancies AS vac ON (Cl.Gender = vac.Gender OR vac.Gender IS NULL) 
	AND (cl.Education = vac.Education)
	AND ((2025 - YEAR(Cl.Birth_date) >= vac.MIN_age OR MIN_age IS NULL) AND (2025 - YEAR(Cl.Birth_date) <= vac.MAX_age OR MAX_age IS NULL))
	AND (SUBSTRING(cl.Address, 0, CHARINDEX(',', cl.Address)) = vac.City OR vac.Work_format IN ('Удаленно', 'Разъезды'))
	WHERE cl.Id = @ClientId

GO
SELECT * FROM dbo.func2(7)

DROP FUNCTION dbo.func2

GO

--Создать 3 триггера
