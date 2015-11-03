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

	PADDINGTABLEROX = 20;
	PADDINGTABLEROY = 0;

	ANCHOCELDA = 4;
	ALTOCELDA = 2;

	ORIGENX = 5;
	ORIGENY = 5;

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
			Tablero[i,j] := VACIO
		end;
	end;
end;

function KeyScan:char;
BEGIN
If KeyPressed then
	KeyScan:=ReadKey
END;

procedure dibujarInfo;
begin
	GotoXY(ORIGENX, ORIGENY);
	if turn then
		write('Es tu turno        ')
	else
		write('Es el turno del CPU');

	GotoXY(ORIGENX, ORIGENY + 5);
	write('Tu: ');
	GotoXY(ORIGENX + 10, ORIGENY + 5);
	textcolor(COLORP1);
	write(FICHAP1);
	textcolor(white);

	GotoXY(ORIGENX, ORIGENY + 10);
	write('CPU: ');
	GotoXY(ORIGENX + 10, ORIGENY + 10);
	textcolor(COLORP2);
	write(FICHAP2);
	textcolor(white);
end;

procedure dibujarFichaJugador;
begin
	for i := 1 to ANCHO do
		begin
			GotoXY(PADDINGTABLEROX + ORIGENX + ANCHOCELDA * i, PADDINGTABLEROY + ORIGENY - ALTOCELDA div 2);
			write(' ', VACIO);
		end;
	if turn then
	begin
		GotoXY(PADDINGTABLEROX + ORIGENX + ANCHOCELDA * x, PADDINGTABLEROY + ORIGENY - ALTOCELDA div 2);
		write(' ', FICHAP1);
	end;
end;

procedure dibujarTablero;
begin
	for i := 1 to ANCHO do
	begin
		GotoXY(PADDINGTABLEROX + ORIGENX + ANCHOCELDA - 1, PADDINGTABLEROY + ORIGENY - ALTOCELDA);
		write('+');
		GotoXY(PADDINGTABLEROX + ORIGENX + ANCHOCELDA * i, PADDINGTABLEROY + ORIGENY - ALTOCELDA);
		write('---+');
		GotoXY(PADDINGTABLEROX + ORIGENX + ANCHOCELDA * i - ANCHOCELDA div 4, PADDINGTABLEROY + ORIGENY - ALTOCELDA div 2);
		write('|');
		GotoXY(PADDINGTABLEROX + ORIGENX + ANCHOCELDA - 1, PADDINGTABLEROY + ORIGENY);
		write('+');
		GotoXY(PADDINGTABLEROX + ORIGENX + ANCHOCELDA * i, PADDINGTABLEROY + ORIGENY);
		write('---+');
		GotoXY(PADDINGTABLEROX + ORIGENX + ANCHOCELDA * (ANCHO + 1) - ANCHOCELDA div 4, PADDINGTABLEROY + ORIGENY - ALTOCELDA div 2);
		write('|');


		GotoXY(PADDINGTABLEROX + ORIGENX + ANCHOCELDA * i, PADDINGTABLEROY + ORIGENY + ALTOCELDA div 2);
		write('---+');

		for j := 1 to ALTO do
		begin
			GotoXY(PADDINGTABLEROX + ORIGENX + ANCHOCELDA - 1, PADDINGTABLEROY + ORIGENY + ALTOCELDA * i - ALTOCELDA div 2);
			write('+');
			
			GotoXY(PADDINGTABLEROX + ORIGENX + ANCHOCELDA - 1, PADDINGTABLEROY + ORIGENY + ALTOCELDA * j);
			write('|');
			
			case Tablero[i, j] of
				FICHAP1: textcolor(COLORP1);
				FICHAP2: textcolor(COLORP2);
				else textcolor(white);
			end;

			GotoXY(PADDINGTABLEROX + ORIGENX + ANCHOCELDA * i, PADDINGTABLEROY + ORIGENY + ALTOCELDA * j);
			write(' ', Tablero[i,j], ' ');

			textcolor(white);
			write('|');

			GotoXY(PADDINGTABLEROX + ORIGENX + ANCHOCELDA * i, 1 + PADDINGTABLEROY + ORIGENY + ALTOCELDA * j);
			writeln('---+');
		end;
	end;
	writeln();
end;

procedure draw;
begin
	{clrscr;}
	dibujarInfo;
	dibujarFichaJugador;
	dibujarTablero;
end;

function tableroLleno: Boolean;
begin
	tableroLleno:=true;
	for i := 1 to ANCHO do
	begin
		for j := 1 to ALTO do
		begin
			if Tablero[i][j] = VACIO then
			begin
				tableroLleno:=false;
				i:=ANCHO;
				j:=ALTO
			end;
		end;
	end;
end;

function enLinea: Boolean;
begin

end;

function colocarFicha:Boolean;
begin
	for i := ALTO downto 1 do
	begin
		if Tablero[x][i] = VACIO then
		begin
			Tablero[x][i]:=FICHAP1;
			i:=1;
			colocarFicha:=true
		end
		else
			colocarFicha:=false
	end;
end;

procedure handleTurn;
begin
	input:=KeyScan;
	if turn then  { TURNO JUGADOR }
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
    			if colocarFicha then
    				turn := false
    		end;
		end;
	end  { FIN TURNO JUGADOR }
	else { TURNO CPU }
	begin
		for i := 1 to ANCHO do
		begin
			for j := ALTO downto 1 do
			begin
				if Tablero[i][j] = VACIO then
				begin
					Tablero[i][j] := FICHAP2;
					i:=ANCHO;
					j:=1;
					turn:=true
				end
			end;			
		end;
		delay(150);
	end; { FIN TURNO CPU }
	if input = #27 then
		gameOver:=true
end;

procedure update;
begin
	if tableroLleno then
		init
	else
		handleTurn
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
	clrscr;
end.