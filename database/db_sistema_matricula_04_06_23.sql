CREATE DATABASE db_matriculas;
USE db_matriculas;


CREATE TABLE docentes
(
	iddocente	INT AUTO_INCREMENT PRIMARY KEY,
	nombres		VARCHAR(100)	NOT NULL,
	numdoc		VARCHAR(11)	NOT NULL,
	fechanac	DATE 		NOT NULL,
	telefono	CHAR(9)		NULL,
	correo		VARCHAR(50)	NULL,
	direccion	VARCHAR(100)	NULL,
	especialidad	VARCHAR(80)	NULL,
	estado		CHAR(1)		NOT NULL DEFAULT '1',
	create_at	DATETIME	NOT NULL DEFAULT NOW(),
	update_at	DATETIME	NULL,
	CONSTRAINT uk_numdoc_doc UNIQUE(numdoc)
)ENGINE = INNODB;

CREATE TABLE cursos
(
	idcurso		INT AUTO_INCREMENT PRIMARY KEY,
	curso 		VARCHAR(50)	NOT NULL,
	creditos	INT 		NOT NULL,
	estado		CHAR(1)		NOT NULL DEFAULT '1',
	create_at	DATETIME	NOT NULL DEFAULT NOW(),
	update_at	DATETIME	NULL,
	CONSTRAINT uk_curso_curs UNIQUE(curso)
)ENGINE = INNODB;	

CREATE TABLE detalles_cursos
(
	iddtcurs	INT AUTO_INCREMENT PRIMARY KEY,
	idcurso		INT 		NOT NULL,
	iddocente	INT 		NOT NULL,
	estado		CHAR(1)		NOT NULL DEFAULT '1',
	create_at	DATETIME	NOT NULL DEFAULT NOW(),
	update_at	DATETIME	NULL,
	CONSTRAINT fk_idcurs_curs FOREIGN KEY (idcurso) REFERENCES cursos (idcurso),
	CONSTRAINT fk_iddoc_docs FOREIGN KEY (iddocente) REFERENCES docentes (iddocente)
)ENGINE = INNODB;

SELECT * FROM detalles_cursos;


SELECT 
	detalles_cursos.iddtcurs,
	cursos.curso,
	docentes.`nombres`
FROM detalles_cursos
	INNER JOIN docentes ON docentes.`iddocente` = detalles_cursos.iddocente
	INNER JOIN cursos ON cursos.idcurso = detalles_cursos.idcurso
	ORDER BY iddtcurs DESC;

CREATE TABLE carreras
(
	idcarrera	INT AUTO_INCREMENT PRIMARY KEY,
	carrera 	VARCHAR(100)	NOT NULL,
	duracion	VARCHAR(10)	NOT NULL,
	costo		DECIMAL(7,2)	NULL,
	estado		CHAR(1)		NOT NULL DEFAULT '1',
	create_at	DATETIME	NOT NULL DEFAULT NOW(),
	update_at	DATETIME	NULL,
	CONSTRAINT uk_carrer_carrers UNIQUE(carrera)
)ENGINE = INNODB;

CREATE TABLE detalles_carreras
(
	iddtcarrs	INT AUTO_INCREMENT PRIMARY KEY,
	idcarrera	INT 		NOT NULL,
	idcurso 	INT 		NOT NULL,
	estado		CHAR(1)		NOT NULL DEFAULT '1',
	create_at	DATETIME	NOT NULL DEFAULT NOW(),
	update_at	DATETIME	NULL,
	CONSTRAINT fk_idcarr_carrs FOREIGN KEY (idcarrera) REFERENCES carreras (idcarrera),
	CONSTRAINT fk_idcur_curs FOREIGN KEY (idcurso) REFERENCES cursos (idcurso)
)ENGINE = INNODB;

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

CREATE TABLE matriculas
(
	idmatricula	INT AUTO_INCREMENT PRIMARY KEY,
	nombres		VARCHAR(100)	NOT NULL,
	numdoc		VARCHAR(11)	NOT NULL,
	idcarrera	INT 		NOT NULL,
	periodo		VARCHAR(10)	NOT NULL,
	semestre	VARCHAR(10) 	NOT NULL,
	turno		VARCHAR(10)	NOT NULL,
	fechainicio	DATE 		NOT NULL,
	fechafinal   	DATE 		NULL,
	estado		CHAR(1)		NOT NULL DEFAULT '1',
	create_at	DATETIME	NOT NULL DEFAULT NOW(),
	update_at	DATETIME	NULL,
	CONSTRAINT fk_idcar_carrs FOREIGN KEY (idcarrera) REFERENCES carreras(idcarrera),
	CONSTRAINT uk_numdoc_matric UNIQUE(numdoc)
)ENGINE = INNODB;

CREATE TABLE estudiantes
(
	idestudiante	INT AUTO_INCREMENT PRIMARY KEY,
	idmatricula	INT 		NOT NULL,
	fechanac	DATE 		NOT NULL,
	iddtcarrs	INT 		NOT NULL,
	telefono	CHAR(8)		NULL,
	correo		VARCHAR(50)	NULL,
	direccion	VARCHAR(100)	NULL,
	estado		CHAR(1)		NOT NULL DEFAULT '1',
	create_at	DATETIME	NOT NULL DEFAULT NOW(),
	update_at	DATETIME	NULL,
	CONSTRAINT fk_idmatr_matric FOREIGN KEY (idmatricula) REFERENCES matriculas (idmatricula),
	CONSTRAINT uk_idmatric_matric UNIQUE(idmatricula),
	CONSTRAINT fk_iddtcarrs_carrera FOREIGN KEY (iddtcarrs) REFERENCES detalles_carreras (iddtcarrs)
)ENGINE = INNODB;
SELECT * FROM estudiantes;


CALL spu_listarestudiantes();
CREATE TABLE usuarios
(
	idusuario	INT AUTO_INCREMENT PRIMARY KEY,
	apellidos	VARCHAR(50) 	NOT NULL,
	nombres		VARCHAR(50) 	NOT NULL,
	fechanac	DATE 		NOT NULL,		
	nombreusuario	VARCHAR(50) 	NOT NULL,
	clave		VARCHAR(90) 	NOT NULL,
	telefono	CHAR(9) 	NULL,
	estado		CHAR(1)		NOT NULL DEFAULT '1',
	create_at	DATETIME	NOT NULL  DEFAULT NOW(),
	update_at	DATETIME	NULL,
	CONSTRAINT uk_nomusua_usu UNIQUE(nombreusuario)
)ENGINE = INNODB;



DELIMITER $$
CREATE PROCEDURE spu_usuarios_login(IN _nombreusuario VARCHAR(50))
BEGIN
	SELECT	idusuario,
				apellidos,
				nombres,
				nombreusuario,
				clave
		FROM usuarios 
		WHERE nombreusuario = _nombreusuario AND estado = '1';
END $$
SELECT * FROM usuarios;
-- INSERTAMOS REGISTROS A LA TABLA USUARIOS
INSERT INTO usuarios (apellidos,nombres,fechanac,nombreusuario,clave,telefono) VALUES
	('Rosales Magallanes','Luis Alberto','1990-02-15','rosalesmagallanes@senati.pe','123456','951357852'),
	('Rubio Pecho','Juana Rosa','1985-05-26','rubiopecho@senati.pe','123456','987456123'),
	('Poma Torres','Ruth Antonia','1992-08-25','pomatorres@senati.pe','123456','963842175'),
	('Yauca Saravia','Mario Raúl','1988-07-04','yaucasaravia@senati.pe','123456','913782647')
	
-- ACTUALIZAMOS LA CLAVE DE LOS USUARIOS
UPDATE usuarios SET
clave = '$2y$10$EBWySfGVZy/zLCsv3mzxn.McpdJwVDDYVzG0c3dXdfQO83Xfm/FMG'
WHERE idusuario =3;

-- INSERTANDO REGISTROS A LA TABLA DOCENTES	
INSERT INTO docentes(nombres,numdoc,fechanac,especialidad) VALUES
	('Mendoza Chia, Sergio','21598674','1985-03-08','Redes'),
	('Medrano Enriquez, Karina','21598472','1989-05-07',''),
	('López Arteaga, Julio','46389567','1990-08-19','')
DELETE FROM matriculas;
ALTER TABLE docentes AUTO_INCREMENT 1;	
SELECT * FROM matriculas;

-- INSERTANDO REGISTROS A LA TABLA CURSOS
INSERT INTO cursos(curso,creditos) VALUES
	('Matemática',40),
	('Lenguaje',40),
	('Física',30),
	('Computación',25),
	('Inglés',30)
	
-- INSERTANDO REGISTROS A LA TABLA DETALLES_CURSOS
INSERT INTO detalles_cursos (idcurso, iddocente) VALUES
		(1,1),
		(2,2),
		(3,3)

-- INSERTANDO REGISTROS A LA TABLA CARRERAS
INSERT INTO carreras (carrera, duracion,costo) VALUES
	('Ingenieria de Software','3 años',350.5),
	('Mécanica Automotriz','4 años',320.7),
	('Diseño Gráfico','3 años',350.5)
	
-- INSERTANDO REGISTROS A LA TABLA DETALLES_CURSOS
INSERT INTO detalles_carreras (idcarrera, idcurso) VALUES
		(1,1),
		(2,2),
		(3,3)

-- INSERTANDO REGISTROS A LA TABLA MATRICULAS
INSERT INTO matriculas (nombres,numdoc,idcarrera,periodo,semestre,turno,fechainicio,fechafinal) VALUES
	('Marcelo Aquije, Roger','21548796',1,'2023-01','1 semestre','Mañana','2023-06-12','2023-12-12'),
	('Pachas Meneses, Sergio','21365487',2,'2023-01','2 semestre','Tarde','2023-07-20','2023-01-15'),
	('Garay Ronceros, Ana','23569874',3,'2023-01','3 semestre','Noche','2023-08-21','2023-02-26')

DELETE FROM matriculas;
ALTER TABLE docentes AUTO_INCREMENT 1;	
-- INSERTANDO REGISTROS A LA TABLA ESTUDIANTES
INSERT INTO estudiantes (idmatricula,fechanac,iddtcarrs) VALUES
	(1,'2001-05-12',1),
	(2,'2000-06-03',2),
	(3,'2002-09-26',3)
SELECT * FROM estudiantes;
SELECT * FROM detalles_carreras;

-- CREAMOS PROCEDIMIENTOS ALMACENADOS

-- LISTAR_MATRICULAS
DELIMITER $$
CREATE PROCEDURE spu_listar_matriculas()
BEGIN
SELECT
	matriculas.`idmatricula`,
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
	ORDER BY idmatricula DESC;
END $$

CALL spu_listar_matriculas();

-- REGISTRAR_MATRICULAS
DELIMITER $$
CREATE PROCEDURE spu_registrar_matriculas
(
	IN _nombres	VARCHAR(100),
	IN _numdoc 	VARCHAR(11),
	IN _idcarrera 	INT,
	IN _periodo	VARCHAR(10),
	IN _semestre 	VARCHAR(10),
	IN _turno	VARCHAR(10),
	IN _fechainicio	DATE,
	IN _fechafinal 	DATE
	
)
BEGIN
INSERT INTO matriculas (nombres,numdoc,idcarrera,periodo,semestre,turno,fechainicio,fechafinal) VALUES
	(_nombres,_numdoc,_idcarrera,_periodo,_semestre,_turno,_fechainicio,_fechafinal);
END $$

-- LISTAR ESTUDIANTE
DELIMITER $$
CREATE PROCEDURE spu_listar_estudiantes()
BEGIN
SELECT	
	estudiantes.`idestudiante`,
	matriculas.`nombres`,
	estudiantes.`fechanac`,
	estudiantes.`telefono`,
	estudiantes.`correo`,
	estudiantes.`direccion`
FROM estudiantes
	INNER JOIN matriculas ON matriculas.`idmatricula` = estudiantes.`idmatricula`
	ORDER BY idestudiante DESC;
END $$

CALL spu_listar_estudiante();

-- ACTUALIZA MATRICULA
DELIMITER $$
CREATE PROCEDURE spu_actualizar_matriculas
(
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
		fechafinal	= _fechafinal,
		update_at	= NOW()
	WHERE idmatricula = _idmatricula;
END $$

DELIMITER $$
CREATE PROCEDURE spu_obtener_matriculas
(
	IN _idmatricula INT
)
BEGIN
	SELECT * FROM matriculas WHERE idmatricula = _idmatricula;
END $$

DELIMITER $$
CREATE PROCEDURE spu_eliminar_matriculas
(
	IN _idmatricula INT
)
BEGIN
	DELETE FROM matriculas WHERE idmatricula = _idmatricula;
END $$
CALL spu_eliminar_matriculas(15);

-- Creamos un buscador de matriculas
DELIMITER $$
CREATE PROCEDURE spu_matriculados_buscar_dni(IN _numdoc VARCHAR(11))
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
END $$

CALL spu_matriculados_buscar_dni('21365487');

DELIMITER $$ 
CREATE PROCEDURE spu_listar_carreras()
BEGIN
SELECT
	carreras.`idcarrera`,
	carreras.`carrera`,
	carreras.`duracion`,
	carreras.`costo`
	

FROM carreras
	ORDER BY idcarrera DESC;
END $$

SELECT * FROM cursos;

DELIMITER $$
CREATE PROCEDURE spu_listar_dtcarreras()
BEGIN
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
END $$

CALL spu_listar_dtcarreras();

-- ACTUALIZAR DETALLES_CARRERAS
DELIMITER $$
CREATE PROCEDURE spu_actualizar_dtcarreras
(
	IN _iddtcarrs	INT,
	IN _idcarrera 	VARCHAR(100),
	-- IN _duracion	VARCHAR(10),
	-- IN _costo	decimal(7,2),
	IN _idcurso	INT
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
END $$
CALL spu_actualizar_dtcarreras(1,1,4);
SELECT * FROM cursos;
SELECT * FROM carreras;
DELIMITER $$
CREATE PROCEDURE spu_obtener_dtcarreras
(
	IN _iddtcarrs INT
)
BEGIN
	SELECT * FROM detalles_carreras WHERE iddtcarrs = _iddtcarrs;
END $$

DELIMITER $$
CREATE PROCEDURE spu_eliminar_dtcarreras
(
	IN _iddtcarrs INT
)
BEGIN
	DELETE FROM detalles_carreras WHERE iddtcarrs = _iddtcarrs;
END $$

DELIMITER $$
CREATE PROCEDURE spu_registrar_carreras
(
	IN _carrera	VARCHAR(100),
	IN _duracion 	VARCHAR(10),
	IN _costo 	DECIMAL(7,2)	
)
BEGIN
INSERT INTO carreras(carrera,duracion,costo) VALUES
	(_carrera,_duracion,_costo);
END $$
SELECT * FROM carreras;
CALL spu_registrar_carreras('Computación Informatica','3 años',80.3);

DELIMITER $$
CREATE PROCEDURE spu_listar_carreras()
BEGIN
SELECT 
	carreras.`idcarrera`,
	carreras.carrera,
	duracion,
	costo
	
FROM carreras
	ORDER BY iddtcarrs DESC;
END $$

CALL spu_listar_carreras();
-- ACTUALIZA CARRERAS
DELIMITER $$
CREATE PROCEDURE spu_actualizar_carreras
(
	IN _idcarrera	INT,
	IN _carrera 	VARCHAR(100),
	IN _duracion	VARCHAR(10),
	IN _costo	DECIMAL(7.2)
)	
BEGIN	
	UPDATE carreras  SET
		carrera		= _carrera,
		duracion 	= _duracion,
		costo		= _costo,
		update_at	= NOW()
	WHERE 	idcarrera = _idcarrera;
END $$

CALL spu_actualizar_carreras(1,'Ingenieria de Software','3 años',103.30);

DELIMITER $$
CREATE PROCEDURE spu_obtener_carreras
(
	IN _idcarrera INT
)
BEGIN
	SELECT * FROM carreras WHERE idcarrera = _idcarrera;
END $$

DELIMITER $$
CREATE PROCEDURE spu_eliminar_carreras
(
	IN _idcarrera INT
)
BEGIN
	DELETE FROM carreras WHERE idcarrera = _idcarrera;
END $$
SELECT * FROM carreras;

DELIMITER $$
CREATE PROCEDURE spu_listar_docentes()
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
END $$

DELIMITER $$
CREATE PROCEDURE spu_obtener_docentes
(
	IN _iddocente INT
)
BEGIN
	SELECT * FROM docentes WHERE iddocente = _iddocente;
END $$

DELIMITER $$
CREATE PROCEDURE spu_eliminar_docentes
(
	IN _iddocente INT
)
BEGIN
	DELETE FROM docentes WHERE iddocente = _iddocente;
END $$

-- REGISTRAR_MATRICULAS
DELIMITER $$
CREATE PROCEDURE spu_registrar_docentes
(
	IN _nombres	VARCHAR(100),
	IN _numdoc 	VARCHAR(11),
	IN _fechanac 	DATE,
	IN _telefono	CHAR(9),
	IN _correo	VARCHAR(50),
	IN _direccion	VARCHAR(100),
	IN _especialidad VARCHAR(80)

	
)
BEGIN
INSERT INTO docentes (nombres,numdoc,fechanac,telefono,correo,direccion,especialidad) VALUES
	(_nombres,_numdoc,_fechanac,_telefono,_correo,_direccion,_especialidad);
END $$

CALL spu_listar_docentes();

-- ACTUALIZA CARRERAS
DELIMITER $$
CREATE PROCEDURE spu_actualizar_docentes
(
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
END $$

-- LISTAR ESTUDIANTES
DELIMITER $$
CREATE PROCEDURE spu_listarestudiantes()
BEGIN
SELECT 
	estudiantes.idestudiante,
	matriculas.nombres,
	carreras.carrera,
	cursos.curso,
	fechanac,
	telefono,
	correo,
	direccion
FROM estudiantes
	INNER JOIN matriculas ON matriculas.idmatricula = estudiantes.idmatricula
	INNER JOIN detalles_carreras ON detalles_carreras.idcarrera = estudiantes.iddtcarrs
	INNER JOIN cursos ON cursos.idcurso = detalles_carreras.idcurso
	INNER JOIN carreras ON carreras.idcarrera = detalles_carreras.idcarrera
	ORDER BY idestudiante DESC;
END $$

-- REGISTRAR CURSOS
DELIMITER $$ 
CREATE PROCEDURE spu_registrar_cursos
(
	IN _curso VARCHAR(50),
	IN _creditos INT
)
BEGIN
INSERT INTO cursos (curso, creditos) VALUES
	(_curso, _creditos);
END $$

SELECT * FROM cursos;

DELIMITER $$
CREATE PROCEDURE spu_listar_cursos()
BEGIN
SELECT 
	idcurso,
	curso,
	creditos
FROM cursos
	ORDER BY idcurso DESC;
END

DELIMITER $$
CREATE PROCEDURE spu_actualizar_cursos
(
	IN _idcurso INT,
	IN _curso VARCHAR(50),
	IN _creditos INT
)
BEGIN
UPDATE cursos SET
	curso		= _curso,
	creditos 	= _creditos,
	update_at	= NOW()
	WHERE idcurso 	= _idcurso;
END $$

CALL spu_actualizar_cursos(1,'Matemática',35);

DELIMITER $$
CREATE PROCEDURE spu_obtener_cursos
(
	IN _idcurso INT
)
BEGIN
	SELECT * FROM cursos WHERE idcurso = _idcurso;
END $$

DELIMITER $$
CREATE PROCEDURE spu_eliminar_cursos
(
	IN _idcurso INT
)
BEGIN
	DELETE FROM cursos WHERE idcurso = _idcurso;
END $$

SELECT * FROM cursos;
