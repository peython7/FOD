program punto4;

const
	valorAlto = 'ZZZZ';
	dimF = 30;
	
type
	cadena: string [20];
	
	producto = record
		cod: cadena;
		nom: cadena;
		descripcion: cadena;
		stock: integer;
		stockMinimo: integer;
		precio: real;
	end;
	
	prod = record
		cod: cadena;
		cantidad: integer;
	end;
	
	archivoMaestro = file of producto;
	archivoDetalle =  file of prod;
	
	vectorArchivo = array [1..dimF] of archivoDetalle;
	vectorProd = array [1.. dimF] of prod;
	
procedure leer(var a:archivoDetalle; var p:prod);
begin
	if(not EOF(a))then begin
		read(a,p);
	end
	else begin
		p.cod:=valorAlto;
	end;
end;

procedure minimo(var min:integer; var p:vectorProd; var d:vectorArchivo);
var
	i,pos:integer;
begin
	min:=p[i];
	for i:= 1 to dimF do begin
		if(p[i].cod < min.cod)then begin
			min:= p[i];
			pos:=i;
		end;
	end;
	leer(d[pos],p[pos]);
end;

procedure actualizarMaestro(var m:archivoMaestro; var d:vectorArchivo);
var
	regD:vectorProd;
	min:prod;
	aux: prod;
	i:integer;
	regM: producto;
begin
	reset(m);
	read(m,regM);
	for i:= 1 to dimF do begin
		reset(d[i]);
		leer(d[i],redD[i]);
	end;
	minimo(min,d,regD);
	writeln('Los productos con stock minimo menor al actual son: ');
	while(min.cod <> valorAlto)do begin
		aux.cod:= min.cod;
		aux.cantidad:=0;
		while(min.cod = aux.cod)do begin
			aux.cantidad:= aux.cantidad + min.cantidad;
			minimo(min,d,regD);
		end;
		while(m.cod <> aux.cod)do begin
			read(m,regM);
		end;
		regM.stock:= regM.stock - aux.cantidad;
		seek(m,filePos(m)-1);
		write(m,regM);
		if(regM.stockMin > regM.stock)then begin
			writeln(regM.nombre,'',regM.cod,'',regM.descripcion,'',regM.stock,'',regM.stockMin,'',regM.precio);
		end;
	end;
	close(m);
	for i:=1 to dimF do begin
		close(d[i]);
	end;
end;

var
	m:archivoMaestro;
	d:vectorArchivo;
	c:cadena;
	i:integer;
begin
	writeln('Ingrese nombre del maestro: ');
	readln(c);
	assign(m,c);
	for i:= 1 to dimF do begin
		writeln('Ingrese el nombre del detalle ',i,':');
		readln(c);
		assign(d[i],c);
	end;
	actualizarMaestro(m,d);
end.
