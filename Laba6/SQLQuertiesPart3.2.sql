--a
SELECT cl.Surname, cl.Name, cl.Patronim, cl.Birth_date, vac.Job_title, vac.Salary, vac.Education, vac.Gender, vac.MIN_age, vac.MAX_age, vac.City, vac.Hours_per_week, vac.Employment_type, vac.Shedule, vac.Work_format
FROM Client cl, Client_match_Vacancy, Vacancy vac
WHERE MATCH(cl-(Client_match_Vacancy)->vac)

--b
WITH helpTable AS 
(
	SELECT Job_title,
	COUNT(*) AS Job_count,
	RANK() OVER(ORDER BY COUNT(*) DESC) AS Row_desc,
	RANK() OVER(ORDER BY COUNT(*)) AS Row_ask
	FROM Vacancy
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
FROM Enterprise ent, HR_departament_belongs_Enterprise hrEnt, HR_departament hr, HR_departament_forms_Vacancy hrVac, Vacancy vac
WHERE MATCH(hr-(hrEnt)->ent) AND MATCH(hr-(hrVac)->vac) AND NOT (vac.Gender IS NULL AND vac.MIN_age IS NULL AND vac.MAX_age IS NULL)

--d
SELECT COUNT(DISTINCT Client.Id) AS [Кол-во безработных с высшим образованием]
FROM Client, Client_match_Vacancy, Vacancy
WHERE MATCH(Client-(Client_match_Vacancy)->Vacancy) AND Vacancy.Education = 'Высшее профессиональное'


--e
SELECT 
    ent.Name AS [Предприятие],
    COUNT(DISTINCT cl.Id) AS [Кол-во трудоустроенных],
    COUNT(CASE WHEN cl.Gender = 'М' THEN 1 END) AS [М],
	COUNT(CASE WHEN cl.Gender = 'Ж' THEN 1 END) AS [Ж],
	COUNT(CASE WHEN cl.Education = 'Высшее профессиональное' THEN 1 END) AS [Высшее обр.],
	COUNT(CASE WHEN cl.Education = 'Среднее профессиональное' THEN 1 END) AS [Среднее спец.],
	COUNT(CASE WHEN DATEADD(YEAR, -40, GETDATE()) <= cl.Birth_date THEN 1 END) AS [До 40],
	COUNT(CASE WHEN DATEADD(YEAR, -40, GETDATE()) > cl.Birth_date THEN 1 END) AS [После 40]
FROM 
    Client cl,
    Client_work_Enterprise clEnt,
    Enterprise ent
WHERE 
    MATCH(cl-(clEnt)->ent)
GROUP BY 
    ent.Name