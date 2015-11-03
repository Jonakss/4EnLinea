program ProgramName;

uses crt;

const 
	FICHAP1DEFAULT = '@';
	COLORP1DEFAULT = 4;
	FICHAP2DEFAULT = '#';
	COLORP2DEFAULT = 1;
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
	input, opc, fichaP1, fichaP2: char;
	colorP1, colorP2: Shortint;

procedure reiniciar;
begin
	x:=1;
	turn:=true;
	input:=VACIO;
	gameOver:=false;

	{Llenar array del tablero}
	for i := 1 to ANCHO do
	begin
		for j := 1 to ALTO do
		begin
			Tablero[i,j] := VACIO
		end
	end
end;

procedure init;
begin
	TextBackground(Black);
	clrscr;

	exit:= false;

	fichaP1:=FICHAP1DEFAULT;
	fichaP2:=FICHAP2DEFAULT;
	colorP1:=COLORP1DEFAULT;
	colorP2:=COLORP2DEFAULT;

	reiniciar;
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

	GotoXY(ORIGENX, ORIGENY + 3);
	write('Tu: ');
	GotoXY(ORIGENX + 10, ORIGENY + 3);
	textcolor(colorP1);
	write(fichaP1);
	textcolor(white);

	GotoXY(ORIGENX, ORIGENY + 5);
	write('CPU: ');
	GotoXY(ORIGENX + 10, ORIGENY + 5);
	textcolor(colorP2);
	write(fichaP2);
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
		write(' ', fichaP1);
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
			

			if Tablero[i, j] = fichaP1 then
				textcolor(colorP1)
			else if Tablero[i, j] = fichaP2 then
				textcolor(colorP2);
			
			{case Tablero[i, j] of
							fichaP1: textcolor(colorP1);
							fichaP2: textcolor(colorP2);
							else textcolor(white);
						end;}

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

{function enLinea: Boolean;
begin

end;}

function colocarFicha:Boolean;
begin
	for i := ALTO downto 1 do
	begin
		if Tablero[x][i] = VACIO then
		begin
			Tablero[x][i]:=fichaP1;
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
					Tablero[i][j] := fichaP2;
					i:=ANCHO;
					j:=1;
					turn:=true
				end
			end;			
		end;
	end; { FIN TURNO CPU }
	if input = #27 then
		gameOver:=true
end;

procedure update;
begin
	if tableroLleno then
		reiniciar
	else
		handleTurn
end;

procedure jugar;
begin
	clrscr;
	CursorOff;
	reiniciar;
	repeat
		update();
		draw();
	until gameOver;
end;

function seleccionarColor(color:char): Shortint;
begin
	case color of
		'1': seleccionarColor := 1;    {Blue}
		'2': seleccionarColor := 2;    {Green}
		'3': seleccionarColor := 3;    {Cyan}
		'4': seleccionarColor := 4;    {Red}
		'5': seleccionarColor := 5;    {Magenta}
		'6': seleccionarColor := 6;    {Brown}
		'7': seleccionarColor := 7;    {White}
		'8': seleccionarColor := 8;    {Grey}
		'9': seleccionarColor := 9;    {Light Blue}
		'A': seleccionarColor := 10;    {Light Green}
		'B': seleccionarColor := 11;    {Light Cyan}
		'C': seleccionarColor := 12;    {Light Red}
		'D': seleccionarColor := 13;    {Light Magenta}
		'E': seleccionarColor := 14;    {Yellow}
		else
			seleccionarColor:=seleccionarColor('1');
	end;
end;

procedure cambiarColores;
var color: char;
begin
	clrscr;
	writeln('------> Cambiar fichas <------');
	writeln();
	textcolor(1);
	write('1) Azul  '); 
	textcolor(2);
	write('2) Verede  '); 
	textcolor(3);
	write('3) Cyan  ');
	textcolor(4);
	write('4) Rojo  ');   
	textcolor(5);
	write('5) Magenta  '); 
	writeln();

	textcolor(6); 
	write('6) Maron  ');
	textcolor(7);
	write('7) Blanco  ');
	textcolor(8);
	write('8) Gris  ');
	textcolor(9);
	write('9) Azul claro  ');
	textcolor(10);
	write('A) Verde claro  ');
	writeln();

	textcolor(11);
	write('B) Cyan claro  ');   
	textcolor(12);
	write('C) Rojo claro  ');   
	textcolor(13);
	write('D) Magenta claro  ');   
	textcolor(14);
	write('E) Amarillo  ');
	writeln();

	textcolor(white);
	writeln();
	writeln('En caso de seleccionar una opción que no este en el menú se utilizara el 1');
	writeln();

	write('Seleccione color jugador 1: ');
	readln(color);
	colorP1 := seleccionarColor(color);
	
	repeat
		if colorP1 = colorP2 then
			write('Seleccione un color distinto, este ya lo tiene el jugador 1: ')
		else
			write('Seleccione color jugador 2: ');

		readln(color);
		colorP2 := seleccionarColor(color)
	until colorP1 <> colorP2;
end;

function seleccionarFicha(ficha:char): char;
begin
	case ficha of
		'1': seleccionarFicha := '@';
		'2': seleccionarFicha := '#';
		'3': seleccionarFicha := '$';
		'4': seleccionarFicha := '%';
		'5': seleccionarFicha := '&';
		'6': seleccionarFicha := '0';
		'7': seleccionarFicha := 'X';
		'8': seleccionarFicha := '*';
		'9': seleccionarFicha := '/';
		'0': seleccionarFicha := 'O';
		else
			seleccionarFicha := seleccionarFicha('1');
	end;
end;

procedure cambiarFichas;
var ficha: char;
begin
	clrscr;
	writeln('------> Cambiar fichas <------');
	writeln();
	writeln('1) @   2) #   3) $   4) %   5) &  ');
	writeln('6) 0   7) X   8) *   9) /   0) O  ');

	writeln();
	writeln('En caso de seleccionar una opción que no este en el menú se utilizara el 1');

	write('Seleccione ficha jugador 1: ');
	readln(ficha);
	fichaP1 := seleccionarFicha(ficha);
	
	repeat
		if fichaP1 = fichaP2 then
			write('Seleccione una ficha distinta, esta ya la tiene el jugador 1: ')
		else
			write('Seleccione ficha jugador 2: ');

		readln(ficha);
		fichaP2 := seleccionarFicha(ficha)
	until fichaP1 <> fichaP2;
end;

procedure opciones;
var 
	sel: char;
begin
	clrscr;
	repeat
		writeln('------> Opciones <------');
		writeln();
		writeln('1) Fichas');
		writeln('2) Colores');
		writeln();
		writeln('0) Atras');
		writeln();
		write('Seleccione opcion: ');
		readln(sel);
		case sel of
			'1': cambiarFichas;
			'2': cambiarColores;
		end;
	until sel = '0';
end;

procedure salir(var exit: Boolean);
var 
	o: char;
begin
	repeat
		writeln('Esta seguro que quiere salir (s: si, n: no)? ');
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
		writeln('2) Opciones');
		writeln();
		writeln('0) Salir');
		writeln();
		write('Seleccione opcion: ');
		readln(opc);
		case opc of
			'1': jugar();
			'2': opciones();
			'0': salir(exit);
			else 
			begin
				textcolor(red);
				writeln();
				write(' Opción inválida.');
				delay(150);
				textcolor(white);
			end;
		end;
	until exit;
	clrscr;
end.