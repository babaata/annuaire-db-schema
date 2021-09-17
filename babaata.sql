-- MySQL Workbench Synchronization
-- Generated: 2021-09-17 14:43
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: lenovo

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `babaata`.`utilisateur` (
  `utilisateur_id` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(100) NULL DEFAULT NULL,
  `date_de_naissance` DATETIME NOT NULL,
  `sexe` VARCHAR(1) NOT NULL COMMENT 'Possible values:\nMasculin = M\nFeminin = F',
  `email` VARCHAR(45) NOT NULL,
  `telephone` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(45) NOT NULL,
  `date_de_creation` DATETIME NULL DEFAULT NULL,
  `date_de_modification` TIMESTAMP NULL DEFAULT NULL,
  `statut` BIT(1) NULL DEFAULT NULL,
  `date_de_desactivation` DATETIME NULL DEFAULT NULL,
  `Adresse_Adresse_id` INT(11) NOT NULL,
  `url_photo` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`utilisateur_id`, `Adresse_Adresse_id`),
  INDEX `fk_utilisateur_Adresse1_idx` (`Adresse_Adresse_id` ASC) VISIBLE,
  CONSTRAINT `fk_utilisateur_Adresse1`
    FOREIGN KEY (`Adresse_Adresse_id`)
    REFERENCES `babaata`.`Adresse` (`Adresse_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `babaata`.`role` (
  `role_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NULL DEFAULT NULL,
  `statut` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `babaata`.`droit` (
  `droit_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NULL DEFAULT NULL,
  `statut` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`droit_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `babaata`.`Adresse` (
  `Adresse_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Pays` VARCHAR(45) NOT NULL,
  `Ville` VARCHAR(45) NOT NULL,
  `Rue` VARCHAR(45) NULL DEFAULT NULL,
  `Zip` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Adresse_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `babaata`.`utilisateur_role` (
  `utilisateur_role_id` INT(11) NOT NULL AUTO_INCREMENT,
  `utilisateur_utilisateur_id` INT(11) NOT NULL,
  `role_role_id` INT(11) NOT NULL,
  PRIMARY KEY (`utilisateur_role_id`, `utilisateur_utilisateur_id`, `role_role_id`),
  INDEX `fk_utilisateur_role_utilisateur_idx` (`utilisateur_utilisateur_id` ASC) VISIBLE,
  INDEX `fk_utilisateur_role_role1_idx` (`role_role_id` ASC) VISIBLE,
  CONSTRAINT `fk_utilisateur_role_utilisateur`
    FOREIGN KEY (`utilisateur_utilisateur_id`)
    REFERENCES `babaata`.`utilisateur` (`utilisateur_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_utilisateur_role_role1`
    FOREIGN KEY (`role_role_id`)
    REFERENCES `babaata`.`role` (`role_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `babaata`.`role_droit` (
  `role_droit_id` INT(11) NOT NULL AUTO_INCREMENT,
  `role_role_id` INT(11) NOT NULL,
  `droit_droit_id` INT(11) NOT NULL,
  PRIMARY KEY (`role_droit_id`, `role_role_id`, `droit_droit_id`),
  INDEX `fk_role_droit_role1_idx` (`role_role_id` ASC) VISIBLE,
  INDEX `fk_role_droit_droit1_idx` (`droit_droit_id` ASC) VISIBLE,
  CONSTRAINT `fk_role_droit_role1`
    FOREIGN KEY (`role_role_id`)
    REFERENCES `babaata`.`role` (`role_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_role_droit_droit1`
    FOREIGN KEY (`droit_droit_id`)
    REFERENCES `babaata`.`droit` (`droit_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `babaata`.`profil` (
  `profil_id` INT(11) NOT NULL AUTO_INCREMENT,
  `titre` VARCHAR(45) NOT NULL,
  `resume` VARCHAR(45) NULL DEFAULT NULL,
  `utilisateur_utilisateur_id` INT(11) NOT NULL,
  PRIMARY KEY (`profil_id`),
  INDEX `fk_profil_utilisateur1_idx` (`utilisateur_utilisateur_id` ASC) VISIBLE,
  CONSTRAINT `fk_profil_utilisateur1`
    FOREIGN KEY (`utilisateur_utilisateur_id`)
    REFERENCES `babaata`.`utilisateur` (`utilisateur_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `babaata`.`competence` (
  `competence_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL DEFAULT NULL,
  `niveau` VARCHAR(45) NULL DEFAULT NULL,
  `profil_profil_id` INT(11) NOT NULL,
  PRIMARY KEY (`competence_id`),
  INDEX `fk_competence_profil1_idx` (`profil_profil_id` ASC) VISIBLE,
  CONSTRAINT `fk_competence_profil1`
    FOREIGN KEY (`profil_profil_id`)
    REFERENCES `babaata`.`profil` (`profil_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `babaata`.`langue` (
  `langue_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `niveau` VARCHAR(45) NULL DEFAULT NULL,
  `profil_profil_id` INT(11) NOT NULL,
  PRIMARY KEY (`langue_id`),
  INDEX `fk_langue_profil1_idx` (`profil_profil_id` ASC) VISIBLE,
  CONSTRAINT `fk_langue_profil1`
    FOREIGN KEY (`profil_profil_id`)
    REFERENCES `babaata`.`profil` (`profil_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `babaata`.`education` (
  `education_id` INT(11) NOT NULL AUTO_INCREMENT,
  `ecole` VARCHAR(45) NULL DEFAULT NULL,
  `type_de_diplome` VARCHAR(45) NULL DEFAULT NULL,
  `date_de_debut` DATETIME NULL DEFAULT NULL,
  `date_de_fin` DATETIME NULL DEFAULT NULL,
  `descriptif` VARCHAR(45) NULL DEFAULT NULL,
  `Adresse_Adresse_id` INT(11) NOT NULL,
  `profil_profil_id` INT(11) NOT NULL,
  PRIMARY KEY (`education_id`, `Adresse_Adresse_id`, `profil_profil_id`),
  INDEX `fk_education_Adresse1_idx` (`Adresse_Adresse_id` ASC) VISIBLE,
  INDEX `fk_education_profil1_idx` (`profil_profil_id` ASC) VISIBLE,
  CONSTRAINT `fk_education_Adresse1`
    FOREIGN KEY (`Adresse_Adresse_id`)
    REFERENCES `babaata`.`Adresse` (`Adresse_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_education_profil1`
    FOREIGN KEY (`profil_profil_id`)
    REFERENCES `babaata`.`profil` (`profil_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `babaata`.`certification` (
  `certification_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `organisme_delivrance` VARCHAR(45) NOT NULL,
  `level` VARCHAR(45) NULL DEFAULT NULL,
  `date_de_certification` DATETIME NULL DEFAULT NULL,
  `date_expiration` DATETIME NULL DEFAULT NULL,
  `profil_profil_id` INT(11) NOT NULL,
  `url` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`certification_id`, `profil_profil_id`),
  INDEX `fk_certification_profil1_idx` (`profil_profil_id` ASC) VISIBLE,
  CONSTRAINT `fk_certification_profil1`
    FOREIGN KEY (`profil_profil_id`)
    REFERENCES `babaata`.`profil` (`profil_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `babaata`.`experience_professionnelle` (
  `experience_professionnelle_id` INT(11) NOT NULL AUTO_INCREMENT,
  `entreprise` VARCHAR(45) NOT NULL,
  `intitule_poste` VARCHAR(45) NOT NULL,
  `date_de_debut` DATETIME NULL DEFAULT NULL,
  `date_de_fin` DATETIME NULL DEFAULT NULL,
  `descriptif` VARCHAR(45) NULL DEFAULT NULL,
  `referent` VARCHAR(45) NULL DEFAULT NULL,
  `profil_profil_id` INT(11) NOT NULL,
  `type_contrat_type_contrat_id` INT(11) NOT NULL,
  PRIMARY KEY (`experience_professionnelle_id`, `profil_profil_id`, `type_contrat_type_contrat_id`),
  INDEX `fk_experience_professionnelle_profil1_idx` (`profil_profil_id` ASC) VISIBLE,
  INDEX `fk_experience_professionnelle_type_contrat1_idx` (`type_contrat_type_contrat_id` ASC) VISIBLE,
  CONSTRAINT `fk_experience_professionnelle_profil1`
    FOREIGN KEY (`profil_profil_id`)
    REFERENCES `babaata`.`profil` (`profil_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_experience_professionnelle_type_contrat1`
    FOREIGN KEY (`type_contrat_type_contrat_id`)
    REFERENCES `babaata`.`type_contrat` (`type_contrat_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `babaata`.`type_contrat` (
  `type_contrat_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`type_contrat_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `babaata`.`media` (
  `media_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `url` VARCHAR(250) NULL DEFAULT NULL,
  `certification_certification_id` INT(11) NOT NULL,
  `certification_profil_profil_id` INT(11) NOT NULL,
  `education_education_id` INT(11) NOT NULL,
  `education_Adresse_Adresse_id` INT(11) NOT NULL,
  `education_profil_profil_id` INT(11) NOT NULL,
  `experience_professionnelle_experience_professionnelle_id` INT(11) NOT NULL,
  `experience_professionnelle_profil_profil_id` INT(11) NOT NULL,
  `experience_professionnelle_type_contrat_type_contrat_id` INT(11) NOT NULL,
  PRIMARY KEY (`media_id`, `certification_certification_id`, `certification_profil_profil_id`, `education_education_id`, `education_Adresse_Adresse_id`, `education_profil_profil_id`, `experience_professionnelle_experience_professionnelle_id`, `experience_professionnelle_profil_profil_id`, `experience_professionnelle_type_contrat_type_contrat_id`),
  INDEX `fk_media_certification1_idx` (`certification_certification_id` ASC, `certification_profil_profil_id` ASC) VISIBLE,
  INDEX `fk_media_education1_idx` (`education_education_id` ASC, `education_Adresse_Adresse_id` ASC, `education_profil_profil_id` ASC) VISIBLE,
  INDEX `fk_media_experience_professionnelle1_idx` (`experience_professionnelle_experience_professionnelle_id` ASC, `experience_professionnelle_profil_profil_id` ASC, `experience_professionnelle_type_contrat_type_contrat_id` ASC) VISIBLE,
  CONSTRAINT `fk_media_certification1`
    FOREIGN KEY (`certification_certification_id` , `certification_profil_profil_id`)
    REFERENCES `babaata`.`certification` (`certification_id` , `profil_profil_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_media_education1`
    FOREIGN KEY (`education_education_id` , `education_Adresse_Adresse_id` , `education_profil_profil_id`)
    REFERENCES `babaata`.`education` (`education_id` , `Adresse_Adresse_id` , `profil_profil_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_media_experience_professionnelle1`
    FOREIGN KEY (`experience_professionnelle_experience_professionnelle_id` , `experience_professionnelle_profil_profil_id` , `experience_professionnelle_type_contrat_type_contrat_id`)
    REFERENCES `babaata`.`experience_professionnelle` (`experience_professionnelle_id` , `profil_profil_id` , `type_contrat_type_contrat_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `babaata`.`referent` (
  `referent_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `poste` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telephone` VARCHAR(45) NULL DEFAULT NULL,
  `experience_professionnelle_experience_professionnelle_id` INT(11) NOT NULL,
  PRIMARY KEY (`referent_id`, `experience_professionnelle_experience_professionnelle_id`),
  INDEX `fk_referent_experience_professionnelle1_idx` (`experience_professionnelle_experience_professionnelle_id` ASC) VISIBLE,
  CONSTRAINT `fk_referent_experience_professionnelle1`
    FOREIGN KEY (`experience_professionnelle_experience_professionnelle_id`)
    REFERENCES `babaata`.`experience_professionnelle` (`experience_professionnelle_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

DROP TABLE IF EXISTS `babaata`.`user` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
