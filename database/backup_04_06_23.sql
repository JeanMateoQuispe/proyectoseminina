/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 10.4.25-MariaDB : Database - db_matriculas
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_matriculas` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `db_matriculas`;

/*Table structure for table `carreras` */

DROP TABLE IF EXISTS `carreras`;

CREATE TABLE `carreras` (
  `idcarrera` int(11) NOT NULL AUTO_INCREMENT,
  `carrera` varchar(100) NOT NULL,
  `duracion` varchar(10) NOT NULL,
  `costo` decimal(7,2) DEFAULT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idcarrera`),
  UNIQUE KEY `uk_carrer_carrers` (`carrera`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;

/*Data for the table `carreras` */

insert  into `carreras`(`idcarrera`,`carrera`,`duracion`,`costo`,`estado`,`create_at`,`update_at`) values 
(1,'Ingenieria de Software','3 años',103.00,'1','2023-06-02 14:14:03','2023-06-04 09:34:25'),
(2,'Mecánica ','3 años',100.00,'1','2023-06-02 14:14:03','2023-06-04 09:42:38'),
(3,'Diseño Gráfico','3 años',350.50,'1','2023-06-02 14:14:03',NULL),
(4,'Administración','4 años',106.00,'1','2023-06-04 07:26:51','2023-06-04 09:27:14'),
(9,'Computación ','2 años',101.00,'1','2023-06-04 09:12:30','2023-06-04 09:17:32'),
(10,'Computación Informatica','3 años',90.00,'1','2023-06-04 09:33:23','2023-06-04 16:42:42');

/*Table structure for table `cursos` */

DROP TABLE IF EXISTS `cursos`;

CREATE TABLE `cursos` (
  `idcurso` int(11) NOT NULL AUTO_INCREMENT,
  `curso` varchar(50) NOT NULL,
  `creditos` int(11) NOT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idcurso`),
  UNIQUE KEY `uk_curso_curs` (`curso`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

/*Data for the table `cursos` */

insert  into `cursos`(`idcurso`,`curso`,`creditos`,`estado`,`create_at`,`update_at`) values 
(1,'Matemática',35,'1','2023-06-02 14:13:58','2023-06-04 16:10:23'),
(2,'Lenguaje',40,'1','2023-06-02 14:13:58',NULL),
(3,'Física',30,'1','2023-06-02 14:13:58',NULL),
(4,'Computación',25,'1','2023-06-02 14:13:58',NULL),
(5,'Inglés Avanzado',32,'1','2023-06-02 14:13:58','2023-06-04 16:14:41');

/*Table structure for table `detalles_carreras` */

DROP TABLE IF EXISTS `detalles_carreras`;

CREATE TABLE `detalles_carreras` (
  `iddtcarrs` int(11) NOT NULL AUTO_INCREMENT,
  `idcarrera` int(11) NOT NULL,
  `idcurso` int(11) NOT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`iddtcarrs`),
  KEY `fk_idcarr_carrs` (`idcarrera`),
  KEY `fk_idcur_curs` (`idcurso`),
  CONSTRAINT `fk_idcarr_carrs` FOREIGN KEY (`idcarrera`) REFERENCES `carreras` (`idcarrera`),
  CONSTRAINT `fk_idcur_curs` FOREIGN KEY (`idcurso`) REFERENCES `cursos` (`idcurso`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `detalles_carreras` */

insert  into `detalles_carreras`(`iddtcarrs`,`idcarrera`,`idcurso`,`estado`,`create_at`,`update_at`) values 
(1,1,1,'1','2023-06-02 14:14:06','2023-06-04 16:48:36'),
(2,2,2,'1','2023-06-02 14:14:06',NULL),
(3,3,3,'1','2023-06-02 14:14:06',NULL);

/*Table structure for table `detalles_cursos` */

DROP TABLE IF EXISTS `detalles_cursos`;

CREATE TABLE `detalles_cursos` (
  `iddtcurs` int(11) NOT NULL AUTO_INCREMENT,
  `idcurso` int(11) NOT NULL,
  `iddocente` int(11) NOT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`iddtcurs`),
  KEY `fk_idcurs_curs` (`idcurso`),
  KEY `fk_iddoc_docs` (`iddocente`),
  CONSTRAINT `fk_idcurs_curs` FOREIGN KEY (`idcurso`) REFERENCES `cursos` (`idcurso`),
  CONSTRAINT `fk_iddoc_docs` FOREIGN KEY (`iddocente`) REFERENCES `docentes` (`iddocente`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `detalles_cursos` */

insert  into `detalles_cursos`(`iddtcurs`,`idcurso`,`iddocente`,`estado`,`create_at`,`update_at`) values 
(1,1,1,'1','2023-06-02 14:14:00',NULL),
(2,2,2,'1','2023-06-02 14:14:00',NULL),
(3,3,3,'1','2023-06-02 14:14:00',NULL);

/*Table structure for table `docentes` */

DROP TABLE IF EXISTS `docentes`;

CREATE TABLE `docentes` (
  `iddocente` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) NOT NULL,
  `numdoc` varchar(11) NOT NULL,
  `fechanac` date NOT NULL,
  `telefono` char(9) DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `especialidad` varchar(80) DEFAULT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`iddocente`),
  UNIQUE KEY `uk_numdoc_doc` (`numdoc`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

/*Data for the table `docentes` */

insert  into `docentes`(`iddocente`,`nombres`,`numdoc`,`fechanac`,`telefono`,`correo`,`direccion`,`especialidad`,`estado`,`create_at`,`update_at`) values 
(1,'Mendoza Chia, Sergio','21598674','1985-03-07','953684215','sergiom@senati.pe','Chincha Baja','Redes','1','2023-06-02 14:13:55','2023-06-04 15:52:18'),
(2,'Medrano Enriquez, Karina','21598472','1989-05-07','953612125','','','','1','2023-06-02 14:13:55','2023-06-04 15:52:27'),
(3,'López Arteaga, Julio','46389569','1990-08-19','987456123','lopezjulio@senati.pe','Pueblo Nuevo','','1','2023-06-02 14:13:55','2023-06-04 16:52:10');

/*Table structure for table `estudiantes` */

DROP TABLE IF EXISTS `estudiantes`;

CREATE TABLE `estudiantes` (
  `idestudiante` int(11) NOT NULL AUTO_INCREMENT,
  `idmatricula` int(11) NOT NULL,
  `fechanac` date NOT NULL,
  `iddtcarrs` int(11) NOT NULL,
  `telefono` char(8) DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idestudiante`),
  UNIQUE KEY `uk_idmatric_matric` (`idmatricula`),
  KEY `fk_iddtcarrs_carrera` (`iddtcarrs`),
  CONSTRAINT `fk_iddtcarrs_carrera` FOREIGN KEY (`iddtcarrs`) REFERENCES `detalles_carreras` (`iddtcarrs`),
  CONSTRAINT `fk_idmatr_matric` FOREIGN KEY (`idmatricula`) REFERENCES `matriculas` (`idmatricula`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `estudiantes` */

insert  into `estudiantes`(`idestudiante`,`idmatricula`,`fechanac`,`iddtcarrs`,`telefono`,`correo`,`direccion`,`estado`,`create_at`,`update_at`) values 
(1,1,'2001-05-12',1,NULL,NULL,NULL,'1','2023-06-02 14:14:12',NULL),
(2,2,'2000-06-03',2,NULL,NULL,NULL,'1','2023-06-02 14:14:12',NULL),
(3,3,'2002-09-26',3,NULL,NULL,NULL,'1','2023-06-02 14:14:12',NULL);

/*Table structure for table `matriculas` */

DROP TABLE IF EXISTS `matriculas`;

CREATE TABLE `matriculas` (
  `idmatricula` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) NOT NULL,
  `numdoc` varchar(11) NOT NULL,
  `idcarrera` int(11) NOT NULL,
  `periodo` varchar(10) NOT NULL,
  `semestre` varchar(10) NOT NULL,
  `turno` varchar(10) NOT NULL,
  `fechainicio` date NOT NULL,
  `fechafinal` date DEFAULT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idmatricula`),
  UNIQUE KEY `uk_numdoc_matric` (`numdoc`),
  KEY `fk_idcar_carrs` (`idcarrera`),
  CONSTRAINT `fk_idcar_carrs` FOREIGN KEY (`idcarrera`) REFERENCES `carreras` (`idcarrera`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4;

/*Data for the table `matriculas` */

insert  into `matriculas`(`idmatricula`,`nombres`,`numdoc`,`idcarrera`,`periodo`,`semestre`,`turno`,`fechainicio`,`fechafinal`,`estado`,`create_at`,`update_at`) values 
(1,'Marcelo Aquije, Lucho','21548793',3,'2023-02','3 semestre','Noche','2023-06-12','2023-12-20','1','2023-06-02 14:14:10',NULL),
(2,'Pachas Meneses, Sergio','21365487',2,'2023-01','2 semestre','Tarde','2023-07-20','2023-01-15','1','2023-06-02 14:14:10',NULL),
(3,'Garay Ronceros, Ana','23569874',3,'2023-01','3 semestre','Noche','2023-08-21','2023-02-26','1','2023-06-02 14:14:10',NULL),
(56,'Poma Torres, Nayeli','25893641',1,'2023-02','5 semestre','Tarde','2023-07-06','2023-11-25','1','2023-06-04 16:16:36',NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

/*Data for the table `usuarios` */

insert  into `usuarios`(`idusuario`,`apellidos`,`nombres`,`fechanac`,`nombreusuario`,`clave`,`telefono`,`estado`,`create_at`,`update_at`) values 
(1,'Rosales Magallanes','Luis Alberto','1990-02-15','rosalesmagallanes@senati.pe','$2y$10$EBWySfGVZy/zLCsv3mzxn.McpdJwVDDYVzG0c3dXdfQO83Xfm/FMG','951357852','1','2023-06-02 14:13:20',NULL),
(2,'Rubio Pecho','Juana Rosa','1985-05-26','rubiopecho@senati.pe','$2y$10$EBWySfGVZy/zLCsv3mzxn.McpdJwVDDYVzG0c3dXdfQO83Xfm/FMG','987456123','1','2023-06-02 14:13:20',NULL),
(3,'Poma Torres','Ruth Antonia','1992-08-25','pomatorres@senati.pe','$2y$10$EBWySfGVZy/zLCsv3mzxn.McpdJwVDDYVzG0c3dXdfQO83Xfm/FMG','963842175','1','2023-06-02 14:13:20',NULL),
(4,'Yauca Saravia','Mario Raúl','1988-07-04','yaucasaravia@senati.pe','123456','913782647','1','2023-06-02 14:13:20',NULL);

/* Procedure structure for procedure `spu_actualizar_carreras` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_actualizar_carreras` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_actualizar_carreras`(
	IN _idcarrera	INT,
	IN _carrera 	VARCHAR(100),
	IN _duracion	VARCHAR(10),
	IN _costo	decimal(7.2)
)
BEGIN	
	UPDATE carreras  SET
		carrera		= _carrera,
		duracion 	= _duracion,
		costo		= _costo,
		update_at	= NOW()
	WHERE 	idcarrera = _idcarrera;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_actualizar_cursos` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_actualizar_cursos` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_actualizar_cursos`(
	in _idcurso int,
	in _curso varchar(50),
	in _creditos int
)
begin
update cursos set
	curso		= _curso,
	creditos 	= _creditos,
	update_at	= NOW()
	WHERE idcurso 	= _idcurso;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_actualizar_docentes` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_actualizar_docentes` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_actualizar_docentes`(
	IN _iddocente	INT,
	IN _nombres	VARCHAR(100),
	IN _numdoc 	VARCHAR(11),
	IN _fechanac 	DATE,
	IN _telefono	CHAR(9),
	IN _correo	VARCHAR(50),
	IN _direccion	VARCHAR(100),
	IN _especialidad VARCHAR(80)
)
BEGIN	
	UPDATE docentes SET
		nombres		= _nombres,
		numdoc 		= _numdoc,
		fechanac	= _fechanac,
		telefono	= _telefono,
		correo		= _correo,
		direccion 	= _direccion,
		especialidad 	= _especialidad,
		update_at	= NOW()
	WHERE 	iddocente = _iddocente;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_actualizar_dtcarreras` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_actualizar_dtcarreras` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_actualizar_dtcarreras`(
	IN _iddtcarrs	INT,
	IN _idcarrera 	VARCHAR(100),
	-- IN _duracion	VARCHAR(10),
	-- IN _costo	decimal(7,2),
	IN _idcurso	int
	-- IN _creditos	int
	
)
BEGIN	
	UPDATE detalles_carreras  SET
		idcarrera	= _idcarrera,
		-- duracion 	= _duracion,
		-- costo 		= _costo,
		idcurso		= _idcurso,
		-- creditos	= _creditos
		update_at	= NOW()
		
	WHERE iddtcarrs = _iddtcarrs;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_actualizar_matriculas` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_actualizar_matriculas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_actualizar_matriculas`(
	IN _idmatricula	INT,
	IN _nombres VARCHAR(100),
	IN _numdoc	VARCHAR(11),
	IN _idcarrera	INT,
	IN _periodo	VARCHAR(10),
	IN _semestre	VARCHAR(10),
	IN _turno	VARCHAR(10),
	IN _fechainicio DATE,
	IN _fechafinal 	DATE
)
BEGIN	
	UPDATE matriculas  SET
		nombres		= _nombres,
		numdoc 		= _numdoc,
		idcarrera 	= _idcarrera,
		periodo		= _periodo,
		semestre	= _semestre,
		turno		= _turno,
		fechainicio	= _fechainicio,
		fechafinal	= _fechafinal
	WHERE idmatricula = _idmatricula;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_eliminar_carreras` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_eliminar_carreras` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_eliminar_carreras`(
	IN _idcarrera INT
)
BEGIN
	DELETE FROM carreras WHERE idcarrera = _idcarrera;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_eliminar_cursos` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_eliminar_cursos` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_eliminar_cursos`(
	IN _idcurso INT
)
BEGIN
	DELETE FROM cursos WHERE idcurso = _idcurso;
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

/* Procedure structure for procedure `spu_eliminar_dtcarreras` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_eliminar_dtcarreras` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_eliminar_dtcarreras`(
	IN _iddtcarrs INT
)
BEGIN
	DELETE FROM detalles_carreras WHERE iddtcarrs = _iddtcarrs;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_eliminar_matriculas` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_eliminar_matriculas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_eliminar_matriculas`(
	IN _idmatricula INT
)
BEGIN
	DELETE FROM matriculas WHERE idmatricula = _idmatricula;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_listarestudiantes` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_listarestudiantes` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listarestudiantes`()
begin
select 
	estudiantes.idestudiante,
	matriculas.nombres,
	carreras.carrera,
	cursos.curso,
	fechanac,
	telefono,
	correo,
	direccion
from estudiantes
	inner join matriculas on matriculas.idmatricula = estudiantes.idmatricula
	inner join detalles_carreras on detalles_carreras.idcarrera = estudiantes.iddtcarrs
	inner join cursos on cursos.idcurso = detalles_carreras.idcurso
	inner join carreras on carreras.idcarrera = detalles_carreras.idcarrera
	order by idestudiante desc;
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_listar_carreras` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_listar_carreras` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_carreras`()
BEGIN
SELECT
	carreras.`idcarrera`,
	carreras.`carrera`,
	carreras.`duracion`,
	carreras.`costo`
	

FROM carreras
	ORDER BY idcarrera DESC;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_listar_cursos` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_listar_cursos` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_cursos`()
begin
select 
	idcurso,
	curso,
	creditos
from cursos
	order by idcurso desc;
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_listar_docentes` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_listar_docentes` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_docentes`()
BEGIN
SELECT 
	docentes.`iddocente`,
	docentes.`nombres`,
	docentes.`fechanac`,
	docentes.`telefono`,
	docentes.`correo`,
	docentes.`direccion`,
	docentes.`especialidad`
	
FROM docentes
	ORDER BY iddocente DESC;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_listar_dtcarreras` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_listar_dtcarreras` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_dtcarreras`()
begin
SELECT 
	detalles_carreras.iddtcarrs,
	carreras.carrera,
	duracion,
	costo,
	cursos.curso,
	creditos
FROM detalles_carreras
	INNER JOIN carreras ON carreras.idcarrera = detalles_carreras.idcarrera
	INNER JOIN cursos ON cursos.idcurso = detalles_carreras.idcurso
	ORDER BY iddtcarrs DESC;
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_listar_estudiantes` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_listar_estudiantes` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_estudiantes`()
begin
select	
	estudiantes.`idestudiante`,
	matriculas.`nombres`,
	estudiantes.`fechanac`,
	estudiantes.`telefono`,
	estudiantes.`correo`,
	estudiantes.`direccion`
from estudiantes
	inner join matriculas on matriculas.`idmatricula` = estudiantes.`idmatricula`
	order by idestudiante desc;
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_listar_matriculas` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_listar_matriculas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_matriculas`()
begin
select
	matriculas.`idmatricula`,
	matriculas.`nombres`,
	carreras.`carrera`,
	matriculas.`periodo`,
	matriculas.`semestre`,
	matriculas.`turno`,
	matriculas.`fechainicio`,
	matriculas.`fechafinal`,
	carreras.`costo`
from matriculas
	inner join carreras on carreras.`idcarrera` = matriculas.`idcarrera`
	order by idmatricula desc;
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_matriculados_buscar_dni` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_matriculados_buscar_dni` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_matriculados_buscar_dni`(IN _numdoc VARCHAR(11))
BEGIN
	SELECT	matriculas.`idmatricula`,
		matriculas.`nombres`,
		carreras.`carrera`,
		matriculas.`periodo`,
		matriculas.`semestre`,
		matriculas.`turno`,
		matriculas.`fechainicio`,
		matriculas.`fechafinal`,
		carreras.`costo`
		FROM matriculas
		INNER JOIN carreras ON carreras.`idcarrera` = matriculas.`idcarrera`
		WHERE matriculas.`numdoc` = _numdoc AND matriculas.estado = '1';
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_obtener_carreras` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_obtener_carreras` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_obtener_carreras`(
	IN _idcarrera INT
)
BEGIN
	SELECT * FROM carreras WHERE idcarrera = _idcarrera;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_obtener_cursos` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_obtener_cursos` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_obtener_cursos`(
	IN _idcurso INT
)
BEGIN
	SELECT * FROM cursos WHERE idcurso = _idcurso;
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

/* Procedure structure for procedure `spu_obtener_dtcarreras` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_obtener_dtcarreras` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_obtener_dtcarreras`(
	IN _iddtcarrs INT
)
BEGIN
	SELECT * FROM detalles_carreras WHERE iddtcarrs = _iddtcarrs;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_obtener_matriculas` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_obtener_matriculas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_obtener_matriculas`(
	IN _idmatricula INT
)
BEGIN
	SELECT * FROM matriculas WHERE idmatricula = _idmatricula;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_registrar_carreras` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_registrar_carreras` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_registrar_carreras`(
	IN _carrera	VARCHAR(100),
	IN _duracion 	VARCHAR(10),
	IN _costo 	decimal(7,2)	
)
BEGIN
INSERT INTO carreras(carrera,duracion,costo) VALUES
	(_carrera,_duracion,_costo);
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_registrar_cursos` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_registrar_cursos` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_registrar_cursos`(
	in _curso varchar(50),
	in _creditos int
)
begin
insert into cursos (curso, creditos) values
	(_curso, _creditos);
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_registrar_docentes` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_registrar_docentes` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_registrar_docentes`(
	IN _nombres	VARCHAR(100),
	IN _numdoc 	VARCHAR(11),
	IN _fechanac 	date,
	IN _telefono	char(9),
	IN _correo	VARCHAR(50),
	IN _direccion	VARCHAR(100),
	IN _especialidad varchar(80)

	
)
BEGIN
INSERT INTO docentes (nombres,numdoc,fechanac,telefono,correo,direccion,especialidad) VALUES
	(_nombres,_numdoc,_fechanac,_telefono,_correo,_direccion,_especialidad);
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_registrar_matriculas` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_registrar_matriculas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_registrar_matriculas`(
	in _nombres	varchar(100),
	in _numdoc 	varchar(11),
	in _idcarrera 	int,
	in _periodo	varchar(10),
	in _semestre 	varchar(10),
	in _turno	varchar(10),
	in _fechainicio	date,
	in _fechafinal 	date
	
)
begin
insert into matriculas (nombres,numdoc,idcarrera,periodo,semestre,turno,fechainicio,fechafinal) values
	(_nombres,_numdoc,_idcarrera,_periodo,_semestre,_turno,_fechainicio,_fechafinal);
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
