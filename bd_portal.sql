create database bd_portal;
use bd_portal;

-- tablas: usuarios, Login, Notas, Materias,
-- drop database bd_portal;

create table usuario(
	id int auto_increment primary key,
	usuario varchar(25),
	clave varchar(25)
);

create table alumno(
	carnet int primary key not null,
	nombre varchar(50),
	carrera varchar(50),
    fech_nac date
    );

create table materia(
	cod_materia char(10) primary key not null,
    nombre varchar(50)
);

create table notas(
	cod_materia char(10) not null,
	carnet_alumno int not null,
    nota double,
    foreign key(cod_materia) references materia(cod_materia),
    foreign key(carnet_alumno) references alumno(carnet)
);







    

