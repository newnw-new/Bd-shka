INSERT INTO Client
VALUES
(N'Москва, ул. Ленина, 10', '+79161234567', N'М', N'Высшее профессиональное', '1985-03-15', N'Иванов', N'Алексей', N'Петрович'),
(N'СПб, Невский пр., 25', '88123456789', N'Ж', N'Среднее профессиональное', '1990-07-22', N'Петрова', N'Ольга', N'Сергеевна'),
(N'Екатеринбург, ул. Мира, 5', '+79165554433', N'М', N'Среднее профессиональное', '1988-11-30', N'Сидоров', N'Дмитрий', NULL),
(N'Новосибирск, пр. Карла Маркса, 17', '+79167778899', N'Ж', N'Высшее профессиональное', '1995-01-10', N'Кузнецова', N'Мария', N'Андреевна'),
(N'Казань, ул. Баумана, 3', '88431234567', N'М', N'Среднее профессиональное', '1983-12-05', N'Федоров', N'Иван', N'Николаевич'),
(N'Владивосток, ул. Светланская, 15', '+79169998877', N'Ж', N'Среднее профессиональное', '1992-09-18', N'Морозова', N'Анна', N'Владимировна'),
(N'Краснодар, ул. Красная, 40', '+79163332211', N'М', N'Высшее профессиональное', '1987-06-25', N'Новиков', N'Сергей', N'Алексеевич'),
(N'Сочи, ул. Навагинская, 7', '88622345678', N'Ж', N'Среднее профессиональное', '1991-04-12', N'Лебедева', N'Екатерина', NULL),
(N'Уфа, пр. Октября, 20', '+79164445566', N'М', N'Высшее профессиональное', '1980-08-08', N'Харитонов', N'Андрей', N'Викторович'),
(N'Калининград, Ленинский пр., 30', '+79161112233', N'Ж', N'Среднее профессиональное', '1994-02-28', N'Иванова', N'Татьяна', N'Борисовна')

INSERT INTO Enterprise
VALUES
(N'ОАО "Газпром"'),
(N'АО "Ростех"'),
(N'ПАО "Сбербанк"'),
(N'ООО "Рога и копыта"'),
(N'АО "Вертолеты России"'),
(N'ПАО "Лукойл"'),
(N'ОАО "РЖД"'),
(N'АО "Транснефть"'),
(N'ООО "Стройсервис"'),
(N'ЗАО "Альфа-Банк"')

INSERT INTO HR_departament
VALUES
('+74951234567', N'Семенов', N'Александр', N'Игоревич'),
('88127654321', N'Колесникова', N'Ирина', N'Викторовна'),
('+74955556677', N'Григорьев', N'Максим', NULL),
('84319876543', N'Ткаченко', N'Олег', N'Петрович'),
('+73518456789', N'Белова', N'Светлана', N'Юрьевна'),
('86122345678', N'Денисов', N'Роман', N'Анатольевич'),
('+74959876543', N'Антонова', N'Марина', N'Сергеевна'),
('84635478901', N'Павлов', N'Денис', N'Валерьевич'),
('+74116543210', N'Ковалева', N'Наталья', N'Александровна'),
('84951230099', N'Фролов', N'Артем', N'Олегович')

INSERT INTO Vacancy
VALUES
(80000, N'Высшее профессиональное', NULL, N'Инженер', NULL, NULL, '5/2', N'Москва', 40, N'Полная', N'На месте'),
(45000, N'Среднее профессиональное', NULL, N'Администратор', NULL, NULL, '5/2', NULL, 30, N'Частичная', N'На месте'),
(120000, N'Высшее профессиональное', NULL, N'Старший разработчик', NULL, NULL, '5/2', NULL, 40, N'Полная', N'Удаленно'),
(35000, N'Среднее профессиональное', N'Ж', N'Кассир', NULL, NULL, '2/2', N'Санкт-Петербург', 20, N'Частичная', N'На месте'),
(95000, N'Высшее профессиональное', N'М', N'Аналитик', NULL, NULL, '5/2', N'Екатеринбург', 40, N'Полная', N'На месте'),
(70000, N'Среднее профессиональное', NULL, N'Механик', 22, NULL, '6/1', N'Новосибирск', 40, N'Вахта', N'Разъезды'),
(150000, N'Высшее профессиональное', NULL, N'Руководитель отдела', NULL, 55, '5/2', N'Казань', 40, N'Полная', N'На месте'),
(55000, N'Среднее профессиональное', N'Ж', N'Оператор ПК', 20, 35, '5/2', N'Владивосток', 30, N'Частичная', N'На месте'),
(110000, N'Высшее профессиональное', N'М', N'Инженер', 35, 60, '5/2', N'Краснодар', 40, N'Полная', N'На месте'),
(60000, N'Среднее профессиональное', NULL, N'Кредитный специалист', 23, 40, '5/2', N'Сочи', 40, N'Полная', N'На месте')



INSERT INTO HR_departament_belongs_Enterprise VALUES
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 1), (SELECT Enterprise.[$node_id_75DDC0D365394F459BCBE8EC0A4023AF] FROM Enterprise WHERE Id = 1)),
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 2), (SELECT Enterprise.[$node_id_75DDC0D365394F459BCBE8EC0A4023AF] FROM Enterprise WHERE Id = 2)),
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 3), (SELECT Enterprise.[$node_id_75DDC0D365394F459BCBE8EC0A4023AF] FROM Enterprise WHERE Id = 3)),
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 4), (SELECT Enterprise.[$node_id_75DDC0D365394F459BCBE8EC0A4023AF] FROM Enterprise WHERE Id = 4)),
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 5), (SELECT Enterprise.[$node_id_75DDC0D365394F459BCBE8EC0A4023AF] FROM Enterprise WHERE Id = 5)),
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 6), (SELECT Enterprise.[$node_id_75DDC0D365394F459BCBE8EC0A4023AF] FROM Enterprise WHERE Id = 6)),
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 7), (SELECT Enterprise.[$node_id_75DDC0D365394F459BCBE8EC0A4023AF] FROM Enterprise WHERE Id = 7)),
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 8), (SELECT Enterprise.[$node_id_75DDC0D365394F459BCBE8EC0A4023AF] FROM Enterprise WHERE Id = 8)),
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 9), (SELECT Enterprise.[$node_id_75DDC0D365394F459BCBE8EC0A4023AF] FROM Enterprise WHERE Id = 9)),
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 10), (SELECT Enterprise.[$node_id_75DDC0D365394F459BCBE8EC0A4023AF] FROM Enterprise WHERE Id = 3))

INSERT INTO HR_departament_forms_Vacancy VALUES
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 1), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 1)),
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 4), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 2)),
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 3), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 3)),
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 4), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 4)),
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 5), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 5)),
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 6), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 6)),
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 3), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 7)),
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 8), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 8)),
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 9), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 9)),
((SELECT HR_departament.[$node_id_CB6E95E7023847769DC9409B4F5F26B8] FROM HR_departament WHERE Id = 10), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 10))

INSERT INTO Client_work_Enterprise VALUES
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 1),(SELECT Enterprise.[$node_id_75DDC0D365394F459BCBE8EC0A4023AF] FROM Enterprise WHERE Id = 1),
N'Инженер', '2020-01-15', NULL),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 2),(SELECT Enterprise.[$node_id_75DDC0D365394F459BCBE8EC0A4023AF] FROM Enterprise WHERE Id = 3),
N'Менеджер', '2021-03-20', '2023-06-10'),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 4),(SELECT Enterprise.[$node_id_75DDC0D365394F459BCBE8EC0A4023AF] FROM Enterprise WHERE Id = 2),
N'Бухгалтер', '2022-02-10', NULL),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 7),(SELECT Enterprise.[$node_id_75DDC0D365394F459BCBE8EC0A4023AF] FROM Enterprise WHERE Id = 4),
N'Программист', '2021-09-12', NULL),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 5),(SELECT Enterprise.[$node_id_75DDC0D365394F459BCBE8EC0A4023AF] FROM Enterprise WHERE Id = 7),
N'Техник', '2018-07-15', '2024-01-20')

INSERT INTO Client_match_Vacancy VALUES
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 9), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 1)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 3), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 2)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 5), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 2)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 6), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 2)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 8), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 2)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 10), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 2)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 9), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 3)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 6), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 4)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 8), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 4)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 10), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 4)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 9), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 5)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 3), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 6)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 5), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 6)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 6), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 6)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 8), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 6)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 10), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 6)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 9), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 7)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 6), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 8)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 8), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 8)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 10), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 8)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 9), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 9)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 3), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 10)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 6), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 10)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 8), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 10)),
((SELECT Client.[$node_id_8F279B8AD3C447EF917751EED0D59D5D] FROM Client WHERE Id = 10), (SELECT Vacancy.[$node_id_52AEC9FC6E8D4F01B2E39718E6A80436] FROM Vacancy WHERE Id = 10))

SELECT * FROM Client
SELECT * FROM Enterprise
SELECT * FROM HR_departament
SELECT * FROM Vacancy
SELECT * FROM HR_departament_belongs_Enterprise
SELECT * FROM HR_departament_forms_Vacancy
SELECT * FROM Client_work_Enterprise
SELECT * FROM Client_match_Vacancy