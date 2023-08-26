-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema pizzeriatest
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeriatest
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeriatest` DEFAULT CHARACTER SET utf8mb4 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `pizzeriatest`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeriatest`.`clientes` (
  `ID_Cliente` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(50) NOT NULL,
  `Apellido1` VARCHAR(50) NOT NULL,
  `Apellido2` VARCHAR(50) NOT NULL,
  `Telefono` VARCHAR(20) NULL,
  PRIMARY KEY (`ID_Cliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizzeriatest`.`tiendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeriatest`.`tiendas` (
  `ID_Tienda` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Direccion` VARCHAR(100) NOT NULL,
  `CodigoPostal` VARCHAR(10) NOT NULL,
  `Localidad` VARCHAR(50) NOT NULL,
  `Provincia` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID_Tienda`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `mydb`.`direcciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`direcciones` (
  `ID_dirrecion` INT NOT NULL,
  `Direccion` VARCHAR(100) NOT NULL,
  `CodigoPostal` VARCHAR(10) NOT NULL,
  `Localidad` VARCHAR(50) NOT NULL,
  `Provincia` VARCHAR(50) NOT NULL,
  `clientes_ID_Cliente` TINYINT(3) NULL,
  `tiendas_ID_Tienda` TINYINT(3) NULL,
  PRIMARY KEY (`ID_dirrecion`),
  INDEX `fk_direcciones_clientes_idx` (`clientes_ID_Cliente` ASC),
  INDEX `fk_direcciones_tiendas1_idx` (`tiendas_ID_Tienda` ASC),
  CONSTRAINT `fk_direcciones_clientes`
    FOREIGN KEY (`clientes_ID_Cliente`)
    REFERENCES `pizzeriatest`.`clientes` (`ID_Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_direcciones_tiendas1`
    FOREIGN KEY (`tiendas_ID_Tienda`)
    REFERENCES `pizzeriatest`.`tiendas` (`ID_Tienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `pizzeriatest`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeriatest`.`pedidos` (
  `ID_Pedido` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `FechaHora` DATETIME NOT NULL,
  `Tipo` ENUM('domicilio', 'recoger') NOT NULL,
  `ID_Cliente` TINYINT(3) UNSIGNED NOT NULL,
  `ID_Tienda` TINYINT(3) UNSIGNED NOT NULL,
  `PrecioTotal` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`ID_Pedido`),
  INDEX `ID_Cliente` (`ID_Cliente` ASC)  ,
  INDEX `ID_Tienda` (`ID_Tienda` ASC)  ,
  CONSTRAINT `pedidos_ibfk_1`
    FOREIGN KEY (`ID_Cliente`)
    REFERENCES `pizzeriatest`.`clientes` (`ID_Cliente`),
  CONSTRAINT `pedidos_ibfk_2`
    FOREIGN KEY (`ID_Tienda`)
    REFERENCES `pizzeriatest`.`tiendas` (`ID_Tienda`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizzeriatest`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeriatest`.`empleados` (
  `ID_Empleado` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(50) NOT NULL,
  `Apellido1` VARCHAR(50) NOT NULL,
  `Apellido2` VARCHAR(50) NOT NULL,
  `NIF` VARCHAR(15) NOT NULL,
  `Telefono` VARCHAR(20) NULL DEFAULT NULL,
  `Posicion` ENUM('cocinero', 'repartidor') NOT NULL,
  `ID_Tienda` TINYINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_Empleado`),
  INDEX `ID_Tienda` (`ID_Tienda` ASC)  ,
  CONSTRAINT `empleados_ibfk_1`
    FOREIGN KEY (`ID_Tienda`)
    REFERENCES `pizzeriatest`.`tiendas` (`ID_Tienda`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `mydb`.`reparto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reparto` (
  `pedidos_ID_Pedido` TINYINT(3) UNSIGNED NOT NULL,
  `empleados_ID_Empleado` TINYINT(3) UNSIGNED NOT NULL,
  `FechaHora_Entrega` DATETIME NOT NULL,
  PRIMARY KEY (`pedidos_ID_Pedido`, `empleados_ID_Empleado`),
  INDEX `fk_reparto_pedidos1_idx` (`pedidos_ID_Pedido` ASC)  ,
  INDEX `fk_reparto_empleados1_idx` (`empleados_ID_Empleado` ASC)  ,
  CONSTRAINT `fk_reparto_pedidos1`
    FOREIGN KEY (`pedidos_ID_Pedido`)
    REFERENCES `pizzeriatest`.`pedidos` (`ID_Pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reparto_empleados1`
    FOREIGN KEY (`empleados_ID_Empleado`)
    REFERENCES `pizzeriatest`.`empleados` (`ID_Empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

USE `pizzeriatest` ;

-- -----------------------------------------------------
-- Table `pizzeriatest`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeriatest`.`productos` (
  `ID_Producto` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(50) NOT NULL,
  `Descripcion` VARCHAR(100) NULL DEFAULT NULL,
  `Imagen` VARCHAR(100) NULL DEFAULT NULL,
  `Precio` DECIMAL(10,2) NOT NULL,
  `tipo_producto` VARCHAR(100) NOT NULL,
  `categoria_producto` VARCHAR(100) NULL,
  PRIMARY KEY (`ID_Producto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizzeriatest`.`detallespedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeriatest`.`detallespedido` (
  `ID_Pedido` TINYINT(3) UNSIGNED NOT NULL,
  `ID_Producto` TINYINT(3) UNSIGNED NOT NULL,
  `Cantidad` INT(11) NOT NULL,
  PRIMARY KEY (`ID_Pedido`, `ID_Producto`),
  INDEX `ID_Producto` (`ID_Producto` ASC) ,
  CONSTRAINT `detallespedido_ibfk_1`
    FOREIGN KEY (`ID_Pedido`)
    REFERENCES `pizzeriatest`.`pedidos` (`ID_Pedido`),
  CONSTRAINT `detallespedido_ibfk_2`
    FOREIGN KEY (`ID_Producto`)
    REFERENCES `pizzeriatest`.`productos` (`ID_Producto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
