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
	INNER JOIN carreras ON carreras.`idcarrera` = alumnos_matriculas.`idcarrera`;
-- WHERE idmatricula = _idmatricula;
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

DELIMITER $$