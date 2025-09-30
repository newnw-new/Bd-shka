CREATE TABLE Clients
(
	[Id] INT PRIMARY KEY,
	[Address] NVARCHAR(50) NOT NULL,
	[Phone_number] NVARCHAR(12) NOT NULL CHECK(Phone_number LIKE '+7[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
	OR Phone_number LIKE '8[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	[Gender] NCHAR(1) NOT NULL CHECK(Gender in(N'М', N'Ж')),
	[Education] NVARCHAR(25) NULL CHECK (Education in(N'Среднее профессиональное', N'Высшее профессиональное')),
	[Birth_date] DATE NOT NULL,
	[Job_title] NVARCHAR(50) NULL,
	[Surname] NVARCHAR(50) NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	[Patronim] NVARCHAR(50) NULL
)

CREATE TABLE Enterprises
(
	[Id] INT PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE HR_departaments
(
	[Id] INT PRIMARY KEY,
	[Id_enterprise] INT NOT NULL FOREIGN KEY REFERENCES Enterprises([Id])
	ON DELETE CASCADE ON UPDATE CASCADE,
	[Phone_number] NVARCHAR(12) NOT NULL CHECK(Phone_number LIKE '+7[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
	OR Phone_number LIKE '8[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	[Boss_surname] NVARCHAR(50) NOT NULL,
	[Boss_name] NVARCHAR(50) NOT NULL,
	[Boss_patronim] NVARCHAR(50) NULL
)

CREATE TABLE Vacancies
(
	[Id] INT PRIMARY KEY,
	[Id_HR_departament] INT NOT NULL FOREIGN KEY REFERENCES HR_departaments([Id])
	ON DELETE CASCADE ON UPDATE CASCADE,
	[Salary] INT NOT NULL CHECK(Salary > 0),
	[Education] NVARCHAR(25) NULL CHECK (Education in(N'Среднее профессиональное', N'Высшее профессиональное')),
	[Gender] NCHAR(1) NULL CHECK (Gender in(N'М', N'Ж')),
	[Job_title] NVARCHAR(50) NOT NULL,
	[MIN_age] TINYINT NULL CHECK (MIN_age > 0),
	[MAX_age] TINYINT NULL CHECK (MAX_age > 0),
	[Shedule] NVARCHAR(5) NOT NULL CHECK (Shedule LIKE '[1-30]/[1-30]'),
	[Experience] TINYINT NULL CHECK (Experience > 0),
	[Hours_per_week] TINYINT NOT NULL CHECK(Hours_per_week > 0 AND Hours_per_week <= 40),
	[Employment_type] NVARCHAR(50) NOT NULL CHECK (Employment_type in(N'Полная', N'Частичная', N'Вахта')),
	[Work_format] NVARCHAR(30) NOT NULL CHECK (Work_format in (N'На месте', N'Удаленно', N'Разъезды')),
	[Vacancy_rating] AS (Salary*0.8)/10000+(1/Hours_per_week),
	CONSTRAINT CK_Age CHECK(MIN_age <= MAX_age)
)

CREATE TABLE Client_Vacancy
(
	[Id_client] INT NOT NULL FOREIGN KEY REFERENCES Clients([Id])
	ON DELETE CASCADE ON UPDATE CASCADE,
	[Id_vacancy] INT NOT NULL FOREIGN KEY REFERENCES Vacancies([Id])
	ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY([Id_client], [Id_vacancy])
)

CREATE TABLE Client_Enterprise
(
	[Id_client] INT NOT NULL FOREIGN KEY REFERENCES Clients([Id])
	ON DELETE CASCADE ON UPDATE CASCADE,
	[Id_enterpise] INT NOT NULL FOREIGN KEY REFERENCES Enterprises([Id])
	ON DELETE CASCADE ON UPDATE CASCADE,
	[Job_title] NVARCHAR(50) NOT NULL,
	[First_work_day] DATE NOT NULL,
	[Last_work_day] DATE NULL,
	PRIMARY KEY([Id_client], [First_work_day])
)

SELECT * FROM Clients

DROP TABLE Clients
DROP TABLE Enterprises
DROP TABLE HR_departaments
DROP TABLE Vacancies
DROP TABLE Client_Enterprise
DROP TABLE Client_Vacancy