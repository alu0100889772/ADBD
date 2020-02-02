delimiter //
CREATE TRIGGER vipear AFTER INSERT ON HOSPEDA
FOR EACH ROW
BEGIN
        -- Contar si un cliente se ha alojado más de 10 veces
        -- Eso es: Si aparece más de 10 veces en la tabla hospeda
        IF (   (SELECT COUNT(*) 
                FROM HOSPEDA
                WHERE dniHospeda = NEW.dniHospeda
                GROUP BY dniHospeda)  >= 10) 
                THEN
                UPDATE CLIENTE
                        SET CLIENTE.categoriaCliente = "VIP"
                        WHERE CLIENTE.dniCliente = NEW.dniHospeda;
        END IF;
END;//

----------------------
----------------------
----------------------
----------------------


delimiter //
CREATE TRIGGER solopuedeservip BEFORE UPDATE ON CLIENTE 
FOR EACH ROW 
BEGIN
DECLARE var_dniCliente VARCHAR(9);
DECLARE var_numeroCliente INTEGER;
DECLARE var_fechaNacimientoCliente DATE;
DECLARE var_nombreCliente VARCHAR(30);
DECLARE var_categoriaCliente VARCHAR(15);

SET var_dniCliente = NEW.dniCliente;
SET var_numeroCliente = NEW.numeroCliente;
SET var_fechaNacimientoCliente = NEW.fechaNacimientoCliente;
SET var_nombreCliente = NEW.nombreCliente;
SET var_categoriaCliente = NEW.categoriaCliente;



        -- Solo se puede ser VIP si se tienen menos 
        -- de 2 incidencias
        IF  (  (SELECT COUNT(*) 
        FROM INCIDENCIA
        WHERE dniIncidencia = NEW.dniCliente
        GROUP BY dniIncidencia)  >= 2) THEN
                SET var_categoriaCliente = "noVIP";
        END IF;

SET NEW.categoriaCliente = var_categoriaCliente;

END;//


----------------------
----------------------
----------------------
----------------------

delimiter //
CREATE TRIGGER desvipear AFTER INSERT ON INCIDENCIA 
FOR EACH ROW 
BEGIN

        IF  ((SELECT COUNT(*) 
        FROM INCIDENCIA
        WHERE dniIncidencia = NEW.dniIncidencia
        GROUP BY dniIncidencia)  >= 2)

        THEN
                UPDATE CLIENTE
                SET CLIENTE.categoriaCliente = "noVIP"
                WHERE CLIENTE.dniCliente = NEW.dniIncidencia;
        END IF;
END;//
