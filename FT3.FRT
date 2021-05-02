
HEX
-1 CONSTANT -1  0 CONSTANT 0  1 CONSTANT 1  2 CONSTANT 2
 -1  CONSTANT  TRUE
  0  CONSTANT  FALSE
83: HERE    H @ ;
83: ALLOT   H +! ;
83: ,       HERE 2 ALLOT ! ;
 : C,       HERE 1 ALLOT C! ;
 : ",       HERE OVER C@ 1+ DUP ALLOT CMOVE ;
83: PAD     HERE 54 + ;
83CODE COUNT  H POP  D 0 MVI  E M MOV  H INX
            H PUSH  D PUSH  NEXT JMP END-CODE
83: COMPILE  R> DUP 2+ >R @ , ;
  : S>D     DUP 0< ;  -- FALSE = -1, TRUE = 0
  : M*      2DUP XOR >R ABS SWAP ABS UM* R> 0<
            IF DNEGATE THEN ;
83: /       /MOD PRESS ;
83: MOD     /MOD DROP ;
  : DABS    DUP 0< IF DNEGATE THEN ;
  : U/      U/MOD PRESS ;
83: UM/MOD  0 DU/MOD DROP PRESS ;
  : M/MOD     ?DUP IF DUP >R 2DUP XOR >R >R DABS R@
                      ABS UM/MOD SWAP R> 0<
                      IF NEGATE THEN SWAP R> 0<
                      IF NEGATE OVER
                         IF 1- R@ ROT - SWAP THEN
                      THEN RDROP
                    THEN  ;
83: */MOD     >R M* R> M/MOD ;
83: */        */MOD PRESS ;
  : <>        = 0= ;
83: QUIT      UQUIT @ ?DUP IF EXECUTE THEN
              R0 @ RP! CONSOLE [COMPILE] [
              FORTH [ FORTHDS 8 + THERE 2- ! ] DEFINITIONS
              LEVEL 0! BEGIN QUERY INTERPRET AGAIN ;
83: ABORT     UABORT @ ?DUP IF EXECUTE THEN
              S0 @ SP! QUIT ;
  : (ABORT")  IF   HERE ID. SPACE R> ID. ABORT
              ELSE R> DUP C@ 1+ + >R THEN ;
83: ABORT"    ?COMP COMPILE (ABORT")
              C" " WORD ", ;              IMMEDIATE
--
83: #>     2DROP HLD @ PAD OVER - ;
83: <#     PAD HLD !  ;
83: HOLD   HLD 1-! HLD @ C! ;
83: SIGN   0< IF C" - HOLD THEN ;
  : >DIG   9 OVER U<
           IF [ C" A 0A - ] LITERAL
           ELSE C" 0 THEN + ;
83: #      BASE @ 0 DU/MOD ROT DROP ROT >DIG HOLD ;
  : #.     BASE @ U/MOD SWAP >DIG HOLD ;
  : #.S    BEGIN #. DUP 0= UNTIL ;
83: #S     BEGIN # 2DUP OR 0= UNTIL ;
  : D.R    >R DUP >R DABS <# #S R> SIGN #>
           R> OVER - SPACES TYPE ;
  : D.     DUP >R DABS <# #S R> SIGN #> TYPE SPACE ;
  : .R     >R DUP >R ABS <# #.S R> SIGN 0 #>
           R> OVER - SPACES TYPE ;
  : .0     <# 0 ?DO #. LOOP IF PAD HLD @ - 0
           ?DO C" * EMIT LOOP ELSE 0 0 #> TYPE THEN ;
83: .      DUP >R ABS <# #.S R> SIGN 0 #> TYPE SPACE ;
83: U.     0 D. ;
--
  3 CONSTANT CFL
83: >BODY    CFL + ;
  : BODY>    CFL - ;
  : >LINK    2- ;
  : LINK>    2+ ;
  : N>LINK   COUNT 3F AND + ;
  : NAME>    N>LINK LINK> ;
  : L>NAME   20 2 DO DUP I -
                     C@ 7F AND 1+ I =
                     IF I - LEAVE THEN
                  LOOP ;
  : >NAME    >LINK L>NAME ;
--
83: WORD     UWORD @ ?DUP IF EXECUTE EXIT THEN
             INB @
             >IN @ + #TIB @ >IN @ - ENCLOSE
             IF INB @ - >IN !
             ELSE #TIB @ >IN ! 0 0 THEN
             DUP HERE C! HERE 1+ SWAP CMOVE
             HERE BL OVER DUP C@ 1+ + C! ;
--
(C/L) CONSTANT C/L     -- dliHA CTPOKi diCplEq
(ST-C) CONSTANT ST-C   -- CTOp-liTEPA dlq BBOdA
(B-SP) CONSTANT B-SP   -- KOd BOzBPATA KuPCOPA pPi BBOdE
(C<-)  CONSTANT C<-    -- KOd "KuPCOP BlEBO"
83: EXPECT  ( AdPEC dliHA --> )
         UEXPECT @ ?DUP IF EXECUTE EXIT THEN
         OVER SWAP 0
         ?DO KEY
             DUP B-SP = OVER C<- = OR
                        IF >R 2DUP = IFNOT R>
                           DUP EMIT BL EMIT EMIT
                           1- R> 1- >R ELSE
                           RDROP THEN R> 1- >R
                        ELSE
             DUP ST-C = IF DROP BL EMIT LEAVE ELSE
             DUP EMIT OVER C! 1+
                        THEN THEN
          LOOP SWAP - SPAN ! ;
--  KOHEc CTPOKi - ByXOd iz TEKCTOBOgO iHTEPpPETATOPA
:
          RDROP ;        IMMEDIATE
83: EMIT  UEMIT @ EXECUTE >OUT 1+! ;
83: KEY   UKEY  @ EXECUTE ;
83: CR    UCR @ EXECUTE >OUT 0! ;
83: TYPE  UTYPE @ ?DUP IF EXECUTE EXIT THEN
          0 ?DO DUP C@ EMIT 1+ LOOP DROP ;
83: FORTH-83 ;
--
FORTH-CODE  CONSTANT F-CODE  -- AdPEC OblACTi KOdA
FORTH-DATA  CONSTANT F-DATA  -- AdPEC OblACTi dAHHyX
--
: QUERY   CR C" > EMIT TIB C/L 1- EXPECT SPAN @ DUP #TIB !
          IF CR THEN >IN 0! TIB INB ! ;
: CONSOLE UCONSOLE @ ?DUP IF EXECUTE EXIT THEN
          ['] (EMIT) UEMIT ! ['] (KEY) UKEY !
          ['] (CR) UCR ! CR  #TIB 0! >IN 0! ;
  : HEX   10 BASE ! ;
83: DECIMAL  0A BASE ! ;
 20 CONSTANT BL
  : BLANK   BL FILL ;
83: SPACE   BL EMIT ;
83: SPACES  0 ?DO SPACE LOOP ;
  : ID.     COUNT 3F AND TYPE ;
83: DEFINITIONS
            CONTEXT @ CURRENT ! ;
 : LATEST   CURRENT @ @ ;
-- iHTEPpPETATOP AdPEC -->  / KOMpilqciq pOlq KOdA
 : !CF       0CD OVER C! 1+ ! ;
 : (!CODE)  -- <AdPEC iHTEPpPETATOPA> -->
            LATEST NAME> !CF ;
 : SMUDGE   LATEST 40 TOGGLE ;
83: [ STATE 0! ;                      IMMEDIATE
83: ] -1 STATE ! ;
83: FIND   UFIND @ ?DUP IF EXECUTE EXIT THEN
           CONTEXT @ ?WORD
           IF TRUE
           ELSE CURRENT @ DUP CONTEXT @ =
                IFNOT ?WORD ELSE DROP FALSE THEN
           THEN
           IF DUP NAME> SWAP C@ 80 AND
                IF 1 ELSE -1 THEN
           ELSE FALSE
           THEN ;
  : +WORD  HERE ROT ", SWAP DUP @ , ! ;
  : -WORD  ?WORD IF N>LINK @ W-LINK @ ! TRUE
                 ELSE DROP FALSE THEN ;
  : (.")    R@ COUNT DUP 1+ R> + >R TYPE ;
  : ERASE   0 FILL ;
83: '       BL WORD FIND 0= ABORT" -? " ;
83: [']     ' [COMPILE] LITERAL ;               IMMEDIATE
83: LITERAL  STATE @ IF COMPILE LIT , THEN ;    IMMEDIATE
  : DLITERAL STATE @ IF COMPILE DLIT , , THEN ; IMMEDIATE
83: [COMPILE] ' , ;                             IMMEDIATE
--
83: CONVERT BEGIN  1+ DUP >R C@ BASE @ DIGIT
            WHILE  SWAP BASE @ * ROT BASE @
                   UM* D+ DPL @ 1+ IF DPL 1+! THEN R>
            REPEAT R> ;
83: NUMBER  0 0 ROT DUP 1+ C@ C" - = ( HA CTEKE -1 ili 0 )
            DUP >R - -1
            BEGIN DPL ! CONVERT DUP
                  DUP C@ BL <> SWAP 0= 0= AND
            WHILE DUP C@ C" . <> ABORT"  -? " 0
            REPEAT DROP R> IF DNEGATE THEN ;
--
 : ?STACK   SP@ S0 @ SWAP U< ABORT" iC~EPpAHiE CTEKA" ;
 : INTERPRET UINTERPRET @ ?DUP IF EXECUTE EXIT THEN
             BEGIN BL WORD FIND DUP
                   IF 0< STATE @ AND
                      IF , ELSE  EXECUTE THEN
                   ELSE DROP NUMBER DPL @ 1+
                           IF [COMPILE] DLITERAL
                           ELSE DROP [COMPILE] LITERAL
                           THEN
                   THEN    ?STACK
             AGAIN ;
--
 : CREATE    BL WORD WARNING @
             IF DUP FIND PRESS
             IF DUP ID. ."  uvE OpPEdElEH " CR THEN THEN
             CURRENT @ +WORD CFL ALLOT NEXT (!CODE) ;
 : (DOES>)   R> (!CODE) ;
83: DOES>    COMPILE (DOES>) CALL HERE !CF
             CFL ALLOT ;          IMMEDIATE
83: CONSTANT CREATE  , ['] @ (!CODE) ;
--
CODE TOCODE  H POP  H DCX  H DCX  H DCX  H DCX
         D POP  M D MOV  H DCX  M E MOV
         NEXT JMP  END-CODE
CODE @EXECUTE H POP  E M MOV  H INX  D M MOV
         XCHG PCHL END-CODE
: QUAN   0 CONSTANT ['] TOCODE HERE CFL ALLOT !CF ;
: VECT   QUAN ['] @EXECUTE (!CODE) ;
: TO     BL WORD FIND ?DUP 0= ABORT"  -?"
         0< STATE @ AND IF >BODY 2+ ,
                        ELSE >BODY 2+ EXECUTE
                        THEN ;   IMMEDIATE
83: VARIABLE CREATE 0 , NEXT (!CODE) ;
83: VOCABULARY  CREATE  01 C, 80 C, CURRENT @ 2- , HERE
           VOC-LINK @ , VOC-LINK ! DOES> 2+ CONTEXT ! ;
: STRING   CREATE ", NEXT (!CODE) ;
 : !CSP    SP@ CSP ! ;
 : ?CSP    SP@ CSP @ XOR ABORT" CbOj CTEKA pO CSP" ;
 : ?EXEC   STATE @ ABORT"  TPEbuET PEviMA BypOlHEHiq" ;
 : ?COMP   STATE @ 0=
           ABORT"  TPEbuET PEviMA KOMpilqcii" ;
 : ?PAIRS  XOR ABORT"  HEpAPHAq CKObKA" ;
83: LEAVE  RDROP RDROP RDROP ;
83: :      ?EXEC !CSP CURRENT @ CONTEXT !
           CREATE SMUDGE ] CALL (!CODE) ;     IMMEDIATE
83: ;      ?COMP ?CSP COMPILE EXIT
           SMUDGE [COMPILE] [ ;               IMMEDIATE
83: IMMEDIATE  LATEST 80 TOGGLE ;
  : DEPTH  SP@ S0 @ SWAP - 2/ 0 MAX ;
  : C"    BL WORD 1+ C@ [COMPILE] LITERAL ;   IMMEDIATE
83: ."    ?COMP COMPILE (.") C" " WORD ",  ;  IMMEDIATE
  : "   --     --> <AdPEC CTPOKi>
          STATE @
          IF COMPILE (") C" " WORD ",
          ELSE C" " WORD PAD OVER C@
               1+ CMOVE PAD
          THEN ;                              IMMEDIATE
83: .(    C" ) WORD COUNT TYPE ;              IMMEDIATE
--
  : >MARK   HERE 0 , ;
  : >RESOLVE  HERE SWAP ! ;
  : <MARK   HERE ;
  : <RESOLVE , ;
83: IF      ?COMP COMPILE ?BRANCH >MARK 2 ;     IMMEDIATE
  : IFNOT   ?COMP COMPILE N?BRANCH >MARK 2 ;    IMMEDIATE
83: ELSE    ?COMP 2 ?PAIRS COMPILE BRANCH
            >MARK SWAP >RESOLVE 2 ;             IMMEDIATE
83: THEN    ?COMP 2 ?PAIRS >RESOLVE ;           IMMEDIATE
83: BEGIN   ?COMP <MARK 1  ;                    IMMEDIATE
  : AGAIN   ?COMP 1 ?PAIRS COMPILE BRANCH
            <RESOLVE ;                          IMMEDIATE
83: DO      ?COMP COMPILE (DO) >MARK <MARK 3 ;  IMMEDIATE
  : ?DO     ?COMP COMPILE (?DO) >MARK <MARK 3 ; IMMEDIATE
83: LOOP    ?COMP 3 ?PAIRS COMPILE (LOOP)
            <RESOLVE >RESOLVE ;                 IMMEDIATE
83: +LOOP   ?COMP 3 ?PAIRS COMPILE (+LOOP)
            <RESOLVE >RESOLVE ;                 IMMEDIATE
83: UNTIL   ?COMP 1 ?PAIRS COMPILE ?BRANCH
            <RESOLVE ;                          IMMEDIATE
--
83: WHILE   ?COMP 1 ?PAIRS 1 [COMPILE] IF 2+ ;  IMMEDIATE
83: REPEAT  ?COMP >R >R [COMPILE] AGAIN
            R> R> 2- [COMPILE] THEN ;           IMMEDIATE
 : >PRT     7F AND DUP BL U< IF DROP C" . THEN ;
 : PTYPE    0 ?DO DUP C@ >PRT EMIT 1+ LOOP DROP ;
 : BREAK    ?KEY IF DROP KEY C" C = ?DUP
            IF CR ABORT"  - pPEPBAH" THEN THEN ;
 : DUMP     7 + 8 U/ 0
           ?DO CR BREAK BASE @ SWAP HEX
               DUP 4 .0 SPACE SPACE DUP
               8 0 DO DUP C@ 2 .0 SPACE 1+
                   LOOP SWAP 8 PTYPE SWAP BASE !
              LOOP DROP ;
 : TRAIL  C/L >OUT @ - ;
 : NLIST  BEGIN @ DUP
          WHILE DUP COUNT 3F AND TRAIL OVER U<
                IF CR THEN DUP 8 + -8 AND OVER -
                -ROT TYPE TRAIL MIN
                0 MAX SPACES N>LINK BREAK
          REPEAT DROP ;
 : WORDS  CONTEXT @ NLIST ;
 : --  -- KOMEHTAPij dO KOHcA CTPOKi
          #TIB @ >IN ! ; IMMEDIATE
 : NOOP   ;   -- puCTAq OpEPAciq
 : S.
        DEPTH ?DUP   IF 1+ 1 DO S0 @ I 2* - @ . LOOP
                 ELSE ." CTEK puCT" THEN ;
83: (   C" ) WORD DROP ;                   IMMEDIATE
: ?CURRENT CURRENT @ ?WORD 0= ABORT"  - ?" ;
: SCRATCH ?EXEC BL WORD CURRENT @ -WORD
          0= ABORT"  - ?" ;                IMMEDIATE
: JOIN   ?EXEC BL WORD  -- zAbyTx KPOME pOClEdHEgO
        ?CURRENT N>LINK @ LATEST N>LINK ! ;  IMMEDIATE
-- uHi~TOviTx B CURRENT
-- : FORGET ?EXEC BL WORD  ?CURRENT DUP FENCE @ U<
--         IF DROP ELSE DUP   H ! N>LINK @ CURRENT @ ! THEN ;
--                                            IMMEDIATE
-- zAMEHiTx CTAPOE OpPEdElEHiE HA HOBOE
: NEW ?EXEC BL WORD  DUP ?CURRENT    -- AdPEC HOBOj CTATxi
      CURRENT @ >R               -- COXPAHiTx CTAPyj CURRENT
      DUP N>LINK CURRENT !       -- uCTAHOBiTx HOByj CURRENT
      NAME> SWAP ?CURRENT NAME>  -- AdP HOB i CTAP pPOcEduP
      0C3 OVER C! 1+ !            -- JMP HA HOBu` pPOcEduPu
      R> CURRENT ! ; IMMEDIATE   -- BOCCTAHOBiTx CURRENT
83: FORGET  BL WORD ?CURRENT DUP
            FENCE @ U< ABORT" ByXOd zA FENCE"
            >R VOC-LINK @
            BEGIN R@ OVER U<
            WHILE FORTH [ FORTHDS 8 + THERE 2- ! ]
                  DEFINITIONS @ DUP VOC-LINK !
            REPEAT
            BEGIN DUP 4 -
                  BEGIN N>LINK @ DUP R@ U<
                  UNTIL
                  OVER 2- ! @ ?DUP 0=
            UNTIL R> H ! ;
--
--
    REF!
;J
