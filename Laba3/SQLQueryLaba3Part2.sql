--a
--Переделать более точное вычисление возраста и с опытом подумать
SELECT cl.Surname, cl.Name, cl.Patronim, vac.Job_title, vac.Salary, vac.Education, vac.Gender, vac.MIN_age, vac.MAX_age, vac.City, vac.Hours_per_week, vac.Employment_type, vac.Shedule, vac.Work_format
FROM Clients AS cl JOIN Vacancies AS vac ON (Cl.Gender = vac.Gender OR vac.Gender IS NULL) 
	AND (cl.Education = vac.Education)
	AND ((2025 - YEAR(Cl.Birth_date) >= vac.MIN_age OR MIN_age IS NULL) AND (2025 - YEAR(Cl.Birth_date) <= vac.MAX_age OR MAX_age IS NULL))

--b
WITH helpTable AS 
(
	SELECT Job_title,
	COUNT(*) AS Job_count,
	RANK() OVER(ORDER BY COUNT(*) DESC) AS Row_desc,
	RANK() OVER(ORDER BY COUNT(*)) AS Row_ask
	FROM Vacancies
	GROUP BY Job_title
)
SELECT Job_title, 
	CASE
		WHEN Row_desc = 1 THEN 'Наиболее'
		WHEN Row_ask = 1 THEN 'Наименее'
	END AS [Тип востребованности]
FROM helpTable
WHERE Row_ask = 1 OR Row_desc = 1

--c
SELECT DISTINCT ent.Id, ent.Name
FROM Enterprises AS ent JOIN HR_departaments AS hr ON Ent.Id = hr.Id_enterprise JOIN Vacancies AS vac ON vac.Id_HR_departament = hr.Id
WHERE NOT (vac.Gender IS NULL AND vac.MIN_age IS NULL AND vac.MAX_age IS NULL)

--d
SELECT COUNT(Id) AS [Кол-во безработных с высшим образованием]
FROM Clients
WHERE Education = 'Высшее профессиональное' AND Job_title IS NULL

--e
--Тоже надо будет с датой поиграться
WITH EntCeCl (EnterpriseId, EnterpriseName, ClientId, ClientGender, ClientEducation, ClientBirth_date) AS 
(SELECT ent.Id, ent.Name, cl.Id, cl.Gender, cl.Education, cl.Birth_date
FROM Enterprises AS ent JOIN Client_Enterprise AS ce ON ent.Id = ce.Id_enterpise JOIN Clients AS cl ON cl.Id = ce.Id_client)
SELECT EnterpriseName,
	COUNT(ClientId) AS [Кол-во трудоустроенных],
	COUNT(CASE WHEN ClientGender = 'М' THEN 1 END) AS [М],
	COUNT(CASE WHEN ClientGender = 'Ж' THEN 1 END) AS [Ж],
	COUNT(CASE WHEN ClientEducation = 'Высшее профессиональное' THEN 1 END) AS [Высшее обр.],
	COUNT(CASE WHEN ClientEducation = 'Среднее профессиональное' THEN 1 END) AS [Среднее спец.],
	COUNT(CASE WHEN 2025 - YEAR(ClientBirth_date) <= 40 THEN 1 END) AS [До 40],
	COUNT(CASE WHEN 2025 - YEAR(ClientBirth_date) > 40 THEN 1 END) AS [После 40]
FROM EntCeCl
GROUP BY EnterpriseId, EnterpriseName
