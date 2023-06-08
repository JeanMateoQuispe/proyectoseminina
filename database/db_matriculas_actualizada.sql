CREATE DATABASE actividad;
USE actividad;

CREATE TABLE personas
(
	idpersona	INT AUTO_INCREMENT PRIMARY KEY,
	apellidos 	VARCHAR(50) 		NOT NULL,
	nombres 	VARCHAR(50) 		NOT NULL,
	genero 		CHAR(1) 		NOT NULL,
	dni 		CHAR(8) 		NOT NULL,
	fechanac 	DATE 			NOT NULL,
	direccion 	VARCHAR(100) 		NULL,
	telefono 	CHAR(9) 		NULL,
	correo 		VARCHAR(100) 		NULL,
	estado		CHAR(1)			NOT NULL DEFAULT '1',
	create_at	DATETIME		NOT NULL DEFAULT NOW(),
	update_at	DATETIME		NULL,
	CONSTRAINT uk_dni_per UNIQUE(dni)
)ENGINE = INNODB;

CREATE TABLE usuarios
(
	idusuario	INT AUTO_INCREMENT PRIMARY KEY,
	idpersona 	INT 		NOT NULL,
	usuario 	VARCHAR(50) 	NOT NULL,
	clave 		VARCHAR(90) 	NOT NULL,
	nivelacceso 	CHAR(1) 	NOT NULL DEFAULT 'I',
	estado		CHAR(1)		NOT NULL DEFAULT '1',
	create_at	DATETIME	NOT NULL DEFAULT NOW(),
	update_at	DATETIME	NULL,
	CONSTRAINT fk_idperso_perso FOREIGN KEY(idpersona) REFERENCES personas(idpersona),
	CONSTRAINT uk_idp_per UNIQUE(idpersona),
	CONSTRAINT uk_usu_usua UNIQUE(usuario)
)ENGINE = INNODB;


CREATE TABLE docentes
(
	iddocente 	INT AUTO_INCREMENT PRIMARY KEY,
	idpersona 	INT 		NOT NULL,
	especialidad 	VARCHAR(100)	NULL,
	estado		CHAR(1)		NOT NULL DEFAULT '1',
	create_at	DATETIME	NOT NULL DEFAULT NOW(),
	update_at	DATETIME	NULL,
	CONSTRAINT fk_idper_person FOREIGN KEY(idpersona) REFERENCES personas(idpersona),
	CONSTRAINT uk_idp_pers UNIQUE(idpersona)
)ENGINE = INNODB;

CREATE TABLE cursos
(
	idcurso 	INT AUTO_INCREMENT PRIMARY KEY,
	curso 		VARCHAR(50) 	NOT NULL,
	creditos 	INT 		NOT NULL,
	iddocente	INT 		NOT NULL,
	estado		CHAR(1)		NOT NULL DEFAULT '1',
	create_at	DATETIME	NOT NULL DEFAULT NOW(),
	update_at	DATETIME	NULL,
	CONSTRAINT uk_cur_curs UNIQUE(curso),
	CONSTRAINT fk_iddoc_docen FOREIGN KEY (iddocente) REFERENCES docentes(iddocente)
)ENGINE = INNODB;


CREATE TABLE carreras
(
	idcarrera 	INT AUTO_INCREMENT PRIMARY KEY,
	carrera 	VARCHAR(50) 	NOT NULL,
	duracion	VARCHAR(10)  	NOT NULL,
	idcurso 	INT 		NOT NULL,
	costo 		DECIMAL(7,2) 	NOT NULL,
	estado		CHAR(1)		NOT NULL DEFAULT '1',
	create_at	DATETIME	NOT NULL DEFAULT NOW(),
	update_at	DATETIME	NULL,
	CONSTRAINT uk_carr_car UNIQUE(carrera),
	CONSTRAINT fk_idcur_cur FOREIGN KEY(idcurso) REFERENCES cursos(idcurso)
)ENGINE = INNODB;

CREATE TABLE detalles
(
	iddt 		INT AUTO_INCREMENT PRIMARY KEY,
	idcarrera 	INT 		NOT NULL,
	idcurso 	INT 		NOT NULL,
	iddocente 	INT 		NOT NULL,
	estado		CHAR(1)		NOT NULL DEFAULT '1',
	create_at	DATETIME	NOT NULL DEFAULT NOW(),
	update_at	DATETIME	NULL,
	CONSTRAINT fk_idcarr_carre FOREIGN KEY (idcarrera) REFERENCES carreras (idcarrera),
	CONSTRAINT fk_idcurs_curso FOREIGN KEY (idcurso) REFERENCES cursos (idcurso),
	CONSTRAINT fk_iddoc_docen FOREIGN KEY (iddocente) REFERENCES docentes(iddocente)
)ENGINE = INNODB;

CREATE TABLE matriculas
(
	idmatricula 	INT AUTO_INCREMENT PRIMARY KEY,
	idpersona 	INT 	NOT NULL,
	idcarrera	INT 	NOT NULL,
	periodo 	VARCHAR(10) 	NOT NULL,
	semestre 	VARCHAR(10) 	NOT NULL,
	proceso 	VARCHAR(10)  	NOT NULL DEFAULT 'En Proceso',
	estado		CHAR(1)		NOT NULL DEFAULT '1',
	create_at	DATETIME	NOT NULL DEFAULT NOW(),
	update_at	DATETIME	NULL,
	CONSTRAINT fk_idprs_pers FOREIGN KEY(idpersona) REFERENCES personas(idpersona),
	CONSTRAINT fk_idcar_carrer FOREIGN KEY(idcarrera) REFERENCES carreras(idcarrera)
)ENGINE = INNODB;

INSERT INTO personas (apellidos,nombres,genero,dni,fechanac,direccion,telefono,correo) VALUES
	('Quispe Lévano','Juan Carlos','M','78563214','2000-12-23','Av. Santa Rosa - Sunampe','953684217','jc@senati.com'),
	('Flores Garcia','Andrea Sofia','F','72589634','1998-02-14','Psj. Miraflores - Chincha Alta','956874235','af@senati.com'),
	('Pachas Guerra','Luis Antonio','M','85963214','1978-06-20','Jr. Benavides - Alto Laran','987456321','lp@senati.com'),
	('Canchari Matias','Milagros Tereza','F','21538467','2001-10-19','Urb. Toche - Carmen','936285741','mc@senati.com')
SELECT * FROM personas;	

INSERT INTO usuarios (idpersona,usuario,clave,nivelacceso) VALUES
	(1,'JUANQUISPE','123456','A')
SELECT * FROM usuarios

SELECT 	CONCAT(personas.apellidos,' ',personas.nombres) AS 'Nombres',
	usuario,
	clave
	usuario
FROM usuarios
	INNER JOIN personas ON personas.idpersona = usuarios.idpersona
	ORDER BY idusuario DESC;
		
INSERT INTO docentes (idpersona,especialidad) VALUES
	(2,'números'),
	(3,'Logistica')
	
SELECT * FROM docentes;

SELECT 	iddocente,
	CONCAT (doc.apellidos,' ',doc.nombres)AS 'Docente',
	especialidad
FROM docentes
	INNER JOIN personas doc ON doc.idpersona = docentes.idpersona
	
INSERT INTO cursos(curso,creditos,iddocente) VALUES
	('Matematica I',50,1),
	('Matematica II',50,2)
SELECT * FROM cursos

SELECT 	idcurso,
	curso,
	creditos,	
	CONCAT(docen.apellidos,' ',docen.nombres) AS 'Docente',
	docentes.especialidad
FROM cursos
	INNER JOIN docentes ON docentes.iddocente = cursos.iddocente
	INNER JOIN personas docen ON docen.idpersona = docentes.idpersona
	ORDER BY idcurso DESC
	
INSERT INTO carreras(carrera,duracion,idcurso,costo) VALUES
	('Administración','5 años',1,300),
	('Diseño','3 años',1,200),
	('Contabilidad','5 años',2,350)
SELECT * FROM carreras

SELECT 	idcarrera,
	carrera,
	duracion,
	curso,
	costo
FROM carreras
	INNER JOIN cursos ON cursos.idcurso = carreras.idcurso
	ORDER BY idcarrera DESC;
	
INSERT INTO matriculas(idpersona,idcarrera,periodo,semestre,proceso) VALUES
	(4,1,'22023-1','1 semestre','')
SELECT * FROM matriculas

UPDATE matriculas SET proceso ='En proceso' WHERE idmatricula = 1;

SELECT 	idmatricula,
	CONCAT(al.apellidos,' ',al.nombres) AS 'Matriculado',
	carrera,
	semestre,
	proceso
FROM matriculas
	INNER JOIN personas al ON al.idpersona = matriculas.idpersona
	INNER JOIN carreras ON carreras.idcarrera = matriculas.idcarrera

