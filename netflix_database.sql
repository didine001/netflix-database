CREATE TABLE `netflix`.`compte` (
  `id_compte` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Prenom` VARCHAR(45) NOT NULL,
  `Date_Naissance` DATE NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `MotDePasse` VARCHAR(45) NOT NULL,
  `Id_Abonnement` INT NULL,
  UNIQUE INDEX `id_compte_UNIQUE` (`id_compte` ASC) VISIBLE,
  PRIMARY KEY (`id_compte`));

CREATE TABLE `netflix`.`abonnement` (
  `id_abonnement` INT NOT NULL AUTO_INCREMENT,
  `Label` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(500) NOT NULL,
  `Prix` DOUBLE NOT NULL,
  PRIMARY KEY (`id_abonnement`),
  UNIQUE INDEX `idabonnement_UNIQUE` (`id_abonnement` ASC) VISIBLE);

CREATE TABLE `netflix`.`profil` (
  `id_profil` INT NOT NULL AUTO_INCREMENT,
  `Id_Compte` INT NOT NULL,
  `Pseudo` VARCHAR(45) NOT NULL,
  `Photo` BLOB NULL,
  PRIMARY KEY (`id_profil`),
  UNIQUE INDEX `id_profil_UNIQUE` (`id_profil` ASC) VISIBLE);

CREATE TABLE `netflix`.`saga` (
  `id_saga` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,

  PRIMARY KEY (`id_saga`),
  UNIQUE INDEX `id_saga_UNIQUE` (`id_saga` ASC) VISIBLE);

CREATE TABLE `netflix`.`video` (
  `id_video` INT NOT NULL AUTO_INCREMENT,
  `Id_Saga` INT,
  `Titre` VARCHAR(500) NOT NULL,
  `Description` VARCHAR(500) NOT NULL,
  `Saison` INT NOT NULL,
  `Episode` INT NOT NULL,
  `Durée` TIME NOT NULL,
  `Id_Categorie` INT NOT NULL,
  PRIMARY KEY (`id_video`),
  UNIQUE INDEX `id_video_UNIQUE` (`id_video` ASC) VISIBLE)
COMMENT = '	';

CREATE TABLE `netflix`.`categorie` (
  `id_categorie` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id_categorie`),
  UNIQUE INDEX `id_categorie_UNIQUE` (`id_categorie` ASC) VISIBLE);

CREATE TABLE `netflix`.`distribution` (
  `id_distribution` INT NOT NULL AUTO_INCREMENT,
  `Id_Personne` INT NOT NULL,
  `Id_Video` INT NOT NULL,
  `Id_Metier` INT NOT NULL,
  PRIMARY KEY (`id_distribution`),
  UNIQUE INDEX `id_distribution_UNIQUE` (`id_distribution` ASC) VISIBLE);

CREATE TABLE `netflix`.`metier` (
  `id_metier` INT NOT NULL AUTO_INCREMENT,
  `Metier` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_metier`),
  UNIQUE INDEX `id_metier_UNIQUE` (`id_metier` ASC) VISIBLE);

CREATE TABLE `netflix`.`personne` (
  `id_personne` INT NOT NULL AUTO_INCREMENT,
  `Prenom` VARCHAR(45) NOT NULL,
  `Nom` VARCHAR(45) NOT NULL,
  `Pays` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_personne`),
  UNIQUE INDEX `id_personne_UNIQUE` (`id_personne` ASC) VISIBLE);

CREATE TABLE `netflix`.`favoris` (
  `id_favoris` INT NOT NULL AUTO_INCREMENT,
  `Id_Profil` INT NOT NULL,
  `Id_Video` INT NOT NULL,
  PRIMARY KEY (`id_favoris`),
  UNIQUE INDEX `id_favoris_UNIQUE` (`id_favoris` ASC) VISIBLE);

CREATE TABLE `netflix`.`reprendre_lecture` (
  `id_reprendre_lecture` INT NOT NULL AUTO_INCREMENT,
  `Id_Profil` INT NOT NULL,
  `Id_Video` INT NULL,
  `Temps_Lecture` TIME NOT NULL,
  PRIMARY KEY (`id_reprendre_lecture`),
  UNIQUE INDEX `id_reprendre_lecture_UNIQUE` (`id_reprendre_lecture` ASC) VISIBLE);

CREATE TABLE `netflix`.`note` (
  `id_note` INT NOT NULL AUTO_INCREMENT,
  `Id_Video` INT NOT NULL,
  `Id_Profil` INT NOT NULL,
  `Note` ENUM("Bien", "Pas bien") NOT NULL,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`id_note`),
  UNIQUE INDEX `id_note_UNIQUE` (`id_note` ASC) VISIBLE);


ALTER TABLE `netflix`.`compte` 
ADD INDEX `fk_compte_abonnement_idx` (`Id_Abonnement` ASC) VISIBLE;
;
ALTER TABLE `netflix`.`compte` 
ADD CONSTRAINT `fk_compte_abonnement`
  FOREIGN KEY (`Id_Abonnement`)
  REFERENCES `netflix`.`abonnement` (`id_abonnement`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `netflix`.`distribution` 
ADD INDEX `fk_distribution_personne_idx` (`Id_Personne` ASC) VISIBLE,
ADD INDEX `fk_distribution_video_idx` (`Id_Video` ASC) VISIBLE,
ADD INDEX `fk_distribution_metier_idx` (`Id_Metier` ASC) VISIBLE;
;
ALTER TABLE `netflix`.`distribution` 
ADD CONSTRAINT `fk_distribution_personne`
  FOREIGN KEY (`Id_Personne`)
  REFERENCES `netflix`.`personne` (`id_personne`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_distribution_video`
  FOREIGN KEY (`Id_Video`)
  REFERENCES `netflix`.`video` (`id_video`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_distribution_metier`
  FOREIGN KEY (`Id_Metier`)
  REFERENCES `netflix`.`metier` (`id_metier`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `netflix`.`favoris` 
ADD INDEX `fk_favoris_video_idx` (`Id_Video` ASC) VISIBLE,
ADD INDEX `fk_favoris_profil_idx` (`Id_Profil` ASC) VISIBLE;
;
ALTER TABLE `netflix`.`favoris` 
ADD CONSTRAINT `fk_favoris_video`
  FOREIGN KEY (`Id_Video`)
  REFERENCES `netflix`.`video` (`id_video`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_favoris_profil`
  FOREIGN KEY (`Id_Profil`)
  REFERENCES `netflix`.`profil` (`id_profil`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `netflix`.`note` 
ADD INDEX `fk_note_video_idx` (`Id_Video` ASC) VISIBLE,
ADD INDEX `fk_note_profil_idx` (`Id_Profil` ASC) VISIBLE;
;
ALTER TABLE `netflix`.`note` 
ADD CONSTRAINT `fk_note_video`
  FOREIGN KEY (`Id_Video`)
  REFERENCES `netflix`.`video` (`id_video`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_note_profil`
  FOREIGN KEY (`Id_Profil`)
  REFERENCES `netflix`.`profil` (`id_profil`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `netflix`.`profil` 
ADD INDEX `fk_profil_compte_idx` (`Id_Compte` ASC) VISIBLE;
;
ALTER TABLE `netflix`.`profil` 
ADD CONSTRAINT `fk_profil_compte`
  FOREIGN KEY (`Id_Compte`)
  REFERENCES `netflix`.`compte` (`id_compte`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `netflix`.`reprendre_lecture` 
ADD INDEX `fk_reprendre_video_idx` (`Id_Video` ASC) VISIBLE,
ADD INDEX `fk_reprendre_profil_idx` (`Id_Profil` ASC) VISIBLE;
;
ALTER TABLE `netflix`.`reprendre_lecture` 
ADD CONSTRAINT `fk_reprendre_video`
  FOREIGN KEY (`Id_Video`)
  REFERENCES `netflix`.`video` (`id_video`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_reprendre_profil`
  FOREIGN KEY (`Id_Profil`)
  REFERENCES `netflix`.`profil` (`id_profil`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `netflix`.`video` 
ADD INDEX `fk_video_categorie_idx` (`Id_Categorie` ASC) VISIBLE,
ADD INDEX `fk_video_saga_idx` (`Id_Saga` ASC) VISIBLE;
;
ALTER TABLE `netflix`.`video` 
ADD CONSTRAINT `fk_video_categorie`
  FOREIGN KEY (`Id_Categorie`)
  REFERENCES `netflix`.`categorie` (`id_categorie`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_video_saga`
  FOREIGN KEY (`Id_Saga`)
  REFERENCES `netflix`.`saga` (`id_saga`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;



-- INSERTION

-- Insertion d'un jeu de test

INSERT INTO netflix.`abonnement` (`Label`, `Description`, `Prix`) VALUES
('Basic', 'Basic subscription for Netflix', 7.99),
('Standard', 'Standard subscription for Netflix', 10.99),
('Premium', 'Premium subscription for Netflix', 13.99);

INSERT INTO netflix.compte (Nom, Prenom, Date_Naissance, Email, MotDePasse, Id_Abonnement) VALUES
('Dupont', 'Jean', '1985-05-22', 'jean.dupont@gmail.com', 'azerty', 1),
('Durand', 'Marie', '1990-08-11', 'marie.durand@gmail.com', 'azerty', 2),
('Martin', 'Pierre', '1978-03-27', 'pierre.martin@gmail.com', 'azerty', 1),
('Leclerc', 'Sophie', '2000-01-01', 'sophie.leclerc@gmail.com', 'azerty', 3);

INSERT INTO netflix.profil (Pseudo, Id_Compte, Photo) VALUES
('jdupont',1 ,NULL),
('mdurand',2 , NULL),
('pmartin',2 , NULL),
('sleclerc',4 , NULL);

INSERT INTO netflix.`categorie` (`Nom`, `Description`) VALUES
('Action', 'Action movies and TV shows'),
('Comedy', 'Comedy movies and TV shows'),
('Drama', 'Drama movies and TV shows'),
('Horror', 'Horror movies and TV shows');

INSERT INTO netflix.`metier` (`Metier`) VALUES
('Actor'),
('Director'),
('Producer'),
('Writer'),
('Cinematographer'),
('Editor');

INSERT INTO netflix.`personne` (`Prenom`, `Nom`, `Pays`) VALUES
('John', 'Doe', 'USA'),
('Jane', 'Doe', 'USA'),
('Bob', 'Smith', 'Canada'),
('Alice', 'Jones', 'UK'),
('Emma', 'Davis', 'Australia');

INSERT INTO netflix.`saga` (`Nom`) VALUES
('The Avengers'),
('Star Wars'),
('Harry Potter');

INSERT INTO netflix.`video` (`id_video`, `Id_Saga`, `Titre`, `Description`, `Saison`, `Episode`, `Durée`, `Id_Categorie`) VALUES
(1, 1, 'The Avengers', 'The Avengers save the world from destruction', 1, 1, '02:23:00', 1),
(2, 1, 'Avengers: Age of Ultron', 'The Avengers fight against the Ultron', 2, 2, '02:21:00', 1),
(3, 1, 'Avengers: Infinity War', 'The Avengers fight against Thanos to save the universe', 3, 3, '02:29:00', 1),
(4, 2, 'Star Wars: Episode IV - A New Hope', 'A young boy becomes a hero in a galaxy far, far away', 1, 1, '02:01:00', 3),
(5, 2, 'Star Wars: Episode V - The Empire Strikes Back', 'The Empire strikes back against the Rebel Alliance', 2, 2, '02:04:00', 3),
(6, 2, 'Star Wars: Episode VI - Return of the Jedi', 'The Rebel Alliance fights against the Empire to restore freedom to the galaxy', 3, 3, '02:14:00', 3),
(7, 3, 'Harry Potter and the Philosopher''s Stone', 'A young boy discovers he is a wizard and attends Hogwarts School of Witchcraft and Wizardry', 1, 1, '02:32:00', 2);

INSERT INTO netflix.favoris (Id_Profil, Id_Video) VALUES 
(1, 1),
(2, 2),
(2, 6);

INSERT INTO netflix.distribution (Id_Personne, Id_Video, Id_Metier) VALUES 
(1, 1, 1),
(2, 2, 2), 
(4, 6, 1);

INSERT INTO netflix.note (Id_Video, Id_Profil, Note, Date) VALUES 
(1, 1, 'Bien', '2023-04-01'),
(5, 2, 'Pas bien', '2023-04-02');

INSERT INTO netflix.reprendre_lecture (Id_Profil, Id_Video, Temps_Lecture) VALUES
(1, 2, '00:15:23'),
(2, 4, '00:47:36'),
(3, 6, '01:02:15'),
(4, 1, '00:10:07');


-- PROCEDURE

-- Creation de la procedure creation_compte permettant de creer un nouveau compte si aucune valeur données n'est NULL, elle ne renvoie rien. Si une seule valeur (autre que id_abonnement est NULL, le message 'Les informations ne peuvent pas être vides' s'affiche

CREATE DEFINER=`root`@`localhost` PROCEDURE `creation_compte`(
    IN Nom VARCHAR(45),
    IN Prenom VARCHAR(45),
    IN Date_Naissance DATE,
    IN Email VARCHAR(45),
    IN MotDePasse VARCHAR(45),
    IN Id_Abonnement INT
)
BEGIN
	IF Nom IS NULL OR Prenom IS NULL OR Data_Naissance IS NULL OR Email IS NULL OR MotDePasse IS NULL THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Les informations ne peuvent pas être vides';		
    ELSE
		INSERT INTO netflix.compte (Nom, Prenom, Date_Naissance, Email, MotDePasse, Id_Abonnement) 
		VALUE (Nom, Prenom, Date_Naissance, Email, MotDePasse, Id_Abonnement)
		;
	END IF;
END


-- Creation de la procédure affichage_compte permettant d'afficher toutes les informations d'un compte uniquement avec son id.

CREATE PROCEDURE netflix.`affichage_compte`(
	IN id_compte INT,
    OUT Nom VARCHAR(45),
    OUT Prenom VARCHAR(45),
    OUT Date_Naissance DATE,
    OUT Email VARCHAR(45),
    OUT MotDePasse VARCHAR(45),
    OUT Id_Abonnement INT
)
BEGIN
	SELECT (Nom, Prenom, Date_Naissance, Email, MotDePasse, Id_Abonnement) 
    FROM netflix.compte
    WHERE id_compte = id_compte
    ;
END


-- Creation d'une précedure suppression_compte permettant de supprimer un compte et toutes les tables qui lui sont liées : favoris,reprendre_lecture et note qui sont lié a profil et qui doivent donc être supprimé avant. Profil est ensuite supprimé puis compte.

CREATE DEFINER=`root`@`localhost` PROCEDURE `suppression_compte`(
	IN id_compte INT
)
BEGIN
	DELETE FROM netflix.favoris
    WHERE favoris.Id_Profil IN 
		(SELECT netflix.profil.Id_Profil 
        FROM netflix.profil 
		WHERE netflix.profil.Id_Compte = id_compte);
    
    DELETE FROM netflix.reprendre_lecture
    WHERE reprendre_lecture.Id_Profil IN 
		(SELECT netflix.profil.Id_Profil 
        FROM netflix.profil 
		WHERE netflix.profil.Id_Compte = id_compte);
    
    DELETE FROM netflix.note
    WHERE note.Id_Profil IN 
		(SELECT netflix.profil.Id_Profil 
        FROM netflix.profil 
		WHERE netflix.profil.Id_Compte = id_compte);
    
	DELETE FROM netflix.profil
    WHERE netflix.profil.Id_Compte = id_compte
    ;
    
	DELETE FROM netflix.compte
    WHERE netflix.compte.id_compte = id_compte
    ;
END


-Création d'une procedure quivient mettre à jour la table compte ayant l'id utilisateur donné. On vient vérifié qu'aucune valeur donnée n'est NULL (sauf Id_Abonnement). Si l'abonnement existe dans la table abonnement alors on vient mettre a jour les colonnes de la ligne ayant l'id donnée. Si une des verification n'est pas respecté on affiche un message d'erreur

CREATE DEFINER=`root`@`localhost` PROCEDURE `maj_compte`(
	IN Id_Compte INT,
	IN Nom VARCHAR(45),
    IN Prenom VARCHAR(45),
    IN Date_Naissance DATE,
    IN Email VARCHAR(45),
    IN MotDePasse VARCHAR(45),
    IN Id_Abonnement INT
    )
BEGIN
	IF Id_Compte IS NULL OR Nom IS NULL OR Prenom IS NULL OR Data_Naissance IS NULL OR Email IS NULL OR MotDePasse IS NULL THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Les informations ne peuvent pas être vides';	
	ELSEIF EXISTS (SELECT * FROM netflix.abonnement WHERE netflix.abonnement.id_abonnement = Id_Abonnement) THEN
		UPDATE netflix.compte 
        SET netflix.compte.Nom = Nom, 
        netflix.compte.Prenom = Prenom, 
        netflix.compte.Date_Naissance = Date_Naissance, 
        netflix.compte.Email = Email, 
        netflix.compte.MotDePasse = MotDePasse,
        netflix.compte.Id_Abonnement = Id_Abonnement
        WHERE netflix.compte.id_compte = Id_Compte;
    ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = "L'abonnement choisit n'existe pas";	
	END IF;
END


-- On créé un trigger permettant d'inserer chaque modification de la table compte dans une seconde table nommée historique_compte servant de fichier log, on y stocke chaque colonne sans exception de la donnée modifié.

CREATE DEFINER=`root`@`localhost` TRIGGER `compte_AFTER_UPDATE` AFTER UPDATE ON `compte` FOR EACH ROW BEGIN
	INSERT INTO netflix.historique_compte (id_compte, Nom, Prenom, Date_Naissance, Email, MotDePasse, Id_Abonnement) 
    VALUES (netflix.compte.id_compte, 
    netflix.compte.Nom, 
    netflix.compte.Prenom, 
    netflix.compte.Date_Naissance, 
    netflix.compte.Email, 
    netflix.compte.MotDePasse, 
    netflix.compte.Id_Abonnement);
END	


-- ------------Creation de Vues

-- Pourcentage de bonne note pour chaque film ainsi que le nombre total de note
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `netflix`.`avis` AS
    SELECT 
        `netflix`.`video`.`id_video` AS `id_video`,
        `netflix`.`video`.`Titre` AS `Titre`,
        COUNT((CASE
            WHEN (`netflix`.`note`.`Note` = 'Bien') THEN 1
        END)) AS `notes_positives`,
        COUNT(`netflix`.`note`.`Note`) AS `total_notes`,
        ROUND(((COUNT((CASE
                    WHEN (`netflix`.`note`.`Note` = 'Bien') THEN 1
                END)) / COUNT(0)) * 100),
                2) AS `pourcentage_notes_positives`
    FROM
        (`netflix`.`video`
        LEFT JOIN `netflix`.`note` ON ((`netflix`.`video`.`id_video` = `netflix`.`note`.`Id_Video`)))
    GROUP BY `netflix`.`video`.`id_video`;

-- Affiche le nombre de video dans lequel chaque personne est marqué ainsi que le pourcentage de video dans lequel il se trouve
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `netflix`.`presence` AS
    SELECT 
        `netflix`.`personne`.`id_personne` AS `id_personne`,
        `netflix`.`personne`.`Prenom` AS `Prenom`,
        `netflix`.`personne`.`Nom` AS `Nom`,
        COUNT(`netflix`.`distribution`.`Id_Video`) AS `Nb_Videos`,
        ROUND(((COUNT(`netflix`.`distribution`.`Id_Video`) * 100) / (SELECT 
                        COUNT(0)
                    FROM
                        `netflix`.`video`)),
                2) AS `Pourcentage_Presence`
    FROM
        (`netflix`.`personne`
        JOIN `netflix`.`distribution` ON ((`netflix`.`personne`.`id_personne` = `netflix`.`distribution`.`Id_Personne`)))
    GROUP BY `netflix`.`personne`.`id_personne`
    ORDER BY `Nb_Videos` DESC;

-- Affiche le nombre de profil de chaque compte, ainsi que le nombre de profil moyen créé par compte pour l'ensemble du site
CREATE 
    ALGORITHM=UNDEFINED 
    DEFINER =`root`@`localhost` 
    SQL SECURITY DEFINER 
VIEW `netflix`.`nb_profil` AS 
    SELECT 
        `netflix`.`compte`.`Nom` AS `Nom`,
        `netflix`.`compte`.`Prenom` AS `Prenom`,
        COUNT(`netflix`.`profil`.`Id_Compte`) AS `nb_profil`,
        AVG(count(`netflix`.`profil`.`Id_Compte`)) OVER ()  AS `nb_moyen_profil` 
    FROM (`netflix`.`compte` 
        LEFT JOIN `netflix`.`profil` ON((`netflix`.`compte`.`id_compte` = `netflix`.`profil`.`Id_Compte`))) 
    GROUP BY `netflix`.`compte`.`id_compte`;

-- Affiche le nombre de ligne de chaque tables sauf historique_compte
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `netflix`.`stats` AS
    SELECT 
        'compte' AS `table_name`, COUNT(0) AS `nombre_lignes`
    FROM
        `netflix`.`compte` 
    UNION SELECT 
        'abonnement' AS `table_name`, COUNT(0) AS `nombre_lignes`
    FROM
        `netflix`.`abonnement` 
    UNION SELECT 
        'profil' AS `table_name`, COUNT(0) AS `nombre_lignes`
    FROM
        `netflix`.`profil` 
    UNION SELECT 
        'saga' AS `table_name`, COUNT(0) AS `nombre_lignes`
    FROM
        `netflix`.`saga` 
    UNION SELECT 
        'video' AS `table_name`, COUNT(0) AS `nombre_lignes`
    FROM
        `netflix`.`video` 
    UNION SELECT 
        'categorie' AS `table_name`, COUNT(0) AS `nombre_lignes`
    FROM
        `netflix`.`categorie` 
    UNION SELECT 
        'distribution' AS `table_name`, COUNT(0) AS `nombre_lignes`
    FROM
        `netflix`.`distribution` 
    UNION SELECT 
        'metier' AS `table_name`, COUNT(0) AS `nombre_lignes`
    FROM
        `netflix`.`metier` 
    UNION SELECT 
        'personne' AS `table_name`, COUNT(0) AS `nombre_lignes`
    FROM
        `netflix`.`personne` 
    UNION SELECT 
        'favoris' AS `table_name`, COUNT(0) AS `nombre_lignes`
    FROM
        `netflix`.`favoris` 
    UNION SELECT 
        'reprendre_lecture' AS `table_name`,
        COUNT(0) AS `nombre_lignes`
    FROM
        `netflix`.`reprendre_lecture` 
    UNION SELECT 
        'note' AS `table_name`, COUNT(0) AS `nombre_lignes`
    FROM
        `netflix`.`note`