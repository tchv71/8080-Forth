CLR
: BLIT R@ C@ R> 2+ >R ;

( FORTH DECODER BY NESTEROV I.L.                     03/12/91 )
( 1ST VER FROM SEMENOV U.A.                                   )

 : IT ; HEX
 VARIABLE NOT-CODE       VARIABLE NO-ADDR 0 NO-ADDR !
 VARIABLE WORD-COUNT
 : ID. ( NFA--> ) COUNT 1F AND TYPE SPACE ;
 : ?EXIT DUP @ DUP ['] ;S =  SWAP ['] EXIT = OR  ;
 : ?LIT  DUP ['] LIT =  ;
 : ?BLIT DUP ['] BLIT = ;
 : ?(.") DUP ['] (.") = ;
 : ?DLIT DUP ['] DLIT = ;
 : ?BRANCH  DUP ['] ?BRANCH =  OVER ['] BRANCH = OR
   OVER ['] (LOOP) = OR OVER ['] (DO) = OR ;
 : ? @ . ;
 : C? C@ . ;
 : D? 2@ SWAP C" . EMIT D. ;
 : ?OFFSET ( CFA_ADDR --> T/F) @ 200 < ;


 : WHAT-IS ( CFA --> )
   ?LIT  IF 1 NOT-CODE ! DROP EXIT THEN
   ?BRANCH IF 1 NOT-CODE ! >NAME ID. EXIT THEN
   ?BLIT IF 2 NOT-CODE ! DROP EXIT THEN
   ?DLIT IF 3 NOT-CODE ! DROP EXIT THEN
   ?(.") IF 4 NOT-CODE ! DROP ." ." C" " EMIT SPACE EXIT THEN
   >NAME ID. ;

 : SPEC-DATA ( CFA1 -->CFA2)
    NOT-CODE @ 1 = ( OVER ?OFFSET OR) IF DUP ? 2+ THEN
    NOT-CODE @ 2 = IF DUP C? 1+ THEN
    NOT-CODE @ 3 = IF DUP D? 4 + THEN
    NOT-CODE @ 4 = IF DUP COUNT TYPE DUP C@ 1+ + C" " EMIT
                      SPACE THEN
 ;

( CONSTANT & VARIABLE )

 : ?CONSTANT ( CFA --> CFA,T/F) DUP @ 1945 = ;
 : CONSTANT-DECOMPILE ( CFA --> ) DUP >NAME ID. ." CONSTANT="
                                  2+ @ . CR ;

 : ?VARIABLE ( CFA --> CFA,T/F) DUP @ 1964 = ;
 : VARIABLE-DECOMPILE ( CFA --> ) DUP >NAME ID. ." VARIABLE AT "
                                  2+ . CR ;


( COLON-DEFINED WORDS)
 : ?COLON-DEFINED ( CFA --> CFA,T/F) DUP 1+ @ CALL = ;
 DECIMAL
 : COLON-DECOMPILE ( CFA -->) 58 EMIT SPACE DUP >NAME ID.
  >BODY 0 WORD-COUNT !
  BEGIN ( CFA_ADDR )
    ?EXIT NOT
  WHILE
    0 NOT-CODE ! NO-ADDR @ IF DUP CR U. THEN
    DUP @ ( CFA_ADDR,CFA)
    WHAT-IS 1 WORD-COUNT +! 2+
     SPEC-DATA
    WORD-COUNT @ 10 MOD 0= IF CR THEN REPEAT 59 EMIT CR ;



( FA-INFO )

: FA-INFO ( CFA -->CFA)  CR HEX
         DUP >NAME DUP ." NFA AT " U. DUP C@ U. SPACE ID. CR
         DUP >LINK ." LFA AT " U. CR
         DUP       ." CFA AT " U. CR
         DUP >BODY ." PFA AT " U. CR ;


( MAIN WORD                                                    )
: DECOD
        '
        FA-INFO
        ?COLON-DEFINED IF COLON-DECOMPILE EXIT THEN
        ?CONSTANT      IF CONSTANT-DECOMPILE EXIT THEN
        ?VARIABLE      IF VARIABLE-DECOMPILE EXIT THEN
        ." PRIMITIVE " CR  DROP
;

0 NO-ADDR !
;S

LE EXIT THEN
        ?VARIABLE      IF VARIABLE-D