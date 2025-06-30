(*1. Archivos Secuenciales Parcial Tercera Fecha 08/08/2023
Una empresa dedicada a la venta de golosinas posee un archivo que contiene información
sobre los productos que tiene a la venta. De cada producto se registran los siguientes datos:
código de producto, nombre comercial, precio de venta, stock actual y stock mínimo.
La empresa cuenta con 20 sucursales. Diariamente, se recibe un archivo detalle de cada
una de las 20 sucursales de la empresa que indica las ventas diarias efectuadas por cada
sucursal. De cada venta se registra código de producto y cantidad vendida. Se debe realizar
un procedimiento que actualice el stock en el archivo maestro con la información disponible
en los archivos detalles y que además informe en un archivo de texto aquellos productos
cuyo monto total vendido en el día supere los $10.000. En el archivo de texto a exportar, por
cada producto incluido, se deben informar todos sus datos. Los datos de un producto se
deben organizar en el archivo de texto para facilitar el uso eventual del mismo como un
archivo de carga.
El objetivo del ejercicio es escribir el procedimiento solicitado, junto con las estructuras de
datos y módulos usados en el mismo.
Notas:
● Todos los archivos se encuentran ordenados por código de producto.
● En un archivo detalles pueden haber 0, 1 o N registros de un producto determinado.
● Cada archivo detalle solo contiene productos que seguro existen en el archivo
maestro.
● Los archivos se recorren una sola vez. En el mismo recorrido, se debe realizar la
actualización del archivo maestro con los archivos detalles, así como la generación
del archivo de texto solicitado*)


program parcial08/08/2023;

const
	
	VA = 30000;
	dimF = 20; 

type
	cadena = string[20];
	
	producto = record
		cod:integer;
		nombre: cadena;
		precio: real;
		stock: integer;
		stockMinimo: integer;
	end;
	
	venta = record
		cod : integer;
		cantidad: integer;
	end;
	
	maestro = file of producto;
	detalle = file of venta;
	
	detalles = file of detalle;
	ventas = file of venta;
	
procedure leer(var d:detalle; var v:venta);
begin
	if(not EOF(d))then begin
		read(d,v);
	end
	else begin
		v.cod:=VA;
	end;
end;

procedure minimo(var min:venta; var d:detalles; var v:ventas);
var
	i,pos:integer;
begin
	min:=v[1];
	for i:= 2 to dimF do begin
		if(min.cod > v[i].cod)then begin
			min:= v[i];
			pos:= i;
		end;
	end;
	leer(d[pos],v[pos]);
end;

procedure actualizar(var m:maestro; var d:detalles; var v:ventas; var t:text);
var
	i:integer;
	regM:producto;
	aux,min:venta;
	montoDelDia: real;
begin
	reset(m);
	rewrite(t);
	writeln(t,'Los productos cuyo monto total supero los 10mil el dia de hoy: ');
	for i:= 1 to dimF do begin
		reset(d[i]);
		leer(d[i],v[i]);
	end;
	leer(m,regM);
	minimo(min,d,v)
	while(min.cod <> VA)do begin
		aux.cod := min.cod;
		aux.cantidad := 0;
		while(aux.cod  = min.cod)do begin
			aux.cantidad := aux.cantidad + min.cantidad;
			minimo(min,d,v);
		end;
		while(regM.cod <> aux.cod)do begin
			read(m,regM);
		end;
		montoDelDia:= aux.cantidad * regM.precio;
		regM.stock:= regM.stock - aux.cantidad;
		seek(m,filepos(m)-1);
		write(m,regM);
		if(montoDelDia > 10000)then begin
			writeln(t,regM.codigo,'',regM.nombre,'',regM.precio,'',regM.stock,'',regM.stockMinimo);
		end;
	end;
	close(m);
	close(t);
	for i:=1 to dimF do begin
		close(d[i]);
	end;
end;




