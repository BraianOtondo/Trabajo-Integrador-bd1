-- MySQL Script generated by MySQL Workbench
-- Thu Oct 14 19:32:41 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema automotriz
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `automotriz` ;

-- -----------------------------------------------------
-- Schema automotriz
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `automotriz` DEFAULT CHARACTER SET utf8 ;
USE automotriz;

-- -----------------------------------------------------
-- Table `automotriz`.`insumo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`insumo` (
  `id_insumo` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id_insumo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `automotriz`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`proveedor` (
  `id_proveedor` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `telefono` VARCHAR(30) NULL,
  `mail` VARCHAR(40) NULL,
  PRIMARY KEY (`id_proveedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `automotriz`.`modelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`modelo` (
  `id_modelo` INT NOT NULL,
  `nombre` VARCHAR(30) NULL,
  PRIMARY KEY (`id_modelo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `automotriz`.`concesionaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`concesionaria` (
  `cuit_concesionaria` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`cuit_concesionaria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `automotriz`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`pedido` (
  `id_pedido` INT NOT NULL,
  `concesionaria_cuit_concesionaria` INT NOT NULL,
  PRIMARY KEY (`id_pedido`),
  CONSTRAINT `fk_pedido_concesionaria1`
    FOREIGN KEY (`concesionaria_cuit_concesionaria`)
    REFERENCES `automotriz`.`concesionaria` (`cuit_concesionaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_pedido_concesionaria1_idx` ON `automotriz`.`pedido` (`concesionaria_cuit_concesionaria` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `automotriz`.`detalle_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`detalle_pedido` (
  `modelo_id_modelo` INT NOT NULL,
  `pedido_id_pedido` INT NOT NULL,
  `cantidad` INT NULL,
  PRIMARY KEY (`modelo_id_modelo`, `pedido_id_pedido`),
  CONSTRAINT `fk_modelo_has_pedido_modelo1`
    FOREIGN KEY (`modelo_id_modelo`)
    REFERENCES `automotriz`.`modelo` (`id_modelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_modelo_has_pedido_pedido1`
    FOREIGN KEY (`pedido_id_pedido`)
    REFERENCES `automotriz`.`pedido` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_modelo_has_pedido_pedido1_idx` ON `automotriz`.`detalle_pedido` (`pedido_id_pedido` ASC) VISIBLE;

CREATE INDEX `fk_modelo_has_pedido_modelo1_idx` ON `automotriz`.`detalle_pedido` (`modelo_id_modelo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `automotriz`.`linea_de_montaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`linea_de_montaje` (
  `id_linea` INT NOT NULL,
  `capacidad` INT NULL,
  `modelo_id_modelo` INT NOT NULL,
  PRIMARY KEY (`id_linea`),
  CONSTRAINT `fk_linea_de_montaje_modelo1`
    FOREIGN KEY (`modelo_id_modelo`)
    REFERENCES `automotriz`.`modelo` (`id_modelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_linea_de_montaje_modelo1_idx` ON `automotriz`.`linea_de_montaje` (`modelo_id_modelo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `automotriz`.`automovil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`automovil` (
  `nro_chasis` INT NOT NULL,
  `precio` DECIMAL NULL,
  `detalle_pedido_modelo_id_modelo` INT NOT NULL,
  `detalle_pedido_pedido_id_pedido` INT NOT NULL,
  `id_linea_asignada` INT NOT NULL,
  PRIMARY KEY (`nro_chasis`),
  CONSTRAINT `fk_automovil_detalle_pedido1`
    FOREIGN KEY (`detalle_pedido_modelo_id_modelo` , `detalle_pedido_pedido_id_pedido`)
    REFERENCES `automotriz`.`detalle_pedido` (`modelo_id_modelo` , `pedido_id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_automovil_linea_de_montaje1`
    FOREIGN KEY (`id_linea_asignada`)
    REFERENCES `automotriz`.`linea_de_montaje` (`id_linea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_automovil_detalle_pedido1_idx` ON `automotriz`.`automovil` (`detalle_pedido_modelo_id_modelo` ASC, `detalle_pedido_pedido_id_pedido` ASC) VISIBLE;

CREATE INDEX `fk_automovil_linea_de_montaje1_idx` ON `automotriz`.`automovil` (`id_linea_asignada` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `automotriz`.`estacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`estacion` (
  `id_estacion` INT NOT NULL,
  `disponible` TINYINT NULL,
  `linea_de_montaje_id_linea` INT NOT NULL,
  PRIMARY KEY (`id_estacion`),
  CONSTRAINT `fk_estacion_linea_de_montaje1`
    FOREIGN KEY (`linea_de_montaje_id_linea`)
    REFERENCES `automotriz`.`linea_de_montaje` (`id_linea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_estacion_linea_de_montaje1_idx` ON `automotriz`.`estacion` (`linea_de_montaje_id_linea` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `automotriz`.`tarea`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`tarea` (
  `id_tarea` INT NOT NULL,
  `nombre` VARCHAR(30) NULL,
  `descripcion` VARCHAR(60) NULL,
  `estacion_id_estacion` INT NOT NULL,
  PRIMARY KEY (`id_tarea`),
  CONSTRAINT `fk_tarea_estacion1`
    FOREIGN KEY (`estacion_id_estacion`)
    REFERENCES `automotriz`.`estacion` (`id_estacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tarea_estacion1_idx` ON `automotriz`.`tarea` (`estacion_id_estacion` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `automotriz`.`estacion_has_automovil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`estacion_has_automovil` (
  `estacion_id_estacion` INT NOT NULL,
  `automovil_nro_chasis` INT NOT NULL,
  `fecha_ingreso` DATETIME NOT NULL,
  `fecha_egreso` DATETIME NULL,
  PRIMARY KEY (`estacion_id_estacion`, `automovil_nro_chasis`),
  CONSTRAINT `fk_estacion_has_automovil_estacion1`
    FOREIGN KEY (`estacion_id_estacion`)
    REFERENCES `automotriz`.`estacion` (`id_estacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estacion_has_automovil_automovil1`
    FOREIGN KEY (`automovil_nro_chasis`)
    REFERENCES `automotriz`.`automovil` (`nro_chasis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_estacion_has_automovil_automovil1_idx` ON `automotriz`.`estacion_has_automovil` (`automovil_nro_chasis` ASC) VISIBLE;

CREATE INDEX `fk_estacion_has_automovil_estacion1_idx` ON `automotriz`.`estacion_has_automovil` (`estacion_id_estacion` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `automotriz`.`tarea_has_insumo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`tarea_has_insumo` (
  `tarea_id_tarea` INT NOT NULL,
  `insumo_id_insumo` INT NOT NULL,
  PRIMARY KEY (`tarea_id_tarea`, `insumo_id_insumo`),
  CONSTRAINT `fk_tarea_has_insumo1_tarea1`
    FOREIGN KEY (`tarea_id_tarea`)
    REFERENCES `automotriz`.`tarea` (`id_tarea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tarea_has_insumo1_insumo1`
    FOREIGN KEY (`insumo_id_insumo`)
    REFERENCES `automotriz`.`insumo` (`id_insumo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tarea_has_insumo1_insumo1_idx` ON `automotriz`.`tarea_has_insumo` (`insumo_id_insumo` ASC) VISIBLE;

CREATE INDEX `fk_tarea_has_insumo1_tarea1_idx` ON `automotriz`.`tarea_has_insumo` (`tarea_id_tarea` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `automotriz`.`insumo_has_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `automotriz`.`insumo_has_proveedor` (
  `insumo_id_insumo` INT NOT NULL,
  `proveedor_id_proveedor` INT NOT NULL,
  `precio` DECIMAL NULL,
  PRIMARY KEY (`insumo_id_insumo`, `proveedor_id_proveedor`),
  CONSTRAINT `fk_insumo_has_proveedor_insumo1`
    FOREIGN KEY (`insumo_id_insumo`)
    REFERENCES `automotriz`.`insumo` (`id_insumo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_insumo_has_proveedor_proveedor1`
    FOREIGN KEY (`proveedor_id_proveedor`)
    REFERENCES `automotriz`.`proveedor` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_insumo_has_proveedor_proveedor1_idx` ON `automotriz`.`insumo_has_proveedor` (`proveedor_id_proveedor` ASC) VISIBLE;

CREATE INDEX `fk_insumo_has_proveedor_insumo1_idx` ON `automotriz`.`insumo_has_proveedor` (`insumo_id_insumo` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
