program punto1;

type
	archivo = file of integer;

var
	arch_int:archivo;
	nomb_arch: string[20];
	num:integer;
begin
	writeln('Ingrese el nombre del archivo: ');
	readln(nomb_arch);
	Assign(arch_int,nomb_arch);
	Rewrite(arch_int);
	write('Ingrese un numero: ');
	read(num);
	while(num <>3000)do begin
		write(arch_int,num);
		write('Ingrese un numero: ');
		read(num);
	end;
	write('La carga de numeros ha finalizado');
	close(arch_int);
end.
