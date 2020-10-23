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







