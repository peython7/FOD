program ejercicio4;

type
	empleado =record
		numeroEmpleado:integer;
		apellido:string[20];
		nombre:string[20];
		edad:integer;
		dni:string[20];
	end;
	
	empleados= file of empleado;

//-------------CARGAR NUEVO ARCHIVO-------------//
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

//-------------IMPRIMIR EMPLEADO-------------//
procedure imprimir(e:empleado);
begin
	writeln('Soy ',e.nombre,e.apellido,' de ',e.edad,' anios');
end;

//-------------CONSIGNA EJERCICIO 3-------------//
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

//-------------IMPRIMIR ARCHIVO-------------//
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

//-------------MAYORES 70-------------//
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

//-------------INCISO A-------------//
function chequearUnicidad(var arch_e:empleados;n:integer):boolean;
var
	e:empleado;
	repetido:boolean;
begin
	repetido:=false;
	while((not EOF(arch_e))AND(not repetido))do begin
		read(arch_e,e);
		if(e.numeroEmpleado = n)then begin
			repetido:=true;
		end;
	end;
	chequearUnicidad:=repetido;
end;	
	
procedure agregarEmpleados(var arch_e:empleados);
var
	e:empleado;
begin
	reset(arch_e);
	leerDatos(e);
	while(e.apellido <> 'fin')do begin
		if(not(chequearUnicidad(arch_e,e.numeroEmpleado)))then begin
			seek(arch_e,fileSize(arch_e));
			write(arch_e,e);
		end;
		leerDatos(e);
	end;
	close(arch_e);
end;

//------------- INCISO B -------------//
procedure modificarEdad(var arch_e:empleados);
var
	num,edad:integer;
	e:empleado;
	ok:boolean;
begin
	reset(arch_e);
	writeln('Ingrese numero de empleado');
	readln(num);
	ok:=false;
	while((not EOF(arch_e)) AND (not ok))do begin
		read(arch_e,e);
		if(e.numeroEmpleado = num)then begin
			ok:=true;
			writeln('Ingrese la nueva edad del empleado: ');
			readln(edad);
			e.edad:=edad;
			seek(arch_e,filePos(arch_e)-1);
			write(arch_e,e);
		end;
	end;
	if(ok)then begin
		writeln('Se modifico correctamente la edad del empleado: ',num);
	end
	else begin
		writeln('No se encontro al empleado');
	end;
	close(arch_e);
end;

//-------------INCISO C-------------//
procedure exportarTxt(var arch_e:empleados);
var
	e:empleado;
	archivo_texto: text;
begin
	Assign(archivo_texto,'todos_empleados.txt');
	reset(arch_e);
	rewrite(archivo_texto);
	while(not EOF(arch_e))do begin
		read(arch_e,e);
		with e do writeln(archivo_texto,'',numeroEmpleado,'',apellido,'',nombre,'',edad,'',dni);
	end;
	writeln('Archivo de texto del contenido del archivo exportado correctamente');
	close(arch_e);
	close(archivo_texto);
end;

//-------------INCISO D-------------//
procedure exportarDni00(var arch_e:empleados);
var
	archivo_texto:text;
	e:empleado;
begin
	assign(archivo_texto,'faltaDNIempleado.txt');
	reset(arch_e);
	rewrite(archivo_texto);
	while(not EOF(arch_e))do begin
		read(arch_e,e);
		if(e.dni = '00')then begin
			with e do writeln(archivo_texto,'',numeroEmpleado,'',apellido,'',nombre,'',edad,'',dni);
		end;
	end;
	writeln('Archivo de texto de los empleados que no tengan cargado el dni exportado correctamente');
	close(arch_e);
	close(archivo_texto);
end;

//-------------MENU DE OPCIONES------------//
procedure menuOpciones(var arc: empleados);
var
    opcion: integer;
begin
    writeln('MENU DE OPCIONES');
    writeln('Opcion 1: Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado');
    writeln('Opcion 2: Listar en pantalla los empleados de a uno por linea');
    writeln('Opcion 3: Listar en pantalla los empleados mayores a 70 anios, proximos a jubilarse');
    writeln('Opcion 4: Agregar uno o mas empleados al final del archivo con sus datos ingresados');
    writeln('Opcion 5: Modificar la edad de un empleado dado');
    writeln('Opcion 6: Exportar el contenido del archivo a un archivo de texto llamado todos_empleados.txt');
    writeln('Opcion 7: Exportar a un archivo de texto llamado: faltaDNIEmpleado.txt, los empleados que no tengan cargado el DNI');
    writeln('Opcion 8: Salir del menu y terminar la ejecucion del programa');
    writeln();
    readln(opcion);
    while(opcion <> 8) do
        begin
            case opcion of
                1: buscarEmpleados(arc);
                2: listarEmpleados(arc);
                3: listarProximosJubilados(arc);
                4: agregarEmpleados(arc);
                5: modificarEdad(arc);
                6: exportarTxt(arc);
                7: exportarDNI00(arc);
            else
                writeln('La opcion ingresada no corresponde a ninguna de las mostradas en el menu de opciones');
            end;
            writeln();
            writeln('MENU DE OPCIONES');
            writeln('Opcion 1: Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado');
            writeln('Opcion 2: Listar en pantalla los empleados de a uno por linea');
            writeln('Opcion 3: Listar en pantalla los empleados mayores a 70 anios, proximos a jubilarse');
            writeln('Opcion 4: Agregar uno o mas empleados al final del archivo con sus datos ingresados');
            writeln('Opcion 5: Modificar la edad de un empleado dado');
            writeln('Opcion 6: Exportar el contenido del archivo a un archivo de texto llamado “todos_empleados.txt”');
            writeln('Opcion 7: Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados que no tengan cargado el DNI');
            writeln('Opcion 8: Salir del menu y terminar la ejecucion del programa');
            readln(opcion);
        end;
end;

var
	arch_e:empleados;
	nom: string[20];
begin
	writeln('Ingrese nombre del archivo: ');
	readln(nom);
	Assign(arch_e,nom);
	rewrite(arch_e);
	cargarDatos(arch_e);
	menuOpciones(arch_e);
end.
