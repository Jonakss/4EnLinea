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
	gameOver:Boolean;
	Tablero: TTable;
	i, j: Integer;

procedure init;
begin
	clrscr;
	gameOver := false;	
	{Llenar array del tablero}
	for i := 1 to ANCHO do
	begin
		for j := 1 to ALTO do
		begin
			Tablero[i,j] := FICHAP1;	
		end;
	end;
end;

procedure dibujarTablero;
begin
	for i := 1 to ANCHO do
	begin
		for j := 1 to ALTO do
		begin
			write(' ', Tablero[i,j], ' ');	
		end;
		writeln();
	end;
end;

procedure draw;
begin
	clrscr;
	dibujarTablero();
end;

procedure update;
begin
	
end;

begin
	init();
	while not gameOver do
	begin
		update();
		draw();
	end;
end.