-- select date_format(curdate(),"%d %b %Y")as fecha;

select nombre,year(curdate()) - year(alumno.fech_nac) + 
	if(date_format(curdate(),'%m-%d')>date_format(alumno.fech_nac,'%m-%d'),0,-1) as edad from alumno;
    
select * from alumno;
select * from materia;
select * from notas;

insert into materia values 
('MATE-1','Matemática 1'),
('PROGRAM-1','Programacion 1'),
('DSIWEB-1','Desarrollo de Sistemas Web 1'),
('UML','Lenguaje Unificado de Modelado'),
('BD-2','Bases de Datos 2'),
('FICA-1','Física 1');

insert into notas values
('MATE-1',12345678,'7.5'),
('PROGRAM-1',12345678,'7.5'),
('DSIWEB-1',12345678,'7.5'),
('UML',12345678,'7.5'),
('BD-2',12345678,'7.5'),
('FICA-1',12345678,'7.5')
-- where cod_materia = materia.cod_materia;

DELIMITER $$

create procedure sp_insertNotas(in codMate char(10), in _carnet int, in nota double)
begin
	declare carnet_alum int;
    declare exit handler for sqlexception
        begin
        rollback;
			select 'ERROR' as Mensaje, 'El carnet no existe en la bd';
        end;
    start transaction;
    set carnet_alum = (select carnet from alumno where carnet=_carnet); 
    if(carnet_alum=null) then
		select 'ERROR' as Mensaje, 'Error en la operacion';        
	else
		set @cMat = (select cod_materia from materia where cod_materia=codMate);
		
		if(@cMat=null) then
			select 'ERROR' as Mensaje, 'El codigo de materia o el codigo y carnet no existen en la bd';			
		else
            insert into notas values(codMate,_carnet,nota);
		end if;   
	end if;
    commit;
end$$

DELIMITER ;

call sp_insertNotas('FICA1',12345678,9.0)

