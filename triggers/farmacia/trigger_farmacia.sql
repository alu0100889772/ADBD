CREATE OR REPLACE FUNCTION compra_medicamento() RETURNS trigger AS $compra_medicamento$
    	BEGIN
		UPDATE "mydbFarmacia"."COMPRA"
		SET  "importe" = "importe" + NEW."importe_linea"
			WHERE NEW."COMPRA_anio" = "mydbFarmacia"."COMPRA"."anio" AND NEW."COMPRA_mes" = "mydbFarmacia"."COMPRA"."mes" AND NEW."COMPRA_dia" = "mydbFarmacia"."COMPRA"."dia"
			AND NEW."COMPRA_minuto" = "mydbFarmacia"."COMPRA"."minuto" AND NEW."COMPRA_segundo" = "mydbFarmacia"."COMPRA"."segundo";

	RETURN NULL;
	END;
$compra_medicamento$ LANGUAGE plpgsql;


CREATE TRIGGER compra_medicamento AFTER INSERT ON "mydbFarmacia"."COMPRA_MEDICAMENTOS"
	FOR EACH ROW EXECUTE PROCEDURE compra_medicamento();
