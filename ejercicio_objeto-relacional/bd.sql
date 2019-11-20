
\echo "Eliminando datos previos"
DROP SCHEMA db CASCADE;
DROP TYPE fechaType CASCADE;
DROP TYPE representacionType CASCADE;
DROP TYPE pointType CASCADE;
DROP TYPE direccionType CASCADE;


\echo "Creando el esquema con las tablas"


CREATE SCHEMA db;

CREATE TYPE fechaType AS (
	anio INT,
	mes INT,
	dia INT,
	hora INT,
	minuto INT,
	segundo INT
);

CREATE TYPE representacionType AS (
	numeroFiguras INT,
	dibujo bytea 
);

CREATE TYPE pointType AS (
	x INT,
	y INT
);

CREATE TYPE direccionType AS (
	calle VARCHAR,
	numero INT,
	piso INT,
	puerta VARCHAR
);

CREATE TABLE db.PLANO (
	id INT NOT NULL,
	fechaEntrega fechaType NULL,
	representacion representacionType NULL,
	arquitectos VARCHAR[] NULL,
	PRIMARY KEY (id)
);




CREATE TABLE db.JEFE_PROYECTO (
	codigo INT NOT NULL,
	nombre VARCHAR UNIQUE NOT NULL,
	telefono INT NULL,
	direccion direccionType NULL,
	PRIMARY KEY (codigo)
);	


CREATE TABLE db.PROYECTO (
	codigo INT NOT NULL,
	nombre VARCHAR NULL,
	codigoJefe INT NOT NULL,
	PRIMARY KEY (codigo),
	CONSTRAINT codigoJefe
		FOREIGN KEY (codigoJefe)
		REFERENCES db.JEFE_PROYECTO(codigo)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);


CREATE TABLE db.PROYECTO_PLANO (
	codigo INT NOT NULL,
	id INT NOT NULL,
	PRIMARY KEY(codigo, id),
	CONSTRAINT codigo
		FOREIGN KEY (codigo)
		REFERENCES db.PROYECTO(codigo)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT id
		FOREIGN KEY (id)
		REFERENCES db.PLANO(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE db.FIGURA (
	nombre VARCHAR NULL, 
	id INT NOT NULL, 
	color VARCHAR NULL,
	area DECIMAL NULL, 
	perimetro DECIMAL NULL,
	plano INT NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT plano
		FOREIGN KEY (plano)
		REFERENCES db.PLANO(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);




CREATE TABLE db.LINEA (
	idLinea INT NOT NULL,
	longitud DECIMAL NULL,
	final pointType NULL,
	origen pointType NULL,
	PRIMARY KEY (idLinea)
);


CREATE TABLE db.POLIGONO (
	n_lineas INT NULL,
	idPoligono INT NOT NULL,
	PRIMARY KEY(idPoligono),
	UNIQUE(idPoligono),
	CONSTRAINT idPoligono
		FOREIGN KEY (idPoligono)
		REFERENCES db.FIGURA(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)INHERITS(db.FIGURA);


CREATE TABLE db.POLIGONO_LINEA (
	idFigura INT NOT NULL,
	idLinea INT NOT NULL,
	PRIMARY KEY(idFigura, idLinea),
	CONSTRAINT idFigura
		FOREIGN KEY (idFigura)
		REFERENCES db.POLIGONO(idPoligono)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT idLinea
		FOREIGN KEY (idLinea)
		REFERENCES db.LINEA(idLinea)
		ON DELETE CASCADE
		ON UPDATE CASCADE

);




