-- CREACION DE BASE DE DATOS --

create schema deposito2;
use deposito2;


-- CREACION DE LAS TABLAS DE LA BD --


create table comprobantes (
n_comprobantes int not null,
detalle varchar (400) not null,
tipo varchar (30) not null,
cuit_proveedores bigint null,
cuit_clientes bigint null,
ingr_egr varchar (12) not null,
fecha date not null,
hora time not null, 
id_legajo int not null,
primary key (n_comprobantes)
);

create table proveedores (
cuit_proveedores bigint not null,
p_nombre varchar (50) not null,
p_direccion varchar (200) null,
p_mail varchar (70) null,
p_telefono varchar (50) not null,
p_iva varchar (30) not null,
primary key (cuit_proveedores)
);

create table clientes (
cuit_clientes bigint not null,
c_nombre varchar (75) not null,
c_direccion varchar (200) null,
c_mail varchar (75) null,
c_telefono varchar (40) not null,
c_iva varchar (30) not null,
primary key (cuit_clientes)
);

create table operadores (
id_legajo int not null,
dni int not null, 
n_y_a varchar (60) not null,
genero varchar (12) null,
telefono varchar (20) not null,
mail varchar (50) null,
domicilio varchar (100) not null,
ingreso date not null,
primary key (id_legajo)
);
create table ingresos (
id_ingresos int not null auto_increment,
id_legajo int not null,
n_comprobantes int not null,
id_articulos int not null,
cant_in int not null,
fecha_in date not null,
hora_in time not null,
primary key (id_ingresos)
);
create table articulos (
id_articulos int not null auto_increment,
nombre varchar (120) not null,
marca varchar (20) not null,
descripcion varchar (300) null,
primary key (id_articulos)
);
create table art_ub (
id_art_ub int not null auto_increment,
id_articulos int not null,
id_ubicacion int not null,
primary key (id_art_ub)
);
create table ubicacion (
id_ubicacion int not null,
area varchar (15) not null,
sector varchar (2) not null,
estante int not null,
primary key (id_ubicacion)
);
create table egresos (
id_egresos int not null auto_increment,
id_legajo int not null,
n_comprobantes int not null,
id_articulos int not null,
cant_eg int not null,
fecha_eg date not null,
hora_eg time not null,
primary key (id_egresos)
);
create table productos_defectuosos (
id_defectuosos int not null auto_increment,
id_ingresos int not null,
id_articulos int not null,
cantidad int not null,

primary key (id_defectuosos)
);
#creacion de relaciones (FK)
alter table comprobantes add constraint fk_legajo_1 foreign key (id_legajo) references operadores (id_legajo);
alter table comprobantes add constraint fk_proveedores foreign key (cuit_proveedores) references proveedores (cuit_proveedores);
alter table comprobantes add constraint fk_clientes foreign key (cuit_clientes) references clientes (cuit_clientes);
alter table ingresos add constraint fk_legajo_2 foreign key (id_legajo) references operadores (id_legajo);
alter table ingresos add constraint fk_comprobantes foreign key (n_comprobantes) references comprobantes (n_comprobantes);
alter table ingresos add constraint fk_articulos_1 foreign key (id_articulos) references articulos (id_articulos);
alter table art_ub add constraint fk_articulos_2 foreign key (id_articulos) references articulos (id_articulos);
alter table art_ub add constraint fk_ubicacion foreign key (id_ubicacion) references ubicacion (id_ubicacion);
alter table egresos add constraint fk_legajo_3 foreign key (id_legajo) references operadores (id_legajo);
alter table egresos add constraint fk_comprobantes_2 foreign key (n_comprobantes) references comprobantes (n_comprobantes);
alter table egresos add constraint fk_articulos_3 foreign key (id_articulos) references articulos (id_articulos);
alter table productos_defectuosos add constraint fk_ingresos foreign key (id_ingresos) references ingresos (id_ingresos);
alter table productos_defectuosos add constraint fk_articulos foreign key (id_articulos) references articulos (id_articulos);


-- CARGAR REGISTROS DE ENTIDAD OPERADORES --

insert into operadores 
values (67938, 40613127, 'Esperanza Yáñez', 'Femenino', '+54 11 4385 1971', 'esperanza.yanez@hotmail.com', 'Calle Los Algarrobos, 951 San Francisco Solano, CP 1842, Buenos Aires, Argentina', '2015-10-26'), 
(93070, 39745843, 'Enzo Gutierrez', 'Masculino', '+54 11 4079 2321', 'enzo.gutierrez@gmail.com', 'Av. Gral. Mosconi, 4367 Villa Lynch, CP 1672, Buenos Aires, Argentina', '2016-09-22'), 
(35553, 49613531, 'Maria Rios', 'Femenino', '+54 11 4631 6808', 'maria.rios@gmail.com', 'Calle Dr. Mariano Moreno, 3171 Hurlingham, CP 1686, Buenos Aires, Argentina', '2015-12-03'), 
(10703, 50376423, 'Santiago Flores', 'Masculino', '+54 11 4524 3725', 'santiago.flores@yahoo.com', 'Calle Granaderos, 1075 Santos Lugares, CP 1676, Buenos Aires, Argentina', '2016-02-09'), 
(87180, 31110458, 'Julieta Muñoz', 'Femenino', '+54 11 4389 4846', 'julieta.munoz@hotmail.com', 'Calle Angel D\'Elía, 3997 La Tablada, CP 1766, Buenos Aires, Argentina', '2015-07-17');

select * from operadores;


-- IMPORTACION DE DATOS DE CLIENTES MEDIANTE ASISTENTE WORKBENCH --

select * from clientes;

-- IMPORTACION DE DATOS DE PROVEEDORES MEDIANTE ASISTENTE WORKBENCH --

select * from proveedores;

-- IMPORTACION DE DATOS DE UBICACION MEDIANTE ASISTENTE WORKBENCH --

select * from ubicacion;

-- IMPORTACION DE DEMÁS DATOS DE ARTICULOS MEDIANTE ASISTENTE WORKBENCH --

select * from articulos;

-- IMPORTACION DE DATOS DE COMPROBANTES MEDIANTE ASISTENTE WORKBENCH --

select * from comprobantes;

-- IMPORTACION DE DATOS DE INGRESOS MEDIANTE ASISTENTE WORKBENCH --

select * from ingresos;

-- IMPORTACION DE DATOS DE EGRESOS MEDIANTE ASISTENTE WORKBENCH --

select * from egresos;

-- IMPORTACION DATOS DE ART_UB MEDIANTE ASISTENTE WORKBENCH -- 

select * from art_ub;

-- IMPORTACION DE DATOS PRODUCTOS_DEFECTUOSOS MEDIANTE ASISTENTE WORWBENCH --

select * from productos_defectuosos;



-- CREACION DE VISTA PRODUCTOS DEFECTUOSOS-- 

CREATE VIEW defectuosos AS
SELECT articulos.nombre, articulos.marca, 
productos_defectuosos.cantidad,  productos_defectuosos.id_ingresos, 
ingresos.n_comprobantes, ingresos.fecha_in, 
comprobantes.cuit_proveedores,
proveedores.p_nombre, proveedores.p_telefono
FROM articulos
JOIN productos_defectuosos ON articulos.id_articulos = productos_defectuosos.id_articulos
JOIN ingresos ON productos_defectuosos.id_ingresos = ingresos.id_ingresos
JOIN comprobantes ON ingresos.n_comprobantes = comprobantes.n_comprobantes
JOIN proveedores ON comprobantes.cuit_proveedores = proveedores.cuit_proveedores;


-- EJECUCION DE LA VISTA: INFORMACION DE PRODUCTOS DEFECTUSOS A PARTIR DE 5 TABLAS --

select * from defectuosos;




-- CREACION DE LA FUNCION DISPONIBILIDAD DE STOCK --


DELIMITER $$
 
 CREATE FUNCTION disponibilidades(id int) RETURNS int
    DETERMINISTIC
BEGIN
  DECLARE stock INT;
  DECLARE total_ingresos INT;
  DECLARE total_egresos INT;
  DECLARE defectuosos  INT; 
  
    -- OBTENER LA CANTIDAD TOTAL DE INGRESOS DEL PRODUCTO -- 
    
  SELECT COALESCE(SUM(cant_in), 0) INTO total_ingresos
  FROM ingresos
  WHERE id_articulos = id;
  
      -- OBTENER LA CANTIDAD TOTAL DE EGRESOS DEL PRODUCTO --
      
  SELECT COALESCE(SUM(cant_eg), 0) INTO total_egresos
  FROM egresos
  WHERE id_articulos = id;
  
  -- OBTENER LA CANTIDAD TOTAL DE BAJAS POR PRODUCTOS DEFECUOSOS --
  
  SELECT coalesce(sum(cantidad), 0)  INTO defectuosos
  FROM productos_defectuosos
  WHERE id_articulos = id; 
  
  -- CALCULAR STOCK ACTUAL --
  
  SET stock = total_ingresos - total_egresos - defectuosos;


  -- RETORNAR EL STOCK --

    
RETURN stock;

END $$


-- EJECUCION DE LA FUNCION DISPONIBILIDAD DE STOCK --

select disponibilidades (8);




-- CREACION DE LA FUNCION DE ALERTA POR STOCK MINIMO --


DELIMITER $$

CREATE FUNCTION alerta_stock(id int, umbral int) RETURNS varchar(400)
    DETERMINISTIC
BEGIN
  DECLARE stock INT;
  DECLARE total_ingresos INT;
  DECLARE total_egresos INT;
  DECLARE defectuosos  INT;
  DECLARE nombree VARCHAR (120);
  DECLARE mensaje VARCHAR (220);
  
    -- OBTENER LA CANTIDAD TOTAL DE INGRESOS DEL PRODUCTO -- 
    
  SELECT COALESCE(SUM(cant_in), 0) INTO total_ingresos
  FROM ingresos
  WHERE id_articulos = id;
  
      -- OBTENER LA CANTIDAD TOTAL DE EGRESOS DEL PRODUCTO --
      
  SELECT COALESCE(SUM(cant_eg), 0) INTO total_egresos
  FROM egresos
  WHERE id_articulos = id;
  
  -- OBTENER LA CANTIDAD TOTAL DE BAJAS POR PRODUCTOS DEFECUOSOS --
  
  SELECT coalesce(sum(cantidad), 0)  INTO defectuosos
  FROM productos_defectuosos
  WHERE id_articulos = id; 
  
  -- CALCULAR STOCK ACTUAL --
  
  SET stock = total_ingresos - total_egresos - defectuosos;
  
  -- OBTENER NOMBRE DEL ARTICULO
  
  SELECT nombre INTO nombree FROM articulos WHERE id_articulos = id;
  
  -- COMPARAR EL STOCK ACTUAL CON EL UMBRAL Y GENERAR UN MENSAJE DE ALERTA SI ES NECESARIO --
  IF stock < umbral THEN
    SET mensaje = CONCAT('¡Alerta de stock bajo! El producto ', nombree, ' tiene un stock de ', stock, ' unidades.');
  ELSE
    SET mensaje = 'El stock del producto en el depósito está dentro del umbral establecido.';
  END IF;
  
  

  -- RETORNAR EL MENSAJE DE ALERTA --
  RETURN mensaje;


END $$




-- EJECUCION DE LA FUNCION ALERTA POR STOCK MINIMO --

select alerta_stock (18, 50);



-- CREACION DE STORED PROCEDURE --

DELIMITER $$

CREATE PROCEDURE sp_articulos_order4(IN campo CHAR(120), IN campo2 CHAR (4))
BEGIN

-- ESTE SP EJECUTA UNA SENTENCIA QUE MUESTRA LOS REGISTROS DE LA TABLA ARTICULOS Y
-- NOS PERMITE ORDENARLO POR ALGUNO DE SUS ATRIBUTOS DE FORMA ASCENDETE O ASCENDENTE --

IF campo <> " " THEN
SET @articulos_order = concat("ORDER BY ", campo, " ", campo2);
ELSE
SET @articulos_order = concat(" ", campo2);
END IF;
SET @clausula = concat("SELECT * FROM articulos ", @articulos_order);
PREPARE runSQL FROM @clausula;
EXECUTE runSQL;
DEALLOCATE PREPARE runSQL;


END $$


-- EJECUCION FUNCION --

CALL sp_articulos_order4 ("nombre","desc");




-- CREACION SP PARA INSERTAR REGISTRO DE PROVEEDORES --


DELIMITER $$

CREATE PROCEDURE add_reg_proveedores4(in cuit bigint, nombre varchar(50), addres varchar(200), mail varchar(70), phone varchar(50), iva varchar(30))
BEGIN

IF cuit <> " " THEN
INSERT INTO proveedores (cuit_proveedores, p_nombre, p_direccion, p_mail, p_telefono, p_iva)
VALUES(cuit, nombre, addres, mail, phone, iva);
SET @clausula = concat("SELECT * FROM proveedores WHERE cuit_proveedores = ", cuit);
ELSE
SET @clausula = "SELECT 'ERROR: no se pudo crear registro de nuevo proveedor' as error";
END IF;

PREPARE runSQL FROM @clausula;
EXECUTE runSQL;
DEALLOCATE PREPARE runSQL;


END $$



-- EJECUCION DEL SP PARA INGRESAR EL REGISTRO DE PROVEEDORES --

CALL add_reg_proveedores4 (12345678901,"MaxMax","Necochea 300","maxmax@mail.com","114258488-58","Responsable Escrito");





-- CREACION DE TRIGGER PARA ACTUALIZAR LOS NUEVOS INGRESOS EN EL STOCK --
-- SE CREA PRIMERO LA TABLA INVENTARIO --


CREATE TABLE inventario (
  id_articulos INT NOT NULL,
  cantidad_disponible INT NOT NULL,
  PRIMARY KEY (id_articulos)
);

-- SE CARGA EL STOCK ACTUAL DE LOS ARTICULOS ANTES DE CREAR EL TRIGGER --

insert into inventario
values
(1,260),
(2,240),
(3,278),
(4,244),
(5,210),
(6,149),
(7,313),
(8,165),
(9,290),
(10,167),
(11,12),
(12,15),
(13,7),
(14,3),
(15,5),
(16,4),
(17,6),
(18,4),
(19,4),
(20,3);


-- SE CREA EL TRIGGER 1 --

DELIMITER $$

CREATE TRIGGER actualizar_stock_ingresos
AFTER INSERT ON ingresos
FOR EACH ROW
BEGIN
  -- SE ACTUALIZA LA CANTIDAD DISPONIBLE DEL ARTICULO EN EL INVENTARIO -- 
  
  SET @cantidad_actual = (SELECT cantidad_disponible FROM inventario WHERE id_articulos = new.id_articulos);
  SET @cantidad_nueva = @cantidad_actual + new.cant_in;
  UPDATE inventario SET cantidad_disponible = @cantidad_nueva WHERE id_articulos = new.id_articulos;
END $$

-- SE CARGA UN NUEVO COMPROBANTE QUE GENERE UN NUEVO INGRESO --

insert into comprobantes 
values (5006,"Tablet Samsung A8 gris 10.5´ 64 gris x95","Remito",20347856632,0,"Ingreso","2023-03-19","15:00:50",10703);

-- SE CARGA EL NUEVO INGRESO --

insert into ingresos
values (null,10703,5006,20,90,"2023-03-20","14:15:00");



-- CREACION DE TRIGGER PARA ACTUALIZAR LOS NUEVOS EGRESOS EN EL STOCK --

-- SE CREA EL TRIGGER 2 --

DELIMITER $$
CREATE TRIGGER actualizar_stock_egresos
AFTER INSERT ON egresos
FOR EACH ROW
BEGIN
  -- SE ACTUALIZA LA CANTIDAD DISPONIBLE DEL ARTICULO EN EL INVENTARIO -- 
  
  SET @cantidad_actual = (SELECT cantidad_disponible FROM inventario WHERE id_articulos = new.id_articulos);
  SET @cantidad_nueva = @cantidad_actual - new.cant_eg;
  UPDATE inventario SET cantidad_disponible = @cantidad_nueva WHERE id_articulos = new.id_articulos;
END $$

-- SE CARGA UN NUEVO COMPROBANTE QUE GENERE UN NUEVO EGRESO --

insert into comprobantes 
values (1211,"Tablet Samsung A8 gris 10.5´ 64 gris x10","Factura A",0,20856592138,"Egreso","2023-03-20","09:00:50",10703);

-- SE CARGA NUEVO EGRESO --

insert into egresos
values (null,10703,5006,20,10,"2023-03-20","09:15:00");


-- CREACION DE TRIGGER PARA ACTUALIZAR LOS NUEVOS EGRESOS EN EL STOCK POR BAJAS PRODUCTOS DEFECTUOSOS --
-- SE CREA EL TRIGGER 3 --

DELIMITER $$
CREATE TRIGGER actualizar_stock_defectuosos
AFTER INSERT ON productos_defectuosos
FOR EACH ROW
BEGIN
  -- SE ACTUALIZA LA CANTIDAD DISPONIBLE DEL ARTICULO EN EL INVENTARIO -- 
  
  SET @cantidad_actual = (SELECT cantidad_disponible FROM inventario WHERE id_articulos = new.id_articulos);
  SET @cantidad_nueva = @cantidad_actual - new.cantidad;
  UPDATE inventario SET cantidad_disponible = @cantidad_nueva WHERE id_articulos = new.id_articulos;
END $$

-- SE CARGA REGISTRO DE NUEVA BAJA POR PRODUCTOS DEFECTUOSOS --

insert into productos_defectuosos
values (null,28,20,3);

-- CONSULTAR STOCK --

select * from inventario;



-- CREACION TABLA PARA REGISTRO DE OPERACIONES A TRAVES DE TRIGGERS -- 

CREATE TABLE registro_operaciones (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_ingresos INT,
  usuario VARCHAR(100) NOT NULL,
  fecha_operacion DATE NOT NULL,
  hora_operacion TIME NOT NULL
);

-- CREACION DEL TIGGERS PARA EL REGISTRO DE OPERACIONES --
-- CREACION TRIGGER 4 --

delimiter $$
CREATE TRIGGER registro_operaciones
AFTER INSERT ON ingresos
FOR EACH ROW
BEGIN
  INSERT INTO registro_operaciones (usuario, id, fecha_operacion, hora_operacion)
  VALUES (USER(), NEW.id_ingresos, DATE(NOW()), TIME(NOW()));
END$$

-- CONSULTAR REGISTROS --

select * from registro_operaciones;




### CREACIÓN DE USUARIOS EN MYSQL --
## CREACIÓN DE USUARIO Y DEFINICIÓN DE PERMISOS --


-- CREACIÓN DEL PRIMER USUARIO Y DEFINICIÓN DE LA CONTRASEÑA --

create user 'usuario_lectura'@'localhost' identified by 'usuario_lectura';


-- OTORGACION DE PERMISO DE SOLO LECTURA DE TODAS LAS TABLAS DE LA BASE DE DATOS --

grant select on deposito2.* to 'usuario_lectura'@'localhost';


-- CON ESTA SENTENCIA SE CONFIRMA LOS PERMISOS OTORGADOS --

flush privileges;


-- CON ESTA SENTENCIA SE RESTRINGE AL USUARIO LA POSIBILIDAD DE ELIMINAR LOS REGISTROS DE LAS TABLAS DE LA BD --

revoke delete on deposito2.* from 'usuario_lectura'@'localhost';

flush privileges;


-- CON ESTA SENTENCIA SE PUEDE COMPROBAR LOS PERMISOS QUE TIENE EL USUARIO --

show grants for 'usuario_lectura'@'localhost';




## CREACION DEL SEGUNDO USUARIO --

create user 'usuario_editor'@'localhost' identified by 'usuario_editor';


-- CON ESTA SENTENCIA SE LE ENTREGA AL USUARIO CREADO PERMISOS 
-- PARA LECTURA, INSERCION Y MODIFICACION DE TODAS LAS TABLAS DE LA BD --

grant select, insert, update on deposito2.* to 'usuario_editor'@'localhost';


-- CON ESTA SENTENCIA SE CONFIRMA LOS PERMISOS OTORGADOS --

flush privileges;


-- CON ESTA SENTENCIA SE RESTRINGE AL USUARIO LA POSIBILIDAD DE ELIMINAR REGISTROS DE LAS TABLAS DE LA BD --

revoke delete on deposito2.* from 'usuario_editor'@'localhost';

flush privileges;



-- CON ESTA SENTENCIA SE PUEDE COMPROBAR LOS PERMISOS OTORGADOS QUE TIENE EL USUARIO --

show grants for 'usuario_editor'@'localhost';

### FIN CREACION DE USUARIOS --
