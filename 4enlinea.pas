program ProgramName;

uses crt;

const 
	FICHAP1 = '@';
	FICHAP2 = '#';
	ESPACIO = ' ';
	ANCHO = 7;
	ALTO = 6;
type 
	TTable = array [1..ANCHO, 1..ALTO] of char;

var 
	gameOver, exit:Boolean;
	Tablero: TTable;
	i, j, x: Integer;
	a, opc: char;

procedure init;
begin
	a:=ESPACIO;
	clrscr;
	x:=0;
	gameOver := false;
	exit:= false;	
	{Llenar array del tablero}
	for i := 1 to ANCHO do
	begin
		for j := 1 to ALTO do
		begin
			Tablero[i,j] := FICHAP1;	
		end;
	end;
end;

Procedure KeyScan;
BEGIN
If KeyPressed then
    BEGIN
      a := ReadKey;
      case a of
      	#75:  {LEFT}
      	begin
      		if x = 0 then
      			x:=0
      		else
      			x:=x-1
      	end;
      	#77:  {RIGTH}
		begin
	      	if x = ANCHO then
      			x:=ANCHO
      		else
      			x:=x+1	
		end;
      end;
      if a = #27 then gameOver:=true
      else gameOver := false
    END
END;

procedure dibujarTablero;
begin
	for i := 1 to ANCHO do
	begin
		for j := 1 to ALTO do
		begin
			GotoXY(5 * i, 5 * j);
			write(' ', Tablero[i,j], ' ');	
		end;
		writeln();
	end;

	writeln(); writeln(x);
end;

procedure draw;
begin
	clrscr;
	dibujarTablero();
end;

procedure update;
begin
	KeyScan();
end;

procedure jugar;
begin
	repeat
		update();
		draw();
	until gameOver;
end;

procedure salir(var exit: Boolean);
var 
	o: char;
begin
	repeat
		Writeln('Esta seguro que quiere salir (s: si, n: no)? ');
		readln(o);
	until (o = 's') or (o = 'n');
	if o = 's' then
		exit:= true
	else if o = 'n' then
		exit:= false
end;

begin
	init();
	repeat
		clrscr;
		writeln('...··· MENÚ ···...');
		writeln();
		writeln('1) Jugar');
		writeln('0) Salir');
		writeln();
		write('Seleccione opción: ');
		readln(opc);
		case opc of
			'1': jugar();
			'0': salir(exit);
			else 
				Write(' Opción inválida.');
		end;
	until exit;
end.