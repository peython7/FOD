program ejercicio5;

const
	valorAlto = 'ZZZZ';
	dimF = 5;
	
type
	cadena = string [20];
	
	fecha= record
		dia: 1..31;
		mes: 1.12;
		anio:integer;
	end;
	
	sesion = record
		cod: cadena;
		f: fecha;
		tiempo: integer;
	end;
	
	ususario = record
		cod: cadena;
		f:fecha;
		total: integer;
	end;
	
	archivoMaestro = file of usuario;
	archivoDetalle = file of sesion;
	
	detalles = array [1..dimF] of archivoDetalle;
	sesiones = array [1..dimF] of sesion;
	
procedure leer(var d:archivoDetalle;var s:sesion);
begin
	if(not EOF(d))then begin
		read(d,s);
	end
	else begin
		s.cod := valorAlto;
	end;
end;

procedure minimo(var min:sesion; var d:detalles; var s:sesiones);
var 
	pos,i:integer;
begin
	min:= s[i];
	for i:=1 to dimF do begin
		if(min.cod > s[i].cod)then begin
			min:=s[i];
			pos:=i;
		end;
	end;
	leer(d[pos],s[pos]);
end;

procedure actualizar(var m:archivoMaestro; var d:detalles);
var
	i:integer;
	u:usuario;
	s:sesiones;
	min:sesion;
begin
	rewrite(m);
	for i:=1 to dimF do begin
		reset(d[i]);
		leer(d[i],s[i]);
	end;
	minimo(min,d,s);
	while(min.cod <> valorAlto)do begin
		u.cod:= min.cod;
		u.total:=0;
		u.f:= min.f;
		while(min.cod = u.cod)do begin
			u.total:= u.total + min.tiempo;
			minimo(min,d,s);
		end;
		write(m,u);
	end;
	close(m);
	for i:= 1 to dimF do begin
		close(d[i]);
	end;
end;
