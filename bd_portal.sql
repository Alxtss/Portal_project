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

-- creacion de vistas

create or replace view view_infoAlumnos as 
	select carnet as 'N° Carnet', nombre as 'Nombre', carrera as 'Carrera', 
    year(curdate()) - year(alumno.fech_nac) + 
	if(date_format(curdate(),'%m-%d')>date_format(alumno.fech_nac,'%m-%d'),0,-1) as edad 
    from alumno;
    
-- select * from view_infoAlumnos


-- creacion de procedimientos almacenados

DELIMITER $$
create procedure sp_addAlumno(in carnet int, in nombre varchar(50), in carrera varchar(50), in fechaNac date)
begin
	insert into alumno values (carnet,nombre,carrera,fechaNac);
end$$
DELIMITER ;

-- call sp_addAlumno(87654321,'Alberto Rodríguez','Licenciatura en Derecho','1993-11-07');


/*create procedure sp_addUsuarios(usuario varchar(25), clave varchar(25)) 
begin
	insert into usuario values(usuario,clave)
end*/

    

