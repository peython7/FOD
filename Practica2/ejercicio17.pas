program ejercicio17;

const

	VA=  9999;
	
	dimF= 10;
	
type
	
	cadena= string[20];
	
	fecha = record
		dia: 1..31;
		mes: 1..12;
		anio: integer;
	end;
	
	moto = record
		cod: integer;
		nombre: cadena;
		descripcion:cadena;
		modelo: cadena;
		marca: cadena;
		stock:integer;
	end;
	
	venta = record
		cod: integer;
		precio: real;
		f:fecha;
	end;

	maestro = file of moto;
	detalle = file of venta;
	
	detalles= array [1..dimF] of detalle;
	ventas = array [1..dimF] of venta;
 
 procedure leer(var d:detalle; var v:venta);
 begin
	if(not EOF(d))then begin
		read(d,v);
	end
	else begin
		v.cod := VA;
	end;
 end;
 
 procedure minimo(var min:venta; var d:detalles; var v:ventas);
 var
	i,pos:integer;
 begin
	min:=v[1];
	pos:=1;
	for i:= 2 to dimF do begin
		if(min.cod > v[i].cod)then begin
			min:= v[i];
			pos:=i;
		end;
	end;
	leer(d[pos],v[pos]);
 end;
 
 procedure actualizarMaestro(var m:maestro; var d:detalles);
 var
	i,contadorVentas,maxVentas:integer;
	regM:moto;
	aux:ventas;
	codigoMasVendida: integer;
	min,act:venta;
begin
	reset(m);
	read(m,regM);
	for i:= 1 to dimF do begin
		reset(d[i]);
		leer(d[i],aux[i]);
	end;
	maxVentas:=0;
	codigoMasVendida:=-1;
	minimo(min,d,aux);
	while(min.cod <> VA)do begin
		act.cod:= min.cod;
		contadorVentas:=0;
		while(min.cod = act.cod)do begin
			contadorVentas:= contadorVentas + 1;
			minimo(min,d,aux);
		end;
		while(regM.cod <> act.cod)do begin
			read(m,regM);
		end;
		regM.stock:= regM.stock - contadorVentas;
		seek(m,filepos(m)-1);
		write(m,regM);
		if(maxVentas < contadorVentas)then begin
			maxVentas:= contadorVentas;
			codigoMasVendida:= act.cod;
		end;
	end;
	close(m);
	for i:= 1 to dimF do begin
		close(d[i]);
	end;
	writeln('La moto más vendida fue la de código: ', codigoMasVendida, ' con ', maxVentas, ' ventas.');
end;
 
 var
  mae: maestro;
  dets: detalles;
  i: integer;
  nombre: cadena;
begin
  writeln('Ingrese nombre del archivo maestro: ');
  readln(nombre);
  assign(mae, nombre);
  for i := 1 to dimF do begin
    writeln('Ingrese nombre del archivo detalle ', i, ': ');
    readln(nombre);
    assign(dets[i], nombre);
  end;
  actualizarMaestro(mae, dets);
end.
