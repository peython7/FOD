program ejercicio7;

type
	novela= record
		cod:integer;
		nom:String;
		gen:string;
		precio:real;
	end;
	
	novelas_arch= file of novela;

procedure leerDatos(var n:novela);
begin
	writeln('Ingresa el codigo de novela');
	readln(n.cod);
	if(n.cod <> -1)then begin
		writeln('Ingrese el nombre de la novela');
		readln(N.nom);
		writeln('Ingrese el genero de la novela');
		readln(N.gen);
		writeln('Ingrese el precio de la misma');
		readln(N.precio);
	end;
end;

procedure crearArchivo(var a:novela_arch; var t:text);
var
	n:novela;
	s:string;
begin
	writeln('Ingrese nombre del archivo binario: ');
	read(s);
	assign(a,s);
	writeln('Ingrese nombre del archivo de texto: ');
	read(s);
	assign(t,s);
	Reset(t);
	Rewrite(a);
	while(not EOF(t))do begin
		readln(t,n.cod,n.precio,n.gen);
		readln(t,n.nom);
		write(a,n);
	end;
	close(t);
	close(a);
	writeln('Se creó el archivo binario de forma correcta');
end;

procedure agregarNovela(var a:novela_arch);
var
	s:string;
	aux:novela;
	n:novela;
begin
	writeln('Ingrese nombre del binario que desea abrir: ');
	read(s);
	assign(a,s);
	Reset(a);
	while(not EOF(a))do begin
		read(a,aux);
	end;
	leer(n);
	if(n.cod <> -1)then begin
		write(a,n);
	end;
	close(a);
end;

procedure modificarNovela(var a:novela_arch);
var
	s:string;
	n:novela;
	num:integer;
	aux:novela;
begin
	writeln('Ingrese el nombre del archivo binario');
	readln(s);
	assign(a,s);
	Reset(a);
	repeat
		read(a,aux)
	until(aux.cod = n.cod);
	seek(a,filePos(a)-1);
	write(a,n);
	close(a);
end;

var
	a:novela_arch;
	t:text;
	num:integer;
begin
	crearArchivo(a,t);
	repeat
		writeln('Ingrese opcion: ');
		writeln('1- Agregar novela');
		writeln('2- Modificar novela');
		readln(num);
		case num of
			1: agregarNovela(a);
			2: modificarNovela(a);
	until(num=0);
end.
