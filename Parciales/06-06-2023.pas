(*1. Archivos Secuenciales
Suponga que tiene un archivo con información referente a los empleados que trabajan en
una multinacional. De cada empleado se conoce el dni (único), nombre, apellido, edad,
domicilio y fecha de nacimiento.
Se solicita hacer el mantenimiento de este archivo utilizando la técnica de reutilización de
espacio llamada lista invertida.
Declare las estructuras de datos necesarias e implemente los siguientes módulos:
Agregar empleado: solicita al usuario que ingrese los datos del empleado y lo agrega al
archivo sólo si el dni ingresado no existe. Suponga que existe una función llamada
existeEmpleado que recibe un dni y un archivo y devuelve verdadero si el dni existe en el
archivo o falso en caso contrario. La función existeEmpleado no debe implementarla. Si el
empleado ya existe, debe informarlo en pantalla.
Quitar empleado: solicita al usuario que ingrese un dni y lo elimina del archivo solo si este
dni existe. Debe utilizar la función existeEmpleado. En caso de que el empleado no exista
debe informarse en pantalla.
Nota: Los módulos que debe implementar deberán guardar en memoria secundaria todo
cambio que se produzca en el archivo. *)

program parcial060623;

const
	
	VA = 9999;
	
type
	
	cadena= string[20];
	
	fecha = record
		dia: 1..31;
		mes:1..12;
		anio: integer;
	end;
	
	empleado = record
		dni:integer;
		nombre: cadena;
		apellido: cadena;
		edad: integer;
		direccion: cadena;
		nacimiento: fecha;
	end;
	
	archivo = file of empleado;
	
procedure leer(var a:archivo; var e:empleado);
begin
	if(not EOF(a))then begin
		read(a,e);
	end
	else begin
		e.dni :=VA;
	end;
end;

procedure leerEmpleado(var e:empleado);
begin
	writeln('Ingrese los datos del empleado que desea registrar: ');
	readln(e.dni);
	readln(e.nombre);
	readln(e.apellido);
	readln(e.edad);
	readln(e.direccion);
	readln(e.nacimiento.dia);
	readln(e.nacimiento.mes);
	readln(e.nacimiento.anio);
end;

procedure agregarEmpleado(var a:archivo);
var
	e,aux:empleado;
begin
	leerEmpleado(e);
	if(existeEmpleado(e.dni,a) = true)then begin
		writeln('El empleado ya esta registrado!!');
	end
	else begin
		reset(a);
		leer(a,aux);
		if((aux.dni <> VA) AND (aux.dni <> 0))then begin
			aux.dni:= aux.dni*-1;
			seek(a,aux.dni);
			read(a,aux);
			seek(a,filePos(a)-1);
			write(a,e);
			if(aux.dni > 0)then begin
				aux.dni := aux.dni * -1;
			end;
			write(a,aux);
		end
		else begin
			seek(a,filesize(a)-1);
			write(a,e);
		end;
		close(a);
	end;
end;

procedure quitarEmpleado(var a:archivo);
var
	dni:integer;
	aux,pos0: empleado;
begin
	writeln('Ingrese dni que desea eliminar: ');
	read(dni);
	if(existeEmpleado(dni,a) =true)then begin
		writeln('El dni buscado no se encuentra en el sistema.');
	end
	else begin
		reset(a);
		leer(a,aux);
		leer(a,pos0);
		while(aux.dni <> dni)do begin
			leer(a,aux);
		end;
		pos= filepos(a)-1;
		seek(a,pos);
		write(a,pos0);
		seek(a,0);
		aux.dni:= pos*-1;
		write(a,aux);
		close(a);
	end;
end;



