-- MySQL Script generated by MySQL Workbench
-- Tue May 12 20:16:24 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ricepos
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ricepos` ;

-- -----------------------------------------------------
-- Schema ricepos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ricepos` DEFAULT CHARACTER SET utf8 ;
USE `ricepos` ;

-- -----------------------------------------------------
-- Table `ricepos`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ricepos`.`User` ;

CREATE TABLE IF NOT EXISTS `ricepos`.`User` (
  `uid` INT NOT NULL AUTO_INCREMENT COMMENT 'รหัส PK ของ Table เป็น Autoincrement',
  `Username` VARCHAR(20) NOT NULL COMMENT 'ชื่อผู้ใช้งาน',
  `Password` CHAR(32) NOT NULL COMMENT 'รหัสผ่าน เข้ารหัส sha1',
  `Role` VARCHAR(45) NOT NULL COMMENT 'บทบาทของผู้ใช้งาน มี default คือ User',
  `Fname` VARCHAR(100) NULL,
  `Lname` VARCHAR(100) NULL,
  PRIMARY KEY (`uid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ricepos`.`Menu_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ricepos`.`Menu_type` ;

CREATE TABLE IF NOT EXISTS `ricepos`.`Menu_type` (
  `mt_id` INT NOT NULL AUTO_INCREMENT,
  `mt_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`mt_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ricepos`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ricepos`.`Menu` ;

CREATE TABLE IF NOT EXISTS `ricepos`.`Menu` (
  `mid` INT NOT NULL AUTO_INCREMENT,
  `Menu_name` VARCHAR(255) NOT NULL,
  `mt_id` INT NOT NULL,
  `Price` DOUBLE NULL DEFAULT 0,
  PRIMARY KEY (`mid`),
  INDEX `fk_Menu_Menu_type_idx` (`mt_id` ASC) ,
  CONSTRAINT `fk_Menu_Menu_type`
    FOREIGN KEY (`mt_id`)
    REFERENCES `ricepos`.`Menu_type` (`mt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ricepos`.`Order_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ricepos`.`Order_type` ;

CREATE TABLE IF NOT EXISTS `ricepos`.`Order_type` (
  `order_type_id` INT NOT NULL AUTO_INCREMENT,
  `order_type_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`order_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ricepos`.`Order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ricepos`.`Order` ;

CREATE TABLE IF NOT EXISTS `ricepos`.`Order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `order_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Total_price` DOUBLE NULL,
  `Change` VARCHAR(45) NULL,
  `order_type_id` INT NOT NULL,
  `uid` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_Order_Order_type1_idx` (`order_type_id` ASC) ,
  INDEX `fk_Order_User1_idx` (`uid` ASC) ,
  CONSTRAINT `fk_Order_Order_type1`
    FOREIGN KEY (`order_type_id`)
    REFERENCES `ricepos`.`Order_type` (`order_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_User1`
    FOREIGN KEY (`uid`)
    REFERENCES `ricepos`.`User` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ricepos`.`Order_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ricepos`.`Order_detail` ;

CREATE TABLE IF NOT EXISTS `ricepos`.`Order_detail` (
  `order_detail_id` INT NOT NULL AUTO_INCREMENT,
  `amount` VARCHAR(45) NOT NULL,
  `sub_total_price` VARCHAR(45) NOT NULL,
  `mid` INT NOT NULL,
  `order_id` INT NOT NULL,
  PRIMARY KEY (`order_detail_id`),
  INDEX `fk_Order_detail_Menu1_idx` (`mid` ASC) ,
  INDEX `fk_Order_detail_Order1_idx` (`order_id` ASC) ,
  CONSTRAINT `fk_Order_detail_Menu1`
    FOREIGN KEY (`mid`)
    REFERENCES `ricepos`.`Menu` (`mid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_detail_Order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `ricepos`.`Order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ricepos`.`Addons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ricepos`.`Addons` ;

CREATE TABLE IF NOT EXISTS `ricepos`.`Addons` (
  `addon_id` INT NOT NULL AUTO_INCREMENT,
  `price` DOUBLE NOT NULL,
  `mid` INT NOT NULL,
  `order_detail_id` INT NOT NULL,
  PRIMARY KEY (`addon_id`),
  INDEX `fk_Addons_Menu1_idx` (`mid` ASC) ,
  INDEX `fk_Addons_Order_detail1_idx` (`order_detail_id` ASC) ,
  CONSTRAINT `fk_Addons_Menu1`
    FOREIGN KEY (`mid`)
    REFERENCES `ricepos`.`Menu` (`mid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Addons_Order_detail1`
    FOREIGN KEY (`order_detail_id`)
    REFERENCES `ricepos`.`Order_detail` (`order_detail_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ricepos`.`sysconfig`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ricepos`.`sysconfig` ;

CREATE TABLE IF NOT EXISTS `ricepos`.`sysconfig` (
  `syscode` CHAR(5) NOT NULL,
  `sysvalue` VARCHAR(255) NULL,
  `sysdesc` VARCHAR(255) NULL,
  PRIMARY KEY (`syscode`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
