/************************************************************CREACION DE SCHEMA************************************************************/
CREATE DATABASE `universoLector`;
USE `universoLector`;

/************************************************************CREACION DE TABLAS************************************************************/
-- Creacion de la tabla "socio"
DROP TABLE IF EXISTS `socio`;
CREATE TABLE `socio` (
`codigoSocio` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'codigo del socio',
`dniSocio` int NOT NULL COMMENT 'DNI del socio',
`apellidoSocio` varchar(100) NOT NULL COMMENT 'apellido del socio',
`nombresSocio` varchar(100) NOT NULL COMMENT 'nombres del socio',
`direccionSocio` varchar(200) NOT NULL COMMENT 'direccion del socio',
`localidadSocio` varchar(100) NOT NULL COMMENT 'localidad del socio',
PRIMARY KEY (`codigoSocio`)
);

-- Creacion de la tabla "telefonoxSocio"
DROP TABLE IF EXISTS `telefonoxSocio`;
CREATE TABLE `telefonoxSocio` (
`codigoTelefonoxSocio` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'codigo de telefono por socio',
`nroTelefono` varchar(100) NOT NULL COMMENT 'numero de telefono del socio',
`codigoSocio` int unsigned NOT NULL COMMENT 'codigo del socio',
PRIMARY KEY (`codigoTelefonoxSocio`),
CONSTRAINT `FK_telefonoxSocio_socio` FOREIGN KEY (`codigoSocio`) REFERENCES `socio` (`codigoSocio`) 
);

-- Creacion de la tabla "editorial"
DROP TABLE IF EXISTS `editorial`;
CREATE TABLE `editorial` (
`codigoEditorial` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'codigo de la editorial',
`razonSocial` varchar(100) NOT NULL COMMENT 'razon social de la editorial',
`telefonoEditorial` varchar(100) NOT NULL COMMENT 'numero de telefono de la editorial',
PRIMARY KEY (`codigoEditorial`)
); 

-- Creacion de la tabla "autor"
DROP TABLE IF EXISTS `autor`;
CREATE TABLE `autor` (
`codigoAutor` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'codigo del autor',
`apellidoAutor` varchar(100) NOT NULL COMMENT 'apellido del autor',
`nombresAutor` varchar(100) NOT NULL COMMENT 'nombres del autor',
PRIMARY KEY (`codigoAutor`)
); 

-- Creacion de la tabla "libro"
DROP TABLE IF EXISTS `libro`;
CREATE TABLE `libro` (
`codigoLibro` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'codigo de libro',
`ISBN` varchar(13) NOT NULL COMMENT 'ISBN del libro',
`tituloLibro` varchar(200) NOT NULL COMMENT 'titulo del libro',
`anioEscritura` date NOT NULL COMMENT 'año en que se escribio el libro',
`anioEdicion` date NOT NULL COMMENT 'año en que se edito el libro',
`codigoAutor` int unsigned NOT NULL COMMENT 'codigo del autor',
`codigoEditorial` int unsigned NOT NULL COMMENT 'codigo de la editorial',
PRIMARY KEY (`codigoLibro`),
CONSTRAINT `FK_libro_editorial` FOREIGN KEY (`codigoEditorial`) REFERENCES `editorial` (`codigoEditorial`),
CONSTRAINT `FK_libro_autor` FOREIGN KEY (`codigoAutor`) REFERENCES `autor` (`codigoAutor`)  
);

-- Creacion de la tabla "volumen"
DROP TABLE IF EXISTS `volumen`;
CREATE TABLE `volumen` (
`codigoVolumen` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'codigo del volumen del libro',
`deteriorado` boolean NOT NULL COMMENT 'indica si el libro esta deteriorado o no',
`codigoLibro` int unsigned NOT NULL COMMENT 'codigo del libro',
PRIMARY KEY (`codigoVolumen`),
CONSTRAINT `FK_volumen_libro` FOREIGN KEY (`codigoLibro`) REFERENCES `libro` (`codigoLibro`)
);

-- Creacion de la tabla "prestamo"
DROP TABLE IF EXISTS `prestamo`;
CREATE TABLE `prestamo` (
`codigoPrestamo` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'codigo del prestamo del libro',
`fechaPrestamo` datetime NOT NULL COMMENT 'fecha en que se presto el libro',
`fechaDevolucion` date NOT NULL COMMENT 'fecha en que se devuelve el libro',
`fechaTope` date NOT NULL COMMENT 'fecha tope para devolver el libro',
`codigoSocio` int unsigned NOT NULL COMMENT 'codigo del socio asociado',
PRIMARY KEY (`codigoPrestamo`),
CONSTRAINT `FK_prestamo_socio` FOREIGN KEY (`codigoSocio`) REFERENCES `socio` (`codigoSocio`)
);

-- Creacion de la tabla "prestamoxVolumen"
DROP TABLE IF EXISTS `prestamoxVolumen`;
CREATE TABLE `prestamoxVolumen` (
`codigoPrestamoxVolumen` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'codigo del prestamo del libro por volumen',
`codigoPrestamo` int unsigned NOT NULL COMMENT 'codigo del prestamo del libro',
`codigoVolumen` int unsigned NOT NULL COMMENT 'codigo del volumen del libro',
PRIMARY KEY (`codigoPrestamoxVolumen`),
CONSTRAINT `FK_prestamoxVolumen_prestamo` FOREIGN KEY (`codigoPrestamo`) REFERENCES `prestamo` (`codigoPrestamo`),
CONSTRAINT `FK_prestamoxVolumen_volumen` FOREIGN KEY (`codigoVolumen`) REFERENCES `volumen` (`codigoVolumen`)
);

/************************************************************INSERCION DE DATOS************************************************************/
-- Insercion de datos de la tabla "socio"

INSERT INTO socio (codigoSocio,dniSocio,apellidoSocio,nombresSocio,direccionSocio,localidadSocio) VALUES
(1,3000000,'JOHNSON','PATRICIA','28 MySQL Boulevard','QLD'),
(2,2988800,'LINDA','WILLIAMS','23 Workhaven Lane','Alberta'),
(3,2500000,'BARBARA','JONES','1411 Lillydale Drive','QLD'),
(4,32980002,'LOIS','BUTLER','1688 Okara Way','Nothwest Border Prov'),
(5,2313909,'ROBIN','HAYES','262 A Corua (La Corua) Parkway','Dhaka');


-- Insercion de datos de la tabla "telefonoxSocio"
INSERT INTO telefonoxSocio (codigoTelefonoxSocio,nroTelefono,codigoSocio) VALUES
(1,'54911-45636453',1),
(2,'54-11-47867654',1),
(3,'11498-2173',2),
(4,'11684736',3),
(5,'(54)-(911)-423-2434',4);


-- Insercion de datos de la tabla "editorial"
INSERT INTO editorial (codigoEditorial,razonSocial,telefonoEditorial) VALUES
(1,'Bloomsbury Publishing','54911564874'),
(2,'Scholastic','223483646'),
(3,'Pottermore Limited','5694839582'),
(4,'Editorial Salamandra','011-239-2343');


-- Insercion de datos de la tabla "autor"
INSERT INTO autor (codigoAutor,apellidoAutor,nombresAutor) VALUES
(1,'Rowling','J. K.');


-- Insercion de datos de la tabla "libro"
INSERT INTO libro (codigoLibro,ISBN,tituloLibro,anioEscritura,anioEdicion,codigoAutor,codigoEditorial) VALUES
(1,'9781907545009','Harry Potter y la piedra filosofal','1997/01/01','1997/01/01',1,4),
(2,'9789878000114','Harry Potter Y La Camara Secreta','2020/01/01','2020/01/01',1,4);


-- Insercion de datos de la tabla "volumen"
INSERT INTO volumen (codigoVolumen,deteriorado,codigoLibro) VALUES
(1,false,1),
(2,false,1),
(3,false,2);


-- Insercion de datos de la tabla "prestamo"
INSERT INTO prestamo (codigoPrestamo,fechaPrestamo,fechaDevolucion,fechaTope,codigoSocio) VALUES

(1,	'2020/1/1','2020/1/7','2020/1/7',1),
(2,	'2020/1/7','2020/1/15','2020/1/14',1),
(3,	'2020/3/4','2020/3/8','2020/3/11',2);


-- Insercion de datos de la tabla "prestamoxVolumen"
INSERT INTO prestamoxVolumen (codigoPrestamoxVolumen,codigoPrestamo,codigoVolumen) VALUES
(1,1,1),
(2,2,2),
(3,3,1),
(4,3,3);
