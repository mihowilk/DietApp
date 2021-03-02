CREATE VIEW fit_planner.uzytkownik_stat AS SELECT *, uzytkownik.waga/(uzytkownik.wzrost*uzytkownik.wzrost)*10000 "bmi" FROM fit_planner.uzytkownik;

CREATE VIEW fit_planner.dziennyplan_stat AS SELECT iddziennyplan, SUM(kalorie) suma_kalorii, SUM(weglowodany) suma_weglowodanow, SUM(bialko) suma_bialka, SUM(tluszcz) suma_tluszczu FROM (SELECT iddziennyplan, kalorie, weglowodany, bialko, tluszcz FROM (select * from fit_planner.dziennyplan, fit_planner.dziennyplan_has_przepis WHERE iddziennyplan=dziennyplan_has_przepis.dziennyplan_iddziennyplan) a JOIN fit_planner.przepis ON (przepis_idprzepis=przepis.idprzepis)) b GROUP BY iddziennyplan;

CREATE VIEW fit_planner.przepis_stat AS SELECT idprzepis, uzytkownik_iduzytkownik, nazwa, poziom_trudnosci, czas_wykonania, czy_weganskie, kalorie, weglowodany, bialko, tluszcz, AVG(gwiazdka) srednia_ocena FROM (SELECT idprzepis, przepis.uzytkownik_iduzytkownik, nazwa, poziom_trudnosci, czas_wykonania, czy_weganskie, kalorie, weglowodany, bialko, tluszcz, gwiazdka FROM fit_planner.przepis LEFT JOIN fit_planner.ocena ON (idprzepis=ocena.przepis_idprzepis)) a GROUP BY idprzepis, uzytkownik_iduzytkownik, nazwa, poziom_trudnosci, czas_wykonania, czy_weganskie, kalorie, weglowodany, bialko, tluszcz;

CREATE VIEW fit_planner.lista_zakupow AS SELECT iddziennyplan, porcja, nazwa FROM (SELECT iddziennyplan, skladnik_idskladnik, porcja FROM (SELECT iddziennyplan, przepis_idprzepis FROM fit_planner.dziennyplan, fit_planner.dziennyplan_has_przepis WHERE iddziennyplan=dziennyplan_has_przepis.dziennyplan_iddziennyplan) a JOIN fit_planner.przepis_has_skladnik ON (a.przepis_idprzepis=przepis_has_skladnik.przepis_idprzepis)) b JOIN fit_planner.skladnik ON (b.skladnik_idskladnik=skladnik.idskladnik);