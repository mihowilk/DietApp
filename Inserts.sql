INSERT INTO fit_planner.dieta values (default, 5, '21 days');
INSERT INTO fit_planner.dieta values (default, 10, '2 months');
INSERT INTO fit_planner.dieta values (default, 15, '6 months');

INSERT INTO fit_planner.uzytkownik values (default, 1, 'Michal', 'Nowak', 'mnowak@gmail.com', 'pass45', 180, 90);
INSERT INTO fit_planner.uzytkownik values (default, 2, 'Adam', 'Bowak', 'abowak@gmail.com', 'pass13', 200, 100);
INSERT INTO fit_planner.uzytkownik values (default, 3, 'Andrzej', 'Kowak', 'akowak@gmail.com', 'pass12', 160, 80);
INSERT INTO fit_planner.uzytkownik values (default, 1, 'Anna', 'Wowak', 'awowak@gmail.com', 'pass15', 160, 55);

INSERT INTO fit_planner.przepis values (default, 1, 'pierogi ruskie', 'sredni', '2 hours', false, '600', '200', '150', '160');
INSERT INTO fit_planner.przepis values (default, 1, 'makaron z cebula', 'latwy', '1 hours', true, '500', '190', '140', '150');
INSERT INTO fit_planner.przepis values (default, 1, 'platki z mlekiem', 'latwy', '15 minutes', false, '300', '340', '250', '160');
INSERT INTO fit_planner.przepis values (default, 2, 'parowki', 'latwy', '5 minutes', false, '600', '200', '145', '161');
INSERT INTO fit_planner.przepis values (default, 3, 'owsianka', 'latwy', '15 minutes', false, '400', '220', '156', '164');
INSERT INTO fit_planner.przepis values (default, 4, 'sushi', 'trudny', '4 hours', false, '600', '230', '140', '154');

INSERT INTO fit_planner.ocena values (default, 1, 4, 5, 'bardzo dobre');
INSERT INTO fit_planner.ocena values (default, 1, 4, 4, 'nawet dobre');
INSERT INTO fit_planner.ocena values (default, 2, 1, 3, 'bywalo lepiej');
INSERT INTO fit_planner.ocena values (default, 3, 2, 2, 'fuj');
INSERT INTO fit_planner.ocena values (default, 4, 3, 4, 'mniam');
INSERT INTO fit_planner.ocena values (default, 4, 1, 5, 'bardzo dobre');
INSERT INTO fit_planner.ocena values (default, 3, 2, 1, 'ochyda');
INSERT INTO fit_planner.ocena values (default, 4, 3, 3, 'niedobre');
INSERT INTO fit_planner.ocena values (default, 4, 1, 2, 'trudne, nie wyszlo');

INSERT INTO fit_planner.skladnik values (default, 'maka');
INSERT INTO fit_planner.skladnik values (default, 'cebula');
INSERT INTO fit_planner.skladnik values (default, 'mleko');
INSERT INTO fit_planner.skladnik values (default, 'platki');
INSERT INTO fit_planner.skladnik values (default, 'parowki');
INSERT INTO fit_planner.skladnik values (default, 'platki owsiane');
INSERT INTO fit_planner.skladnik values (default, 'ryz');
INSERT INTO fit_planner.skladnik values (default, 'ryba');
INSERT INTO fit_planner.skladnik values (default, 'makaron');

INSERT INTO fit_planner.dostawca values (default, 'Danone', 'Niemcy');
INSERT INTO fit_planner.dostawca values (default, 'Wawel', 'Polska');
INSERT INTO fit_planner.dostawca values (default, 'Nestle', 'Holandia');

INSERT INTO fit_planner.dziennyplan values (default);
INSERT INTO fit_planner.dziennyplan values (default);
INSERT INTO fit_planner.dziennyplan values (default);
INSERT INTO fit_planner.dziennyplan values (default);
INSERT INTO fit_planner.dziennyplan values (default);

INSERT INTO fit_planner.przepiskrok values (default, 1, 1, '2 minutes', 'wez make');
INSERT INTO fit_planner.przepiskrok values (default, 1, 2, '20 minutes', 'zrob pierogi');
INSERT INTO fit_planner.przepiskrok values (default, 2, 1, '2 minutes', 'zagotuj wode');
INSERT INTO fit_planner.przepiskrok values (default, 2, 2, '20 minutes', 'zrob makaron');
INSERT INTO fit_planner.przepiskrok values (default, 4, 1, '2 minutes', 'zagotuj wode');
INSERT INTO fit_planner.przepiskrok values (default, 4, 2, '20 minutes', 'zrob parowki');
INSERT INTO fit_planner.przepiskrok values (default, 6, 1, '34 minutes', 'wez rybe');
INSERT INTO fit_planner.przepiskrok values (default, 6, 2, '59 minutes', 'zrob sushi');

INSERT INTO fit_planner.kategoriaprzepisu values (default, 'kuchnia polska');
INSERT INTO fit_planner.kategoriaprzepisu values (default, 'kuchnia azjatycka');
INSERT INTO fit_planner.kategoriaprzepisu values (default, 'kuchnia studencka');

INSERT INTO fit_planner.skladnikkategoria values (default, 'nabial');
INSERT INTO fit_planner.skladnikkategoria values (default, 'mieso');
INSERT INTO fit_planner.skladnikkategoria values (default, 'suche');
INSERT INTO fit_planner.skladnikkategoria values (default, 'warzywo');

INSERT INTO fit_planner.przepis_has_kategoriaprzepisu values (1, 1);
INSERT INTO fit_planner.przepis_has_kategoriaprzepisu values (2, 3);
INSERT INTO fit_planner.przepis_has_kategoriaprzepisu values (3, 3);
INSERT INTO fit_planner.przepis_has_kategoriaprzepisu values (4, 3);
INSERT INTO fit_planner.przepis_has_kategoriaprzepisu values (5, 1);
INSERT INTO fit_planner.przepis_has_kategoriaprzepisu values (5, 3);
INSERT INTO fit_planner.przepis_has_kategoriaprzepisu values (6, 2);

INSERT INTO fit_planner.skladnik_has_skladnikkategoria values (1, 3);
INSERT INTO fit_planner.skladnik_has_skladnikkategoria values (2, 4);
INSERT INTO fit_planner.skladnik_has_skladnikkategoria values (3, 1);
INSERT INTO fit_planner.skladnik_has_skladnikkategoria values (4, 3);
INSERT INTO fit_planner.skladnik_has_skladnikkategoria values (5, 2);
INSERT INTO fit_planner.skladnik_has_skladnikkategoria values (6, 3);
INSERT INTO fit_planner.skladnik_has_skladnikkategoria values (7, 3);
INSERT INTO fit_planner.skladnik_has_skladnikkategoria values (7, 2);

INSERT INTO fit_planner.skladnik_has_dostawca values (1, 1, 5, 100);
INSERT INTO fit_planner.skladnik_has_dostawca values (2, 2, 20, 300);
INSERT INTO fit_planner.skladnik_has_dostawca values (3, 3, 30, 400);
INSERT INTO fit_planner.skladnik_has_dostawca values (4, 3, 45, 500);
INSERT INTO fit_planner.skladnik_has_dostawca values (5, 2, 10, 300);
INSERT INTO fit_planner.skladnik_has_dostawca values (6, 1, 2, 30);
INSERT INTO fit_planner.skladnik_has_dostawca values (7, 3, 20, 1000);
INSERT INTO fit_planner.skladnik_has_dostawca values (8, 2, 30, 300);
INSERT INTO fit_planner.skladnik_has_dostawca values (9, 1, 100, 30);
INSERT INTO fit_planner.skladnik_has_dostawca values (1, 3, 20, 200);
INSERT INTO fit_planner.skladnik_has_dostawca values (3, 2, 30, 300);
INSERT INTO fit_planner.skladnik_has_dostawca values (2, 1, 10, 10);

INSERT INTO fit_planner.przepis_has_skladnik values (1, 1, 100);
INSERT INTO fit_planner.przepis_has_skladnik values (1, 2, 200);
INSERT INTO fit_planner.przepis_has_skladnik values (2, 2, 300);
INSERT INTO fit_planner.przepis_has_skladnik values (2, 9, 400);
INSERT INTO fit_planner.przepis_has_skladnik values (3, 3, 400);
INSERT INTO fit_planner.przepis_has_skladnik values (3, 4, 200);
INSERT INTO fit_planner.przepis_has_skladnik values (4, 4, 100);
INSERT INTO fit_planner.przepis_has_skladnik values (5, 3, 140);
INSERT INTO fit_planner.przepis_has_skladnik values (5, 6, 500);
INSERT INTO fit_planner.przepis_has_skladnik values (6, 7, 300);
INSERT INTO fit_planner.przepis_has_skladnik values (6, 8, 200);

INSERT INTO fit_planner.dieta_has_dziennyplan values (1, 1, 1);
INSERT INTO fit_planner.dieta_has_dziennyplan values (2, 2, 1);
INSERT INTO fit_planner.dieta_has_dziennyplan values (3, 3, 1);
INSERT INTO fit_planner.dieta_has_dziennyplan values (1, 3, 2);
INSERT INTO fit_planner.dieta_has_dziennyplan values (2, 4, 2);
INSERT INTO fit_planner.dieta_has_dziennyplan values (3, 5, 2);

INSERT INTO fit_planner.dziennyplan_has_przepis values (1, 1, 'rano');
INSERT INTO fit_planner.dziennyplan_has_przepis values (2, 1, 'rano');
INSERT INTO fit_planner.dziennyplan_has_przepis values (1, 3, 'wieczorem');
INSERT INTO fit_planner.dziennyplan_has_przepis values (2, 2, 'wieczorem');
INSERT INTO fit_planner.dziennyplan_has_przepis values (1, 2, 'w poludnie');
INSERT INTO fit_planner.dziennyplan_has_przepis values (2, 3, 'w poludnie');
INSERT INTO fit_planner.dziennyplan_has_przepis values (4, 4, 'rano');
INSERT INTO fit_planner.dziennyplan_has_przepis values (5, 1, 'rano');
INSERT INTO fit_planner.dziennyplan_has_przepis values (5, 2, 'wieczorem');
INSERT INTO fit_planner.dziennyplan_has_przepis values (2, 4, 'wieczorem');
INSERT INTO fit_planner.dziennyplan_has_przepis values (4, 6, 'w poludnie');
INSERT INTO fit_planner.dziennyplan_has_przepis values (3, 5, 'w poludnie');