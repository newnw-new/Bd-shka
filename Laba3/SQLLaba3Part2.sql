--a
SELECT cl.Surname, cl.Name, cl.Patronim, cl.Birth_date, vac.Job_title, vac.Salary, vac.Education, vac.Gender, vac.MIN_age, vac.MAX_age, vac.City, vac.Hours_per_week, vac.Employment_type, vac.Shedule, vac.Work_format
FROM Clients AS cl JOIN Vacancies AS vac ON (Cl.Gender = vac.Gender OR vac.Gender IS NULL) 
	AND (cl.Education = vac.Education)
	AND ((Cl.Birth_date <= DATEADD(YEAR, -vac.MIN_age, GETDATE()) OR MIN_age IS NULL) AND (Cl.Birth_date >= DATEADD(YEAR, -vac.MAX_age, GETDATE()) OR MAX_age IS NULL))
	AND cl.Job_title IS NULL

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
		WHEN Row_desc = 1 THEN '��������'
		WHEN Row_ask = 1 THEN '��������'
	END AS [��� ����������������]
FROM helpTable
WHERE Row_ask = 1 OR Row_desc = 1

--c
SELECT DISTINCT ent.Id, ent.Name
FROM Enterprises AS ent JOIN HR_departaments AS hr ON Ent.Id = hr.Id_enterprise JOIN Vacancies AS vac ON vac.Id_HR_departament = hr.Id
WHERE NOT (vac.Gender IS NULL AND vac.MIN_age IS NULL AND vac.MAX_age IS NULL)

--d
SELECT COUNT(Id) AS [���-�� ����������� � ������ ������������]
FROM Clients
WHERE Education = '������ ����������������' AND Job_title IS NULL

--e
WITH EntCeCl (EnterpriseId, EnterpriseName, ClientId, ClientGender, ClientEducation, ClientBirth_date) AS 
(SELECT ent.Id, ent.Name, cl.Id, cl.Gender, cl.Education, cl.Birth_date
FROM Enterprises AS ent JOIN Client_Enterprise AS ce ON ent.Id = ce.Id_enterpise JOIN Clients AS cl ON cl.Id = ce.Id_client)
SELECT EnterpriseName,
	COUNT(ClientId) AS [���-�� ���������������],
	COUNT(CASE WHEN ClientGender = '�' THEN 1 END) AS [�],
	COUNT(CASE WHEN ClientGender = '�' THEN 1 END) AS [�],
	COUNT(CASE WHEN ClientEducation = '������ ����������������' THEN 1 END) AS [������ ���.],
	COUNT(CASE WHEN ClientEducation = '������� ����������������' THEN 1 END) AS [������� ����.],
	COUNT(CASE WHEN DATEADD(YEAR, -40, GETDATE()) <= ClientBirth_date THEN 1 END) AS [�� 40],
	COUNT(CASE WHEN DATEADD(YEAR, -40, GETDATE()) > ClientBirth_date THEN 1 END) AS [����� 40]
FROM EntCeCl
GROUP BY EnterpriseId, EnterpriseName