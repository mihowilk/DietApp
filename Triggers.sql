CREATE FUNCTION fit_planner.over_calories_limit() RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
DECLARE
    a FLOAT;
    b FLOAT;
BEGIN
        SELECT suma_kalorii INTO a FROM fit_planner.dziennyplan_stat WHERE dziennyplan_stat.iddziennyplan=NEW.dziennyplan_iddziennyplan;
        SELECT kalorie INTO b FROM fit_planner.przepis WHERE idprzepis=NEW.przepis_idprzepis;
        IF a+b>2000 THEN
            RAISE EXCEPTION 'Przekroczony limit kalorii';
        ELSE
            RETURN NEW;
        END IF;
    END;
$$;

CREATE TRIGGER excess_calories BEFORE INSERT ON fit_planner.dziennyplan_has_przepis
    FOR EACH ROW EXECUTE PROCEDURE fit_planner.over_calories_limit();



CREATE FUNCTION fit_planner.check_user_rate() RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
DECLARE
    a INT;
BEGIN
        SELECT uzytkownik_iduzytkownik INTO a FROM fit_planner.przepis WHERE przepis.idprzepis=NEW.przepis_idprzepis;
        IF a = NEW.uzytkownik_iduzytkownik THEN
            RAISE EXCEPTION 'Nie mozna wystawiac oceny samemu sobie';
        ELSE
            RETURN NEW;
        END IF;
    END;
$$;

CREATE TRIGGER forbid_self_rate BEFORE INSERT ON fit_planner.ocena
    FOR EACH ROW EXECUTE PROCEDURE fit_planner.check_user_rate();

