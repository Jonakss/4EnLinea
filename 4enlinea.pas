program ProgramName;

uses crt;

const 
	FICHAP1 = '@';
	COLORP1 = red;
	FICHAP2 = '#';
	COLORP2 = blue;
	VACIO = ' ';
	ANCHO = 7;
	ALTO = 6;

type 
	TTable = array [1..ANCHO, 1..ALTO] of char;

var 
	gameOver, exit, turn:Boolean;
	Tablero: TTable;
	i, j: Integer;
	x: 0..ANCHO;
	input, opc: char;

procedure init;
begin
	TextBackground(Black);
	input:=VACIO;
	clrscr;
	x:=1;
	gameOver := false;
	exit:= false;	
	turn:=true;
	{Llenar array del tablero}

	for i := 1 to ANCHO do
	begin
		for j := 1 to ALTO do
		begin
			Tablero[i,j] := FICHAP1
		end;
	end;
end;

function KeyScan:char;
BEGIN
If KeyPressed then
	KeyScan:=ReadKey
END;

procedure dibujarTurno;
begin
	GotoXY(5, 1);
	ClrEol;
	if turn then
		write('Es tu turno')
	else
		write('Es el turno del CPU');
end;

procedure dibujarFichaJugador;
begin
	for i := 1 to ANCHO do
		begin
			GotoXY(5 * i,3);
			write(VACIO);
		end;
	if turn then
	begin
		GotoXY(5 * x,3);
		write(FICHAP1);
	end;
end;

procedure dibujarTablero;
begin
	for i := 1 to ANCHO do
	begin
		for j := 1 to ALTO do
		begin
			GotoXY(5 * i, 5 * j);
			case Tablero[i, j] of
				FICHAP1: textcolor(COLORP1);
				FICHAP2: textcolor(COLORP2);
				else textcolor(white);
			end;
			write(' ', Tablero[i,j], ' ');	
		end;
		writeln();
	end;
	textcolor(white);
	writeln(); writeln(x);
end;

procedure draw;
begin
	{clrscr;}
	dibujarTurno;
	dibujarFichaJugador;
	dibujarTablero;
end;

procedure handleTurn;
begin
	input:=KeyScan;
	if turn then {Turno jugador}
	begin
		case input of
			#75:	(*LEFT*)
          	begin
          		if x = 1 then
          			x:=1
          		else
          			x:=x-1
          	end;
        	#77:	(*RIGTH*)
    		begin
    	      	if x = ANCHO then
          			x:=ANCHO
          		else
          			x:=x+1	
    		end;
    		#80:	(*DOWN*) 
    		begin
    			turn := false;
    		end;
		end;
	end
	else
	begin
		if input = #80 (*DOWN*) then
			turn := true
	end;
	if input = #27 then
		gameOver:=true
end;

procedure update;
begin
	handleTurn;
end;

procedure jugar;
begin
	clrscr;
	CursorOff;
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
		CursorOn;
		writeln('------> MENU <------');
		writeln();
		writeln('1) Jugar');
		writeln('0) Salir');
		writeln();
		write('Seleccione opcion: ');
		readln(opc);
		case opc of
			'1': jugar();
			'0': salir(exit);
			else 
			begin
				textcolor(red);
				writeln();
				Write(' Opción inválida.');
				delay(150);
				textcolor(white);
			end;
		end;
	until exit;
end.