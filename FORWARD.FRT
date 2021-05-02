 ( ---- FORWARD definitons      (c) TCHV ---- )

: FORWSTC CREATE HERE 4 + , 0 , 100 ALLOT DOES> ;
FORWSTC FST ( Forward Definition Storage )
( FRW Word - push a word into Forward Definition Storage )
: FRW ?COMP FST 2+ 1+! BL WORD DUP C@ FST @ C!
      FST 1+! COUNT 0 ?DO DUP C@ SWAP 1+ SWAP FST
      @ ! FST 1+! LOOP DROP HERE FST @ !
      2 FST +! ['] ABORT , ; IMMEDIATE

( Striing comparison T1,T2->F )
: $= OVER C@ 31 AND OVER C@ 31 AND =
   IFNOT 2DROP FALSE  EXIT
   ELSE
      TRUE OVER C@ 0
        ?DO
            ROT 1+ ROT 1+
            ROT OVER C@ 3 PICK C@ = AND
        LOOP -ROT 2DROP
   THEN
;

: SEARCH FST 4 + FST 2+ @ ?DUP
  IFNOT 2DROP FALSE EXIT
  THEN
   0 DO
      2DUP $= ?DUP IF LEAVE THEN
      N>LINK 2+
     LOOP
  -1 <> IF DROP FALSE EXIT THEN
  PRESS DUP N>LINK DUP @ >R 2+ DUP FST @ - NEGATE
  -ROT SWAP ROT <CMOVE> R> FST 2+ 1-! FST
  @ >NAME FST ! TRUE
;

: ; ?COMP SMUDGE COMPILE EXIT [COMPILE] [ (
     BEGIN
       LATEST SEARCH WHILE  ( Whilst it's found, )
       LATEST NAME> SWAP ! ( release forward reference )
     REPEAT
; IMMEDIATE
   ( ------------ End -----------------)

       LATEST NAME> SWAP ! ( release forward reference )
     REPEAT
; IMMEDIATE
   ( ------------ End -------