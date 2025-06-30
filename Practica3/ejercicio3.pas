program ejercicio3;

const
	VA= 30000;
	
type

	cadena= string [20];
	
	novela = record
		cod: integer;
		nombre:cadena;
		genero: cadena;
		duracion: integer;
		director: cadena;
		precio: real;
	end;
	
	archivo= file of novela;

procedure leerNovela(var n:novela);
begin
	readln(n.cod);
	readln(n.nombre);
	readln(n.genero);
	readln(n.duracion);
	readln(n.director);
	readln(n.precio);
end;

procedure leer(var a:archivo; var n:novela);
begin
	if(not EOF(a))then begin
		read(a,n);
	end
	else begin
		n.cod:=VA;
	end;
end;

procedure agregarNovela(var a:archivo);
var
	n,aux:novela;
begin
	leerNovela(n);
	reset(a);
	leer(a,aux);
	if((aux.cod <> VA)AND(aux.cod <> 0))then begin
		aux.cod := aux.cod * -1;
		seek(a,aux.cod); 
		read(a,aux);
		seek(a,filePos(a)-1);
		write(a,n);
		seek(a,0);
		if(aux.cod > 0)then begin
			aux.cod:= aux.cod *-1;
		end;
		write(a,aux);
	end
	else begin
		seek(a,fileSize(a));
		write(a,n);
	end;
	close(a);
end;

procedure eliminarNovela(var a: archivo);
var
	aux,n:novela;
	c,pos:integer;
begin
	writeln('Ingrese codigo de novela que desea eliminar: ');
	readln(c);
	reset(a);
	leer(a,n);
	leer(a,aux);
	while(aux.cod <> c)do begin
		leer(a,aux);
	end;
	if(aux.cod = c)then begin
		pos:= filePos(a)-1;
		seek(a,pos);
		write(a,n);
		seek(a,0);
		aux.cod = aux.cod *-1;
		write(a,aux);
	end
	else begin
		writeln('Codigo inexistente.');
	end;
	close(a);
end;

procedure actualizarNovela(var a:archivo);
var
	n,aux:novela;
begin
	reset(a);
	writeln('No modificar el codigo de novela!!!');
	leerNovela(n);
	leer(a,aux);
	while((aux.cod <> VA)AND(aux.cod <> n.cod))do begin
		leer(a,aux);
	end;
	if(aux.cod = n.cod)then begin
		seek(a,filePos(a)-1);
		write(a,n);
	end
	else begin
		writeln('Novela no encontrada.');
	end;
	close(a);
end;


