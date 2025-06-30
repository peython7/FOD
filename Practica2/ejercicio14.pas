program ejercicio14;

const
	
	VA= 'ZZZZ';

type
  cadena = string[30];

	(*fecha= record
		dia: 1..31;
		mes:1..12;
		anio: integer;
	end;*)

  vuelo = record
    destino: cadena;
    fecha:cadena;
    hora: cadena;
    asientos: integer;
  end;

  venta = record
    destino: cadena;
    fecha: cadena;
    hora: cadena;
    comprados: integer;
  end;

  maestro = file of vuelo;
  detalle = file of venta;
  
  
procedure leer(var d:detalle;var v:venta);
begin
	if(not EOF(d))then begin
		read(d,v);
	end
	else begin
		v.destino:= VA;
	end;
end;

procedure minimo(var min: venta; var r1:venta; var r2: venta; var d1: detalle;var d2: detalle);
begin
	if((r1.destino < r2.destino) OR ((r1.destino = r2.destino)AND(r1.fecha < r2.fecha))OR ((r1.destino = r2.destino)AND(r1.fecha = r2.fecha)AND(r1.hora < r2.hora))then begin
		min:=r1;
		leer(d1,r1);
	end
	else begin
		min:=r2;
		leer(d2,r2);
	end;
end;

procedure actualizarMaestro(var m:maestro; var d1:detalle; var d2: detalle;var t:text ;valor:integer);
var
	r1,r2,min,act:venta;
	regM:vuelo;
begin
	reset(m);
	read(m,regM);
	rewrite(t);
	reset(d1);
	leer(d1,r1);
	reset(d2);
	leer(d2,r2);
	minimo(min,r1,r2,d1,d2);
	while(min.destino <> VA)then begin
		act.destino:= min.destino;
		act.hora:= min.hora;
		act.fecha:= min.fecha;
		act.comprados:= 0;
		while((min.destino = act.destino)AND(act.fecha = min.fecha)AND(act.hora = min.hora)) do begin
			act.comprados := act.comprados + min.comprados;
			minimo(min,r1,r2,d1,d2);
		end;
		while((act.destino <> regM.destino)OR(regM.fecha <> act.fecha)OR(act.hora <> regM.hora))do begin
			read(m,regM);
		end;
		regM.asientos:= regM.asientos - act.comprados;
		seek(m,filepos(m)-1);
		write(m,regM);
		if(regM.asientos < valor)then begin
			writeln(t, 'Destino: ', regM.destino, ' Fecha: ', regM.fecha, ' Hora: ', regM.hora);
		end;
	end;
	close(m);
	close(t);
	close(d1);
	close(d2);
end;




