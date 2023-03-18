-- creacion de base de datos

create schema deposito_compu5;
use deposito_compu5;


-- creacion de base tablas


create table comprobantes (
n_comprobantes int not null,
detalle varchar (200) not null,
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
c_dirrecion varchar (200) null,
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
alter table productos_defectuosos add constraint fk_egresos foreign key (id_egresos) references egresos (id_egresos);
alter table productos_defectuosos add constraint fk_articulos foreign key (id_articulos) references articulos (id_articulos);

-- correr