DECIMAL
( : 0! 0 SWAP ! ; )
( Input a line from keyboard into Text Input Buffer)
: INPLIN CR C" > EMIT
       TIB 64 EXPECT
       CR SPAN @ #TIB ! >IN 0!
;

( Get symbol from input stream )
: GETSYM
    BLK @ ?DUP
     IF
       >IN @ #TIB @ =
       IF DROP RDROP EXIT ( Input buffer is exausted)
       THEN
        BLOCK >IN @ + C@
        DUP 9  = IF DROP BL THEN
        DUP 13 = IF DROP BL THEN
        DUP 255 = IF DROP BL THEN
     ELSE
       #TIB @ >IN @ <
       IF BEGIN ( Request for input of a new line)
            INPLIN #TIB @ 0=
          NOT UNTIL
       THEN
       TIB >IN @ + C@
       >IN @ #TIB @ = IF DROP BL THEN
     THEN
    >IN 1+!
;

: >= < NOT ;
: <= > NOT ;
: ISDIGIT
    DUP C" 0 >=
    OVER C" 9 <= AND
;

: ISSPACE DUP BL = ;

: ISALPHA
   DUP  C" A >=
   OVER C" Z <= AND
   OVER C" a >=
   2 PICK C" z <= AND
   OR
   OVER C" _ = OR
;


( VARIABLE LAST_SYM  VARIABLE GET_AGAIN
: GETC GET_AGAIN @
        IF 0 GET_AGAIN ! LAST_SYM @
        ELSE
          GETSYM DUP LAST_SYM !
        THEN
;

: UNGETC LAST_SYM ! -1 GET_AGAIN ! ;

: CLR_UNGETC 0 GET_AGAIN ! ;
)
: GETC GETSYM ;
: UNGETC DROP >IN @ 1- >IN ! ;
: CLR_UNGETC ; IMMEDIATE

( Skip all spaces and return the code of first nonspace symbol)
: SkipSpaces
    0
    BEGIN
      DROP
      GETC
    ISSPACE NOT UNTIL
;

VARIABLE STR VARIABLE STR_COUNT
: INIT_PUTC HERE 1+ STR ! STR_COUNT 0! ;
: PUTC STR @ C! STR 1+! STR_COUNT 1+! ;
: SAVECOUNT STR @ 0!  STR_COUNT @ HERE C! ;

VARIABLE MaxDelimLen VARIABLE STR

( Read the delimiter from input stream)
(       using the delimiters list)
( Create: MKDEL List_name MaxDelimLength {Delimiter{' '}}'E')
( Does: Reads delimiter symbols from input stream, leave them)
(       on HERE position as a string with a counter )
( Returns: Number of symbols delimiter consists )
(           0 - no delimiters found)
: MKDEL
   CREATE CLR_UNGETC
    BL WORD NUMBER DROP DUP MaxDelimLen ! C,
    BEGIN
     SkipSpaces C,
     MaxDelimLen @
     BEGIN
       GETC
       ISSPACE NOT WHILE
       C, 1-
     REPEAT
     DROP
     0 DO
        BL  C,
       LOOP
     SkipSpaces DUP UNGETC
    C" E = UNTIL
    GETC DROP
    MaxDelimLen @ 1+ 0 DO
      BL C,
    LOOP
   DOES> ( Read one delimiter)
       DUP C@ MaxDelimLen ! 1+
       0 ROT ROT ( Len Sym Addr)
       BEGIN     ( Len Sym Addr)
         DUP C@  ( Len Sym Addr Table[Addr])
         DUP BL = NOT WHILE
         2 PICK =
         IF  ( Len Sym Addr)
           ROT 1+ ROT ( Addr Len Sym)
           PUTC SWAP ( Len Addr) 1+ GETC SWAP
         ELSE MaxDelimLen @ 1+ +
         THEN
       REPEAT DROP DROP UNGETC
;

( : C" BL WORD 1+ C@ LITERAL ; )
( Delimiters list, '_' is a blank symbol)
MKDEL E_DELIMS 2 [ ]  , ? @ . ; ( ) =  + - * / :_ := E

0 CONSTANT _IDENT
1 CONSTANT _NUMBER
2 CONSTANT _DELIMTR
3 CONSTANT _UNKNOWN
4 CONSTANT _WORD

C" ^ CONSTANT QUOTE
: GET_LEXEM
    INIT_PUTC
    SkipSpaces
    ISDIGIT IF
      ( ." Digit:")
      BEGIN
        PUTC
        GETC
      ISDIGIT NOT UNTIL
      UNGETC SAVECOUNT HERE _NUMBER
    ELSE ISALPHA IF
      ( ." Ident:")
      BEGIN
        PUTC
        GETC
        ISALPHA OVER ISDIGIT SWAP DROP OR
      NOT UNTIL
      UNGETC SAVECOUNT HERE _IDENT
    ELSE
      DUP QUOTE = IF
      DROP
      BEGIN
        GETC
        DUP QUOTE = NOT WHILE
        PUTC
      REPEAT DROP SAVECOUNT HERE _WORD
    ELSE
      E_DELIMS DROP SAVECOUNT HERE
      DUP C@ IF _DELIMTR ELSE _UNKNOWN THEN
    THEN
    THEN
    THEN
;

VOCABULARY INFIX INFIX DEFINITIONS
: OPR_STC CREATE HERE 2+ , 40 ALLOT DOES> ;
OPR_STC OPR
: >OPR OPR @ ! 2 OPR +! ;
: OPR@ OPR @ 2- @ ;
: OPR> OPR@ -2 OPR +! ;
: >OPR> >R BEGIN OPR@ R@ < NOT WHILE OPR> DROP OPR>
STATE @ IF , ELSE EXECUTE THEN REPEAT R> DROP ;
: 2-OP >IN @ >R ' R> >IN ! CREATE IMMEDIATE , ,
DOES> 2@ >R >R R@ >OPR> R> R> >OPR >OPR ;
: 1-OP 9 2-OP ;
2 2-OP OR 2 2-OP XOR 3 2-OP AND 4 2-OP =
5 2-OP < 5 2-OP > 6 2-OP + 6 2-OP -
7 2-OP * 7 2-OP / 7 2-OP MOD
1-OP NOT 1-OP ABS 1-OP NEGATE
: ( 0 >OPR ; IMMEDIATE
: ) 1 >OPR> OPR> DROP ; IMMEDIATE
VARIABLE ?MEAN

: ", HERE OVER C@ 1+ DUP ALLOT CMOVE ;
: +WORD HERE ROT ", SWAP DUP @ , ! ;

: VAR_
     GET_LEXEM [ FORTH ]  _IDENT =
      NOT ABORT" Not an ident"
      CURRENT @ +WORD CFL ALLOT 0 , IMMEDIATE
  DOES> [ INFIX ] [COMPILE] LITERAL ?MEAN @
  IF STATE @ IF COMPILE @ ELSE @ THEN THEN ;

: VAR
   BEGIN
     VAR_ [ FORTH ]
     GET_LEXEM _DELIMTR =
      NOT ABORT" , OR ; EXPECTED"
      1+ C@ DUP C" ; = NOT WHILE
      C" , =
      NOT ABORT" , OR ; EXPECTED"
   REPEAT DROP
; IMMEDIATE
: := [COMPILE] ( -1 ?MEAN ! ; IMMEDIATE
: ; [COMPILE] ) STATE @ IF COMPILE SWAP COMPILE !
 ELSE SWAP ! THEN 0 ?MEAN ! ; IMMEDIATE


FORTH DEFINITIONS

: STDIO #TIB 0! >IN 0! BLK 0! ;
: LEX
  INFIX
  CLR_UNGETC
  BEGIN
    GET_LEXEM
       DUP _NUMBER =
          IF DROP 0. ROT CONVERT 2DROP [COMPILE] LITERAL ELSE
       DUP _IDENT = OVER _DELIMTR = OR SWAP _WORD = OR
          IF FIND DUP
             IF 0< STATE @ AND
                IF ,
                ELSE EXECUTE THEN
             ELSE DROP HERE ID.
                   ." is'nt found" STDIO THEN
          ELSE
             ." Bad Symbol '" GETC EMIT ." '" STDIO
          THEN
       THEN
       ?STACK
  AGAIN
;
;S

MKDEL C_Delims 3 { } ? : ; , [ ] ( ) ~ .
 =_ == _ !_ != _
 &_ && &= _ |_ || |= _  ^_ ^= _
 -_ -- -= -> _
 +_ ++ += _
 /_ *_ %_ *= _
 >_ >= >>_ >>= _ <_ <= <<_ <<= E

: : ?EXEC !CSP CURRENT @ CONTEXT !
  BL WORD DUP CR ID.  CURRENT @ +WORD CFL ALLOT
  SMUDGE ] CALL (!CODE) ;
;S


= E

: : ?EXEC !C