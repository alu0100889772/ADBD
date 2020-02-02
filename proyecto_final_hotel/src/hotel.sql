-- MySQL Script generated by MySQL Workbench
-- jue 30 ene 2020 18:38:20 WET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema hotelbdd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hotelbdd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hotelbdd` DEFAULT CHARACTER SET utf8 ;
USE `hotelbdd` ;

-- -----------------------------------------------------
-- Table `hotelbdd`.`CLIENTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotelbdd`.`CLIENTE` ;

CREATE TABLE IF NOT EXISTS `hotelbdd`.`CLIENTE` (
  `dniCliente` VARCHAR(9) NOT NULL,
  `numeroCliente` INT NOT NULL,
  `fechaNacimientoCliente` DATE NULL DEFAULT NULL,
  `nombreCliente` VARCHAR(30) NULL DEFAULT NULL,
  `categoriaCliente` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`dniCliente`, `numeroCliente`),
  INDEX `dni_idx` (`dniCliente` ASC),
  INDEX `numeroCliente_idx` (`numeroCliente` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelbdd`.`HABITACION`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotelbdd`.`HABITACION` ;

CREATE TABLE IF NOT EXISTS `hotelbdd`.`HABITACION` (
  `tipoHabitacion` VARCHAR(45) NULL DEFAULT NULL,
  `numeroHabitacion` INT NOT NULL,
  PRIMARY KEY (`numeroHabitacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelbdd`.`HOSPEDA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotelbdd`.`HOSPEDA` ;

CREATE TABLE IF NOT EXISTS `hotelbdd`.`HOSPEDA` (
  `fechaIni` DATETIME NOT NULL,
  `fechaFin` DATETIME NOT NULL,
  `dniHospeda` VARCHAR(9) NOT NULL,
  `numeroHab` INT NOT NULL,
  `numeroClient` INT NOT NULL,
  PRIMARY KEY (`fechaIni`, `fechaFin`, `dniHospeda`, `numeroHab`, `numeroClient`),
  INDEX `dni_idx` (`dniHospeda` ASC),
  INDEX `numeroCliente_idx` (`numeroClient` ASC),
  INDEX `numeroHabitacion_idx` (`numeroHab` ASC),
  CONSTRAINT `dniHospedajeFK`
    FOREIGN KEY (`dniHospeda` , `numeroClient`)
    REFERENCES `hotelbdd`.`CLIENTE` (`dniCliente` , `numeroCliente`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `numeroHabitacionFK`
    FOREIGN KEY (`numeroHab`)
    REFERENCES `hotelbdd`.`HABITACION` (`numeroHabitacion`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelbdd`.`INCIDENCIA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotelbdd`.`INCIDENCIA` ;

CREATE TABLE IF NOT EXISTS `hotelbdd`.`INCIDENCIA` (
  `numeroIncidencia` INT NOT NULL,
  `tipoIncidencia` VARCHAR(45) NULL DEFAULT NULL,
  `dniIncidencia` VARCHAR(9) NOT NULL,
  `descripcionIncidencia` TEXT NULL DEFAULT NULL,
  `numeroClienteIncidencia` INT NOT NULL,
  PRIMARY KEY (`numeroIncidencia`, `dniIncidencia`, `numeroClienteIncidencia`),
  INDEX `dni_idx` (`dniIncidencia` ASC),
  INDEX `numeroCliente_idx` (`numeroClienteIncidencia` ASC),
  CONSTRAINT `dniIncidenciaFK`
    FOREIGN KEY (`dniIncidencia` , `numeroClienteIncidencia`)
    REFERENCES `hotelbdd`.`CLIENTE` (`dniCliente` , `numeroCliente`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelbdd`.`INSTALACION`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotelbdd`.`INSTALACION` ;

CREATE TABLE IF NOT EXISTS `hotelbdd`.`INSTALACION` (
  `idInstalacion` INT NOT NULL,
  `nombreInstalacion` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idInstalacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelbdd`.`ENSER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotelbdd`.`ENSER` ;

CREATE TABLE IF NOT EXISTS `hotelbdd`.`ENSER` (
  `idEnser` INT NOT NULL AUTO_INCREMENT,
  `aval` VARCHAR(9) NOT NULL,
  `idInstalacion` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idEnser`, `aval`),
  INDEX `idInstalacion_idx` (`idInstalacion` ASC),
  CONSTRAINT `idInstalacionEnser`
    FOREIGN KEY (`idInstalacion`)
    REFERENCES `hotelbdd`.`INSTALACION` (`idInstalacion`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelbdd`.`RENTA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotelbdd`.`RENTA` ;

CREATE TABLE IF NOT EXISTS `hotelbdd`.`RENTA` (
  `fechaIniRenta` DATETIME NOT NULL,
  `fechaFinRenta` DATETIME NOT NULL,
  `dniRenta` VARCHAR(9) NOT NULL,
  `numeroCliente` INT NOT NULL,
  `idEnser` INT NOT NULL,
  PRIMARY KEY (`fechaIniRenta`, `fechaFinRenta`, `dniRenta`, `numeroCliente`, `idEnser`),
  INDEX `dni_idx` (`dniRenta` ASC),
  INDEX `numeroCliente_idx` (`numeroCliente` ASC),
  INDEX `IdEnser_idx` (`idEnser` ASC),
  CONSTRAINT `dniRentaFK`
    FOREIGN KEY (`dniRenta` , `numeroCliente`)
    REFERENCES `hotelbdd`.`CLIENTE` (`dniCliente` , `numeroCliente`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `IdEnserRenta`
    FOREIGN KEY (`idEnser`)
    REFERENCES `hotelbdd`.`ENSER` (`idEnser`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelbdd`.`PAGO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotelbdd`.`PAGO` ;

CREATE TABLE IF NOT EXISTS `hotelbdd`.`PAGO` (
  `idPago` INT NOT NULL,
  `monedaPago` VARCHAR(15) NULL DEFAULT NULL,
  `numCuentaPago` VARCHAR(24) NULL DEFAULT NULL,
  `cantidadPago` FLOAT NULL DEFAULT NULL,
  `conceptoPago` VARCHAR(15) NULL DEFAULT NULL,
  `metodoPago` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`idPago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelbdd`.`PAGO_CONSUMO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotelbdd`.`PAGO_CONSUMO` ;

CREATE TABLE IF NOT EXISTS `hotelbdd`.`PAGO_CONSUMO` (
  `idPagoConsumo` INT NOT NULL AUTO_INCREMENT,
  `dniPagoConsumo` VARCHAR(9) NULL DEFAULT NULL,
  `fechaPagoConsumo` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idPagoConsumo`),
  INDEX `dniPagoConsumo_idx` (`dniPagoConsumo` ASC),
  CONSTRAINT `idPagoConsumo`
    FOREIGN KEY (`idPagoConsumo`)
    REFERENCES `hotelbdd`.`PAGO` (`idPago`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `dniPagoConsumo`
    FOREIGN KEY (`dniPagoConsumo`)
    REFERENCES `hotelbdd`.`CLIENTE` (`dniCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelbdd`.`RESERVA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotelbdd`.`RESERVA` ;

CREATE TABLE IF NOT EXISTS `hotelbdd`.`RESERVA` (
  `idReserva` INT NOT NULL,
  `partnerReserva` VARCHAR(45) NULL DEFAULT NULL,
  `tarifaReserva` VARCHAR(15) NULL DEFAULT NULL,
  `usoReserva` VARCHAR(15) NULL DEFAULT NULL,
  `fechaReserva` DATETIME NULL DEFAULT NULL,
  `fechaIniHospedaje` DATETIME NULL DEFAULT NULL,
  `fechaFinHospedaje` DATETIME NULL DEFAULT NULL,
  `numeroHabitacion` INT NULL DEFAULT NULL,
  `dniReserva` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`idReserva`, `dniReserva`),
  INDEX `numeroHabitacion_idx` (`numeroHabitacion` ASC),
  INDEX `dni_idx` (`dniReserva` ASC),
  CONSTRAINT `numeroHabitacionReservaFK`
    FOREIGN KEY (`numeroHabitacion`)
    REFERENCES `hotelbdd`.`HABITACION` (`numeroHabitacion`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `dniReservaFK`
    FOREIGN KEY (`dniReserva`)
    REFERENCES `hotelbdd`.`CLIENTE` (`dniCliente`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `hotelbdd`.`PAGO_HOSPEDAJE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotelbdd`.`PAGO_HOSPEDAJE` ;

CREATE TABLE IF NOT EXISTS `hotelbdd`.`PAGO_HOSPEDAJE` (
  `idPagoHospedaje` INT NOT NULL,
  `idReservaPagoHospedaje` INT NULL DEFAULT NULL,
  `fechaIniPagoHospedaje` DATETIME NULL DEFAULT NULL,
  `fechaFinPagoHospedaje` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idPagoHospedaje`),
  INDEX `idReserva_idx` (`idReservaPagoHospedaje` ASC),
  CONSTRAINT `idPagoHospedaje`
    FOREIGN KEY (`idPagoHospedaje`)
    REFERENCES `hotelbdd`.`PAGO` (`idPago`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `idReservaHospedaje`
    FOREIGN KEY (`idReservaPagoHospedaje`)
    REFERENCES `hotelbdd`.`RESERVA` (`idReserva`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelbdd`.`HORARIOS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotelbdd`.`HORARIOS` ;

CREATE TABLE IF NOT EXISTS `hotelbdd`.`HORARIOS` (
  `idInst` INT NOT NULL,
  `horaInicio` TIME NOT NULL,
  `horaFin` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idInst`, `horaInicio`, `horaFin`),
  CONSTRAINT `idInstalacionHorarios`
    FOREIGN KEY (`idInst`)
    REFERENCES `hotelbdd`.`INSTALACION` (`idInstalacion`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelbdd`.`EMPLEADO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotelbdd`.`EMPLEADO` ;

CREATE TABLE IF NOT EXISTS `hotelbdd`.`EMPLEADO` (
  `dniEmpleado` VARCHAR(9) NOT NULL,
  `tipoServicio` VARCHAR(15) NULL DEFAULT NULL,
  `nombreEmpleado` VARCHAR(45) NULL DEFAULT NULL,
  `nominaEmpleado` FLOAT NULL DEFAULT NULL,
  `tipoEmpleado` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`dniEmpleado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelbdd`.`TRABAJA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotelbdd`.`TRABAJA` ;

CREATE TABLE IF NOT EXISTS `hotelbdd`.`TRABAJA` (
  `dniTrabajador` VARCHAR(9) NOT NULL,
  `idIns` INT NOT NULL,
  `fechaInicio` DATE NOT NULL,
  `fechaFin` DATE NOT NULL,
  `turnoEmpleado` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`dniTrabajador`, `fechaInicio`, `fechaFin`),
  INDEX `idInstalacion_idx` (`idIns` ASC),
  CONSTRAINT `dniTrabaja`
    FOREIGN KEY (`dniTrabajador`)
    REFERENCES `hotelbdd`.`EMPLEADO` (`dniEmpleado`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `idInstalacionTrabaja`
    FOREIGN KEY (`idIns`)
    REFERENCES `hotelbdd`.`INSTALACION` (`idInstalacion`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
