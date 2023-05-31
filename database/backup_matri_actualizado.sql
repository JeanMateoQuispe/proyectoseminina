/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 10.4.25-MariaDB : Database - matricula
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`matricula` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `matricula`;

/*Table structure for table `alumnos_matriculas` */

DROP TABLE IF EXISTS `alumnos_matriculas`;

CREATE TABLE `alumnos_matriculas` (
  `idmatricula` int(11) NOT NULL AUTO_INCREMENT,
  `alumno` varchar(100) NOT NULL,
  `fechanac` date NOT NULL,
  `numdoc` varchar(11) NOT NULL,
  `iddocente` int(11) NOT NULL,
  `idcarrera` int(11) NOT NULL,
  `periodo` varchar(10) NOT NULL,
  `semestre` varchar(10) NOT NULL,
  `fechainicio` date NOT NULL,
  `fechafinal` date DEFAULT NULL,
  `pago` decimal(7,2) DEFAULT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idmatricula`),
  UNIQUE KEY `uk_numdoc_alum` (`numdoc`),
  KEY `fk_docent_docentes` (`iddocente`),
  KEY `fk_idcarre_carre` (`idcarrera`),
  CONSTRAINT `fk_docent_docentes` FOREIGN KEY (`iddocente`) REFERENCES `docentes` (`iddocente`),
  CONSTRAINT `fk_idcarre_carre` FOREIGN KEY (`idcarrera`) REFERENCES `carreras` (`idcarrera`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

/*Data for the table `alumnos_matriculas` */

insert  into `alumnos_matriculas`(`idmatricula`,`alumno`,`fechanac`,`numdoc`,`iddocente`,`idcarrera`,`periodo`,`semestre`,`fechainicio`,`fechafinal`,`pago`,`estado`,`create_at`,`update_at`) values 
(1,'Marcelo Aquije, Roger','2000-05-12','21548796',1,1,'2023','I','2023-06-12','2023-08-29',537.50,'1','2023-05-23 22:43:17',NULL),
(2,'Garay Ronceros, Ana','2001-06-20','21365487',2,2,'2023','II','2023-07-20','2024-01-27',645.50,'1','2023-05-23 22:43:17',NULL),
(3,'Pachas Meneses, Sergio','2002-09-15','23569874',3,3,'2023','III','2023-08-21','2023-10-27',706.30,'1','2023-05-23 22:43:17',NULL),
(4,'Luque Diaz, Luis','2001-08-12','21548799',1,1,'2023','II','2023-06-12','2023-12-08',537.50,'1','2023-05-28 17:00:03',NULL),
(5,'Huaman Anchante, Jose','2000-02-06','95368412',1,1,'2023','I','2023-06-06','2023-12-15',537.50,'1','2023-05-29 14:10:57',NULL),
(13,'Lima Liscay, Roberto','2001-05-09','36987545',2,1,'2023','III','2023-06-18','2023-12-23',537.50,'1','2023-05-29 19:29:54',NULL);

/*Table structure for table `carreras` */

DROP TABLE IF EXISTS `carreras`;

CREATE TABLE `carreras` (
  `idcarrera` int(11) NOT NULL AUTO_INCREMENT,
  `idcurso` int(11) DEFAULT NULL,
  `nombrecarrera` varchar(100) NOT NULL,
  `duracion` int(11) NOT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idcarrera`),
  UNIQUE KEY `uk_nomcarre_carreras` (`nombrecarrera`),
  KEY `fk_curso_cursos` (`idcurso`),
  CONSTRAINT `fk_curso_cursos` FOREIGN KEY (`idcurso`) REFERENCES `cursos` (`idcurso`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `carreras` */

insert  into `carreras`(`idcarrera`,`idcurso`,`nombrecarrera`,`duracion`,`estado`,`create_at`,`update_at`) values 
(1,1,'Ingenieria de Software',3,'1','2023-05-23 22:42:59',NULL),
(2,2,'Ingenieria Ambiental',3,'1','2023-05-23 22:42:59',NULL),
(3,3,'Ingenieria Industrial',3,'1','2023-05-23 22:42:59',NULL);

/*Table structure for table `cursos` */

DROP TABLE IF EXISTS `cursos`;

CREATE TABLE `cursos` (
  `idcurso` int(11) NOT NULL AUTO_INCREMENT,
  `nombrecurso` varchar(100) NOT NULL,
  `creditos` int(11) NOT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  `idmatricula` int(11) DEFAULT NULL,
  PRIMARY KEY (`idcurso`),
  UNIQUE KEY `uk_nomcur_cursos` (`nombrecurso`),
  KEY `fk_idmatric_matricu` (`idmatricula`),
  CONSTRAINT `fk_idmatric_matricu` FOREIGN KEY (`idmatricula`) REFERENCES `alumnos_matriculas` (`idmatricula`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `cursos` */

insert  into `cursos`(`idcurso`,`nombrecurso`,`creditos`,`estado`,`create_at`,`update_at`,`idmatricula`) values 
(1,'Matemática',40,'1','2023-05-23 22:42:53',NULL,NULL),
(2,'Lenguaje',40,'1','2023-05-23 22:42:53',NULL,NULL),
(3,'Física',30,'1','2023-05-23 22:42:53',NULL,NULL),
(4,'Computación',25,'1','2023-05-23 22:42:53',NULL,NULL),
(5,'Inglés',30,'1','2023-05-23 22:42:53',NULL,NULL);

/*Table structure for table `docentes` */

DROP TABLE IF EXISTS `docentes`;

CREATE TABLE `docentes` (
  `iddocente` int(11) NOT NULL AUTO_INCREMENT,
  `docente` varchar(100) NOT NULL,
  `fechanac` date NOT NULL,
  `numdoc` varchar(11) NOT NULL,
  `especialidad` varchar(100) DEFAULT NULL,
  `idcurso` int(11) NOT NULL,
  `idcarrera` int(11) NOT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`iddocente`),
  UNIQUE KEY `uk_numdoc_doc` (`numdoc`),
  KEY `fk_idcur_curs` (`idcurso`),
  CONSTRAINT `fk_idcur_curs` FOREIGN KEY (`idcurso`) REFERENCES `cursos` (`idcurso`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `docentes` */

insert  into `docentes`(`iddocente`,`docente`,`fechanac`,`numdoc`,`especialidad`,`idcurso`,`idcarrera`,`estado`,`create_at`,`update_at`) values 
(1,'Mendoza Chia, Sergio','1985-03-08','21598674','Matemática cuantica',1,1,'1','2023-05-23 22:43:03',NULL),
(2,'Medrano Enriquez, Karina','1989-05-07','21598472','',2,2,'1','2023-05-23 22:43:03',NULL),
(3,'López Arteaga, Julio','1990-08-19','46389567','',3,3,'1','2023-05-23 22:43:03',NULL),
(5,'Nieto Galvez, Romero','1970-09-15','23587419','Redes',4,1,'1','2023-05-29 22:00:42',NULL);

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `idusuario` int(11) NOT NULL AUTO_INCREMENT,
  `apellidos` varchar(50) NOT NULL,
  `nombres` varchar(50) NOT NULL,
  `fechanac` date NOT NULL,
  `nombreusuario` varchar(50) NOT NULL,
  `clave` varchar(90) NOT NULL,
  `telefono` char(9) DEFAULT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `uk_nomusua_usu` (`nombreusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `usuarios` */

insert  into `usuarios`(`idusuario`,`apellidos`,`nombres`,`fechanac`,`nombreusuario`,`clave`,`telefono`,`estado`,`create_at`,`update_at`) values 
(1,'Rosales Magallanes','Luis Alberto','1990-02-15','rosalesmagallanes@senati.pe','$2y$10$ZTQq8DFJLjHDSuhryl3/oepYvZqqljRKG.bd.jx9g8lVkLhVwnaMG','951357852','1','2023-05-23 22:42:04',NULL),
(2,'Rubio Pecho','Juana Rosa','1985-05-26','rubiopecho@senati.pe','123456','987456123','1','2023-05-23 22:42:04',NULL),
(3,'Poma Torres','Ruth Antonia','1992-08-25','pomatorres@senati.pe','123456','963842175','1','2023-05-23 22:42:04',NULL),
(4,'Yauca Saravia','Mario Raúl','1988-07-04','yaucasaravia@senati.pe','123456','913782647','1','2023-05-23 22:42:04',NULL),
(5,'Puma Cossio','Erick','1993-01-13','pumacossio@senati.pe','123456','913782786','1','2023-05-28 12:30:44',NULL);

/* Procedure structure for procedure `spu_actualizar_docentes` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_actualizar_docentes` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_actualizar_docentes`(
	IN _iddocente	INT,
	IN _docente 	VARCHAR(100),
	IN _fechanac	DATE,
	IN _numdoc	VARCHAR(11),
	in _especialidad varchar(100),
	IN _idcurso	INT,
	IN _idcarrera	INT	
)
BEGIN	
	UPDATE docentes SET
		docente 	= _docente,
		fechanac 	= _fechanac,
		numdoc 		= _numdoc,
		especialidad	= _especialidad,
		idcurso 	= _idcurso,
		idcarrera 	= _idcarrera
		
	WHERE iddocente = _iddocente;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_actualizar_matriculas` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_actualizar_matriculas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_actualizar_matriculas`(
	IN _idmatricula	INT,
	IN _matriculado VARCHAR(100),
	IN _fechanac	DATE,
	IN _numdoc	VARCHAR(11),
	IN _iddocente	INT,
	IN _idcarrera	INT,
	IN _periodo	VARCHAR(10),
	IN _semestre	VARCHAR(10),
	IN _fechainicio DATE,
	IN _fechafinal 	DATE,
	IN _pago	DECIMAL(7,2)
)
begin	
	UPDATE alumnos_matriculas  SET
		alumno 		= _matriculado,
		fechanac 	= _fechanac,
		numdoc 		= _numdoc,
		iddocente 	= _iddocente,
		idcarrera 	= _idcarrera,
		periodo		= _periodo,
		semestre	= _semestre,
		fechainicio	= _fechainicio,
		fechafinal	= _fechafinal,
		pago		= _pago
	WHERE idmatricula = _idmatricula;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_eliminar_docentes` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_eliminar_docentes` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_eliminar_docentes`(
	IN _iddocente INT
)
BEGIN
	DELETE FROM docentes WHERE iddocente = _iddocente;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_eliminar_matriculas` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_eliminar_matriculas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_eliminar_matriculas`(
	IN _idmatricula INT
)
BEGIN
	DELETE FROM alumnos_matriculas WHERE idmatricula = _idmatricula;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_listar_docentes` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_listar_docentes` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_docentes`()
BEGIN
SELECT
	docentes.`iddocente`,
	docentes.`docente`,
	-- docentes.`fechanac`,
	-- docentes.`numdoc`,
	docentes.`especialidad`,
	cursos.`nombrecurso`
	-- carreras.`nombrecarrera`

	
FROM docentes
	INNER JOIN cursos ON cursos.`idcurso` = docentes.`idcurso`
	-- inner join carreras on carreras.`idcarrera` = docentes.`idcarrera`
-- WHERE idmatricula = _idmatricula;
	ORDER BY iddocente DESC;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_listar_matricula` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_listar_matricula` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_matricula`()
BEGIN
SELECT
	alumnos_matriculas.`idmatricula`,
	alumnos_matriculas.`alumno`,
	docentes.`docente`,
	carreras.`nombrecarrera`,
	alumnos_matriculas.`periodo`,
	alumnos_matriculas.`semestre`,
	alumnos_matriculas.`fechainicio`,
	alumnos_matriculas.`fechafinal`,
	alumnos_matriculas.`pago`
FROM alumnos_matriculas
	INNER JOIN docentes ON docentes.`iddocente` = alumnos_matriculas.`iddocente`
	INNER JOIN carreras ON carreras.`idcarrera` = alumnos_matriculas.`idcarrera`
-- WHERE idmatricula = _idmatricula;
	order by idmatricula desc;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_listar_usuarios` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_listar_usuarios` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_usuarios`()
BEGIN
SELECT
	usuarios.`idusuario`,
	usuarios.`apellidos`,
	usuarios.`nombres`,
	usuarios.`fechanac`,
	usuarios.`nombreusuario`
FROM usuarios;
	
-- WHERE idmatricula = _idmatricula;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_obtener_docentes` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_obtener_docentes` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_obtener_docentes`(
	IN _iddocente INT
)
BEGIN
	SELECT * FROM docentes WHERE iddocente = _iddocente;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_obtener_matriculas` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_obtener_matriculas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_obtener_matriculas`(
	IN _idmatricula INT
)
BEGIN
	SELECT * FROM alumnos_matriculas WHERE idmatricula = _idmatricula;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_registrar_docente` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_registrar_docente` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_registrar_docente`(
	IN _docente	VARCHAR(100),
	IN _fechanac	DATE,
	IN _numdoc	VARCHAR(11),
	IN _especialidad varchar(100),
	IN _idcurso	int,
	IN _idcarrera	INT
)
BEGIN
INSERT INTO docentes (docente,fechanac,numdoc,especialidad,idcurso,idcarrera) VALUES 
	(_docente,_fechanac,_numdoc,_especialidad,_idcurso,_idcarrera);  
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_registrar_matricula` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_registrar_matricula` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_registrar_matricula`(
	IN _matriculado VARCHAR(100),
	IN _fechanac	DATE,
	IN _numdoc	VARCHAR(11),
	IN _iddocente	INT,
	IN _idcarrera	INT,
	IN _periodo	VARCHAR(10),
	IN _semestre	VARCHAR(10),
	IN _fechainicio DATE,
	IN _fechafinal 	DATE,
	IN _pago	DECIMAL(7,2)
)
BEGIN
INSERT INTO alumnos_matriculas (alumno,fechanac,numdoc,iddocente,idcarrera,periodo,semestre,fechainicio,fechafinal,pago) VALUES 
	(_matriculado,_fechanac,_numdoc,_iddocente,_idcarrera,_periodo,_semestre,_fechainicio,_fechafinal,_pago);  
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_registrar_usuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_registrar_usuario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_registrar_usuario`(
	in _apellidos 		varchar(50),
	in _nombres 		varchar(50),
	in _fechanac 		date,
	in _nombreusuario 	varchar(50),
	in _clave		varchar(90),
	in _telefono		char(9)
)
begin 
	insert into usuarios (apellidos,nombres,fechanac,nombreusuario,clave,telefono) values
		(_apellidos, _nombres, _fechanac, _nombreusuario, _clave, _telefono);
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_usuarios_login` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_usuarios_login` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_login`(IN _nombreusuario VARCHAR(50))
BEGIN
	SELECT	idusuario,
				apellidos,
				nombres,
				nombreusuario,
				clave
		FROM usuarios 
		WHERE nombreusuario = _nombreusuario AND estado = '1';
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
