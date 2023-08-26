-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema tienda
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tienda
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tienda` DEFAULT CHARACTER SET utf8mb4 ;
USE `tienda` ;

-- -----------------------------------------------------
-- Table `tienda`.`direcciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`direcciones` (
  `id_direccion` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(100) NOT NULL,
  `numero` TINYINT(4) NULL DEFAULT NULL,
  `piso` VARCHAR(10) NULL DEFAULT NULL,
  `puerta` VARCHAR(10) NULL DEFAULT NULL,
  `ciudad` VARCHAR(50) NOT NULL,
  `codigo_postal` VARCHAR(10) NOT NULL,
  `pais` VARCHAR(30) NOT NULL,
  INDEX `CodigoPostal_idx` (`codigo_postal` ASC)  ,
  PRIMARY KEY (`id_direccion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `tienda`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`clientes` (
  `id_cliente` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido1` VARCHAR(50) NOT NULL,
  `apellido2` VARCHAR(50) NOT NULL,
  `telefono` VARCHAR(20) NULL DEFAULT NULL,
  `correo_electronico` VARCHAR(100) NULL DEFAULT NULL,
  `fecha_registro` DATE NOT NULL,
  `id_cliente_recomendador` TINYINT(3) NULL DEFAULT NULL,
  `direcciones_id_direccion` INT NOT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `ID_Cliente_Recomendador` (`id_cliente_recomendador` ASC)  ,
  UNIQUE INDEX `Correo_Electronico_UNIQUE` (`correo_electronico` ASC)  ,
  UNIQUE INDEX `Telefono_UNIQUE` (`telefono` ASC)  ,
  INDEX `nombre_idx` (`nombre` ASC)  ,
  INDEX `apellido1_idx` (`apellido1` ASC)  ,
  INDEX `apellido2_idx` (`apellido2` ASC)  ,
  INDEX `fk_clientes_direcciones1_idx` (`direcciones_id_direccion` ASC)  ,
  CONSTRAINT `clientes_ibfk_2`
    FOREIGN KEY (`id_cliente_recomendador`)
    REFERENCES `tienda`.`clientes` (`id_cliente`),
  CONSTRAINT `fk_clientes_direcciones1`
    FOREIGN KEY (`direcciones_id_direccion`)
    REFERENCES `tienda`.`direcciones` (`id_direccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `tienda`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`empleados` (
  `id_empleado` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido1` VARCHAR(50) NOT NULL,
  `apellido2` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_empleado`),
  INDEX `nombreEmpleado_idx` (`nombre` ASC)  ,
  INDEX `apellido1_idx` (`apellido1` ASC)  ,
  INDEX `apellido2_idx` (`apellido2` ASC)  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `tienda`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`proveedores` (
  `id_proveedor` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `fax` VARCHAR(20) NULL DEFAULT NULL,
  `nif` VARCHAR(15) NOT NULL,
  `direcciones_id_direccion` INT NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  UNIQUE INDEX `NIF_UNIQUE` (`nif` ASC)  ,
  UNIQUE INDEX `Nombre_UNIQUE` (`nombre` ASC)  ,
  INDEX `fk_proveedores_direcciones1_idx` (`direcciones_id_direccion` ASC)  ,
  CONSTRAINT `fk_proveedores_direcciones1`
    FOREIGN KEY (`direcciones_id_direccion`)
    REFERENCES `tienda`.`direcciones` (`id_direccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `tienda`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`gafas` (
  `id_gafa` TINYINT(3) NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(50) NOT NULL,
  `graduacion_lente1` FLOAT NULL DEFAULT NULL,
  `graduacion_lente2` FLOAT NULL DEFAULT NULL,
  `tipo_montura` ENUM('flotante', 'pasta', 'metalica') NOT NULL,
  `color_montura` VARCHAR(20) NOT NULL,
  `color_lente1` VARCHAR(15) NULL DEFAULT NULL,
  `color_lente2` VARCHAR(15) NULL DEFAULT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `proveedores_id_proveedor` TINYINT(3) NOT NULL,
  PRIMARY KEY (`id_gafa`),
  INDEX `fk_gafas_proveedores1_idx` (`proveedores_id_proveedor` ASC) IN ,
  INDEX `marca_idx` (`marca` ASC)  ,
  UNIQUE INDEX `marca_UNIQUE` (`marca` ASC)  ,
  CONSTRAINT `fk_gafas_proveedores1`
    FOREIGN KEY (`proveedores_id_proveedor`)
    REFERENCES `tienda`.`proveedores` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `tienda`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`ventas` (
  `id_venta` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fecha_venta` DATE NOT NULL,
  `gafas_id_gafa` TINYINT(3) NOT NULL,
  `empleados_id_empleado` TINYINT(3) NOT NULL,
  `clientes_id_cliente` TINYINT(3) NOT NULL,
  PRIMARY KEY (`id_venta`),
  INDEX `fk_ventas_gafas1_idx` (`gafas_id_gafa` ASC)  ,
  INDEX `fk_ventas_empleados1_idx` (`empleados_id_empleado` ASC)  ,
  INDEX `fk_ventas_clientes1_idx` (`clientes_id_cliente` ASC)  ,
  INDEX `fecha_idx` (`fecha_venta` ASC)  ,
  CONSTRAINT `fk_ventas_gafas1`
    FOREIGN KEY (`gafas_id_gafa`)
    REFERENCES `tienda`.`gafas` (`id_gafa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_empleados1`
    FOREIGN KEY (`empleados_id_empleado`)
    REFERENCES `tienda`.`empleados` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_clientes1`
    FOREIGN KEY (`clientes_id_cliente`)
    REFERENCES `tienda`.`clientes` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
