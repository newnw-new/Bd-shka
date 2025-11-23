CREATE TABLE Client
(
	[Id] INT IDENTITY(1,1) PRIMARY KEY,
	[Address] NVARCHAR(50) NOT NULL,
	[Phone_number] NVARCHAR(12) NOT NULL CHECK(Phone_number LIKE '+7[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
	OR Phone_number LIKE '8[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	[Gender] NCHAR(1) NOT NULL CHECK(Gender in(N'М', N'Ж')),
	[Education] NVARCHAR(25) NOT NULL CHECK (Education in(N'Среднее профессиональное', N'Высшее профессиональное')),
	[Birth_date] DATE NOT NULL,
	[Surname] NVARCHAR(50) NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	[Patronim] NVARCHAR(50) NULL
) AS NODE

CREATE TABLE Enterprise
(
	[Id] INT IDENTITY(1,1) PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL
) AS NODE

CREATE TABLE HR_departament
(
	[Id] INT IDENTITY(1,1) PRIMARY KEY,
	[Phone_number] NVARCHAR(12) NOT NULL CHECK(Phone_number LIKE '+7[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
	OR Phone_number LIKE '8[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	[Boss_surname] NVARCHAR(50) NOT NULL,
	[Boss_name] NVARCHAR(50) NOT NULL,
	[Boss_patronim] NVARCHAR(50) NULL
) AS NODE

CREATE TABLE Vacancy
(
	[Id] INT IDENTITY(1,1) PRIMARY KEY,
	[Salary] INT NOT NULL CHECK(Salary > 0),
	[Education] NVARCHAR(25) NULL CHECK (Education in(N'Среднее профессиональное', N'Высшее профессиональное')),
	[Gender] NCHAR(1) NULL CHECK (Gender in(N'М', N'Ж')),
	[Job_title] NVARCHAR(50) NOT NULL,
	[MIN_age] TINYINT NULL CHECK (MIN_age > 0),
	[MAX_age] TINYINT NULL CHECK (MAX_age > 0),
	[Shedule] NVARCHAR(5) NOT NULL CHECK (Shedule LIKE '[1-9]/[1-9]' OR Shedule LIKE '[1-2][0-9]/[1-9]' OR Shedule LIKE '[1-9]/[1-2][0-9]' OR Shedule LIKE '[1-2][0-9]/[1-2][0-9]' OR Shedule LIKE '30/30'),
	[City] NVARCHAR(100) NULL,
	[Hours_per_week] TINYINT NOT NULL CHECK(Hours_per_week > 0 AND Hours_per_week <= 40),
	[Employment_type] NVARCHAR(50) NOT NULL CHECK (Employment_type in(N'Полная', N'Частичная', N'Вахта')),
	[Work_format] NVARCHAR(30) NOT NULL CHECK (Work_format in (N'На месте', N'Удаленно', N'Разъезды')),
	[Vacancy_rating] AS (Salary*0.8)/10000+(1/Hours_per_week),
	CONSTRAINT CK_Age CHECK(MIN_age <= MAX_age)
) AS NODE

CREATE TABLE HR_departament_belongs_Enterprise AS EDGE

CREATE TABLE HR_departament_forms_Vacancy AS EDGE

CREATE TABLE Client_work_Enterprise
(
	[Job_title] NVARCHAR(50) NOT NULL,
	[First_work_day] DATE NOT NULL,
	[Last_work_day] DATE NULL
) AS EDGE

CREATE TABLE Client_match_Vacancy AS EDGE

DROP TABLE Client
DROP TABLE Enterprise
DROP TABLE HR_departament
DROP TABLE Vacancy
DROP TABLE HR_departament_belongs_Enterprise
DROP TABLE HR_departament_forms_Vacancy
DROP TABLE Client_match_Vacancy
DROP TABLE Client_work_Enterprise