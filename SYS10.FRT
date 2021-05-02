( *** Forth control  structures extensions *** )


 ( ----------  CASE implementation ---------- )
     ( From  Baranov-Nozdrunov p. 100 )
: CASE ?COMP CSP @ !CSP 4 ; IMMEDIATE
: OF 4 ?PAIRS COMPILE OVER COMPILE =
     [COMPILE] IF COMPILE DROP 5 ; IMMEDIATE
: ENDOF 5 ?PAIRS [COMPILE] ELSE 4 ; IMMEDIATE
: ENDCASE 4 ?PAIRS COMPILE DROP
     BEGIN SP@ CSP @ = 0= WHILE [COMPILE] THEN
     REPEAT CSP ! ; IMMEDIATE
   ( ------------ End -----------------)


( ostorvnee s FORGET ! )
: (FORGET) BRANCH [ ' FORGET >BODY 6 + , ] ;

: REMEMBER CREATE DOES> (FORGET) ;


BASE @ HEX
: MY CONTEXT @
   BEGIN @ DUP FENCE @ > WHILE
      DUP COUNT 3F AND DUP 8 / 1+ 8 *
      OVER - -ROT TYPE SPACES N>LINK >OUT @ 38 U<
      IFNOT CR THEN
   REPEAT DROP ;
BASE !
;S

         ( Signed double word multiplying )
: D* 3 PICK >R 1 PICK >R 3 ROLL * -ROT * + R> R> UM* ROT + ;

         ( Some of string operations )
: STR$ CREATE DUP C, 0 C, 0 DO 0 , LOOP DOES> 1+ ;
: INP$ ' >BODY DUP C@ SWAP 1+ DUP 1+ ROT
       EXPECT SPAN @ SWAP C! ;

 STR$ CREATE DUP C, 0 C, 0 DO 0 , LOOP DOES> 1+ ;
: INP$ ' >BODY DUP C@ SWAP 1+ DUP 