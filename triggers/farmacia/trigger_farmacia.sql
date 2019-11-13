CREATE OR REPLACE FUNCTION laboratorio_propio() RETURNS trigger AS $laboratorio_propio$
    BEGIN
        UPDATE "mydbFarmacia"."MEDICAMENTOS"
            SET "laboratorio" = 0
                WHERE "mydbFarmacia"."MEDICAMENTOS"."laboratorio" IS NULL;
        RETURN NULL;
    END;
$laboratorio_propio$ LANGUAGE plpgsql;


CREATE TRIGGER laboratorio_propio BEFORE INSERT ON "mydbFarmacia"."MEDICAMENTOS"
    FOR EACH ROW EXECUTE PROCEDURE laboratorio_propio();
