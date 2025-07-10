program ejercicio2;

const
	valorAlto= 30000;
	
type
	cadena= string[20];
	
	producto=record
		cod:integer;
		nom:cadena;
		precio:real;
		stock:integer;
		stockMinimo:integer;
	end;
	
	venta= record
		cod:integer;
		cant:integer;
	end;
	
	maestro= file of producto;
	detalle = file of venta;
	
procedure leer(var v:venta; var det:detalle);
begin
	if(not EOF(det))then begin
		read(det,v);
	end
	else begin
		v.cod:= valorAlto;
	end;
end;

procedure incisoA(var m:maestro; var d:detalle);
var
	regD: venta;
	regM: producto;
	aux: venta;
begin
	reset(m);
	reset(d);
	read(m,redM);
	leer(regD,d);
	while(regM.cod <> valorAlto)do begin
		aux.cod:=regD.cod;
		aux.cant:=0;
		while((regD.cod = aux.cod) AND (regD.cod <> valorAlto)) do begin
			aux.cant:= aux.cant + regD.cant;
			leer(regD,d);
		end;
		while(aux.cod <> regM.cod)do begin
			read(m,regM);
		end;
		seek(m,filepos(m)-1);
		regM.stock:= regM.stock - aux.cant;
		write(m,regM);
		if(not EOF(arch_mae))then begin
			read(arch_mae,regm);
		end;
	end;
	close(m);
	close(d);
end;

procedure incisoB(var mae:maestro; var t:text);
var
	regM:producto;
begin
	reset(mae);
	rewrite(t);
	while(not EOF(mae))do begin
		read(mae, regM);
		if(regM.stock < regM.stockMinimo)then begin	
			writeln(t,regM.cod,'   ',regM.precio,'   ',regM.nom);
			writeln(t,regM.st,'   ',regM.stmin);
		end;
	end;
	close(mae);
	close(t);
end;

var
	mae:maestro;
	det:detalle;
	num:integer;
	t:text;
	cad:cadena;  
begin
	writeln('Ingrese el nombre del archivo maestro'); 
	readln(cad);
	Assign(mae,cad);
	writeln('Ingrese el nombre del archivo detalle');
	readln(cad);
	Assign(det,cad);
	repeat
		writeln('Ingrese la opcion a ejecutar ');
		writeln('0.Terminar el programa');
		writeln('1.Actualizar el archivo maestro');
		writeln('2.Exportar productos con stock menor al minimo');
		readln(num);
		case num of
			0:writeln('El programa termino');
			1: begin
				writeln('ingrese el nombre del archivo maestro');
				readln(cad);
				assign(arch_mae,cad);
				writeln('ingrese el nombre del archivo maestro');
				readln(cad);
				assign(arch_det,cad);
				inciso_a(arch_mae,arch_det);
			end;  
			2: begin
				writeln('ingrese el nombre del archivo de texto');
				readln(cad);
				assign(t,cad);
				incisoB(mae,t);
			end;
	until(num=0);
end.
