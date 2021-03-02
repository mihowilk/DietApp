CREATE TABLE SkladnikKategoria (
  idSkladnikKategoria SERIAL PRIMARY KEY NOT NULL,
  nazwa VARCHAR(45) NOT NULL
);

CREATE TABLE Skladnik (
  idSkladnik SERIAL PRIMARY KEY NOT NULL,
  nazwa VARCHAR(45) NOT NULL
);

CREATE TABLE KategoriaPrzepisu (
  idKategoriaPrzepisu SERIAL PRIMARY KEY NOT NULL,
  nazwa VARCHAR(45) NOT NULL
);

CREATE TYPE poziom_trudnosci AS ENUM('latwy', 'sredni', 'trudny');

CREATE TABLE Przepis (
  idPrzepis SERIAL PRIMARY KEY NOT NULL,
  Uzytkownik_idUzytkownik INTEGER NOT NULL,
  nazwa VARCHAR(45) NOT NULL,
  poziom_trudnosci POZIOM_TRUDNOSCI NOT NULL,
  czas_wykonania INTERVAL NOT NULL CONSTRAINT dodatni_czas CHECK(czas_wykonania>INTERVAL '0' second),
  czy_weganskie BOOL NOT NULL,
  kalorie FLOAT NOT NULL CONSTRAINT dodatnie_kalorie CHECK(kalorie>0),
  weglowodany FLOAT NOT NULL CONSTRAINT dodatnie_weglowodany CHECK(weglowodany>0),
  bialko FLOAT NOT NULL CONSTRAINT dodatnie_bialko CHECK(bialko>0),
  tluszcz FLOAT NOT NULL CONSTRAINT dodatni_tluszcz CHECK(tluszcz>0)
--   srednia_ocena - jako widok
);

CREATE TABLE Dostawca (
  idDostawca SERIAL PRIMARY KEY NOT NULL,
  nazwa VARCHAR(45) NOT NULL,
  lokalizacja VARCHAR(45) NOT NULL
);

CREATE TABLE DziennyPlan (
  idDziennyPlan SERIAL PRIMARY KEY NOT NULL
--   suma_kalorie - jako widok
--   suma_weglowodany - jako widok
--   suma_bialko - jako widok
--   suma_tluszcz - jako widok
);

CREATE TABLE Dieta (
  idDieta SERIAL PRIMARY KEY NOT NULL,
  zmiana_wagi FLOAT NOT NULL,
  czas_na_zmiane INTERVAL NOT NULL CONSTRAINT dodatni_czas CHECK(czas_na_zmiane>INTERVAL '0' second)
);

CREATE TABLE PrzepisKrok (
  idPrzepisKrok SERIAL PRIMARY KEY NOT NULL,
  Przepis_idPrzepis INTEGER NOT NULL,
  numer_kroku INTEGER NOT NULL CONSTRAINT dodatni_numer CHECK(numer_kroku>0),
  czas_wykonania INTERVAL NOT NULL CONSTRAINT dodatni_czas CHECK(czas_wykonania>INTERVAL '0' second),
  instrukcja VARCHAR(255) NOT NULL
);

CREATE TABLE Uzytkownik (
  idUzytkownik SERIAL PRIMARY KEY NOT NULL,
  Dieta_idDieta INTEGER,
  imie VARCHAR(45) NOT NULL,
  nazwisko VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL CONSTRAINT email_used UNIQUE,
  haslo VARCHAR(45) NOT NULL,
  wzrost FLOAT NOT NULL CONSTRAINT poprawny_wzrost CHECK(wzrost>50 AND wzrost<250),
  waga FLOAT NOT NULL CONSTRAINT poprawna_waga CHECK(waga>25 AND waga<650)
--   bmi - jako widok
);

CREATE TABLE Przepis_has_KategoriaPrzepisu (
  Przepis_idPrzepis INTEGER NOT NULL,
  KategoriaPrzepisu_idKategoriaPrzepisu INTEGER NOT NULL,
  PRIMARY KEY (Przepis_idPrzepis, KategoriaPrzepisu_idKategoriaPrzepisu)
);

CREATE TABLE Przepis_has_Skladnik (
  Przepis_idPrzepis INTEGER NOT NULL,
  Skladnik_idSkladnik INTEGER NOT NULL,
  porcja FLOAT NOT NULL CONSTRAINT poprawna_porcja CHECK(porcja>0),
  PRIMARY KEY (Przepis_idPrzepis, Skladnik_idSkladnik)
);

CREATE TABLE Dieta_has_DziennyPlan (
  Dieta_idDieta INTEGER NOT NULL,
  DziennyPlan_idDziennyPlan INTEGER NOT NULL,
  numer_dnia INTEGER NOT NULL CONSTRAINT dodatni_numer CHECK(numer_dnia>0),
  PRIMARY KEY (Dieta_idDieta, DziennyPlan_idDziennyPlan)
);

CREATE TABLE DziennyPlan_has_Przepis (
  DziennyPlan_idDziennyPlan INTEGER NOT NULL,
  Przepis_idPrzepis INTEGER NOT NULL,
  pora_dnia VARCHAR(45) NOT NULL,
  PRIMARY KEY (DziennyPlan_idDziennyPlan, Przepis_idPrzepis)
);

CREATE TABLE Skladnik_has_SkladnikKategoria (
  Skladnik_idSkladnik INTEGER NOT NULL,
  SkladnikKategoria_idSkladnikKategoria INTEGER NOT NULL,
  PRIMARY KEY (Skladnik_idSkladnik, SkladnikKategoria_idSkladnikKategoria)
);

CREATE TABLE Ocena (
  idOcena SERIAL PRIMARY KEY NOT NULL,
  Uzytkownik_idUzytkownik INTEGER NOT NULL,
  Przepis_idPrzepis INTEGER NOT NULL,
  gwiazdka INTEGER NOT NULL CONSTRAINT zakres_ocen CHECK(gwiazdka>0 AND gwiazdka<6),
  komentarz VARCHAR(255)
);

CREATE TABLE Skladnik_has_Dostawca (
  Skladnik_idSkladnik INTEGER NOT NULL,
  Dostawca_idDostawca INTEGER NOT NULL,
  cena FLOAT NOT NULL CONSTRAINT cena_dodatnia CHECK(cena>0),
  ilosc FLOAT NOT NULL CONSTRAINT ilosc_dodatnia CHECK(ilosc>0),
  PRIMARY KEY (Skladnik_idSkladnik, Dostawca_idDostawca)
);

ALTER TABLE PrzepisKrok ADD FOREIGN KEY (Przepis_idPrzepis) REFERENCES Przepis (idPrzepis);

ALTER TABLE Uzytkownik ADD FOREIGN KEY (Dieta_idDieta) REFERENCES Dieta (idDieta);

ALTER TABLE Przepis_has_KategoriaPrzepisu ADD FOREIGN KEY (Przepis_idPrzepis) REFERENCES Przepis (idPrzepis);

ALTER TABLE Przepis_has_KategoriaPrzepisu ADD FOREIGN KEY (KategoriaPrzepisu_idKategoriaPrzepisu) REFERENCES KategoriaPrzepisu (idKategoriaPrzepisu);

ALTER TABLE Przepis_has_Skladnik ADD FOREIGN KEY (Przepis_idPrzepis) REFERENCES Przepis (idPrzepis);

ALTER TABLE Przepis_has_Skladnik ADD FOREIGN KEY (Skladnik_idSkladnik) REFERENCES Skladnik (idSkladnik);

ALTER TABLE Przepis ADD FOREIGN KEY (Uzytkownik_idUzytkownik) REFERENCES Uzytkownik (idUzytkownik);

ALTER TABLE Dieta_has_DziennyPlan ADD FOREIGN KEY (Dieta_idDieta) REFERENCES Dieta (idDieta);

ALTER TABLE Dieta_has_DziennyPlan ADD FOREIGN KEY (DziennyPlan_idDziennyPlan) REFERENCES DziennyPlan (idDziennyPlan);

ALTER TABLE DziennyPlan_has_Przepis ADD FOREIGN KEY (DziennyPlan_idDziennyPlan) REFERENCES DziennyPlan (idDziennyPlan);

ALTER TABLE DziennyPlan_has_Przepis ADD FOREIGN KEY (Przepis_idPrzepis) REFERENCES Przepis (idPrzepis);

ALTER TABLE Skladnik_has_SkladnikKategoria ADD FOREIGN KEY (Skladnik_idSkladnik) REFERENCES Skladnik (idSkladnik);

ALTER TABLE Skladnik_has_SkladnikKategoria ADD FOREIGN KEY (SkladnikKategoria_idSkladnikKategoria) REFERENCES SkladnikKategoria (idSkladnikKategoria);

ALTER TABLE Ocena ADD FOREIGN KEY (Uzytkownik_idUzytkownik) REFERENCES Uzytkownik (idUzytkownik);

ALTER TABLE Ocena ADD FOREIGN KEY (Przepis_idPrzepis) REFERENCES Przepis (idPrzepis);

ALTER TABLE Skladnik_has_Dostawca ADD FOREIGN KEY (Skladnik_idSkladnik) REFERENCES Skladnik (idSkladnik);

ALTER TABLE Skladnik_has_Dostawca ADD FOREIGN KEY (Dostawca_idDostawca) REFERENCES Dostawca (idDostawca);

CREATE INDEX Przepis_FKIndex1 ON Przepis (Uzytkownik_idUzytkownik);

CREATE INDEX IFK_Rel_22 ON Przepis (Uzytkownik_idUzytkownik);

CREATE INDEX PrzepisKrok_FKIndex1 ON PrzepisKrok (Przepis_idPrzepis);

CREATE INDEX IFK_Rel_05 ON PrzepisKrok (Przepis_idPrzepis);

CREATE INDEX Uzytkownik_FKIndex1 ON Uzytkownik (Dieta_idDieta);

CREATE INDEX IFK_Rel_08 ON Uzytkownik (Dieta_idDieta);

CREATE INDEX Przepis_has_KategoriaPrzepisu_FKIndex1 ON Przepis_has_KategoriaPrzepisu (Przepis_idPrzepis);

CREATE INDEX Przepis_has_KategoriaPrzepisu_FKIndex2 ON Przepis_has_KategoriaPrzepisu (KategoriaPrzepisu_idKategoriaPrzepisu);

CREATE INDEX IFK_Rel_06 ON Przepis_has_KategoriaPrzepisu (Przepis_idPrzepis);

CREATE INDEX IFK_Rel_07 ON Przepis_has_KategoriaPrzepisu (KategoriaPrzepisu_idKategoriaPrzepisu);

CREATE INDEX Przepis_has_Skladnik_FKIndex1 ON Przepis_has_Skladnik (Przepis_idPrzepis);

CREATE INDEX Przepis_has_Skladnik_FKIndex2 ON Przepis_has_Skladnik (Skladnik_idSkladnik);

CREATE INDEX IFK_Rel_10 ON Przepis_has_Skladnik (Przepis_idPrzepis);

CREATE INDEX IFK_Rel_11 ON Przepis_has_Skladnik (Skladnik_idSkladnik);

CREATE INDEX Dieta_has_DziennyPlan_FKIndex1 ON Dieta_has_DziennyPlan (Dieta_idDieta);

CREATE INDEX Dieta_has_DziennyPlan_FKIndex2 ON Dieta_has_DziennyPlan (DziennyPlan_idDziennyPlan);

CREATE INDEX IFK_Rel_01 ON Dieta_has_DziennyPlan (Dieta_idDieta);

CREATE INDEX IFK_Rel_02 ON Dieta_has_DziennyPlan (DziennyPlan_idDziennyPlan);

CREATE INDEX DziennyPlan_has_Przepis_FKIndex1 ON DziennyPlan_has_Przepis (DziennyPlan_idDziennyPlan);

CREATE INDEX DziennyPlan_has_Przepis_FKIndex2 ON DziennyPlan_has_Przepis (Przepis_idPrzepis);

CREATE INDEX IFK_Rel_03 ON DziennyPlan_has_Przepis (DziennyPlan_idDziennyPlan);

CREATE INDEX IFK_Rel_04 ON DziennyPlan_has_Przepis (Przepis_idPrzepis);

CREATE INDEX Skladnik_has_SkladnikKategoria_FKIndex1 ON Skladnik_has_SkladnikKategoria (Skladnik_idSkladnik);

CREATE INDEX Skladnik_has_SkladnikKategoria_FKIndex2 ON Skladnik_has_SkladnikKategoria (SkladnikKategoria_idSkladnikKategoria);

CREATE INDEX IFK_Rel_14 ON Skladnik_has_SkladnikKategoria (Skladnik_idSkladnik);

CREATE INDEX IFK_Rel_15 ON Skladnik_has_SkladnikKategoria (SkladnikKategoria_idSkladnikKategoria);

CREATE INDEX Ocena_FKIndex1 ON Ocena (Przepis_idPrzepis);

CREATE INDEX Ocena_FKIndex2 ON Ocena (Uzytkownik_idUzytkownik);

CREATE INDEX IFK_Rel_18 ON Ocena (Przepis_idPrzepis);

CREATE INDEX IFK_Rel_19 ON Ocena (Uzytkownik_idUzytkownik);

CREATE INDEX Skladnik_has_Dostawca_FKIndex1 ON Skladnik_has_Dostawca (Skladnik_idSkladnik);

CREATE INDEX Skladnik_has_Dostawca_FKIndex2 ON Skladnik_has_Dostawca (Dostawca_idDostawca);

CREATE INDEX IFK_Rel_12 ON Skladnik_has_Dostawca (Skladnik_idSkladnik);

CREATE INDEX IFK_Rel_13 ON Skladnik_has_Dostawca (Dostawca_idDostawca);
