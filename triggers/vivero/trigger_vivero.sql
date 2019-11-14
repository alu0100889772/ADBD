CREATE OR REPLACE FUNCTION reducir_stock() RETURNS trigger AS $reducir_stock$
    BEGIN
        UPDATE "mydb"."PRODUCTO"
            SET stock = "mydb"."PRODUCTO"."stock" - NEW.cantidad
                WHERE "mydb"."PRODUCTO"."codigoProducto" = "codigoProducto";
	RETURN NULL;
    END;
$reducir_stock$ LANGUAGE plpgsql;


CREATE TRIGGER reducir_stock AFTER INSERT ON "mydb"."VENTAS"
    FOR EACH ROW EXECUTE PROCEDURE reducir_stock();
