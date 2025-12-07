USE recruitment_agency

CREATE ROLE Supervisor
CREATE ROLE Employee

GRANT SELECT ON dbo.Clients TO Supervisor
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Enterprises TO Supervisor
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.HR_departaments TO Supervisor WITH GRANT OPTION
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Vacancies TO Supervisor WITH GRANT OPTION
GRANT SELECT, INSERT, UPDATE ON dbo.Client_Enterprise TO Supervisor -- Вот здесь можно подумать над триггером для удаления, чтоб при удалении запись не удалялась, а ставился last_day
--Тут нужно ещё добавить права на процедуры и функции 
GRANT EXEC ON dbo.FindBiggerSalaryVacancies TO Supervisor
GRANT EXEC ON dbo.AVGSalary TO Supervisor
GRANT EXEC ON dbo.func1 TO Supervisor
GRANT SELECT ON dbo.MaskPhone TO Supervisor
GRANT EXEC ON dbo.MaskYear TO Supervisor
GRANT SELECT ON dbo.MaskAll TO Supervisor

GRANT SELECT, UPDATE ON dbo.Clients TO Employee -- Подумать над delete
GRANT SELECT ON dbo.Vacancies TO Employee
GRANT SELECT ON dbo.Client_Enterprise TO Employee
GRANT SELECT ON dbo.HR_departaments TO Employee
GRANT SELECT ON dbo.Enterprises TO Employee
--Тут нужно ещё добавить права на процедуру и функции и сделать представление для hr отделов и enterprises чтоб не раскрывать id и всю информацию передавать в одной таблице
GRANT EXEC ON dbo.FindUnemployed TO Employee
GRANT EXEC ON dbo.FindVacanciesForUnemployed TO Employee
GRANT EXEC ON dbo.FindVacanciesBiggerAvgSalary TO Employee
GRANT SELECT ON dbo.func2 TO Employee
GRANT SELECT ON dbo.func3 TO Employee
GRANT SELECT ON dbo.MaskPhone TO Employee
GRANT EXEC ON dbo.MaskYear TO Employee
GRANT SELECT ON dbo.MaskAll TO Employee

CREATE LOGIN User_kibor WITH PASSWORD = '1234567'
CREATE LOGIN User1_kibor WITH PASSWORD = '1234567'

CREATE USER RecUser FOR LOGIN User_kibor
CREATE USER RecUser1 FOR LOGIN User1_kibor

ALTER ROLE Supervisor ADD MEMBER RecUser
ALTER ROLE Employee ADD MEMBER RecUSer1

SELECT name, type_desc 
FROM sys.database_principals 
WHERE name = 'RecUser1';