 USE
 ParqueFerroviario
 GO

 --------------------------CONSULTAS----------------------------------------
 --FUNCION DE AGREGADO
--funcion de agregado que devuelve el total de taller que hay en la tabla
select COUNT (*) as cantidad from Taller
--Ahora, si queremos que nos muestre el total de taller que hay dependiendo de un grupo especifico(en este caso, numero de taller por ubicacion), usamos:
select ubicacion, count(*) from Taller
group by ubicacion



--ESCALAR
---Funcion escalar que opera sobre la misma fila y el resultado lo devuelve para la misma fila----
select ubicacion, SUBSTRING(ubicacion, 1, 5) as primeras5letras,
--Funcion escalar de fecha, por cada fila se devuelve la flecha---
getdate () as fechahoy
from Estado
GO


----MAX
SELECT MAX(precio)  
FROM Articulo;  
GO


---MIN
SELECT MIN(precio)  
FROM Articulo;  
GO

select CONVERT (varchar (4),idEmpleado)+'-'+(nombre+' '+apellidoPaterno+' '+apellidoMaterno)Nombre
FROM Empleado 
WHERE estatus=1 AND Nombre like('A%')----EL _ hace que respete lo que se indica --
GO

select DATEADD(day,2,getdate())


--En este ejemplo se establece como primer día de la semana 5 (viernes) y se supone que el día actual, Today, cae en sábado. La instrucción SELECT devuelve el valor de DATEFIRST y el número del día actual de la semana.
SET DATEFIRST 1;  
SELECT @@DATEFIRST AS 'Primer dia'  
    ,DATEPART(dw, SYSDATETIME()) AS 'Hoy';  


--eomonth: Esta función devuelve el último día del mes que contiene la fecha especificada, con un desplazamiento opcional.
--Eomonth con tipo de datetime explicito
DECLARE @date DATETIME = '06/13/2021';  
SELECT EOMONTH ( @date ) AS Resultado;  
GO

--Toma la cadena de caracteres abc def y se utilizan los caracteres [ y ] para crear un identificador delimitado de SQL Server válido.
SELECT QUOTENAME(idTren)
FROM Tren

--En el ejemplo siguiente se devuelven los cinco caracteres situados más a la derecha del nombre de cada persona de la base de datos 
SELECT RIGHT(nombre, 5) AS 'Primer nombre'  
FROM Empleado   
WHERE idEmpleado< 5  
ORDER BY nombre;  
GO

--Sw eliminan los apellidos y se concatena una coma, dos espacios y los nombres de las personas que aparecen en la tabla 
SELECT RTRIM(apellidoPaterno)+ SPACE(2) +(apellidoMaterno) + ',' + SPACE(2) +  LTRIM(nombre) as [nombre completo]
FROM Empleado  
ORDER BY apellidoPaterno,apellidoMaterno, nombre;  


SELECT CONCAT('$', round(precio,idArticulo)) as totalSimbolo FROM Articulo;



----Trigger Utilizados-----------
/*USE ParqueFerroviario
SELECT * FROM sys.triggers
GO*/

--trigger 1 que registra las eliminaciones hechas de las tablas-------------------------


create table HistorialTrenEmpleado
(
idHistorialTrenEmpleado int identity(1,1) primary key,
fecha date,
accion varchar(100)
)
go
--
create trigger TR_eliminar_TrenEmpleado
on TrenEmpleado for delete
AS
BEGIN
insert into HistorialTrenEmpleado(fecha,accion )
values (getdate(), 'Se borro el dato correcto')
end
go
--Revisar que el trigger se realizo correctamente
delete from TrenEmpleado where idTrenEmpleado= 9
go
select * from HistorialTrenEmpleado;
go


------------TRIGGER 2-------------------------------------
---este tiene que ir antes de hacer los insert para que s---
create table HistorialTaller
(
idHistorialTaller int identity(1,1) primary key,
fecha date,
decripcion varchar(100)
)
go
CREATE TRIGGER TR_TallerInsertado
ON Taller for insert
AS
INSERT INTO HistorialTaller values(GETDATE(),'Registro insertado')
GO
--Triger 3 actualizar------------------------------
create table HistorialActualizar
(
idHistorialActualizar int identity(1,1) primary key,
fecha date,
accion varchar(100)
)
go
--
create trigger TR_Actualizar_Ruta
on Ruta for update
AS
BEGIN
insert into HistorialActualizar(fecha,accion )
values (getdate(), 'Se actualizo el dato correcto')
end
go
--Revisar que el trigger se realizo correctamente
UPDATE Ruta SET rutaTren='Durango a Ciudad de Mexico' WHERE idRuta=3
go
select * from HistorialActualizar;
go



--------trigger historial de insertar-4--------------------
create table HistorialInsertar
(
idHistorialInsertar int identity(1,1) primary key,
fecha date,
accion varchar(100)
)
go
--
create trigger TR_Insertar_Taller
on Taller for INSERT 
AS
BEGIN
insert into HistorialInsertar(fecha,accion )
values (getdate(), 'Se inserto el dato correcto')
end
go
--Revisar que el trigger se realizo correctamente
INSERT INTO Taller(ubicacion)
VALUES ('Frontera Central')
go
select * from HistorialInsertar;
go



-------------5 TRIGGER--------------------------------------------------
create table HistorialVagon
(
idHistorialVagon int identity(1,1) primary key,
fecha date,
accion varchar(100)
)
go
create trigger TR_eliminar_Vagon
on Vagon for delete
AS
BEGIN
insert into HistorialVagon(fecha,accion )
values (getdate(), 'Se borro el dato correcto')
end
go
--Revisar que el trigger se realizo correctamente
delete from Vagon where idVagon= 9
go
select * from HistorialVagon;
go
select * from Vagon;

-------------6 TRIGGER----------------------------------------------------------

create table HistorialCiudad
(
idHistorialCiudad int identity(1,1) primary key,
fecha date,
accion varchar(100)
)
go
--
create trigger TR_Actualizar_Ciudad
on Ciudad for update
AS
BEGIN
insert into HistorialCiudad(fecha,accion )
values (getdate(), 'Se actualizo el dato correcto')
end
go
--Revisar que el trigger se realizo correctamente
UPDATE Ciudad SET codigoPostal='25234' WHERE idCiudad=5
go
select * from HistorialCiudad;
go
SELECT * FROM Ciudad 

---------------7 TIGGER------------------------------------------------------------


create table HistorialInsertarArticulo
(
idHistorialInsertarArticulo int identity(1,1) primary key,
fecha date,
accion varchar(100)
)
go
--
create trigger TR_Insertar_Articulo
on Articulo for INSERT 
AS
BEGIN
insert into HistorialInsertarArticulo(fecha,accion )
values (getdate(), 'Se inserto el dato correcto')
end
go
--Revisar que el trigger se realizo correctamente
INSERT INTO Articulo(nombre,codigo,precio)
VALUES ('Durmientes pintados','332762','15000')
go
select * from HistorialInsertarArticulo;
go





--------------8-----------------------------------------------------
create table HistorialPatio
(
idHistorialPatio int identity(1,1) primary key,
fecha date,
decripcion varchar(100)
)
go
CREATE TRIGGER TR_PatioInsertado
ON Patio for insert
AS
INSERT INTO HistorialPatio values(GETDATE(),'Registro insertado')
GO
----9 trigger 4 mensaje que avisa que se inserto------------------------
CREATE TRIGGER TR_Mensaje_Empresa
on Empresa
for insert
as
   print'Empresa Registrada'
go
-----10 -trigger 5 mensaje que avisa que se actualizo----------------------------
CREATE TRIGGER TR_Mensaje_Puesto
on Puesto
for UPDATE
as
   print'Puesto Actualizado'
go






 ------------------------PROCEDIMIENTOS ALMACENADOS---------------------------
 --- 1-----Restar existencias
CREATE PROCEDURE  SP_RestarExistencia
@id_Articulo as int ,
@cantidad as int
AS
UPDATE Articulo SET precio=precio-@cantidad
WHERE idArticulo=@id_Articulo
GO

  exec SP_RestarExistencia 2,1000
       --SELECT* FROM Articulo
GO
	  
--- 2---Mostrar el puesto
CREATE PROCEDURE SP_VerPuesto
AS
select *from Puesto
where nombreDePuesto= 'Obrero';
GO

   --select *from Puesto
    --where nombreDePuesto= 'Obrero';
    --GO
    exec SP_VerPuesto
	--select *from Puesto    
	GO   
----------3 sumar existencia en articulo----------------------------
CREATE PROCEDURE SP_SumarExistencia
@id_Articulo as int ,
@Cantidad as int
AS
UPDATE Articulo SET precio=precio+@Cantidad
WHERE idArticulo=@id_Articulo
GO

 exec SP_SumarExistencia 6,100000
GO	   
-------- 4 insertar registro empresa---------------------------
CREATE PROCEDURE SP_InsertarRegistroEmpresa
(
@idEmpresa int ,
@nombre varchar(100),
@codigoPostal varchar(100),
@telefono varchar(20) ,
@ubicacion varchar(100)

)
AS
BEGIN
INSERT INTO Empresa(nombre,codigoPostal,telefono,ubicacion)
VALUES (@nombre,@codigoPostal,@telefono,@ubicacion)
END
GO

   exec SP_InsertarRegistroEmpresa 1,'Ferromex Frontera Centro ','25345','866-121-34-51','Frontera Coahuila'
   GO
--- 5--ACTUALIZAR PRECIO Articulo
CREATE PROCEDURE ActualizaPrecioActiculo
(
@Id INT,
@Precio DECIMAL(10, 2)
)
AS
BEGIN
UPDATE Articulo
SET Precio = @Precio
WHERE idArticulo = @Id
END
GO
exec ActualizaPrecioActiculo 5,50000
GO
--- 6---- Description: Obtener los productos por marcas.
 CREATE PROCEDURE SP_NombreArticulo
 (
    @nombre INT
	)
AS
BEGIN
    
    SELECT * FROM Articulo WHERE idArticulo = @nombre;
END
GO
EXEC SP_NombreArticulo
       @nombre = 4;--Parametros de entrada
	   GO
---------7 En el ejemplo anterior, podemos ver que al eliminar un EMPLEADO y
	----este tiene una relación en otra tabla, lo primero que se realiza es eliminar los datos----
	---de la tabla relacionada para terminar de eliminar EMPLEADO y este Id no esté relacionado en tablas secundarias.
	
CREATE PROCEDURE SP_Vagon
(
@idVagon INT
)
AS
IF EXISTS (SELECT * FROM TrenEmpleado WHERE @idVagon = @idVagon)
BEGIN

       DELETE FROM TrenEmpleado WHERE @idVagon = @idVagon
END
DELETE FROM Vagon WHERE idVagon = @idVagon
GO

--SELECT *FROM Venta
--SELECT *FROM Empleado
---------------------------8

CREATE PROCEDURE SP_InsertarRegistroPuesto
(
@idPuesto int ,
@nombreDePuesto varchar(100)


)
AS
BEGIN
INSERT INTO Puesto(nombreDePuesto)
VALUES (@nombreDePuesto)
END
GO
	   
	exec SP_InsertarRegistroPuesto 1,'Cuadrilla de Tripulacion '
	GO
-------- 9 insertar registro viaje---------------------------
CREATE PROCEDURE SP_InsertarRegistroTaller
(
@idTaller int ,
@ubicacion varchar(100)


)
AS
BEGIN
INSERT INTO Taller(ubicacion)
VALUES (@ubicacion)
END
GO
 exec SP_InsertarRegistroTaller 1,'Monlova altos hornos de mexico'
 GO
---------------10
CREATE PROCEDURE SP_insertar_update
      
	 @idEstacion int,----ID
	 @salida varchar (100) ,
	 @llegada varchar (100) ,
	 @telefono varchar(25) ,
	 @idEmpresa int 
AS
----Compara si existe o no existe el ID ya sea para poder actualizar o insertar uno nuevo
IF NOT EXISTS (SELECT * FROM Estacion WHERE idEstacion = @idEstacion)
------Es para poder insertar un registro nuevo
BEGIN
       INSERT INTO Estacion(salida,llegada,telefono,idEmpresa)
       VALUES (@salida,@llegada,@telefono,@idEmpresa)
END

-------Es para poder actualizar los campos 
ELSE
BEGIN
       UPDATE Estacion SET
       salida = @salida,
       llegada = @llegada,
       telefono =@telefono,
	   idEmpresa = @idEmpresa
       WHERE idEstacion = @idEstacion
END
GO

		   ---Se actualiza uno que ya esta
EXEC SP_insertar_update @idEstacion = 4, @salida = 'Estacion Saltillo', @llegada = 'Estacion Ciudad de Mexico' ,@telefono ='866-155-21-30..' ,  @idEmpresa = 9

 

----este se inserta uno nuevo
EXEC SP_insertar_update 0, @salida = 'Estacion Torreon', @llegada = 'Estaion Eagle Pass' ,@telefono ='211-432-77-44' ,  @idEmpresa = 9


GO






--------------------VIEW
create view vwConsulta1
as
select ubicacion, SUBSTRING(ubicacion, 1, 5) as primeras5letras,
getdate () as fechahoy
from Estado
GO


create view vwConsulta2
as
select CONVERT (varchar (4),idEmpleado)+'-'+(nombre+' '+apellidoPaterno+' '+apellidoMaterno)Nombre
FROM Empleado 
WHERE estatus=1 AND Nombre like('A%')----EL _ hace que respete lo que se indica --
GO

create view vwConsulta3
as 
SELECT CONCAT('$', round(precio,idArticulo)) as totalSimbolo FROM Articulo;
GO


