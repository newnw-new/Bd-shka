--a
--���������� ����� ������ ���������� �������� � � ������ ��������
SELECT cl.Surname, cl.Name, cl.Patronim, vac.Job_title, vac.Salary, vac.Education, vac.Gender, vac.MIN_age, vac.MAX_age, vac.Experience, vac.Hours_per_week, vac.Employment_type, vac.Shedule, vac.Work_format
FROM Clients AS cl JOIN Vacancies AS vac ON (Cl.Gender = vac.Gender OR vac.Gender IS NULL) 
	AND (cl.Education = vac.Education)
	AND ((2025 - YEAR(Cl.Birth_date) >= vac.MIN_age OR MIN_age IS NULL) AND (2025 - YEAR(Cl.Birth_date) <= vac.MAX_age OR MAX_age IS NULL))

--b

SELECT TOP 1 WITH TIES Job_title
FROM Vacancies
GROUP BY Job_title
ORDER BY COUNT(Job_title) DESC
--UNION
SELECT TOP 1 WITH TIES Job_title
FROM Vacancies
GROUP BY Job_title
ORDER BY COUNT(Job_title)

--c
SELECT DISTINCT ent.Id, ent.Name
FROM Enterprises AS ent JOIN HR_departaments AS hr ON Ent.Id = hr.Id_enterprise JOIN Vacancies AS vac ON vac.Id_HR_departament = hr.Id
WHERE NOT (vac.Gender IS NULL AND vac.MIN_age IS NULL AND vac.MAX_age IS NULL)

--d
SELECT COUNT(Id) AS [���-�� ����������� � ������ ������������]
FROM Clients
WHERE Education = '������ ����������������' AND Job_title IS NULL

--e
--���� ���� ����� � ����� ����������
WITH EntCeCl (EnterpriseId, EnterpriseName, ClientId, ClientGender, ClientEducation, ClientBirth_date) AS 
(SELECT ent.Id, ent.Name, cl.Id, cl.Gender, cl.Education, cl.Birth_date
FROM Enterprises AS ent JOIN Client_Enterprise AS ce ON ent.Id = ce.Id_enterpise JOIN Clients AS cl ON cl.Id = ce.Id_client)
SELECT EnterpriseName,
	COUNT(ClientId) AS [���-�� ���������������],
	COUNT(CASE WHEN ClientGender = '�' THEN 1 END) AS [�],
	COUNT(CASE WHEN ClientGender = '�' THEN 1 END) AS [�],
	COUNT(CASE WHEN ClientEducation = '������ ����������������' THEN 1 END) AS [������ ���.],
	COUNT(CASE WHEN ClientEducation = '������� ����������������' THEN 1 END) AS [������� ����.],
	COUNT(CASE WHEN 2025 - YEAR(ClientBirth_date) <= 40 THEN 1 END) AS [�� 40],
	COUNT(CASE WHEN 2025 - YEAR(ClientBirth_date) > 40 THEN 1 END) AS [�� 40]
FROM EntCeCl
GROUP BY EnterpriseId, EnterpriseName
