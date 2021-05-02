( ** sistemnye ras{ireniq tipow dannyh ** )
: VECTOR CREATE DUP , 2* ALLOT DOES>
OVER 1- OVER @ U< IF SWAP 2* + EXIT THEN
." o{ibka w indekse" ABORT ;
VARIABLE RND HEX
: RANDOM RND @ A6A5 * 3619 + DUP RND ! UM* PRESS ;
: zna~ @ ;
: prisw 3 + ! ;
: adr ; HEX
: QUAN CREATE  CD C, COMPILE prisw CD C,
COMPILE adr 0 , DOES> CFL 2* + @ ;
: TO ' >BODY STATE @ IF , ELSE EXECUTE ELSE
 THEN ; IMMEDIATE
: AT ' >BODY CFL + STATE @ IF , ELSE EXECUTE THEN ;
 IMMEDIATE
: VECT CREATE CD C, COMPILE prisw CD C,
COMPILE zna~ COMPILE ABORT DOES> 6 + @ EXECUTE ;
: ?+ DUP 0< ABORT" otricatelxnoe zna~enie" ;
: w-adr 2DUP @ U< IF SWAP 1+ 2* + EXIT THEN SWAP CR
 . ." - nedopustimyj adres dlq wektora "
 BODY> BODY> BODY> >NAME ID. ABORT ;
: w-prisw 3 + w-adr ! ;
: VQUAN ?+ CREATE CD C, COMPILE w-prisw CD C,
COMPILE w-adr 1+ DUP , 2* HERE SWAP DUP ALLOT
 ERASE DOES> 6 + w-adr @ ; DECIMAL
: w-razm ' >BODY 6 + @ [COMPILE] LITERAL ; IMMEDIATE
adr 1+ DUP , 2* HERE SWAP DUP ALLOT
 ERASE DOES> 6 + w-adr @ ; DECIMA