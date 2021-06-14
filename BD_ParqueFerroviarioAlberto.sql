USE master;
GO
IF DB_ID (N'ParqueFerroviario') IS NOT NULL----NOMBRE BD
 DROP DATABASE ParqueFerroviario;---- BD
GO
CREATE DATABASE	ParqueFerroviario---- BD
ON
(NAME = ParqueFerroviario_dat,---- BD
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ParqueFerroviario_dat.mdf',----NOMBRE BD
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
(NAME =ParqueFerroviario_log,---- BD
    FILENAME =  'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ParqueFerroviario_dat.ldf',----NOMBRE BD
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB )
GO
USE ParqueFerroviario;---- BD

GO	

-------------TABLAS-----------------------------
CREATE TABLE Taller
(   
      
	 idTaller int IDENTITY (1,1),----ID
	 ubicacion varchar(100) NOT NULL,
	 estatus bit NOT NULL DEFAULT 1
	 CONSTRAINT PK_Taller PRIMARY KEY (idTaller)----ID

);
CREATE TABLE Articulo
(   
      
	 idArticulo int IDENTITY (1,1),----ID
	 nombre varchar(100) NOT NULL,
	 codigo varchar(100) NOT NULL,
	 precio decimal(10,2) NOT NULL,
	 estatus bit NOT NULL DEFAULT 1
	 CONSTRAINT PK_Articulo PRIMARY KEY (idArticulo)----ID

);
CREATE TABLE Puesto
(   
      
	 idPuesto int IDENTITY (1,1),----ID
	 nombreDePuesto varchar(100) NOT NULL,
	 estatus bit NOT NULL DEFAULT 1
	 CONSTRAINT PK_Puesto PRIMARY KEY (idPuesto)----ID

);
CREATE TABLE Empresa
(   
      
	 idEmpresa int IDENTITY (1,1),----ID
	 nombre varchar(100) NOT NULL,
	 codigoPostal varchar(100) NOT NULL,
	 telefono varchar(20) NOT NULL,
	 ubicacion varchar(100) NOT NULL,
	 estatus bit NOT NULL DEFAULT 1,
	 CONSTRAINT PK_Empresa PRIMARY KEY (idEmpresa)----ID

);
CREATE TABLE Estacion
(   
      
	 idEstacion int IDENTITY (1,1),----ID
	 salida varchar (100) NOT NULL,
	 llegada varchar (100) NOT NULL,
	 telefono varchar(25) NOT NULL,
	 estatus bit NOT NULL DEFAULT 1,
	 idEmpresa int NOT NULL
	 CONSTRAINT PK_Estacion PRIMARY KEY (idEstacion)----ID

);
CREATE TABLE Tren
(   
      
	 idTren int IDENTITY (1,1),----ID
	 numero varchar(100) NOT NULL,
	 destino varchar(100) NOT NULL,
	 diesel varchar(100) NOT NULL,
	 fabricado varchar(100) NOT NULL,
	 estatus bit NOT NULL DEFAULT 1,
	 idEstacion int NOT NULL
	 CONSTRAINT PK_Tren PRIMARY KEY (idTren)----ID

);
CREATE TABLE Ciudad
(   
      
	 idCiudad int IDENTITY (1,1),----ID
	 ubicacion varchar(100) NOT NULL,
	 codigoPostal varchar(50) NOT NULL,
	 estatus bit NOT NULL DEFAULT 1,
	 idEmpresa int NOT NULL
	 CONSTRAINT PK_Ciudad PRIMARY KEY (idCiudad)----ID

);
CREATE TABLE Patio
(   
      
	 idPatio int IDENTITY (1,1),----ID
	 ubicacion varchar(100) NOT NULL,
	 estatus bit NOT NULL DEFAULT 1,
	 idCiudad int NOT NULL
	 CONSTRAINT PK_Patio PRIMARY KEY (idPatio)----ID

);
CREATE TABLE Vagon
(   
      
	 idVagon int IDENTITY (1,1),----ID
	 carga varchar(100) NOT NULL,
	 estatus bit NOT NULL DEFAULT 1,
	 idPatio int NOT NULL,
	 idTaller int NOT NULL,
	 idTren int NOT NULL
	 CONSTRAINT PK_Vagon PRIMARY KEY (idVagon)----ID

);
CREATE TABLE Ruta
(   
      
	 idRuta int IDENTITY (1,1),----ID
	 rutaTren varchar(100) NOT NULL,
	 estatus bit NOT NULL DEFAULT 1,
	 idCiudad int NOT NULL
	 CONSTRAINT PK_Ruta PRIMARY KEY (idRuta)----ID

);
CREATE TABLE Viaje
(   
      
	 idViaje int IDENTITY (1,1),----ID
	 origen varchar(100) NOT NULL,
	 destino varchar(100) NOT NULL,
	 estatus bit NOT NULL DEFAULT 1,
	 idTren int NOT NULL
	 CONSTRAINT PK_Viaje PRIMARY KEY (idViaje)----ID

);
CREATE TABLE Proveedor
(   
      
	 idProveedor int IDENTITY (1,1),----ID
	 nombre varchar(100) NOT NULL,
	 apellidoPaterno varchar(100) NOT NULL,
	 apellidoMaterno varchar(100) NOT NULL,
	 telefono varchar(100) NOT NULL,
	 correo varchar(100) NOT NULL,
	 estatus bit NOT NULL DEFAULT 1,
	 idCiudad int NOT NULL
	 CONSTRAINT PK_Proveedor PRIMARY KEY (idProveedor)----ID

);
CREATE TABLE Compra
(   
      
	 idCompra int IDENTITY (1,1),----ID
	 nombreDeCompra varchar(100) NOT NULL,
	 codigo varchar(100) NOT NULL,
     estatus bit NOT NULL DEFAULT 1,
	 idEmpresa int NOT NULL,
	 idProveedor int NOT NULL
	 CONSTRAINT PK_Compra PRIMARY KEY (idCompra)----ID

);
CREATE TABLE Empleado
(   
      
	 idEmpleado int IDENTITY (1,1),----ID
	 nombre varchar(100) NOT NULL,
	 apellidoPaterno varchar(100) NOT NULL,
	 apellidoMaterno varchar(100) NOT NULL,
	 estatus bit NOT NULL DEFAULT 1,
	 idPuesto int NOT NULL,
	 idEmpresa int NOT NULL
	 CONSTRAINT PK_Empleado PRIMARY KEY (idEmpleado)----ID

);
CREATE TABLE Estado
(   
      
	 idEstado int IDENTITY (1,1),----ID
	 ubicacion varchar(100) NOT NULL,
	 estatus bit NOT NULL DEFAULT 1,
	 idCiudad int NOT NULL
	 CONSTRAINT PK_Estado PRIMARY KEY (idEstado)----ID

);
CREATE TABLE TrenEmpleado

(   
     idTrenEmpleado int IDENTITY (1,1),
	 idTren int NOT NULL,
	 idEmpleado int NOT NULL,
	 estatus bit NOT NULL DEFAULT 1
	 CONSTRAINT PK_TrenEmpleado PRIMARY KEY (idTrenEmpleado)

);
CREATE TABLE CompraArticulo

(   
     idCompraArticulo int IDENTITY (1,1),
	 idCompra int NOT NULL,
	 idArticulo int NOT NULL,
	 estatus bit NOT NULL DEFAULT 1
	 CONSTRAINT PK_CompraArticulo PRIMARY KEY (idCompraArticulo)

);

--------------------INDEX---------------------------------
CREATE INDEX IX_Taller ON Taller(idTaller);
CREATE INDEX IX_Articulo ON Articulo(idArticulo);
CREATE INDEX IX_Puesto ON Puesto(idPuesto);
CREATE INDEX IX_Empresa ON Empresa(idEmpresa);
CREATE INDEX IX_Estacion ON Estacion(idEstacion);
CREATE INDEX IX_Tren ON Tren(idTren);
CREATE INDEX IX_Ciudad ON Ciudad(idCiudad);
CREATE INDEX IX_Patio ON Patio(idPatio);
CREATE INDEX IX_Vagon ON Vagon(idVagon);
CREATE INDEX IX_Ruta ON Ruta(idRuta);
CREATE INDEX IX_Viaje ON Viaje(idViaje);
CREATE INDEX IX_Proveedor ON Proveedor(idProveedor);
CREATE INDEX IX_Compra ON Compra(idCompra);
CREATE INDEX IX_Empleado ON Empleado(idEmpleado);
CREATE INDEX IX_Estado ON Estado(idEstado);
CREATE INDEX IX_TrenEmpleado ON TrenEmpleado(idTren,idEmpleado);
CREATE INDEX IX_CompraArticulo ON CompraArticulo(idCompra,idArticulo);
GO


--------------------RELACIONES---------------------------------
ALTER TABLE Estacion---nombre de la tabla que tiene la llave foranea
ADD CONSTRAINT FK_EstacionEmpresa ---nombre de tabla junto con la llave foranea
FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa);
GO


ALTER TABLE Tren
ADD CONSTRAINT FK_TrenEstacion 
FOREIGN KEY (idEstacion) REFERENCES Estacion(idEstacion);
GO


ALTER TABLE Ciudad
ADD CONSTRAINT FK_CiudadEmpresa
FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa);
GO

ALTER TABLE Patio
ADD CONSTRAINT FK_PatioCiudad
FOREIGN KEY (idCiudad) REFERENCES Ciudad(idCiudad);
GO

ALTER TABLE Vagon
ADD CONSTRAINT FK_VagonTren
FOREIGN KEY (idTren) REFERENCES Tren(idTren);
GO

ALTER TABLE Vagon
ADD CONSTRAINT FK_VagonTaller
FOREIGN KEY (idTaller) REFERENCES Taller(idTaller);
GO

ALTER TABLE Vagon
ADD CONSTRAINT FK_VagonPatio
FOREIGN KEY (idPatio) REFERENCES Patio(idPatio);
GO

ALTER TABLE Ruta
ADD CONSTRAINT FK_RutaCiudad
FOREIGN KEY (idCiudad) REFERENCES Ciudad(idCiudad);
GO

ALTER TABLE Viaje
ADD CONSTRAINT FK_ViajeTren
FOREIGN KEY (idTren) REFERENCES Tren(idTren);
GO

ALTER TABLE Proveedor
ADD CONSTRAINT FK_ProveedorCiudad
FOREIGN KEY (idCiudad) REFERENCES Ciudad(idCiudad);
GO


ALTER TABLE Compra
ADD CONSTRAINT FK_CompraEmpresa
FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa);
GO

ALTER TABLE Compra
ADD CONSTRAINT FK_CompraProveedor
FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProveedor);
GO


ALTER TABLE Empleado
ADD CONSTRAINT FK_EmpleadoPuesto
FOREIGN KEY (idPuesto) REFERENCES Puesto(idPuesto);
GO

ALTER TABLE Empleado
ADD CONSTRAINT FK_EmpleadoEmpresa
FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa);
GO

ALTER TABLE Estado
ADD CONSTRAINT FK_EstadoCiudad
FOREIGN KEY (idCiudad) REFERENCES Ciudad(idCiudad);
GO


ALTER TABLE TrenEmpleado
ADD CONSTRAINT FK_TrenEmpleadoTren
FOREIGN KEY (idTren) REFERENCES Tren(idTren);
GO
ALTER TABLE TrenEmpleado
ADD CONSTRAINT FK_TrenEmpleadoEmpleado
FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado);
GO


ALTER TABLE CompraArticulo
ADD CONSTRAINT FK_CompraArticuloCompra
FOREIGN KEY (idCompra) REFERENCES Compra(idCompra);
GO
ALTER TABLE CompraArticulo
ADD CONSTRAINT FK_CompraArticuloArticulo
FOREIGN KEY (idArticulo) REFERENCES Articulo(idArticulo);
GO






    
--------------------Poblar--------------------------------------
--------------------Insertar Registros--------------------------






INSERT INTO Taller(ubicacion)
VALUES ('Frontera Zona norte'),
       ('Frontera Zona sur'),
	   ('Ramos Coahuila'),
	   ('Saltillo Coahuila'),
	   ('Monterrey Nuevo Leon'),
	   ('San nicolas de los garza Nuevo Leon'),
	   ('La joya Zacatecas'),
	   ('Garden city Kansas'),
	   ('Rosetown Canada'),
	   ('Naucalpan Ciudad de Mexico')

	  


INSERT INTO Articulo(nombre,codigo,precio)
VALUES ('Zapatas de rueda','332762','15000'),
       ('Durmientes','999373','25000'),
	   ('Rieles','712546','20000'),
	   ('Ruedas','112435','125000'),
	   ('Postes','324657','90000'),
	   ('Trenes','478777','750000'),
	   ('Vagones','212435','200000'),
	   ('Diesel','553787','100000'),
	   ('Trucks','827637','30000'),
	   ('Aceites','432987','95000')
	 




INSERT INTO Puesto(nombreDePuesto)
VALUES ('Maquinista'),
       ('Maquinista'),
	   ('Obrero'),
	   ('Obrero'),
	   ('Garrotero'),
	   ('Garrotero'),
	   ('Obrero'),
	   ('Obrero'),
	   ('Mecanico'),
	   ('Mecanico')



INSERT INTO Empresa(nombre,codigoPostal,telefono,ubicacion)
VALUES ('Ferromex','25628','866-124-44-55','Frontera Coahuila'),
       ('Nacionales de Mexico','33321','811-654-76-88','Tampico Miramar'),
	   ('Kansas city southern de Mexico','23843','811-765-32-21','Monterrey Nuevo Leon'),
	   ('Ferromex Divicion Golfo Sur','40913','866-645-77-14','Guerrero Xochilapa'),
	   ('Union Pacific Railroad','94102','211-764-99-33','San Francisco Outer sunset'),
	   ('Kansas City Southern Railway','64101','211-124-44-55','Frontera Coahuila'),
	   ('Ferrocarril Chiapas Mayab','30443','855-612-43-99','Chiapas Tuxtla Gutierrez'),
	   ('BNSF Railway','83459','211-124-44-55','Colorado Denver'),
	   ('Ferromex Divicion Golfo Norte','89670','866-774-33-76','Tamaulipas Las Norias'),
	   ('Norfolk Southern Railway','15202','423-442-76-88','Pittsburgh Pensilvania')

INSERT INTO Estacion(salida,llegada,telefono,idEmpresa)
VALUES ('Estacion Frontera','Estacion Saltillo','866-283-66-70',1),
       ('Estacion San nicolas N.L.','Estacion Durango','866-983-12-84',2),
	   ('Estaion Nogales','Estacion Torreon','866-543-44-11',3),
	   ('Estacion Zacatecas','Estacion Eagle Pass','811-654-82-99',4),
	   ('Estacion Silao','Estacion Monterrey','811-123-30-41',5),
	   ('Estacion Nacozari','Estacion Frontera','811-342-40-67',6),
	   ('Estacion Dallas','Estacion Oklahoma','866-674-98-59',7),
	   ('Estacion Saltillo','Estacion San Antonio','866-765-48-37',8),
	   ('Estacion Phoenix','Estacion Mexicali','866-472-98-11',9),
	   ('Estacion Saltillo','Estacion Torreon','866-234-19-28',10)



INSERT INTO Tren(numero,destino,diesel,fabricado,idEstacion)
VALUES ('161','San nicolas de los garza Nuevo Leon','2500 litros','EUA',1),
       ('300','Frontera Coahuila','2500 litros','EUA',2),
	   ('244','Durango San juan del Rio','2500 litros','EUA',3),
	   ('888','Guanajuato Guanajuato','2500 litros','EUA',4),
	   ('171','Saltillo Coahuila','2500 litros','EUA',5),
	   ('234','Monterrey Nuevo Leon','2500 litros','EUA',6),
	   ('947','San Francisco Outer sunset','2500 litros','EUA',7),
	   ('555','Pittsburgh Pensilvania','2500 litros','EUA',8),
	   ('777','Colorado Denver','2500 litros','EUA',9),
	   ('593','Tampico Miramar','2500 litros','EUA',10)

	   


INSERT INTO Ciudad(ubicacion,codigoPostal,idEmpresa)
VALUES ('Frontera Coahuila','25628',1),
       ('Frontera Coahuila','25630',2),
	   ('San nicolas de los garza Nuevo Leon','66400',3),
	   ('San nicolas de los garza Nuevo Leon','25771',4),
	   ('Saltillo Coahuila','25324',5),
	   ('Saltillo Coahuila','25314',6),
	   ('Durango San juan del Rio','35770',7),
	   ('Durango El Chaparral','35766',8),
	   ('Guanajuato Guanajuato','36234',9),
	   ('Guanajuato Marfil','36257',10)

	   



INSERT INTO Patio(ubicacion,idCiudad)
VALUES ('Frontera Coahuila adelante de estacion',1),
       ('Monclova Coahuila en altos hornos de mexico',2),
	   ('Sabinas Coahuila en el centro de patio',3),
	   ('Frontera Coahuila cruzando puente de la occidental',4),
	   ('Castaños Coahuila ',5),
	   ('Saltillo Coahuila zona norte',6),
	   ('Frontera Coahuila zona sur',7),
	   ('Veracruz Valente diaz divicion golfo sur',8),
	   ('kansas city Belton',9),
	   ('Canada Calgary',10)

	   

INSERT INTO Vagon(carga,idTaller,idPatio,idTren)
VALUES ('Transporta Madera',1,1,1),
       ('Transporta Vigas',2,2,2),
	   ('Transporta Rollos de Acero',3,3,3),
	   ('Transporta Material Peligroso',4,4,4),
	   ('Transporta Autos',5,5,5),
	   ('Transporta Camionetas',6,6,6),
	   ('Transporta Maiz',7,7,7),
	   ('Transporta Trigo',8,8,8),
	   ('Transporta Carbon',9,9,9),
	   ('Transporta Chatarra',10,10,10)





INSERT INTO Ruta(rutaTren,idCiudad)
VALUES ('Frontera a Saltillo',1),
       ('Torreon a Durango',2),
	   ('Monterrey a Puebla',3),
	   ('Colima  a Queretaro',4),
	   ('Frontera a Sierra Blanca',5),
	   ('Nogales a Phoenix',6),
	   ('Monterrey a Eagle Pass',7),
	   ('Ciudad de Mexico a Houston',8),
	   ('Oklahoma a Iowa',9),
	   ('Frontera a Monterrey',10)
	 
		


INSERT INTO Viaje(origen,destino,idTren)
VALUES ('Nacozari','Chihuahua',1),
       ('Frontera','Monterrey',2),
	   ('Saltillo','Torreon',3),
	   ('Ciudad Victoria','Silao',4),
	   ('Ciudad de mexico','Zacatecas',5),
	   ('Durango','Nogales',6),
	   ('Mexicali','Clifton',7),
	   ('Austin','Dallas',8),
	   ('Frontera','Spofford',9),
	   ('Monterrey','San Antonio',10)

	   



INSERT INTO Proveedor(nombre,apellidoPaterno,apellidoMaterno,telefono,correo,idCiudad)
VALUES ('Ramon','Torres','Martinez','866-534-33-33','torres@gmail.com',1),
       ('David','Castro','De la Cruz','866-956-63-22','castrodavid@gmail.com',2),
	   ('Nagato','Pain','Gutierritos','811-371-41-77','painnagato@gmail.com',3),
	   ('Antonio','Ramirez','Cruz','811-234-35-88','antonioramirez@gmail.com',4),
	   ('Alejandro','Carrizales','Martinez','866-765-46-83','carrizalesalejandro@gmail.com',5),
	   ('Noel','Valdez','Gomez','866-567-65-28','valdeznoel@gmail.com',6),
	   ('Eduardo','Gonzales','Soto','211-637-26-97','torres@gmail.com',7),
	   ('Carlos','Romero','Ruiz','211-693-55-69','carlosromero@gmail.com',8),
	   ('Sasuke','Morales','Ortiz','866-476-77-99','sasukemorales@gmail.com',9),
	   ('Jesus Manuel','Pruneda','Garcia','866-885-45-77','gariajesus@gmail.com',10)
       


INSERT INTO Compra(nombreDeCompra,codigo,idProveedor,idEmpresa)
VALUES ('Viga','553722',1,1),
       ('Durmientes','757346',2,2),
	   ('Riel','123321',3,3),
	   ('Clavos de via','547986',4,4),
	   ('Vagones','987123',5,5),
	   ('Tren','764345',6,6),
	   ('Carbon','987562',7,7),
	   ('Ejes','183543',8,8),
	   ('Aceites','234987',9,9),
	   ('Truck','345987',10,10)




INSERT INTO Empleado(nombre,apellidoPaterno,apellidoMaterno,idPuesto,idEmpresa)
VALUES ('Alberto','Salazar','Zuñiga',1,1),
       ('Sergio','Salazar','Zuñiga',2,2),
	   ('Adrian','Benitez','Martinez',3,3),
	   ('Santiago','Contreras','Dominguez',4,4),
	   ('Cesar','Delgado','Rodriguez',5,5),
	   ('Marcos','Sanchez','Ramon',6,6),
	   ('David','Aguilar','Amador',7,7),
	   ('Noel','Valdez','Lopez',8,8),
	   ('Ramon','Mendez','Torres',9,9),
	   ('Roberto','Meza','Vargas',10,10)




INSERT INTO Estado(ubicacion,idCiudad)
VALUES ('Coahuila',1),
       ('Nuevo Leon',2),
	   ('Chihuahua',3),
	   ('Ciudad de Mexico',4),
	   ('Kansas',5),
	   ('Zacatecas',6),
	   ('San Antonio',7),
	   ('San Luis Potosi',8),
	   ('Tamaulipas',9),
	   ('Ontario',10)




INSERT INTO TrenEmpleado(idTren,idEmpleado)
VALUES (1,1),
       (2,2),
	   (3,3),
	   (4,4),
	   (5,5),
	   (6,6),
	   (7,7),
	   (8,8),
	   (9,9),
	   (10,10)



INSERT INTO CompraArticulo(idCompra,idArticulo)
VALUES (1,1),
       (2,2),
	   (3,3),
	   (4,4),
	   (5,5),
	   (6,6),
	   (7,7),
	   (8,8),
	   (9,9),
	   (10,10)

	   





---------Actualizar------------------------------
UPDATE Empresa SET telefono='866-154-66-44' WHERE idEmpresa=1
UPDATE Ciudad SET codigoPostal='25626' WHERE idCiudad=2
UPDATE Estado SET ubicacion='Puebla Mexico' WHERE idEstado=4
UPDATE Puesto SET nombreDePuesto='Maquinista' WHERE idPuesto=9
UPDATE Empleado SET nombre='Alfonso' WHERE idEmpleado=8
UPDATE Proveedor SET telefono='211-223-55-98' WHERE idProveedor=1
UPDATE Compra SET nombreDeCompra='Diesel' WHERE idCompra=7
UPDATE Estacion SET salida='Estacion Los Mochis' WHERE idEstacion=1
UPDATE Tren SET numero='288' WHERE idTren=5
UPDATE Viaje SET destino='Saltillo' WHERE idViaje=2
UPDATE Ruta SET rutaTren='Ciudad de Mexico a Aguscalientes' WHERE idRuta=9
UPDATE Patio SET ubicacion='Zacatecas Zona Centro' WHERE idPatio=6
UPDATE Taller SET ubicacion='Torreon Gomez Palacio' WHERE idTaller=2
UPDATE Vagon SET carga='Transporta Chatarra' WHERE idVagon=1
UPDATE Articulo SET precio='35000' WHERE idArticulo=1




--------Eliminar-------------------------------------------

DELETE FROM TrenEmpleado WHERE idTrenEmpleado=10
DELETE FROM Vagon WHERE idVagon=10
DELETE FROM Taller WHERE idTaller=10
DELETE FROM CompraArticulo WHERE idCompraArticulo=10
DELETE FROM Articulo WHERE idArticulo=10
DELETE FROM Empleado WHERE idEmpleado=10
DELETE FROM Puesto WHERE idPuesto=10
DELETE FROM Compra WHERE idCompra=10
DELETE FROM Proveedor WHERE idProveedor=10
DELETE FROM Estado WHERE idEstado=10
DELETE FROM Patio WHERE idPatio=10
DELETE FROM Ruta WHERE idRuta=10
DELETE FROM Ciudad WHERE idCiudad=10
DELETE FROM Viaje WHERE idViaje=10
DELETE FROM Tren WHERE idTren=10
DELETE FROM Estacion WHERE idEstacion=10
DELETE FROM Empresa WHERE idEmpresa=10

----Seleccionar---------------------------------------------

SELECT * FROM Empresa
SELECT * FROM Ciudad
SELECT * FROM Estado
SELECT * FROM Puesto
SELECT * FROM Empleado
SELECT * FROM Proveedor
SELECT * FROM Compra
SELECT * FROM Estacion
SELECT * FROM Tren
SELECT * FROM Viaje
SELECT * FROM Ruta
SELECT * FROM Patio
SELECT * FROM Taller

SELECT * FROM Vagon
SELECT * FROM Articulo
SELECT * FROM CompraArticulo
SELECT * FROM TrenEmpleado





   















