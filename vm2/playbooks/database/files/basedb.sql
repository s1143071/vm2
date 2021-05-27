DROP SCHEMA IF EXISTS klanten;
CREATE SCHEMA klanten;
USE klanten;
SET AUTOCOMMIT=0;

DROP TABLE IF EXISTS `gegevens`;

CREATE TABLE `gegevens` (
  `Klant_ID` INT NOT NULL AUTO_INCREMENT,
  `Naam` CHAR(40) NOT NULL DEFAULT 'asd',
  `Functie` CHAR(40) NOT NULL DEFAULT 'asd',
  PRIMARY KEY (`Klant_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

INSERT INTO `gegevens` (Naam, Functie) VALUES ('Enes Ozdemir','Student');
INSERT INTO `gegevens` (Naam, Functie) VALUES ('Jeffery Kuster','Chef');
COMMIT;

SET AUTOCOMMIT=1;
