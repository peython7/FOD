program ejercicio3;

type
	empleado =record
		numeroEmpleado:integer;
		apellido:string[20];
		nombre:string[20];
		edad:integer;
		dni:string[20];
	end;
	
	empleados= file of empleado;

procedure leerDatos(var e:empleado);
begin
	writeln('Ingrese apellido: ');
	read(e.apellido);
	if(e.apellido <> 'fin')then begin
		writeln('Ingrese dni: ');
		read(e.dni);
		writeln('Ingrese nombre: ');
		read(e.nombre);
		writeln('Ingrese numero de empleado: ');
		read(e.numeroEmpleado);
	end;
end;

procedure cargarDatos(var e_arch:empleados);
var
	e:empleado;
begin
	leerDatos(e);
	while(e.apellido <> 'fin')do begin
		write(e_arch,e);
		leerDatos(e);
	end;
end;

procedure imprimir(e:empleado);
begin
	writeln('Soy ',e.nombre,e.apellido,' de ',e.edad,' anios');
end;

procedure buscarEmpleados(var a:empleados);
var
	empleadoBuscado: string[20];
	cad:string;
	e:empleado;
begin
	writeln('Ingrese archivo a utilizar: ');
	readln(cad);
	writeln('Ingresa empleado a buscar: ');
	read(empleadoBuscado);
	Assign(a,cad);
	reset(a);
	while(not EOF(a))do begin
		read(a,e);
		if((e.nombre = empleadoBuscado) OR (e.apellido = empleadoBuscado))then begin
			imprimir(e);
		end;
	end;
	close(a);
end;

procedure listarEmpleados(var a:empleados);
var
	cad:string;
	e:empleado;
begin
	writeln('Ingrese archivo a utilizar: ');
	readln(cad);
	Assign(a,cad);
	reset(a);
	while(not EOF(a))do begin
		read(a,e);
		imprimir(e);
	end;
	close(a);
end;

procedure listarProximosJubilados(var a:empleados);
var
	e:empleado;
	cad:string[20];
begin
	writeln('Ingrese archivo a ultilizar: ');
	readln(cad);
	Assign(a,cad);
	reset(a);
	while(not EOF(a))do begin
		read(a,e);
		if(e.edad > 70)then begin
			imprimir(e);
		end;
	end;
	close(a);
end;

var
	arch_e:empleados;
	nom: string[20];
	opcion:integer;
begin
	writeln('Ingrese nombre del archivo: ');
	read(nom);
	Assign(arch_e,nom);
	rewrite(arch_e);
	cargarDatos(arch_e);
	close(arch_e);
	writeln('Elegir una opcion: ');
	writeln('0: finalizar el programa');
	writeln('1: buscar empleados por apellido o nombre');
	writeln('2: listar empleados');
	writeln('3: listar proximos a jubilarse');
	readln(opcion);
	case(opcion)of
		0:begin
			writeln('Programa finalizado');
		end;
		1:begin
			buscarEmpleados(arch_e);
		end;
		2:begin 
			listarEmpleados(arch_e);
		end;
		3:begin
			listarProximosJubilados(arch_e);	
		end;
		else begin
			writeln('Valor ingresado invalido');
		end;
	end;
end.
