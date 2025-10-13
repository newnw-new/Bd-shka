--Выборка из одной таблицы.
--1.1 Выбрать из произвольной таблицы данные и отсортировать их по двум 
--произвольным имеющимся в таблице признакам (разные направления сортировки).
SELECT * FROM Clients
ORDER BY Name

SELECT * FROM Clients
ORDER BY Birth_date DESC

--1.2 Выбрать из произвольной таблицы те записи, которые удовлетворяют
--условию отбора (where). Привести 2-3 запроса.
SELECT * FROM Clients
WHERE Gender = N'М'

SELECT * FROM Clients
WHERE Education = N'Среднее профессиональное'

SELECT * FROM Clients
WHERE Patronim IS NULL

--1.3  Привести примеры 2-3 запросов с использованием агрегатных функций
--(count, max, sum и др.) с группировкой и без группировки. 
SELECT COUNT(*) AS [Всего людей], COUNT(Patronim) AS [Кол-во людей с отчеством], COUNT(*)-COUNT(Patronim) AS [Кол-во людей без отчества]
FROM Clients

SELECT Gender, MIN(Birth_date) AS min_date, MAX(Birth_date) AS max_date
FROM Clients
GROUP BY Gender

--1.4 Привести примеры подведения подытога с использованием GROUP BY [ALL] [ CUBE | ROLLUP](2-3 запроса). 
--В ROLLUP и CUBE использовать не менее 2-х столбцов.
SELECT Education, Gender, COUNT(*) AS [Кол-во людей]
FROM Clients
GROUP BY ROLLUP (Education, Gender)

SELECT Education, Gender, COUNT(*) AS [Кол-во людей]
FROM Clients
GROUP BY CUBE (Education, Gender)

--1.5 Выбрать из таблиц информацию об объектах, в названиях которых нет заданной последовательности букв (LIKE).
SELECT *
FROM Clients 
WHERE Surname NOT LIKE N'Иванов%'

--Выборка из нескольких таблиц.
--2.1 Вывести информацию подчиненной (дочерней) таблицы, заменяя коды
--(значения внешних ключей) соответствующими символьными значениями из
--родительских таблиц. Привести 2-3 запроса с использованием классического
--подхода соединения таблиц (where).
SELECT ent.Name, hr.Phone_number, hr.Boss_surname, hr.Boss_name, hr.Boss_patronim
FROM Enterprises AS ent, HR_departaments AS hr
WHERE ent.Id = hr.Id_enterprise

SELECT hr.Phone_number, hr.Boss_surname, hr.Boss_name, hr.Boss_patronim, vac.Salary, vac.Education, vac.Gender, vac.Job_title, vac.MIN_age, vac.MAX_age, vac.Shedule, vac.City, vac.Hours_per_week, vac.Employment_type, vac.Work_format, vac.Vacancy_rating
FROM Vacancies AS vac, HR_departaments AS hr
WHERE vac.Id_HR_departament = hr.Id

--2.2  Реализовать запросы пункта 2.1 через внутреннее соединение inner join. 
SELECT ent.Name, hr.Phone_number, hr.Boss_surname, hr.Boss_name, hr.Boss_patronim
FROM Enterprises AS ent JOIN HR_departaments AS hr ON ent.Id = hr.Id_enterprise

SELECT hr.Phone_number, hr.Boss_surname, hr.Boss_name, hr.Boss_patronim, vac.Salary, vac.Education, vac.Gender, vac.Job_title, vac.MIN_age, vac.MAX_age, vac.Shedule, vac.City, vac.Hours_per_week, vac.Employment_type, vac.Work_format, vac.Vacancy_rating
FROM Vacancies AS vac JOIN HR_departaments AS hr ON vac.Id_HR_departament = hr.Id

--2.3 Левое внешнее соединение left join. Привести 2-3 запроса.
SELECT ent.Name, hr.Phone_number, hr.Boss_surname, hr.Boss_name, hr.Boss_patronim
FROM Enterprises AS ent LEFT JOIN HR_departaments AS hr ON ent.Id = hr.Id_enterprise

SELECT hr.Phone_number, hr.Boss_surname, hr.Boss_name, hr.Boss_patronim, vac.Salary, vac.Education, vac.Gender, vac.Job_title, vac.MIN_age, vac.MAX_age, vac.Shedule, vac.City, vac.Hours_per_week, vac.Employment_type, vac.Work_format, vac.Vacancy_rating
FROM HR_departaments AS hr LEFT JOIN Vacancies AS vac ON vac.Id_HR_departament = hr.Id

--2.4 Правое внешнее соединение right join. Привести 2-3 запроса 
SELECT ent.Name, hr.Phone_number, hr.Boss_surname, hr.Boss_name, hr.Boss_patronim
FROM HR_departaments AS hr RIGHT JOIN Enterprises AS ent ON ent.Id = hr.Id_enterprise

SELECT hr.Phone_number, hr.Boss_surname, hr.Boss_name, hr.Boss_patronim, vac.Salary, vac.Education, vac.Gender, vac.Job_title, vac.MIN_age, vac.MAX_age, vac.Shedule, vac.City, vac.Hours_per_week, vac.Employment_type, vac.Work_format, vac.Vacancy_rating
FROM Vacancies AS vac RIGHT JOIN HR_departaments AS hr ON vac.Id_HR_departament = hr.Id

--2.5 Привести примеры 2-3 запросов с использованием агрегатных функций и группировки.
SELECT Enterprises.Name, COUNT(HR_departaments.Id_enterprise) AS [Кол-во HR-отделов]
FROM Enterprises LEFT JOIN HR_departaments ON Enterprises.Id = HR_departaments.Id_enterprise
GROUP BY Enterprises.Name

SELECT hr.Id, AVG(vac.Vacancy_rating) AS [Среднее значение рейтинга вакансий]
FROM HR_departaments AS hr LEFT JOIN Vacancies AS vac ON hr.Id = vac.Id_HR_departament
GROUP BY hr.Id

--2.6 Привести примеры 2-3 запросов с использованием группировки и условия отбора групп (Having).
SELECT Enterprises.Name, COUNT(HR_departaments.Id_enterprise) AS [Кол-во HR-отделов]
FROM Enterprises LEFT JOIN HR_departaments ON Enterprises.Id = HR_departaments.Id_enterprise
GROUP BY Enterprises.Name
HAVING COUNT(HR_departaments.Id_enterprise) < 2

SELECT hr.Id, AVG(vac.Vacancy_rating) AS [Среднее значение рейтинга вакансий]
FROM HR_departaments AS hr LEFT JOIN Vacancies AS vac ON hr.Id = vac.Id_HR_departament
GROUP BY hr.Id
HAVING NOT AVG(vac.Vacancy_rating) IS NULL

--2.7 Привести примеры 3-4 вложенных (соотнесенных, c использованием IN, EXISTS) запросов.
SELECT ent.Name, hr.Phone_number, vac.Job_title, vac.Employment_type
FROM (Enterprises AS ent JOIN HR_departaments AS hr ON ent.Id = hr.Id_enterprise) JOIN Vacancies AS vac ON hr.Id = vac.Id_HR_departament
WHERE vac.Employment_type IN('Полная', 'Частичная')

SELECT ent.Name, hr.Phone_number
FROM Enterprises AS ent JOIN HR_departaments AS hr ON ent.Id = hr.Id_enterprise
WHERE EXISTS(SELECT * FROM Vacancies WHERE Vacancies.Employment_type IN ('Полная', 'Частичная'))

SELECT ent.Name, hr.Phone_number
FROM Enterprises AS ent JOIN HR_departaments AS hr ON ent.Id = hr.Id_enterprise
WHERE NOT EXISTS(SELECT * FROM Vacancies AS vac WHERE vac.Shedule IN ('6/1', '7/0', '5/5'))

--Представления
--3.1 На основе любых запросов из п. 2 создать два представления (VIEW).
CREATE VIEW EnterHRdepVacView AS
SELECT ent.Name, hr.Phone_number, vac.Job_title, vac.Employment_type
FROM (Enterprises AS ent JOIN HR_departaments AS hr ON ent.Id = hr.Id_enterprise) JOIN Vacancies AS vac ON hr.Id = vac.Id_HR_departament

CREATE VIEW EnterCountHRdepsView AS
SELECT Enterprises.Name, COUNT(HR_departaments.Id_enterprise) AS [Кол-во HR-отделов]
FROM Enterprises LEFT JOIN HR_departaments ON Enterprises.Id = HR_departaments.Id_enterprise
GROUP BY Enterprises.Name;

--3.2 Привести примеры использования общетабличных выражений (СТЕ) (2-3 запроса)
WITH With1 (Surname) AS
(SELECT Surname
FROM Clients 
WHERE Surname NOT LIKE N'Иванов%')
SELECT * FROM With1;

WITH With2 (Salary) AS
(SELECT Salary
FROM Vacancies
WHERE Salary>200
)
SELECT * FROM With2

--Функции ранжирования
--4.1 Привести примеры 3-4 запросов с использованием ROW_NUMBER, RANK, DENSE_RANK (c  PARTITION BY и без)
SELECT ROW_NUMBER() OVER(ORDER BY Salary) AS [Номер], Salary, Job_title
FROM Vacancies
ORDER BY Job_title

SELECT ROW_NUMBER() OVER(PARTITION BY Education ORDER BY Birth_date) AS [Номер], Birth_date, Name, Surname, Patronim, Education
FROM Clients
ORDER BY Name, Surname, Patronim

SELECT RANK() OVER(ORDER BY Id_enterprise) AS [Номер], Boss_name, Id_enterprise
FROM HR_departaments

SELECT DENSE_RANK() OVER(ORDER BY Id_enterprise) AS [Номер], Boss_name, Id_enterprise
FROM HR_departaments

--Объдинение, пересечение, разность
--5.1 Привести примеры 3-4 запросов с использованием UNION / UNION ALL, EXCEPT, INTERSECT.
--Данные  в одном из запросов отсортируйте по произвольному признаку.
SELECT Job_title
FROM Vacancies AS vac
WHERE Education = 'Среднее профессиональное'
UNION
SELECT Job_title
FROM Vacancies AS vac
WHERE Education = 'Высшее профессиональное'
ORDER BY Job_title

SELECT Job_title
FROM Vacancies AS vac
WHERE Education = 'Среднее профессиональное'
UNION ALL
SELECT Job_title
FROM Vacancies AS vac
WHERE Education = 'Высшее профессиональное'
ORDER BY Job_title

SELECT Surname, Name, Patronim, Birth_date
FROM Clients
WHERE Gender = 'М'
INTERSECT
SELECT Surname, Name, Patronim, Birth_date
FROM Clients
WHERE YEAR(Birth_date) < 2004
ORDER BY Birth_date

SELECT Surname, Name, Patronim, Birth_date
FROM Clients
WHERE Gender = 'М'
EXCEPT
SELECT Surname, Name, Patronim, Birth_date
FROM Clients
WHERE YEAR(Birth_date) < 2004
ORDER BY Birth_date

--Использование CASE, PIVOT и UNPIVOT.
--6.1 Привести примеры получения сводных (итоговых) таблиц с использованием CASE
SELECT Job_title, Salary,
	CASE
		WHEN Salary < 22000 THEN 'Меньше МРОТ'
		WHEN Salary < 80000 THEN 'Меньше средней'
		ELSE 'Больше средней'
	END SalaryType
FROM Vacancies

SELECT Name, Surname, Patronim, Education,
	CASE Education
		WHEN 'Среднее профессиональное' THEN 'Без приоритета'
		WHEN 'Высшее профессиональное' THEN 'С приоритетом'
	END Prioritet
FROM Clients

--6.2 Привести примеры получения сводных (итоговых) таблиц с использованием PIVOT и UNPIVOT.
SELECT Job_title, [Полная], [Частичная], [Вахта]
FROM (SELECT Job_title, Salary, Employment_type FROM Vacancies) AS HelpTable
PIVOT(
	AVG(Salary)
	FOR Employment_type IN([Полная], [Частичная], [Вахта])
) pvt;

SELECT Id, val1, val2
FROM (SELECT Id, Surname, Name, Patronim FROM Clients) As HelpTable
UNPIVOT(
	val1 FOR val2 IN(Surname, Name, Patronim)
) unpvt;