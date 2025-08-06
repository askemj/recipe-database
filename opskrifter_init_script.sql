-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema opskrifter
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `opskrifter` ;

-- -----------------------------------------------------
-- Schema opskrifter
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `opskrifter` ;
USE `opskrifter` ;

-- -----------------------------------------------------
-- Table `opskrifter`.`Opskriftstype`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter`.`Opskriftstype` ;

CREATE TABLE IF NOT EXISTS `opskrifter`.`Opskriftstype` (
  `opskriftstype_id` INT NOT NULL AUTO_INCREMENT,
  `opskriftstype_tekst` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`opskriftstype_id`),
  UNIQUE INDEX `opskriftstype_tekst_UNIQUE` (`opskriftstype_tekst` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opskrifter`.`Ret`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter`.`Ret` ;

CREATE TABLE IF NOT EXISTS `opskrifter`.`Ret` (
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
    REFERENCES `opskrifter`.`Opskriftstype` (`opskriftstype_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opskrifter`.`Varekategori`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter`.`Varekategori` ;

CREATE TABLE IF NOT EXISTS `opskrifter`.`Varekategori` (
  `varekategori_id` INT NOT NULL AUTO_INCREMENT,
  `varekategori_tekst` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`varekategori_id`),
  UNIQUE INDEX `varekategori_tekst_UNIQUE` (`varekategori_tekst` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opskrifter`.`Vare`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter`.`Vare` ;

CREATE TABLE IF NOT EXISTS `opskrifter`.`Vare` (
  `vare_id` INT NOT NULL AUTO_INCREMENT,
  `vare_navn` VARCHAR(45) NOT NULL,
  `basisvare` TINYINT NULL,
  `Varekategori_varekategori_id` INT NOT NULL,
  PRIMARY KEY (`vare_id`),
  UNIQUE INDEX `VareNavn_UNIQUE` (`vare_navn` ASC),
  INDEX `fk_Vare_Varekategori1_idx` (`Varekategori_varekategori_id` ASC),
  CONSTRAINT `fk_Vare_Varekategori1`
    FOREIGN KEY (`Varekategori_varekategori_id`)
    REFERENCES `opskrifter`.`Varekategori` (`varekategori_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opskrifter`.`Tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter`.`Tag` ;

CREATE TABLE IF NOT EXISTS `opskrifter`.`Tag` (
  `tag_id` INT NOT NULL AUTO_INCREMENT,
  `tag_tekst` VARCHAR(45) NOT NULL,
  `tag_beskrivelse` VARCHAR(120) NOT NULL DEFAULT 'NA',
  PRIMARY KEY (`tag_id`),
  UNIQUE INDEX `TagTekst_UNIQUE` (`tag_tekst` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opskrifter`.`RetTag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter`.`RetTag` ;

CREATE TABLE IF NOT EXISTS `opskrifter`.`RetTag` (
  `Ret_ret_id` INT NOT NULL,
  `Tag_tag_id` INT NOT NULL,
  INDEX `fk_Ret_has_Tags_Tags1_idx` (`Tag_tag_id` ASC),
  INDEX `fk_Ret_has_Tags_Ret1_idx` (`Ret_ret_id` ASC),
  PRIMARY KEY (`Ret_ret_id`, `Tag_tag_id`),
  CONSTRAINT `fk_RetTags_Ret1`
    FOREIGN KEY (`Ret_ret_id`)
    REFERENCES `opskrifter`.`Ret` (`ret_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RetTags_Tags1`
    FOREIGN KEY (`Tag_tag_id`)
    REFERENCES `opskrifter`.`Tag` (`tag_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opskrifter`.`Enhed`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter`.`Enhed` ;

CREATE TABLE IF NOT EXISTS `opskrifter`.`Enhed` (
  `enhed_id` INT NOT NULL AUTO_INCREMENT,
  `enhed_navn` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`enhed_id`),
  UNIQUE INDEX `Enhed_UNIQUE` (`enhed_navn` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opskrifter`.`Varefunktion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter`.`Varefunktion` ;

CREATE TABLE IF NOT EXISTS `opskrifter`.`Varefunktion` (
  `Varefunktion_id` INT NOT NULL AUTO_INCREMENT,
  `Varefunktion_tekst` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Varefunktion_id`),
  UNIQUE INDEX `Varetype_tekst_UNIQUE` (`Varefunktion_tekst` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opskrifter`.`RetVare`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter`.`RetVare` ;

CREATE TABLE IF NOT EXISTS `opskrifter`.`RetVare` (
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
    REFERENCES `opskrifter`.`Ret` (`ret_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RetVare_Vare1`
    FOREIGN KEY (`Vare_vare_id`)
    REFERENCES `opskrifter`.`Vare` (`vare_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RetVare_Enhed1`
    FOREIGN KEY (`Enhed_enhed_id`)
    REFERENCES `opskrifter`.`Enhed` (`enhed_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RetVare_Varefunktion1`
    FOREIGN KEY (`Varefunktion_Varefunktion_id`)
    REFERENCES `opskrifter`.`Varefunktion` (`Varefunktion_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `opskrifter`.`Indkøbskurv`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter`.`Indkøbskurv` ;

CREATE TABLE IF NOT EXISTS `opskrifter`.`Indkøbskurv` (
  `indkøbskurv_id` INT NOT NULL AUTO_INCREMENT,
  `oprettet_dato` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `senest_ændret_dato` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `beskrivelse_tekst` VARCHAR(90) NULL,
  PRIMARY KEY (`indkøbskurv_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `opskrifter`.`IndkøbskurvVare`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter`.`IndkøbskurvVare` ;

CREATE TABLE IF NOT EXISTS `opskrifter`.`IndkøbskurvVare` (
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
    REFERENCES `opskrifter`.`Indkøbskurv` (`indkøbskurv_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IndkøbskurvVare_Vare1`
    FOREIGN KEY (`Vare_vare_id`)
    REFERENCES `opskrifter`.`Vare` (`vare_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IndkøbskurvVare_Ret1`
    FOREIGN KEY (`Ret_ret_id`)
    REFERENCES `opskrifter`.`Ret` (`ret_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `opskrifter`.`Thumbnail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter`.`Thumbnail` ;

CREATE TABLE IF NOT EXISTS `opskrifter`.`Thumbnail` (
  `thumbnail_base64` TEXT NOT NULL,
  `Ret_ret_id` INT NOT NULL,
  PRIMARY KEY (`Ret_ret_id`),
  CONSTRAINT `fk_Thumbnail_Ret`
    FOREIGN KEY (`Ret_ret_id`)
    REFERENCES `opskrifter`.`Ret` (`ret_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `opskrifter` ;

-- -----------------------------------------------------
-- Table `opskrifter`.`MealPlans`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `opskrifter`.`MealPlans` ;

CREATE TABLE IF NOT EXISTS `opskrifter`.`MealPlans` (
  `id` TEXT NOT NULL,
  `oprettet` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ændret` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MealPlanJson` TEXT NOT NULL,
  `beskrivelse` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

USE `opskrifter` ;

-- -----------------------------------------------------
-- View `opskrifter`.`VarerTilRet`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `opskrifter`.`VarerTilRet` ;
USE `opskrifter`;
CREATE  OR REPLACE VIEW `VarerTilRet` AS
SELECT Ret.ret_id, RetVare.maengde, Enhed.enhed_navn, Vare.vare_navn, Varekategori.varekategori_tekst, Vare.basisvare, Varefunktion.Varefunktion_tekst FROM RetVare 
INNER JOIN Ret ON Ret.ret_id = RetVare.Ret_ret_id
INNER JOIN Enhed ON RetVare.Enhed_enhed_id = Enhed.enhed_id
INNER JOIN Vare ON RetVare.Vare_vare_id = Vare.vare_id
INNER JOIN Varekategori ON Vare.Varekategori_varekategori_id = Varekategori.varekategori_id
INNER JOIN Varefunktion ON Varefunktion_Varefunktion_id = Varefunktion_id;

-- -----------------------------------------------------
-- View `opskrifter`.`TagsTilRet`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `opskrifter`.`TagsTilRet` ;
USE `opskrifter`;
CREATE  OR REPLACE VIEW `TagsTilRet` AS
SELECT Ret.ret_id, Tag.tag_id, Tag.tag_tekst FROM Ret 
INNER JOIN RetTag ON Ret.ret_id = RetTag.Ret_ret_id
INNER JOIN Tag ON Tag.tag_id = RetTag.Tag_tag_id;

-- -----------------------------------------------------
-- View `opskrifter`.`AlleVarer`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `opskrifter`.`AlleVarer` ;
USE `opskrifter`;
CREATE  OR REPLACE VIEW `AlleVarer` AS
SELECT Vare.vare_id, Vare.vare_navn, Vare.basisvare, Varekategori.varekategori_tekst FROM Vare 
INNER JOIN Varekategori ON Vare.Varekategori_varekategori_id = Varekategori.varekategori_id;

-- -----------------------------------------------------
-- View `opskrifter`.`RetView`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `opskrifter`.`RetView` ;
USE `opskrifter`;
CREATE OR REPLACE VIEW RetView AS
SELECT 
    r.ret_id,
    r.ret_navn,
    r.noter,
    r.antal_portioner,
    r.forberedelsestid_tid,
    r.totaltid_tid,
    o.opskriftstype_tekst,
    GROUP_CONCAT(DISTINCT t.tag_tekst ORDER BY t.tag_tekst SEPARATOR ', ') AS tags,
    GROUP_CONCAT(DISTINCT v.vare_navn ORDER BY v.vare_navn SEPARATOR ', ') AS ingredienser,
    th.thumbnail_base64
FROM Ret r
INNER JOIN Opskriftstype o ON r.Opskriftstype_opskriftstype_id = o.opskriftstype_id
LEFT JOIN RetTag rt ON r.ret_id = rt.Ret_ret_id
LEFT JOIN Tag t ON rt.Tag_tag_id = t.tag_id
LEFT JOIN RetVare rv ON r.ret_id = rv.Ret_ret_id
LEFT JOIN Vare v ON rv.Vare_vare_id = v.vare_id
LEFT JOIN Thumbnail th ON r.ret_id = th.Ret_ret_id
GROUP BY r.ret_id;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
