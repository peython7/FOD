program ejercicio3;

const 
	valorAlto= 'ZZZ';
type
	cadena = string[30];
	
	provincia = record
		nombre: cadena;
		cant: integer;
		total: integer;
	end;
	
	censo = record
		nombre: cadena;
		cod: cadena;
		cant: integer;
		total:integer;
	end;
	
	archivoMaestro= file of provincia;
	archivoDetalle= file of censo;
	
procedure leer(var a:archivoDetalle; var c:censo);
begin
	if(not EOF(a))then begin
		read(a,c);
	end
	else begin
		c.nombre:=valorAlto;
	end;
end;

procedure actualizar(var m:archivoMaestro; var d1:archivoDetalle; var d2:archivoDetalle);
var
	min: censo;
	regM:provincia;
	r1,r2:censo;
begin
	reset(m);
	reset(d2);
	reset(d1);
	leer(d1,r1);
	leer(d2,r2);
	minimo(r1,r2,min,d1,d2);
	while(min.cod <> valorAlto)do begin
		read(m,regM);
		while(regM.nombre <> min.nombre)do begin
			read(m,regM);
		end;
		while(regM.nombre = min.nombre)do begin
			regM.cant := regM.cant + min.cant;
			regM.total := regM.total + min.total;
			minimo(r1,r2,min,d1,d2);
		end;
		seek(m,filepos(m)-1);
		write(m,regM);
	end;
	close(m);
	close(d1);
	close(d2);
end;

procedure minimo(var r1:censo;var r2:censo; var min: censo; var d1:archivoDetalle; var d2: archivoDetalle);
begin
	if(r1.nombre <= r2.nombre)then begin
		min:= r1;
		leer(d1,r1);
	end
	else begin
		min:= r2;
		leer(d2,r2);
	end;
end;

var
	det1,det2: archivoDetalle;
	mae:archivoMaestro;
	c:cadena;
begin
	writeln('Ingrese nombre del archivo Maestro: ');
	read(c);
	assign(mae,c);
	writeln('Ingrese nombre del archivo detalle 1: ');
	read(c);
	assign(det1,c);
	writeln('Ingrese nombre del archivo detalle 2: ');
	read(c);
	assign(det2,c);
	actualizar(mae,det1,det2);
end.
