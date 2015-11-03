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
	i, j, x: Integer;
	var a: char;

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
    END
END;

procedure init;
begin
	a:=ESPACIO;
	clrscr;
	x:=0;
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

begin
	init();
	while not gameOver do
	begin
		update();
		draw();
	end;
end.