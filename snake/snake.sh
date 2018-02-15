#!/bin/bash
# Snake Game
# v1.0

drawborder() {
	#Teken bovenkant
	tput setf 6
	tput cup $FIRSTROW $FIRSTCOL
	x=$FIRSTCOL
	while [ "$x" -le "$LASTCOL" ];
	do
		printf %b "$WALLCHAR"
		x=$(( $x + 1 ));
	done

	#Teken de zijkanten
	#$FIRSTROW
	while [ "$x" -le "$LASTROW" ];
	do
		tput cup $x $FIRSTCOL; printf %b "$WALLCHAR"
		tput cup $x $LASTCOL; printf %b "$WALLCHAR"
		x=$(( $x + 1 ));
	done

	#Teken de onderkant
	tput cup $LASTROW $FIRSTCOL
	x=$FIRSTCOL
	while [ "$x" -le "$LASTCOL" ];
	do
		printf %b "$WALLCHAR"
		x=$(( $x + 1 ));
	done
	tput setf 9
}

apple() {
	# Kiest de coordinaten in het spel
	APPLEX=$[( $RANDOM % ( $[ $AREAMAXX - $AREAMINX ] + 1 ) ) + $AREAMINX ]
	APPLEY=$[( $RANDOM % ( $[ $AREAMAXY - $AREAMAXY ] + 1 ) ) + $AREAMINY ]
}

drawapple() {
	# Kijken of er niet al een plek is ingenomen
	LASTEL=$(( ${#LASTPOSX[@]} - 1 ))
	x=0
	apple
	while [ "$x" -le "$LASTEL" ];
	do
		if [ "APPLEX" = "${LASTPOSX[$x]}" ] && [ "$APPLEY" = "${LASTPOSY[$x]}" ];
		then
			# Niet de juiste coordinaten... in gebruik
			x=0
			apple
		else
			x=$(( $x + 1 ))
		fi
	done
	tput setf 4
	tput cup $APPLEY $APPLEX
	printf %b "$APPLECHAR"
	tput setf 9
}

growsnake() {
	# Zorgt ervoor dat de slang groter word
	LASTPOSX=( ${LASTPOSX[0]} ${LASTPOSX[0]} ${LASTPOSX[0]} ${LASTPOSX[@]} )
	LASTPOSY=( ${LASTPOSY[0]} ${LASTPOSY[0]} ${LASTPOSY[0]} ${LASTPOSY[@]} )
	RET=1
	while [ "$RET" -eq "1" ];
	do
		apple
		RET=$?
	done
	drawapple
}

move() {
	case "$DIRECTION" in
		u) POSY=$(( $POSY - 1 ));;
		d) POSY=$(( $POSY + 1 ));;
		l) POSX=$(( $POSX - 1 ));;
		r) POSX=$(( $POSX + 1 ));;
	esac

	#Kijkt als je ergens tegen aankomt
	( sleep $DELAY && kill -ALRM $$ ) &
	if [ "$POSX" -le "$FIRSTCOL" ] || [ "$POSX" -ge "$LASTCOL" ] ; then
		tput cup $(( $LASTROW + 1 )) 0
		stty echo
		echo " GAME OVER! Je hebt een muur geraakt!"
		gameover
	elif [ "$POSY" -le "$FIRSTROW" ] || [ "$POSY" -ge "$LASTROW" ] ; then
		tput cup $(( $LASTROW + 1 )) 0
		stty echo
		echo " GAMEOVER! Je hebt een muur geraakt!"
		gameover
	fi

	# Krijgt laatste element van de array REF
	LASTEL=$(( ${#LASTPOSX[@]} - 1 ))
	#tput cup $ROWS 0
	#printf "LASTEL: $LASTEL"

	x=1 # Zet het start element op 1 als positie 0 word verder naar beneden geteken einde van de staart
	while [ "$x" -le "$LASTEL" ];
	do
		if [ "$POSX" = "${LASTPOX[$x]}" ] && [ "$POSY" = "${LASTPOSY[$x]}" ];
		then
			tput cup $(( $LASTROW + 1 )) 0
			echo " GAME OVER! JE HEBT JEZELF OPGEGETEN!"
			gameover
		fi
		x=$(( $x + 1 ))
	done
	# Zorgt ervoor dat de laatste positie weer verdwijnt
	tput cup ${LASTPOSY[0]} ${LASTPOSX[0]}
	printf " "

	# Verwijderd de positie bij 1 (Zorgt ervoor dat de oudste weggaat)
	LASTPOSX=( `echo "${LASTPOSX[@]}" | cut -d " " -f 2-` $POSX) 
	LASTPOSY=( `echo "${LASTPOSY[@]}" | cut -d " " -f 2-` $POSY)
	tput cup 1 10
	#echo "LASTPOSX array ${LASTPOSX[@]} LASTPOSY array ${LASTPOSY[@]}"
	tput cup 2 10
	echo "SIZE=${#LASTPOSX[@]}"

	# Update positie geschiedenis(Voeg laatste toe aan de hoogste var)
	LASTPOSX[$LASTEL]=$POSX
	LASTPOSY[$LASTEL]=$POSY

	# Geef nieuwe positie aan
	tput setf 
	tput cup $POSY $POSX
	printf %b "$SNAKECHAR"
	tput setf 9

	# Controleer of we een appel raken
	if [ "$POSX" -eq "$APPLEX" ] && [ "$POSY" -eq "$APPLEY" ]; then
		growsnake
		updatescore 10
	fi
}

updatescore() {
	SCORE=$(( $SCORE + $1 ))
	tput cup 2 30
	printf "SCORE: $SCORE"
}
randomchar() {
	[ $# -eq 0 ] && return 1
	n=$(( ($RANDOM % $#) + 1 ))
	eval DIRECTION=\${$n}
}

gameover() {
	tput cvvis
	stty echo
	sleep $DELAY
	trap exit ALRM
	tput cup $ROWS 0
	exit
}

########################EINDE VAN DE FUNCTIES#########################

# Mooiere CHARS maar worden niet gesuport
#SNAKECHAR="\0256"
#WALLCHAR="\0244"
#APPLECHAR="\0362"
#
# Normale ASCII CHARS
SNAKECHAR="@"			# CHAR VOOR DE SNAKE
WALLCHAR="X"			# CHAR VOOR DE MUUR
APPLECHAR="o"			# CHAR VOOR APPEL
#
SNAKESIZE=5			# GROOTE VAN DE SLANG
DELAY=0.2			# DELAY VOOR HET BEWEGEN
FIRSTROW=3			# EERSTE RIJ VAN DE GAME
FIRSTCOL=1			# EERSTE COLLOM VAN DE GAME
LASTCOL=40			# LAATSTE COLLOM VAN DE GAME
LASTROW=20			# LAATSTE RIJ VAN DE GAME
AREAMAXX=$(( $LASTCOL - 1 ))	# Verste dat je naar rechts kan
AREAMINX=$(( $FIRSTCOL + 1 ))	# Verste dat je naar links kan
AREAMAXY=$(( $LASTROW - 1 ))	# Verste dat je naar beneden kan
AREAMINY=$(( $FIRSTROW + 1 ))	# Verste dat je omhoog kan
ROWS=`tput lines`		# Aantal rijen in de terminal
ORIGINX=$(( $LASTCOL /2 ))	# Start punt X
ORIGINY=$(( $LASTROW /2 ))	# Start punt Y
POSX=$ORIGINX			# zet POSX als start positie
POSY=$ORIGINY			# zet POSY als start positie

# Area Padding
ZEROES=`echo |awk '{printf("%0"'"$SNAKESIZE"'"d\n",$1)}' | sed 's/0/0 /g'`
LASTPOSX=( $ZEROES )                    # Vult het op met 0 voor het begin
LASTPOSY=( $ZEROES )                    # Vult het op met 0 voor het begin
SCORE=0                                 # Begin score

clear
echo "
Toetsen:

 W - Omhoog
 S - Beneden
 A - Links
 D - Rechts
 X - Afsluiten

 Druk op ENTER om door te gaan
"

stty -echo
tput civis
read RTN
tput setb 0
tput bold
clear
drawborder
updatescore 0

# Teken de eerste appel op het scherm
# (Heeft collision detection om te zorgen dat 
#  we niet over de slang tekenen)
drawapple
sleep 1
trap move ALRM

# Kiest een random richting om heen te gaan
DIRECTIONS=( u d l r )
randomchar "${DIRECTIONS[@]}"

sleep 1
move
while :
do
   read -s -n 1 key
   case "$key" in
   w)   DIRECTION="u";;
   s)   DIRECTION="d";;
   a)   DIRECTION="l";;
   d)   DIRECTION="r";;
   x)   tput cup $COLS 0
        echo "Sluit Af..."
        tput cvvis
        stty echo
        tput reset
        printf "Dag Dag!\n"
        trap exit ALRM
        sleep $DELAY
        exit 0
        ;;
   esac
done
