-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema opskrifter2
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `opskrifter2` ;

-- -----------------------------------------------------
-- Schema opskrifter2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `opskrifter2` ;
USE `opskrifter2` ;

-- -----------------------------------------------------
-- Table `opskrifter2`.`Opskriftstype`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter2`.`Opskriftstype` ;

CREATE TABLE IF NOT EXISTS `opskrifter2`.`Opskriftstype` (
  `opskriftstype_id` INT NOT NULL AUTO_INCREMENT,
  `opskriftstype_tekst` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`opskriftstype_id`),
  UNIQUE INDEX `opskriftstype_tekst_UNIQUE` (`opskriftstype_tekst` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opskrifter2`.`Ret`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter2`.`Ret` ;

CREATE TABLE IF NOT EXISTS `opskrifter2`.`Ret` (
  `ret_id` INT NOT NULL AUTO_INCREMENT,
  `ret_navn` VARCHAR(90) NOT NULL,
  `noter` VARCHAR(500) NULL,
  `antal_portioner` INT NULL,
  `forberedelsestid_tid` INT NULL,
  `totaltid_tid` INT NULL,
  `Opskriftstype_opskriftstype_id` INT NOT NULL,
  PRIMARY KEY (`ret_id`),
  UNIQUE INDEX `ret_navn_UNIQUE` (`ret_navn` ASC),
  INDEX `fk_Ret_Opskriftstype1_idx` (`Opskriftstype_opskriftstype_id` ASC),
  CONSTRAINT `fk_Ret_Opskriftstype1`
    FOREIGN KEY (`Opskriftstype_opskriftstype_id`)
    REFERENCES `opskrifter2`.`Opskriftstype` (`opskriftstype_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opskrifter2`.`Varekategori`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter2`.`Varekategori` ;

CREATE TABLE IF NOT EXISTS `opskrifter2`.`Varekategori` (
  `varekategori_id` INT NOT NULL AUTO_INCREMENT,
  `varekategori_tekst` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`varekategori_id`),
  UNIQUE INDEX `varekategori_tekst_UNIQUE` (`varekategori_tekst` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opskrifter2`.`Vare`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter2`.`Vare` ;

CREATE TABLE IF NOT EXISTS `opskrifter2`.`Vare` (
  `vare_id` INT NOT NULL AUTO_INCREMENT,
  `vare_navn` VARCHAR(45) NOT NULL,
  `basisvare` TINYINT NULL,
  `Varekategori_varekategori_id` INT NOT NULL,
  PRIMARY KEY (`vare_id`),
  UNIQUE INDEX `VareNavn_UNIQUE` (`vare_navn` ASC),
  INDEX `fk_Vare_Varekategori1_idx` (`Varekategori_varekategori_id` ASC),
  CONSTRAINT `fk_Vare_Varekategori1`
    FOREIGN KEY (`Varekategori_varekategori_id`)
    REFERENCES `opskrifter2`.`Varekategori` (`varekategori_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opskrifter2`.`Tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter2`.`Tag` ;

CREATE TABLE IF NOT EXISTS `opskrifter2`.`Tag` (
  `tag_id` INT NOT NULL AUTO_INCREMENT,
  `tag_tekst` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE INDEX `TagTekst_UNIQUE` (`tag_tekst` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opskrifter2`.`RetTag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter2`.`RetTag` ;

CREATE TABLE IF NOT EXISTS `opskrifter2`.`RetTag` (
  `Ret_ret_id` INT NOT NULL,
  `Tag_tag_id` INT NOT NULL,
  INDEX `fk_Ret_has_Tags_Tags1_idx` (`Tag_tag_id` ASC),
  INDEX `fk_Ret_has_Tags_Ret1_idx` (`Ret_ret_id` ASC),
  PRIMARY KEY (`Ret_ret_id`, `Tag_tag_id`),
  CONSTRAINT `fk_RetTags_Ret1`
    FOREIGN KEY (`Ret_ret_id`)
    REFERENCES `opskrifter2`.`Ret` (`ret_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RetTags_Tags1`
    FOREIGN KEY (`Tag_tag_id`)
    REFERENCES `opskrifter2`.`Tag` (`tag_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opskrifter2`.`Enhed`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter2`.`Enhed` ;

CREATE TABLE IF NOT EXISTS `opskrifter2`.`Enhed` (
  `enhed_id` INT NOT NULL AUTO_INCREMENT,
  `enhed_navn` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`enhed_id`),
  UNIQUE INDEX `Enhed_UNIQUE` (`enhed_navn` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opskrifter2`.`Varefunktion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter2`.`Varefunktion` ;

CREATE TABLE IF NOT EXISTS `opskrifter2`.`Varefunktion` (
  `Varefunktion_id` INT NOT NULL AUTO_INCREMENT,
  `Varefunktion_tekst` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Varefunktion_id`),
  UNIQUE INDEX `Varetype_tekst_UNIQUE` (`Varefunktion_tekst` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opskrifter2`.`RetVare`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter2`.`RetVare` ;

CREATE TABLE IF NOT EXISTS `opskrifter2`.`RetVare` (
  `maengde` DECIMAL(6,2) NULL,
  `Enhed_enhed_id` INT NULL,
  `Ret_ret_id` INT NOT NULL,
  `Vare_vare_id` INT NOT NULL,
  `Varefunktion_Varefunktion_id` INT NOT NULL,
  INDEX `fk_Ret_has_Vare_Vare1_idx` (`Vare_vare_id` ASC),
  INDEX `fk_Ret_has_Vare_Ret1_idx` (`Ret_ret_id` ASC),
  PRIMARY KEY (`Ret_ret_id`, `Vare_vare_id`),
  INDEX `fk_RetVare_Varefunktion1_idx` (`Varefunktion_Varefunktion_id` ASC),
  CONSTRAINT `fk_RetVare_Ret1`
    FOREIGN KEY (`Ret_ret_id`)
    REFERENCES `opskrifter2`.`Ret` (`ret_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RetVare_Vare1`
    FOREIGN KEY (`Vare_vare_id`)
    REFERENCES `opskrifter2`.`Vare` (`vare_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RetVare_Enhed1`
    FOREIGN KEY (`Enhed_enhed_id`)
    REFERENCES `opskrifter2`.`Enhed` (`enhed_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RetVare_Varefunktion1`
    FOREIGN KEY (`Varefunktion_Varefunktion_id`)
    REFERENCES `opskrifter2`.`Varefunktion` (`Varefunktion_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `opskrifter2`.`Indkøbskurv`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter2`.`Indkøbskurv` ;

CREATE TABLE IF NOT EXISTS `opskrifter2`.`Indkøbskurv` (
  `indkøbskurv_id` INT NOT NULL AUTO_INCREMENT,
  `oprettet_dato` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `senest_ændret_dato` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  `beskrivelse_tekst` VARCHAR(90) NULL,
  PRIMARY KEY (`indkøbskurv_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opskrifter2`.`IndkøbskurvVare`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter2`.`IndkøbskurvVare` ;

CREATE TABLE IF NOT EXISTS `opskrifter2`.`IndkøbskurvVare` (
  `IndkøbskurvVare_id` INT NOT NULL AUTO_INCREMENT,
  `Indkøbskurv_indkøbskurv_id` INT NOT NULL,
  `maengde` DECIMAL(6,2) NULL,
  `enhed` VARCHAR(45) NULL,
  `vare` VARCHAR(45) NOT NULL,
  `varekategori` VARCHAR(45) NOT NULL,
  `Vare_vare_id` INT NULL,
  `Ret_ret_id` INT NULL,
  INDEX `fk_IndkøbskurvVare_Indkøbskurv1_idx` (`Indkøbskurv_indkøbskurv_id` ASC),
  PRIMARY KEY (`IndkøbskurvVare_id`),
  INDEX `fk_IndkøbskurvVare_Vare1_idx` (`Vare_vare_id` ASC),
  INDEX `fk_IndkøbskurvVare_Ret1_idx` (`Ret_ret_id` ASC),
  CONSTRAINT `fk_IndkøbskurvVare_Indkøbskurv1`
    FOREIGN KEY (`Indkøbskurv_indkøbskurv_id`)
    REFERENCES `opskrifter2`.`Indkøbskurv` (`indkøbskurv_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IndkøbskurvVare_Vare1`
    FOREIGN KEY (`Vare_vare_id`)
    REFERENCES `opskrifter2`.`Vare` (`vare_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IndkøbskurvVare_Ret1`
    FOREIGN KEY (`Ret_ret_id`)
    REFERENCES `opskrifter2`.`Ret` (`ret_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
