program ejercicio3;

const
	valorAlto= 'ZZZZ';

type
	cadena= string[30];
	
	provincia= record
		nombre: cadena;
		cant:integer;
		total: integer;
	end;
	
	censo= record
		nombre: cadena;
		cod:integer;
		cant:integer;
		total:integer;
	end;
	
	maestro= file of provincia;
	detalle= file of censo;
	
procedure leer(var det: detalle; var c:censo);
begin
	if(no EOF(det))then begin
		read(det,c);
	end
	else begin
		c.nom:= valorAlto;
	end;
end;

procedure minimo(var r1:censo; var r2:censo; var min:censo; var det1:detalle; var det2:detalle);
begin
	if(r1.nombre <= r2.nombre)then begin
		min:= r1;
		leer(det1,r1);
	end
	else begin
		min:=r2;
		leer(det2,r2);
	end;
end;

procedure actualizar(var mae:maestro;var det1:detalle;var det2:detalle);
var
  min:censo;
  regm:provincia;
  r1:censo;
  r2:censo;
begin
	reset(mae);
	reset(det1);
	reset(det2);
	leer(det1,r1);
	leer(det2,r2);
	minimo(r1,r2,min,det1,det2);
	while(min.nom <> valor_alto)do begin
		read(mae,regm);
		while(regm.nom <> min.nom)do begin
			read(mae,regm);
		end;
		while(regm.nom = min.nom)do begin
			regm.cant:= regm.cant + min.cant;
			regm.tot:= regm.tot + min.tot;
			minimo(r1,r2,min,det1,det2);
		end;
		seek(mae,filepos(mae)-1);
		write(mae,regm);
	end;
 close(mae);
 close(det1);
 close(det2);
end;

var
	det1:detalle;
	det2:detalle;
	mae:maestro;
	cad:cadena;
begin
	writeln('Ingrese el nombre del archivo maestro');
	readln(cad);
	Assign(mae,cad);
	writeln('Ingrese el nombre del archivo detalle');
	readln(cad);
	Assign(det1,cad);
	writeln('Ingrese el nombre del segundo archivo detalle');
	readln(cad);
	Assign(det2,cad);
	actualizar(mae,det1,det2);
end.
