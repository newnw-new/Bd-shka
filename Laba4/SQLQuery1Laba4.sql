--Создать 4 различных хранимых процедуры
--a
--Процедура без параметров, возвращающая список нетрудоустроенных претендентов и
--подходящих им вакансий с максимальной заработной платой в форме:
--ФИО, возраст, пол, образование, предприятие, должность, зарплата
CREATE PROCEDURE FindUnemployed AS
BEGIN
	WITH EntVac AS
	(SELECT ent.Name, vac.Job_title, vac.Salary, vac.Gender, vac.Education, vac.Work_format, vac.MIN_age, vac.MAX_age, vac.City
	FROM Enterprises AS ent JOIN HR_departaments AS hr ON ent.Id = hr.Id_enterprise JOIN Vacancies AS vac ON vac.Id_HR_departament = hr.Id)

	SELECT cl.Surname, cl.Name, cl.Patronim, cl.Birth_date, cl.Gender, cl.Education, vac.Name, vac.Job_title, vac.Salary
	FROM Clients AS cl JOIN EntVac AS vac ON (Cl.Gender = vac.Gender OR vac.Gender IS NULL) 
	AND (cl.Education = vac.Education)
	AND ((Cl.Birth_date <= DATEADD(YEAR, -vac.MIN_age, GETDATE()) OR MIN_age IS NULL) AND (Cl.Birth_date >= DATEADD(YEAR, -vac.MAX_age, GETDATE()) OR MAX_age IS NULL))
	AND (SUBSTRING(cl.Address, 0, CHARINDEX(',', cl.Address)) = vac.City OR vac.Work_format IN ('Удаленно', 'Разъезды'))
END;

EXEC FindUnemployed

DROP PROCEDURE FindUnemployed

--b
--Процедура, на входе получающая размер зарплаты и формирующая список вакансий с зарплатой не меньше заданной
CREATE PROCEDURE FindBiggerSalaryVacancies
	@Salary INT
AS
BEGIN
	SELECT * FROM Vacancies WHERE Salary >= @Salary
END

EXEC FindBiggerSalaryVacancies 50000

DROP PROCEDURE FindBiggerSalaryVacancies

--c
--Процедура, на входе получающая ФИО безработного, выходной параметр – название должности с максимальной зарплатой,
--которая ему подходит
-- исправить вывод
CREATE PROCEDURE FindVacanciesForUnemployed
	@Surname NVARCHAR(50),
	@Name NVARCHAR(50),
	@Patronim NVARCHAR(50),
	@Job_title NVARCHAR(50) OUTPUT,
	@Salary INT OUTPUT
AS
BEGIN
	SELECT TOP 1 @Job_title = vac.Job_title, @Salary = vac.Salary
	FROM Clients AS cl JOIN Vacancies AS vac ON (Cl.Gender = vac.Gender OR vac.Gender IS NULL) 
	AND (cl.Education = vac.Education)
	AND ((Cl.Birth_date <= DATEADD(YEAR, -vac.MIN_age, GETDATE()) OR MIN_age IS NULL) AND (Cl.Birth_date >= DATEADD(YEAR, -vac.MAX_age, GETDATE()) OR MAX_age IS NULL))
	AND (SUBSTRING(cl.Address, 0, CHARINDEX(',', cl.Address)) = vac.City OR vac.Work_format IN ('Удаленно', 'Разъезды'))
	WHERE cl.Surname = @Surname AND cl.Name = @Name AND (cl.Patronim = @Patronim OR (cl.Patronim IS NULL AND @Patronim IS NULL))
	ORDER BY vac.Salary DESC
END

DECLARE @Best_job NVARCHAR(50), @Salary_best_job INT
EXEC FindVacanciesForUnemployed 'Петрова', 'Ольга', 'Сергеевна', @Best_job OUTPUT, @Salary_best_job OUTPUT
PRINT @Best_job
PRINT @Salary_best_job

DROP PROCEDURE FindVacanciesForUnemployed

--d
--Процедура, которая вызывает процедуру, вычисляющую среднюю зарплату по всем вакансиям,
--и выводит список вакансий с зарплатой больше, чем полученная во вложенной процедуре
CREATE PROCEDURE AVGSalary
	@AvgSalary INT OUTPUT
AS
BEGIN
	SELECT @AvgSalary = AVG(Salary)
	FROM Vacancies
END

CREATE PROCEDURE FindVacanciesBiggerAvgSalary AS
BEGIN
	DECLARE @AvgSalary INT
	EXEC AVGSalary @AvgSalary OUTPUT

	SELECT *
	FROM Vacancies
	WHERE Salary > @AvgSalary
END

EXEC FindVacanciesBiggerAvgSalary

DROP PROCEDURE FindVacanciesBiggerAvgSalary
DROP PROCEDURE AVGSalary

--3 пользовательских функции
--a
--Скалярная функция, возвращающая по размеру зарплаты количество вакансий с зарплатой не меньше заданной
CREATE FUNCTION func1 (@Salary INT)
RETURNS INT
BEGIN
	DECLARE @Result INT
	SELECT @Result = COUNT(Id) FROM Vacancies WHERE Salary >= @Salary
	RETURN @Result
END

PRINT dbo.func1(50000)

--b
--Inline-функция, возвращающая все подходящин вакансии для заданного претендента
CREATE FUNCTION func2 (@ClientId INT)
RETURNS TABLE
RETURN 
	SELECT vac.*
	FROM Clients AS cl JOIN Vacancies AS vac ON (Cl.Gender = vac.Gender OR vac.Gender IS NULL) 
	AND (cl.Education = vac.Education)
	AND ((Cl.Birth_date <= DATEADD(YEAR, -vac.MIN_age, GETDATE()) OR MIN_age IS NULL) AND (Cl.Birth_date >= DATEADD(YEAR, -vac.MAX_age, GETDATE()) OR MAX_age IS NULL))
	AND (SUBSTRING(cl.Address, 0, CHARINDEX(',', cl.Address)) = vac.City OR vac.Work_format IN ('Удаленно', 'Разъезды'))
	WHERE cl.Id = @ClientId

SELECT * FROM func2(1)

--с
--Multi-statement-функция, возвращающая ФИО начальников отделов кадров,
--телефоны отделов кадров предприятий, где есть вакансии, подходящие заданному претенденту
CREATE FUNCTION func3 (@IdClient INT)
RETURNS @HrTable TABLE ([Фамилия] VARCHAR(50), [Имя]VARCHAR(50), [Отчество]VARCHAR(50), [Телефон] NVARCHAR(12))
AS
BEGIN
	INSERT INTO @HrTable
		SELECT hr.Boss_surname, hr.Boss_name, hr.Boss_patronim, hr.Phone_number FROM HR_departaments hr JOIN dbo.func2(@IdClient) f ON hr.Id = f.Id_HR_departament
	RETURN
END

SELECT * FROM dbo.func3(1)
--Создать 3 триггера
--a
--Триггер любого типа на операцию трудоустройства безработного – если данный безработный
--трудоустраивался агентством > 2-х раз, то такая запись не добавляется
CREATE TRIGGER jobPlacementTrigger
ON Client_Enterprise INSTEAD OF INSERT
AS
BEGIN
	
	-- Создаем таблицу где считаем количество трудоустройств в Client_Enterprise потом создаем таблицу где нумеруем для каждого клиента в таблице inserted трудоустройство после делаем insert с select где проверяем что для клинта кол-во старых трудоустройств + кол-во новых трудоустройств (это номер) <=2
	WITH CountClientJobs (ClientId, JobCount) AS 
	(
		SELECT Id_client, COUNT(*)
		FROM Client_Enterprise
		GROUP BY Id_client
	), RowNumInsertClient AS 
	(
		SELECT ROW_NUMBER() OVER(partition by Id_client ORDER BY First_work_day) as num, inserted.*
		FROM inserted
	)
	INSERT INTO Client_Enterprise 
	SELECT rnic.Id_client, rnic.Id_enterpise, rnic.Job_title, rnic.First_work_day, rnic.Last_work_day
	FROM RowNumInsertClient rnic JOIN CountClientJobs ccj ON rnic.Id_client = ccj.ClientId
	WHERE ccj.JobCount + rnic.num <= 2
END



--b
--Последующий триггер на изменение размера заработной платы для вакансии – если она уменьшается,
--то такое изменение должно отмениться с выводом соответствующего сообщения
CREATE TRIGGER salaryChangeTrigger 
ON Vacancies AFTER UPDATE
AS
BEGIN
	IF EXISTS (SELECT * FROM inserted JOIN deleted ON inserted.Id = deleted.Id
	WHERE inserted.Salary < deleted.Salary)
	BEGIN
		ROLLBACK
		PRINT('Отмена изменений')
	END
END

DROP TRIGGER salaryChangeTrigger

--c
--Замещающий триггер на операцию удаления безработного – если он трудоустраивался
--с помощью агентства хотя бы 1 раз, то удаление отменяется
CREATE TRIGGER deleteClientTrigger
ON Clients INSTEAD OF DELETE
AS
BEGIN
	DELETE FROM Clients
	WHERE Clients.Id IN (SELECT deleted.id 
		FROM deleted 
		WHERE deleted.id NOT IN (SELECT Client_Enterprise.Id_client FROM Client_Enterprise))
END