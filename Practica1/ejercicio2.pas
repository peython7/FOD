program ejercicio2;

type
	archivo=file of integer;

procedure procesar(var p:real;var m1500:integer;var n_arch:archivo);
var
	num:integer;
begin
	while(not EOF(n_arch))do begin
		read(n_arch,num);
		p:=p+num;
		if(num < 1500)then begin
			m1500:= m1500 +1;
		end;
	end;
	p:= p/fileSize(n_arch);
end;

procedure imprimirArchivo(var arch:archivo);
var
	num:integer;
begin
	while(not EOF(arch))do begin
		read(arch,num);
		writeln(num);
	end;
end;
	
var
	nom:string[20];
	numMenores1500:integer;
	prom:real;
	arch:archivo;

begin
	numMenores1500:=0;
	prom:=0;
	writeln('Ingrese nombre del archivo que desea abrir: ');
	readln(nom);
	Assign(arch,nom);
	Reset(arch);
	imprimirArchivo(arch);
	seek(arch,0);
	procesar(prom,numMenores1500,arch);
	close(arch);
	writeln('La cantidad de numeros menores a 1500 es de: ',numMenores1500);
	writeln('El promedio fue de: ',prom);
end.
