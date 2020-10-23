-- --------------------------------------------------------------------------------------------------------------------
-- creacion de vistas
-- --------------------------------------------------------------------------------------------------------------------

-- vista de datos de alumno

create or replace view view_infoAlumnos as 
	select carnet as 'N° Carnet', nombre as 'Nombre', carrera as 'Carrera', 
    year(curdate()) - year(alumno.fech_nac) + 
	if(date_format(curdate(),'%m-%d')>date_format(alumno.fech_nac,'%m-%d'),0,-1) as edad 
    from alumno;
    
-- select * from view_infoAlumnos

-- --------------------------------------------------------------------------------------------------------------------

-- vista para consulta de materias en BD

create or replace view v_materias as
	select cod_materia as 'Codigo de Materia', nombre as 'Nombre de Materia' from materia;
    
-- select * from v_materias

-- ---------------------------------------------------------------------------------------------------------------------
-- creacion de procedimientos almacenados
-- --------------------------------------------------------------------------------------------------------------------

-- procedimiento para insertar alumnos

DELIMITER $$
create procedure sp_addAlumno(in carnet int, in nombre varchar(50), in carrera varchar(50), in fechaNac date)
begin
	insert into alumno values (carnet,nombre,carrera,fechaNac);
end$$
DELIMITER ;

-- call sp_addAlumno(87654321,'Alberto Rodríguez','Licenciatura en Derecho','1993-11-07');

-- ---------------------------------------------------------------------------------------------------------------------

-- procedimiento para insertar notas 

DELIMITER $$

create procedure sp_insertNotas(in codMate char(10), in _carnet int, in nota double)
begin
	declare carnet_alum int;
    declare cMat char(10);
    
    declare exit handler for sqlexception
        begin
        rollback;        
			 select 'ERROR' as Mensaje, 'El carnet o codigo de materia ingresado no existe en la BD';            
        end;
        
    start transaction;
    
    set carnet_alum = (select carnet from alumno where carnet=_carnet); 
    
    if(carnet_alum=null) then
		select 'ERROR' as Mensaje, 'Error en la operacion';        
	else
		set cMat = (select cod_materia from materia where cod_materia=codMate);
		
		if(cMat=null) then
			select 'ERROR' as Mensaje, 'Error en la operacion';			
		else
            insert into notas values(codMate,_carnet,nota);
            select * from notas;
		end if;   
	end if;
     
    commit;
end$$

DELIMITER ;

-- call sp_insertNotas('DSIWEB-1',87654321,6.6)

-- ---------------------------------------------------------------------------------------------------------------------

-- procedimiento para ver notas_alumno

DELIMITER //

create procedure sp_viewNotasAlumno(in _carnet int)
begin
	declare existe int;
    
    select count(carnet) into existe from alumno where carnet=_carnet;
    
    if existe then    
		select a.carnet as 'N° Carnet', a.nombre as 'Nombre del Alumno', m.cod_materia as 'Codigo de Materia', n.nota 
		from alumno a inner join notas n on a.carnet=n.carnet_alumno inner join materia m on n.cod_materia=m.cod_materia where a.carnet=_carnet;
	else
		select 'El carnet ingresado no existe en la BD';
	end if;
    commit;
    
end //

DELIMITER ;

-- call sp_viewNotasAlumno(87654321);


-- ---------------------------------------------------------------------------------------------------------------------

-- procedimiento para agregar materias

DELIMITER //

create procedure sp_addMateria(in codMat char(10), in nombre varchar(50))
begin
	declare existe int;
    
    Select count(cod_materia) into existe from materia where cod_materia=codMat;
    
    if existe then
		select 'La materia ya existe';
	else
		insert into materia values(codMat,nombre);
        select *,'Materia insertada con exito' as Info from materia where cod_materia=codMat;
	end if;
end //

DELIMITER ;

-- call sp_addMateria('BD-1','Bases de Datos 1');





