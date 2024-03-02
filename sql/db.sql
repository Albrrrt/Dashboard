-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

create database `prueba2`;
use `prueba2`;

-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidoP` VARCHAR(45) NOT NULL,
  `apellidoM` VARCHAR(45) NOT NULL,
  `colonia` VARCHAR(45) NOT NULL,
  `calle` VARCHAR(45) NOT NULL,
  `cp` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Venta_Agenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Venta_Agenda` (
  `idVA` INT NOT NULL AUTO_INCREMENT,
  `fecha_pago` DATE NOT NULL,
  `monto` DECIMAL(2) NOT NULL,
  `adeudo` DECIMAL(2) NOT NULL,
  `fecha_fin` DATE NOT NULL,
  `tipo_pago` VARCHAR(45) NOT NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`idVA`),
  INDEX `fk_Venta_Agenda_Usuario_idx` (`idUsuario` ASC) ,
  CONSTRAINT `fk_Venta_Agenda_Usuario`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `nivel` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `costo` DECIMAL(2) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `duracion` VARCHAR(45) NOT NULL,
  `idCategoria` INT NOT NULL,
  PRIMARY KEY (`idProducto`),
  INDEX `fk_Producto_Categoria1_idx` (`idCategoria` ASC) ,
  CONSTRAINT `fk_Producto_Categoria1`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Factura` (
  `idFactura` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `rfc` VARCHAR(45) NOT NULL,
  `domicilioF` VARCHAR(45) NOT NULL,
  `cfdi` VARCHAR(45) NOT NULL,
  `idVA` INT NOT NULL,
  `idProducto` INT NOT NULL,
  PRIMARY KEY (`idFactura`),
  INDEX `fk_Factura_Venta_Agenda1_idx` (`idVA` ASC) ,
  INDEX `fk_Factura_Producto1_idx` (`idProducto` ASC) ,
  CONSTRAINT `fk_Factura_Venta_Agenda1`
    FOREIGN KEY (`idVA`)
    REFERENCES `Venta_Agenda` (`idVA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Factura_Producto1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Informes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Informes` (
  `idInformes` INT NOT NULL AUTO_INCREMENT,
  `fecha_proxima` VARCHAR(45) NOT NULL,
  `idFactura` INT NOT NULL,
  PRIMARY KEY (`idInformes`),
  INDEX `fk_Informes_Factura1_idx` (`idFactura` ASC) ,
  CONSTRAINT `fk_Informes_Factura1`
    FOREIGN KEY (`idFactura`)
    REFERENCES `Factura` (`idFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Proveer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proveer` (
  `idProveer` INT NOT NULL AUTO_INCREMENT,
  `idUsuario` INT NOT NULL,
  `idProducto` INT NOT NULL,
  PRIMARY KEY (`idProveer`),
  INDEX `fk_Proveer_Usuario1_idx` (`idUsuario` ASC) ,
  INDEX `fk_Proveer_Producto1_idx` (`idProducto` ASC) ,
  CONSTRAINT `fk_Proveer_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Proveer_Producto1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



