-- MySQL Script generated by MySQL Workbench
-- Sun Nov 10 21:40:29 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema IotDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `IotDB` ;

-- -----------------------------------------------------
-- Schema IotDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `IotDB` DEFAULT CHARACTER SET utf8 ;
USE `IotDB` ;

-- -----------------------------------------------------
-- Table `IotDB`.`device`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IotDB`.`device` ;

CREATE TABLE IF NOT EXISTS `IotDB`.`device` (
  `id_device` INT NOT NULL,
  `status` TINYBLOB NOT NULL,
  `brand` VARCHAR(45) NULL,
  `model` VARCHAR(45) NULL,
  `min_con` VARCHAR(45) NULL,
  `max_con` VARCHAR(45) NULL,
  `use_time` VARCHAR(45) NULL,
  `time_register` DATETIME NULL,
  `time_unsubcribe` DATETIME NULL,
  `x` INT NULL,
  `y` INT NULL,
  PRIMARY KEY (`id_device`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IotDB`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IotDB`.`product` ;

CREATE TABLE IF NOT EXISTS `IotDB`.`product` (
  `id_product` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(120) NULL,
  `os` VARCHAR(45) NULL,
  `device_id_device` INT NOT NULL,
  PRIMARY KEY (`id_product`, `device_id_device`),
  CONSTRAINT `fk_product_device1`
    FOREIGN KEY (`device_id_device`)
    REFERENCES `IotDB`.`device` (`id_device`)
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IotDB`.`sensor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IotDB`.`sensor` ;

CREATE TABLE IF NOT EXISTS `IotDB`.`sensor` (
  `id_sensor` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  `firmware` VARCHAR(45) NULL,
  `clasification` VARCHAR(45) NULL,
  `device_id_device` INT NOT NULL,
  PRIMARY KEY (`id_sensor`, `device_id_device`),
  CONSTRAINT `fk_sensor_device1`
    FOREIGN KEY (`device_id_device`)
    REFERENCES `IotDB`.`device` (`id_device`)
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IotDB`.`admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IotDB`.`admin` ;

CREATE TABLE IF NOT EXISTS `IotDB`.`admin` (
  `id_admin` VARCHAR(20) NOT NULL,
  `name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_admin`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IotDB`.`stage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IotDB`.`stage` ;

CREATE TABLE IF NOT EXISTS `IotDB`.`stage` (
  `id_stage` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `admin_id_admin` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_stage`),
  CONSTRAINT `fk_stage_admin1`
    FOREIGN KEY (`admin_id_admin`)
    REFERENCES `IotDB`.`admin` (`id_admin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IotDB`.`report`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IotDB`.`report` ;

CREATE TABLE IF NOT EXISTS `IotDB`.`report` (
  `id_report` INT NOT NULL,
  `consumption` DECIMAL NULL,
  `date` DATE NULL,
  `time` TIME NULL,
  `admin_id_admin` VARCHAR(20) NOT NULL,
  `device_id_device` INT NOT NULL,
  PRIMARY KEY (`id_report`, `admin_id_admin`),
  CONSTRAINT `fk_report_admin1`
    FOREIGN KEY (`admin_id_admin`)
    REFERENCES `IotDB`.`admin` (`id_admin`),
  CONSTRAINT `fk_report_device1`
    FOREIGN KEY (`device_id_device`)
    REFERENCES `IotDB`.`device` (`id_device`)
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IotDB`.`scenario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IotDB`.`scenario` ;

CREATE TABLE IF NOT EXISTS `IotDB`.`scenario` (
  `id_scenario` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id_scenario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IotDB`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IotDB`.`user` ;

CREATE TABLE IF NOT EXISTS `IotDB`.`user` (
  `username` VARCHAR(20) NOT NULL,
  `name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(255) NOT NULL,
  `status` TINYBLOB NULL,
  `date_register` DATE NULL,
  `date_unsubscribe` DATE NULL,
  `admin_id_admin` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`username`, `admin_id_admin`),
  CONSTRAINT `fk_user_admin1`
    FOREIGN KEY (`admin_id_admin`)
    REFERENCES `IotDB`.`admin` (`id_admin`)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IotDB`.`floor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IotDB`.`floor` ;

CREATE TABLE IF NOT EXISTS `IotDB`.`floor` (
  `id_floor` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `stage_id_stage` INT NOT NULL,
  PRIMARY KEY (`id_floor`, `stage_id_stage`),
  CONSTRAINT `fk_floor_stage1`
    FOREIGN KEY (`stage_id_stage`)
    REFERENCES `IotDB`.`stage` (`id_stage`)
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IotDB`.`room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IotDB`.`room` ;

CREATE TABLE IF NOT EXISTS `IotDB`.`room` (
  `id_room` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `floor_id_floor` INT NOT NULL,
  `scenario_id_scenario` INT NOT NULL,
  PRIMARY KEY (`id_room`, `floor_id_floor`),
  CONSTRAINT `fk_room_floor1`
    FOREIGN KEY (`floor_id_floor`)
    REFERENCES `IotDB`.`floor` (`id_floor`),
  CONSTRAINT `fk_room_scenario1`
    FOREIGN KEY (`scenario_id_scenario`)
    REFERENCES `IotDB`.`scenario` (`id_scenario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IotDB`.`device_has_room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IotDB`.`device_has_room` ;

CREATE TABLE IF NOT EXISTS `IotDB`.`device_has_room` (
  `device_id_device` INT NOT NULL,
  `room_id_room` INT NOT NULL,
  PRIMARY KEY (`device_id_device`, `room_id_room`),
  CONSTRAINT `fk_device_has_room_device1`
    FOREIGN KEY (`device_id_device`)
    REFERENCES `IotDB`.`device` (`id_device`),
  CONSTRAINT `fk_device_has_room_room1`
    FOREIGN KEY (`room_id_room`)
    REFERENCES `IotDB`.`room` (`id_room`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IotDB`.`user_has_stage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IotDB`.`user_has_stage` ;

CREATE TABLE IF NOT EXISTS `IotDB`.`user_has_stage` (
  `user_username` VARCHAR(20) NOT NULL,
  `stage_id_stage` INT NOT NULL,
  PRIMARY KEY (`user_username`, `stage_id_stage`),
  CONSTRAINT `fk_user_has_stage_user1`
    FOREIGN KEY (`user_username`)
    REFERENCES `IotDB`.`user` (`username`),
  CONSTRAINT `fk_user_has_stage_stage1`
    FOREIGN KEY (`stage_id_stage`)
    REFERENCES `IotDB`.`stage` (`id_stage`)
    )
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;