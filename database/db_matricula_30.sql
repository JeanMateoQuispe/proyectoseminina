CREATE DATABASE matricula;
USE matricula;

CREATE TABLE usuarios
(
	idusuario		INT AUTO_INCREMENT PRIMARY KEY,
	apellidos		VARCHAR(50) 		NOT NULL,
	nombres			VARCHAR(50) 		NOT NULL,
	fechanac		DATE 			NOT NULL,		
	nombreusuario		VARCHAR(50) 		NOT NULL,
	clave			VARCHAR(90) 		NOT NULL,
	telefono		CHAR(9) 		NULL,
	estado			CHAR(1)			NOT NULL DEFAULT '1',
	create_at		DATETIME		NOT NULL  DEFAULT NOW(),
	update_at		DATETIME		NULL,
	CONSTRAINT uk_nomusua_usu UNIQUE(nombreusuario)
)ENGINE = INNODB;

INSERT INTO usuarios (apellidos,nombres,fechanac,nombreusuario,clave,telefono) VALUES
	('Rosales Magallanes','Luis Alberto','1990-02-15','rosalesmagallanes@senati.pe','123456','951357852'),
	('Rubio Pecho','Juana Rosa','1985-05-26','rubiopecho@senati.pe','123456','987456123'),
	('Poma Torres','Ruth Antonia','1992-08-25','pomatorres@senati.pe','123456','963842175'),
	('Yauca Saravia','Mario Raúl','1988-07-04','yaucasaravia@senati.pe','123456','913782647')
DELIMITER $$
CREATE PROCEDURE spu_registrar_usuario
(
	IN _apellidos 		VARCHAR(50),
	IN _nombres 		VARCHAR(50),
	IN _fechanac 		DATE,
	IN _nombreusuario 	VARCHAR(50),
	IN _clave		VARCHAR(90),
	IN _telefono		CHAR(9)
)
BEGIN 
	INSERT INTO usuarios (apellidos,nombres,fechanac,nombreusuario,clave,telefono) VALUES
		(_apellidos, _nombres, _fechanac, _nombreusuario, _clave, _telefono);
END $$

CALL spu_registrar_usuario('Puma Cossio','Erick','13-01-1992','pumacossio@senati.pe','123456','913782786')

UPDATE usuarios
	SET fechanac	= '1993-01-13'
WHERE idusuario = 5

CREATE TABLE cursos
(
	idcurso			INT AUTO_INCREMENT PRIMARY KEY,
	nombrecurso 		VARCHAR(100)		NOT NULL,
	creditos		INT 			NOT NULL,
	-- idmatricula		int 			not null,
	estado			CHAR(1)			NOT NULL DEFAULT '1',
	create_at		DATETIME		NOT NULL  DEFAULT NOW(),
	update_at		DATETIME		NULL,
	CONSTRAINT uk_nomcur_cursos UNIQUE(nombrecurso)
	-- constraint fk_idmatri_matricula foreign key(idmatricula) references alumnos_matriculas(idmatricula)
)ENGINE = INNODB;

ALTER  TABLE cursos ADD COLUMN idmatricula INT NULL
ALTER TABLE cursos ADD CONSTRAINT fk_idmatric_matricu FOREIGN KEY(idmatricula) REFERENCES alumnos_matriculas(idmatricula)

INSERT INTO cursos(nombrecurso,creditos) VALUES
	('Matemática',40),
	('Lenguaje',40),
	('Física',30),
	('Computación',25),
	('Inglés',30)

CREATE TABLE carreras
(
	idcarrera		INT AUTO_INCREMENT PRIMARY KEY,
	idcurso			INT,
	nombrecarrera		VARCHAR(100) 	NOT NULL,
	duracion		INT 		NOT NULL,
	estado			CHAR(1)		NOT NULL DEFAULT '1',
	create_at		DATETIME	NOT NULL  DEFAULT NOW(),
	update_at		DATETIME	NULL,
	CONSTRAINT fk_curso_cursos FOREIGN KEY(idcurso) REFERENCES cursos(idcurso),
	CONSTRAINT uk_nomcarre_carreras UNIQUE(nombrecarrera)
)ENGINE = INNODB;

INSERT INTO carreras(idcurso,nombrecarrera,duracion) VALUES
	(1,'Ingenieria de Software',3),
	(2,'Ingenieria Ambiental',3),
	(3,'Ingenieria Industrial',3)
	
CREATE TABLE docentes
(
	iddocente		INT AUTO_INCREMENT PRIMARY KEY,
	docente 		VARCHAR(100)		NOT NULL,
	-- apellidos		VARCHAR(50) 		NOT NULL,
	-- nombres			VARCHAR(50) 		NOT NULL,
	fechanac		DATE 			NOT NULL,
	numdoc			VARCHAR(11) 		NOT NULL,
	especialidad		VARCHAR(100)  		NULL,
	idcurso			INT 			NOT NULL,
	idcarrera		INT 			NOT NULL,
	estado			CHAR(1)			NOT NULL DEFAULT '1',
	create_at		DATETIME		NOT NULL  DEFAULT NOW(),
	update_at		DATETIME		NULL,
	CONSTRAINT fk_idcur_curs FOREIGN KEY(idcurso) REFERENCES cursos(idcurso),
	CONSTRAINT uk_numdoc_doc UNIQUE(numdoc)
)ENGINE = INNODB;

INSERT INTO docentes(docente,fechanac,numdoc,especialidad,idcurso,idcarrera) VALUES
	('Mendoza Chia, Sergio','1985-03-08','21598674','',1,1),
	('Medrano Enriquez, Karina','1989-05-07','21598472','',2,2),
	('López Arteaga, Julio','1990-08-19','46389567','',3,3)

CREATE TABLE alumnos_matriculas
(
	idmatricula		INT AUTO_INCREMENT PRIMARY KEY,
	-- idusuario		INT 				NOT NULL,
	-- apellidos		VARCHAR(50) 			NOT NULL,
	-- nombres			VARCHAR(50) 			NOT NULL,
	alumno 			VARCHAR(100)			NOT NULL,
	fechanac		DATE 				NOT NULL,
	numdoc			VARCHAR(11) 			NOT NULL,
	iddocente		INT 				NOT NULL,
	idcarrera		INT 				NOT NULL,
	periodo			VARCHAR(10)			NOT NULL,
	semestre		VARCHAR(10)			NOT NULL,
	fechainicio		DATE 				NOT NULL,
	fechafinal		DATE 				NULL,
	pago			DECIMAL(7,2)			NULL,
	estado			CHAR(1)				NOT NULL DEFAULT '1',
	create_at		DATETIME			NOT NULL  DEFAULT NOW(),
	update_at		DATETIME			NULL,
	-- CONSTRAINT fk_usuario_usua FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario),
	CONSTRAINT fk_docent_docentes FOREIGN KEY(iddocente) REFERENCES docentes(iddocente),
	CONSTRAINT fk_idcarre_carre FOREIGN KEY(idcarrera) REFERENCES carreras(idcarrera),
	CONSTRAINT uk_numdoc_alum UNIQUE(numdoc)
)ENGINE = INNODB;

INSERT INTO alumnos_matriculas (alumno,fechanac,numdoc,iddocente,idcarrera,periodo,semestre,fechainicio,fechafinal,pago) VALUES
	('Marcelo Aquije, Roger','2000-05-12','21548796',1,1,'2023','I','2023-06-12','',537.5),
	('Garay Ronceros, Ana','2001-06-20','21365487',2,2,'2023','II','2023-07-20','',645.5),
	('Pachas Meneses, Sergio','2002-09-15','23569874',3,3,'2023','III','2023-08-21','',706.3)

SELECT * FROM usuarios;
SELECT * FROM docentes;
SELECT * FROM cursos;
SELECT * FROM carreras;
SELECT * FROM alumnos_matriculas;

-- Prodecimientos almacenados

DELIMITER $$ 
CREATE PROCEDURE spu_listar_matricula()
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
	ORDER BY idmatricula DESC;
END $$

CALL spu_listar_matricula();

DELIMITER $$
CREATE PROCEDURE spu_registrar_matricula
(
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
END $$

CALL spu_registrar_matricula('Luque Diaz, Luis','2001-08-12','21548799',1,1,'2023','II','2023-06-12','2023-12-08',537.5)
CALL spu_registrar_matricula('Rodriguez Anchante','2000-02-12','21548777',1,1,'2023','II','2023-06-12','2023-12-08',537.5)

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

CALL spu_usuarios_login('rosalesmagallanes@senati.pe');

UPDATE usuarios SET
clave = '$2y$10$ZTQq8DFJLjHDSuhryl3/oepYvZqqljRKG.bd.jx9g8lVkLhVwnaMG'
WHERE idusuario =1;

DELIMITER $$ 
CREATE PROCEDURE spu_listar_usuarios()
BEGIN
SELECT
	usuarios.`idusuario`,
	usuarios.`apellidos`,
	usuarios.`nombres`,
	usuarios.`fechanac`,
	usuarios.`nombreusuario`
FROM usuarios;
	
-- WHERE idmatricula = _idmatricula;
END $$

CALL spu_listar_usuarios();

DELIMITER $$
CREATE PROCEDURE spu_actualizar_matriculas
(
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
BEGIN	
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
END $$

DELIMITER $$
CREATE PROCEDURE spu_obtener_matriculas
(
	IN _idmatricula INT
)
BEGIN
	SELECT * FROM alumnos_matriculas WHERE idmatricula = _idmatricula;
END $$

DELIMITER $$
CREATE PROCEDURE spu_eliminar_matriculas
(
	IN _idmatricula INT
)
BEGIN
	DELETE FROM alumnos_matriculas WHERE idmatricula = _idmatricula;
END $$

DELIMITER $$ 
CREATE PROCEDURE spu_listar_docentes()
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
END $$

CALL spu_listar_docentes()	

DELIMITER $$
CREATE PROCEDURE spu_registrar_docente
(
	IN _docente	VARCHAR(100),
	IN _fechanac	DATE,
	IN _numdoc	VARCHAR(11),
	IN _especialidad VARCHAR(100),
	IN _idcurso	INT,
	IN _idcarrera	INT
)	
	
BEGIN
INSERT INTO docentes (docente,fechanac,numdoc,especialidad,idcurso,idcarrera) VALUES 
	(_docente,_fechanac,_numdoc,_especialidad,_idcurso,_idcarrera);  
END $$
SELECT * FROM cursos
CALL spu_registrar_docente('Chumbiarca Torres, Juan','1978-12-26',21598641,'Redes',4,1);

DELIMITER $$
CREATE PROCEDURE spu_obtener_docentes
(
	IN _iddocente INT
)
BEGIN
	SELECT * FROM docentes WHERE iddocente = _iddocente;
END $$

DELIMITER $$
CREATE PROCEDURE spu_actualizar_docentes
(
	IN _iddocente	INT,
	IN _docente 	VARCHAR(100),
	IN _fechanac	DATE,
	IN _numdoc	VARCHAR(11),
	IN _especialidad VARCHAR(100),
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
END $$

DELIMITER $$
CREATE PROCEDURE spu_eliminar_docentes
(
	IN _iddocente INT
)
BEGIN
	DELETE FROM docentes WHERE iddocente = _iddocente;
END $$

DELIMITER $$ 
CREATE PROCEDURE spu_listar_cursos()
BEGIN
SELECT
	cursos.`idcurso`,
	cursos.`nombrecurso`,
	cursos.`creditos`

FROM cursos
	ORDER BY idcurso DESC;
END $$

CALL spu_listar_cursos()

DELIMITER $$
CREATE PROCEDURE spu_registrar_cursos
(
	IN _nombrecurso	VARCHAR(100),
	IN _creditos		INT
)	
	
BEGIN
INSERT INTO cursos (nombrecurso, creditos) VALUES 
	(_nombrecurso,_creditos);  
END $$

SELECT * FROM cursos;

DELIMITER $$
CREATE PROCEDURE spu_actualizar_cursos
(
	IN _idcurso		INT,
	IN _nombrecurso	VARCHAR(100),
	IN _creditos 	INT	
)
BEGIN	
	UPDATE cursos SET
		nombrecurso 	= _nombrecurso,
		creditos	= _creditos

	WHERE idcurso = _idcurso;
END $$

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



DELIMITER $$ 
CREATE PROCEDURE spu_listar_carreras()
BEGIN
SELECT
	carreras.`idcarrera`,
	cursos.`nombrecurso`,
	carreras.`nombrecarrera`,
	carreras.`duracion`
	

FROM carreras
	INNER JOIN cursos ON cursos.`idcurso` = carreras.`idcurso`
	ORDER BY idcarrera DESC;
END $$

DELIMITER $$
CREATE PROCEDURE spu_registrar_carreras
(	
	IN _idcurso			INT,
	IN _nombrecarrera	VARCHAR(100),
	IN _duracion	INT
)	
	
BEGIN
INSERT INTO carreras (idcurso, nombrecarrera, duracion) VALUES 
	(_idcurso,_nombrecarrera,_duracion);  
END $$

DELIMITER $$
CREATE PROCEDURE spu_actualizar_carreras
(
	IN _idcarrera 	INT,
	IN _idcurso		INT,
	IN _nombrecarrera VARCHAR(100),
	IN _duracion 	INT	
)
BEGIN	
	UPDATE carreras SET
		idcurso = _idcurso,
		nombrecarrera 	= _nombrecarrera,
		duracion	= _duracion
	WHERE idcarrera = _idcarrera;
END $$

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

SELECT * FROM cursos;