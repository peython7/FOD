program parcial04/06/2024;

const 
	valorAlto = 9999;
type
	cad = string[30];
	
	fecha = record
		dia:1..31;
		mes:1..12;
		anio:integer;
	end;
	
	prestamo = record
		sucursal:integer;
		dniEmpleado:cad;
		numeroPrestamo:integer;
		fec:fecha;
		monto:real;
	end;

	archivo: file of prestamo;
	
procedure leer(var a:archivo; var p:prestamo);
begin
	if(not EOF(a))then
		read(a,p);
	else 
		p.sucursal:=valorAlto;
end;

function extraerAnio(f: fecha): integer;
begin
  extraerAnio := f.anio;
end;

procedure cargarTxt(var a:archivo; var t:text);
var
	p:prestamo;
	sucursalActual:integer;
	dniActual: cad;
	contadorVentasAnio: integer;
	montoAnio: real;
	anioActual: integer;
	sucursalMontoTotal: real;
	cantidadVentasSucursal:integer;
	montoEmpresa:real;
	ventasEmpresa:integer;
	montoEmpleado: real;
	cantidadVentasEmpleado: integer;
begin
	reset(a);
	rewrite(t);
	leer(a,p);
	writeln(t,'Informe de ventas de la empresa: ');
	ventasEmpresa:=0;
	montoEmpresa:=0;
	while(p.sucursal <> valorAlto)do begin
		sucursalMontoTotal:=0;
		cantidadVentasSucursal:=0;
		sucursalActual := p.sucursal;
		writeln(t,'Sucursal: ',p.sucursal);
		while(sucursalActual = p.sucursal)do begin
			dniActual:= p.dniEmpleado;
			montoEmpleado:= 0;
			cantidadVentasEmpleado:= 0;
			writeln(t, 'Empleado: DNI ', dniActual);
			while(dniActual = p.dniEmpleado)do begin
				montoAnio:=0;
				contadorVentasAnio:=0;
				anioActual:=extraerAnio(p.fec);
				while(anioActual = extraerAnio(p.fec))do begin
					montoAnio:= montoAnio + p.monto;
					contadorVentasAnio:= contadorVentasAnio + 1;
					leer(a,p);
				end;
				writeln(t, 'Año ', anioActual, ' Cantidad de ventas ', contadorVentasAnio, ' Monto total ', montoAnio:0:2);
				montoEmpleado := montoEmpleado + montoAnio;
				cantidadVentasEmpleado := cantidadVentasEmpleado + contadorVentasAnio;
			end;
			writeln(t, 'Totales ', cantidadVentasEmpleado, ' ', montoEmpleado:0:2);
			cantidadVentasSucursal:=cantidadVentasSucursal + cantidadVentasEmpleado;
			sucursalMontoTotal:= sucursalMontoTotal + montoEmpleado;
		end;
		ventasEmpresa:= ventasEmpresa + cantidadVentasSucursal;
		montoEmpresa:= montoEmpresa + sucursalMontoTotal;
		writeln(t,'Cantidad total de ventas sucursal: ',cantidadVentasSucursal);
		writeln(t,'Monto total vendido por sucursal: ',sucursalMontoTotal:0:2);
	end;
	writeln(t,'Cantidad de ventas de la empresa: ',ventasEmpresa);
	writeln(t,'Monto total vendido por la empresa: ',montoEmpresa:0:2);
	close(t);
	close(a);
end;

var
	a:archivo;
	t:text;
	c:cad;
begin
	writeln('Ingrese nombre del archivo: ');
	readln(c);
	assign(a,c);
	writeln('Ingrese nombre del archivo de teto: ');
	readln(c);
	assign(t,c);
	cargarTxt(a,t);
end.
