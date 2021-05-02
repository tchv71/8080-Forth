--         cElEBOj KOMpilqTOP
HEX
: --| [COMPILE] -- ; -- MOi pOMETKi B TEKCTE
: NWRITE  FCB " COM" FSET &WRITE ; -- OTKudA CKOlxKO
9000 CONSTANT WRF
--
--
WARNING 0!     FORTH CONTEXT @ @
 VARIABLE EX-FORTH EX-FORTH ! -- uzEl dlq ClOBAPq FORTH
          VOCABULARY METAFORT
              METAFORT DEFINITIONS
HEX
: ?NUMBER -- CTPOKA -> ~iClO TRUE / CTPOKA FALSE
          >R 0 0 R@ 1+ DUP C@ C" - =
          IF 0 ELSE -1 THEN DUP >R +
          CONVERT C@ BL =
          IF DROP R> IFNOT NEGATE THEN RDROP TRUE
          ELSE 2DROP RDROP R> FALSE
          THEN ;
: ::      ?EXEC CREATE CALL (!CODE) ]
          SMUDGE !CSP ;               IMMEDIATE
: !CURRENT CURRENT ! ;
: NODE    VARIABLE   -- iHCTPuMEHTAlxHyj cElEBOj CpiCOK
           0 ,       -- AdPEC NFA pOClEdHEj cElEBOj CTATxi
           0 ,       -- pPizHAK HAli~iq zAgOlOBKA
           0 ,       -- AdPEC CFA pOClEdHEj cElEBOj CTATxi
             ;
   NODE TFORTH       -- ClOBAPx cElEBOgO fOPTA
   NODE MFORTH       -- iHCTPuMEHTAlxHyE ClOBA
   NODE TASSEMBLER   -- ClOBAPx cElEBOgO ACCEMblEPA
   NODE MASSEMBLER   -- ClOBAPx iHCTPuMEHTAlxHOgO ACCEMblEPA
   NODE TEDITOR      -- ClOBAPx cElEBOgO PEdAKTOPA
   NODE D-VOC        -- ~ACTi DOES>
   NODE LAB          --  METKi pO EQU i L:
 VARIABLE MAXREF      --  KOHEc pOlq dlq CCylOK BpEPEd
 VARIABLE HR0         --  HA~AlO pOlq dlq CCylOK BpEPEd
 VARIABLE HR          --  uKAzATElx B pOlE dlq CCylOK
 VARIABLE H-L         --
 VARIABLE TARG0       --  HA~AlO PAzME}EHiq cElEBOgO ClOBAPq
 VARIABLE TBASE       --  CME}EHiE dlq By~iCl. AbC. AdPECA
 VARIABLE TH          --  cElEBOj uKAzATElx B cElEBOM ClOBAPE
 VARIABLE TH0         --  HA~. zHA~EHiE cElEBOgO uKAzATElq
 VARIABLE DH          --  uKAzATElx dAHHyX B cElEBOM ClOBAPE
 VARIABLE ITCURRENT   --  iHCTPuMEHTAlxHyj ClOBAPx KOMpilqcii
 VARIABLE TSTATE      --  COCTOqHiE iCpOlHEHiE - KOMpilqciq
 VARIABLE TVOC-LINK   --  CCylKA HA pOClEdHij cElEBOj ClOBAPx
 VARIABLE <FL>        --  pPizHAK CCylKi BpEPEd
 VARIABLE <W>         --  AdPEC PAzME}EHiq CCylKi BpEPEd
 VARIABLE HEAD-?      --  pPizHAK HAli~iq zAgOlOBKA
 VARIABLE COMP-?      --  pPizHAK KOMpilqcii
 VARIABLE PRED-VOC    --  cElEBOj AdPEC pPEdydu}EgO ClOBAPq
--
0B300 DUP HR0 ! HR !
0C300 MAXREF !
09000 H-L !
: <H>     HR @ HERE HR ! H ! ;
: ?H      MAXREF @ HERE U<
          IF HR0 @ <H> EXECUTE <H>  -- iCpOlHEHiE REF!
             MAXREF @ HERE U<
             IF ." HET MECTA dlq CCylOK BpEPEd"
          THEN THEN ;
--       KOHTEKCTy B BidE CTEKA
: ST     CREATE HERE , ALLOT DOES> ;
  10 ST TCNTX        --  cElEBOj KOHTEKCT
  10 ST MCNTX        --  iHCTPuMEHTAlxHyj KOHTEKCT
--          pOMECTiTx uzEl B KOHTEKCT
: >CNTX  -- uzEl  KOHTEKCT ---
        DUP >R @
        BEGIN 2DUP @ =
             IF R> ! DROP EXIT THEN
             2- DUP R@ 1+ U<
        UNTIL DROP 2 R@ +! R> @ ! ;
--          CHqTx uzEl C KOHTEKCTA
-- : CNTX>  -- KOHTEKCT --- uzEl
--         DUP @ 2DUP =
--         ABORT"  KOHTEKCT puCT"
--         @ -2 ROT +! ;
--          ubPATx uzEl iz KOHTEKCTA
-- : CNTX>>  CNTX> DROP ;
: >META   MCNTX >CNTX ; -- pOlOviTx B iHCTP KOHTEKCT
: >TARGET TCNTX >CNTX ; -- pOlOviTx B cElEBOj KOHTEKCT
--        pOiCK B KOHTEKCTE
--   iMq KOHTEKCT --- CFA TRUE / iMq FALSE
: CFIND   DUP @ 2DUP =
          ABORT" KOHTEKCT puCT" >R SWAP
          BEGIN OVER R@ <>
          WHILE R@ @ ?WORD
                IF NAME> PRESS RDROP TRUE EXIT
                THEN R> 2- >R
          REPEAT PRESS RDROP FALSE ;
    LAB     >META
    MFORTH  >META
    TFORTH  >TARGET
--
: TFIND   TCNTX CFIND ;
: MFIND   MCNTX CFIND ;
: ID-?    ID. ."  -?" ABORT ;
: ?EX-FORTH ( iMq -> TRUE / iMq FALSE )
          EX-FORTH ?WORD IF NAME> EXECUTE TRUE
                         ELSE FALSE THEN ;
: T?EXEC    TSTATE @
            ABORT"  TPEbuET PEviMA BypOlHEHiq" ;
 3 CONSTANT TCFL
: THERE     TH @ ;
: DHERE     DH @ ;
: TALLOT    COMP-? @ IF TH +! ELSE DROP THEN ;
: DALLOT    COMP-? @ IF DH +! ELSE DROP THEN ;
-- TADDR -> ADDR
: T>        TBASE @ + ;
: T!        T> ! ;
: T@        T> @ ;
: TC!       T> C! ;
: TC@       T> C@ ;
: T,        THERE 2 TALLOT T! ;
: TC,       THERE 1 TALLOT TC! ;
: T",       THERE T> OVER C@ 1+ DUP TALLOT CMOVE ;
--
: TCURRENT  ITCURRENT @ 2+ ;
: TIMMED    TCURRENT 2+ ;
: TLASTW    TCURRENT 2+ 2+ ;
: TLAST   TCURRENT @ ;
: ITLAST  ITCURRENT @ @ ;
: T-HEAD  HEAD-? @
          IF THERE SWAP T", TLAST T, TCURRENT !
             TRUE TIMMED !
          ELSE DROP TIMMED 0!
          THEN ;
: ITCREATE BL WORD DUP TFIND
          IF OVER ID. ."  uvE OpPEdElEH" CR THEN DROP
          ITCURRENT @ +WORD ;
: TCREATE >IN @ >R BL WORD T-HEAD R> >IN !
          ITCREATE THERE DUP
          TLASTW ! , ( AdPEC B cElEBOM ClOBAPE )
          TCFL TALLOT ;
: T?COMP    TSTATE @ 0=
            ABORT"  TPEbuET PEviMA KOMpilqcii" ;
: T[        TSTATE 0! ;
: T]        TRUE TSTATE ! ;
: MLATEST   MCNTX @ @ @ ;
: ITSMUDGE   ITLAST 40 TOGGLE ;
: USE-LAB   <W> @ ! <FL> 0! ;
: EXEC-T,   <FL> @ IF THERE USE-LAB THEN T, ;
: T!CF      0CD OVER TC! 1+ <FL> @
            IF DUP USE-LAB THEN T! ;
: T(!CODE)  TLASTW @ T!CF ;
--
: STR-PARM    R> R> DUP C@ OVER + 1+ DUP 2+ >R
            @ SWAP ROT >R ;
: >VOC ;
: VOC>      R> DUP 2+ >R @ TCNTX >CNTX >VOC ;
: >VOC      <H> ?H COMPILE VOC> TCNTX @ @ ,
            <H> ;                          NEW >VOC
: >LAB ;
--     PAzPE{EHiE CCylKi HA METKu BpEPEd
: LAB>    STR-PARM  LAB ?WORD
          IF NAME> >BODY @ OVER T@ + SWAP T!
          ELSE 2DUP >LAB DROP USE-LAB
          SWAP CR . ID. ."  HEOpPEdElEHHAq METKA"
          THEN ;
: >LAB  --  iMq ---  0
          COMP-? @
          IF <H> ?H COMPILE LAB> ",
             TRUE <FL> ! HERE <W> ! 0 , <H>
          ELSE DROP THEN 0 ;                NEW >LAB
--           PAzPE{EHiE CCylOK HA KOd
: >DREF ;
: DREF>   STR-PARM D-VOC ?WORD
          IFNOT 2DUP >DREF SWAP CR . SPACE ID.
          ."   HEPAzPE{EHHAq CCylKA HA KOd"
          ELSE  NAME> @ SWAP T!
          THEN ;
--  zApiCx CCylKi HA KOd
-- AdPEC iMq ---
: >DREF   COMP-? @
          IF D-VOC ?WORD
             IF NAME> @ SWAP T!
             ELSE <H> ?H COMPILE DREF> ", , <H>
             THEN
          ELSE 2DROP THEN ;                 NEW >DREF
--  zAHECEHiE B CpiCOK D-VOC
-- AdPEC iMq ---
: +D-VOC  D-VOC +WORD , ;
: >REF ;
--
: REF>   --
  STR-PARM TFIND
           IFNOT 2DUP >REF SWAP CR . SPACE ID.
                 ."   HET B cElEBOM ClOBAPE"
           ELSE @ SWAP T! THEN ;
: >REF   -- AdPEC CTPOKA --> / BydA~A BHE{HEj CCylKi
           COMP-? @
           IF <H> ?H COMPILE REF> ", , <H>
           ELSE 2DROP THEN ;                 NEW >REF
: TCOMP       -- CTPOKA --> / diHAMi~. KOMpil. B TFORTH
      TFIND IF @ T,
            ELSE THERE SWAP >REF 0 T,
            THEN ;
: [MCOMPILE]  -- pPiHudiTElxHAq KOMpilqciq ClOB iz MFORTH
            ?COMP BL WORD MFIND IF ,
            ELSE ID-? THEN ;         IMMEDIATE
: FOR-LAB   CREATE  BL WORD ",
            DOES> MFIND
                  IF >BODY @ ELSE >LAB THEN ;
FOR-LAB TCALL  CALLR
FOR-LAB TNEXT  NEXTR
: FOR-CODE CREATE BL WORD ",
           DOES> TFIND
             IF @
             ELSE 0 SWAP >REF HR @ 2- <W> !
                  TRUE <FL> ! 0 THEN ;
FOR-CODE TCONST @
: TCOMPILE COMPILE (") BL WORD ",
           COMPILE TCOMP ; IMMEDIATE
-- CTPuKTuPy upPABlEHiq
  MFORTH >META  MFORTH !CURRENT
:: AGAIN  T?COMP 1 ?PAIRS TCOMPILE BRANCH T, ;
:: BEGIN  T?COMP THERE 1 ;
:: DO     T?COMP TCOMPILE (DO) THERE 0 T, 5 ;
:: THEN   T?COMP 2 ?PAIRS THERE SWAP T! ;
:: ELSE   T?COMP 2 ?PAIRS TCOMPILE BRANCH
          THERE 0 T, SWAP 2 [MCOMPILE] THEN 2 ;
:: IF     T?COMP TCOMPILE ?BRANCH THERE 0 T, 2 ;
:: IFNOT  T?COMP TCOMPILE N?BRANCH THERE 0 T,  2 ;
:: LOOP   T?COMP 5 ?PAIRS TCOMPILE (LOOP)
          DUP 2+ T, THERE SWAP T! ;
:: REPEAT >R >R [MCOMPILE] AGAIN R> R>
          2- [MCOMPILE] THEN ;
:: UNTIL  T?COMP 1 ?PAIRS TCOMPILE ?BRANCH T, ;
:: WHILE  [MCOMPILE] IF 2+ ;
:: +LOOP  T?COMP 5 ?PAIRS TCOMPILE (+LOOP)
          DUP 2+ T, THERE SWAP T! ;
:: LITERAL  TSTATE @ IF TCOMPILE LIT T, THEN ;
:: DLITERAL TSTATE @ IF TCOMPILE DLIT T, T, THEN ;
:: ?DO    T?COMP TCOMPILE (?DO) THERE 0 T, 5 ;
:: [']    T?COMP TCOMPILE LIT
          BL WORD TFIND IF @ T,
          ELSE THERE SWAP >REF 0 T,
          THEN ;
:: C"     BL WORD 1+ C@ [MCOMPILE] LITERAL ;
:: [      T[ ;
:: ."     T?COMP TCOMPILE (.") C" " WORD T", ;
:: "      [COMPILE] " TSTATE @
          IF TCOMPILE (") T", THEN ;
:: ABORT" T?COMP TCOMPILE (ABORT") [COMPILE] " T", ;
:: [COMPILE] BL WORD TCOMP ;
-- ObPAbOTKA KOHcA CTPOKi
::
          RDROP  ;
:: --     [COMPILE] -- ;
:: (      [COMPILE] ( ;
:: [[     BEGIN INTERPRET GETLINE AGAIN  ;   --| GETLINE
--
--  COzdAHiE HOByX CTATEj
:: :      T?EXEC !CSP TCREATE TCALL T(!CODE) ITSMUDGE T] ;
:: 83:    [MCOMPILE] : ;
:: ;      T?COMP ?CSP TCOMPILE EXIT ITSMUDGE
          [COMPILE] T[ ;
:: DOES>    -- BOzMOvHO pEPEKl`~EHiE HA OblACTx TARGET
            TCOMPILE (DOES>) TRUE COMP-? !
            ITLAST DUP C@ DUP -ROT 01F AND OVER C!
            THERE OVER  +D-VOC C!
            TCALL THERE TCFL TALLOT T!CF ;
:: ;S       RDROP ;
--| :: ;J       RDROP RDROP ;
:: ;J      [COMPILE] -- LEVEL @ 1-  --|
           IF 2 LEVEL -! FCB DUP GPTR ! 24 + DMA! LEVEL 1+!
             ELSE LEVEL 0! RDROP RDROP THEN ;
:: READ    T> READ ; --|
--
     METAFORT DEFINITIONS
: ]]        RDROP RDROP ;
: (<C-D>)   TCREATE 0 T(!CODE) TLASTW @ 1+ ;
: <CREATE-DOES>  COMPILE (<C-D>) LATEST [COMPILE] LITERAL
            COMPILE >DREF ;          IMMEDIATE
: DO-LAB    @ [MCOMPILE] LITERAL ;
--
     EX-FORTH >META  EX-FORTH !CURRENT
--
:: TALLOT   TALLOT ;
:: ALLOT    DALLOT ;
:: HERE     DHERE ;
:: THERE    THERE ;
:: ,        EXEC-T, ;
:: !        T! ;
:: C!       TC! ;
:: @        T@ ;
:: C@       TC@ ;
:: FDATA    DH ! ;
:: FCODE    TARG0 @ OVER - TBASE ! DUP TH0 ! TH ! ;
:: ]        T] ;
:: CONSTANT >IN @ >R TCREATE TCONST T(!CODE) DUP EXEC-T,
            R> >IN ! CURRENT @ SWAP EX-FORTH CURRENT !
            CONSTANT CURRENT ! ;
:: VARIABLE DHERE 2 DALLOT [MCOMPILE] CONSTANT ;
:: IMMEDIATE TIMMED @
            IF TLAST T> 80 TOGGLE THEN ;
:: VOCABULARY
            <CREATE-DOES> THERE 01 TC, 80 TC,
            0 T, PRED-VOC !            --
            THERE TVOC-LINK @ T, TVOC-LINK ! ;   --
:: '        BL WORD TFIND 0=
            ABORT"  HE OpPEdElEHO iCpOlHEHiE" @ ;
:: FORTH    MFORTH >META  TFORTH >TARGET ;
:: ASSEMBLER MASSEMBLER >META TASSEMBLER >TARGET ;
:: EDITOR   TEDITOR >TARGET ;
:: DEFINITIONS TCNTX @  @ ITCURRENT ! ;
:: END-VOC: TLAST [MCOMPILE] ' 5 + T! ;
:: EQU    -- zHA~EHiE ---
          BL WORD LAB ?WORD
          IF DUP ID. ."   uvE OpPEdElEHA" CR THEN
          LAB +WORD ['] DO-LAB HERE CFL ALLOT !CF , ;
:: L:     THERE [MCOMPILE] EQU ;
:: DL:    DHERE [MCOMPILE] EQU ;
:: +AR    TRUE HEAD-? ! ;      -- C zAgOlOBKAMi
:: -AR    HEAD-? 0! ;          -- bEz zAgOlOBKOB
:: +COMP  TRUE COMP-? ! ;      -- KOMpiliPOBATx
:: -COMP  COMP-? 0! ;          -- HE KOMpiliPOBATx
--
   MFORTH >META
METAFORT DEFINITIONS
--
: MINTERPR BEGIN BL WORD MFIND
           IF EXECUTE
           ELSE TSTATE @
                IF TFIND
                   IF @ T,
                   ELSE ?NUMBER
                      IF [MCOMPILE] LITERAL
                      ELSE THERE SWAP >REF 0 T,
                      THEN
                   THEN
                ELSE ?EX-FORTH
                    IFNOT ?NUMBER IFNOT >LAB THEN
                THEN THEN
           THEN ?STACK
           AGAIN ;
: JMINTERPR BEGIN GETLINE MINTERPR AGAIN ;  --| GETLINE
--
: REF!I <H> COMPILE EXIT HR0 @ 5 + H ! <H> ;
: REF!    COMP-? @ TRUE COMP-? ! HR0 @ EXECUTE COMP-? ! ;
: REFINIT HR0 @ HR ! HERE 2+ 2+ TARG0 ! H-L @ H !
          <H> 0CD C, CALL , COMPILE REF!I <H> ;
--|   dorabotka komandy TC
: TC      -- KOMAHdA TipA JEC dlq KOMpilqcii cElEBOgO TEKCTA
          FCB " FRT" FSET DUP >R ?OPEN ?FERR
          R@ GPTR !   R@ 20 + 4 ERASE   80 R> 23 + DUP 1+ DMA! C!
          [COMPILE] -- LEVEL @ LEVEL 1+!
          IFNOT WARNING 0! JMINTERPR CONSOLE TRUE WARNING ! THEN ;
: (QUIT)  METAFORT DEFINITIONS T[ HEX
          R0 @ RP! CONSOLE      [COMPILE] [ LEVEL 0!  --|  [COMPILE] [ LEVEL 0!
          BEGIN QUERY INTERPRET AGAIN ;
        ' (QUIT) F-DATA !
: (TITLE) CR 20 SPACES
         ." cElEBAq  KOMpilqciq.  04.09.86" CR ;
      ' (TITLE) F-DATA 0A + !
: TSIZE  THERE T> OVER - [ HEX ] 50 U/ 1+ 50 * ;
EX-FORTH >META  EX-FORTH !CURRENT
:: TARGET HERE WRF 80 - OVER - -1 FILL REFINIT ;
:: REF!   REF! ;
:: TC     TC ;         --|    dlq Bloveniq operatora tC
   METAFORT DEFINITIONS
:  TSAVE  TARG0 @ TSIZE NWRITE ;
:  TSAVE7970  TARG0 @ 2- TH0 @ OVER ! TSIZE NWRITE ;
-- FORTH-83 iHCTPuMEHTAlxHyj ACCEMblEP 02.12.1985
     METAFORT DEFINITIONS
: 8* 2* 2* 2* ;
: ?FL <FL> @ IF ."  BiCiT CCylKA BpEPEd" ABORT THEN ;
--
 : 1MI  CREATE C, DOES> C@ TC, ?FL ;
 : 2MI  CREATE C, DOES> C@ + TC, ?FL ;
 : 3MI  CREATE C, DOES> C@ SWAP 8* + TC, ?FL ;
 : 4MI  CREATE C, DOES> C@ TC, TC, ?FL  ;
 : 5MI  CREATE C, DOES> C@ TC,  EXEC-T,   ;
--
10 CONSTANT FRMAX ( MAKCiMAlxHOE ~iClO CCylOK BpEPEd)
   VARIABLE FRTABLE  FRMAX  2* 2*  ALLOT
10 CONSTANT LBLMAX ( MAKCiMAlxHOE ~iClO lOKAlxHyX METOK)
   VARIABLE LTABLE   LBLMAX 1+ 2*  ALLOT
: FRCHK   ( pPOBEPKA HEPAzPE{EHHyX CCylOK BpEPEd )
          FRMAX 0 DO I 2* 2* FRTABLE + @
                     ABORT" HEPAzPE{EHHAq CCylKA BpEPEd"
                  LOOP ;
: FRCLR   ( iHiciAlizAciq TAblicy CCylOK BpEPEd )
          FRTABLE FRMAX 2* 2* ERASE
          LTABLE LBLMAX 1+ 2* ERASE ;
: FRRES   ( PAzPE{EHiE CCylOK BpEPEd )
          FRMAX 0 DO  I 2* 2* FRTABLE + 2DUP @ =
                    IF THERE OVER 2+ @ T> +! 0!
                    ELSE DROP THEN
                  LOOP ;
: FRADD   ( dObABlEHiE CCylKi BpEPEd B TAblicu )
          FRMAX 1+ 0
          DO FRMAX I = ABORT" Cli{KOM MHOgO CCylOK BpEPEd"
             I 2* 2* FRTABLE + DUP @ 0= IF 2DUP !
             THERE 1+ SWAP 2+ ! LEAVE ELSE DROP THEN
          LOOP ;
 -- OpPEdElq`}iE BXOvdEHiq METOK
: !LT   CREATE , DOES> @  FRRES THERE SWAP 2* LTABLE + ! ;
 -- iCpOlxzu`}iE BXOvdEHiq METOK
: @LT     CREATE , DOES> @ DUP 2*
          LTABLE + @ SWAP OVER 0=
          IF FRADD THEN DROP ;
--
        MFORTH >META MASSEMBLER !CURRENT
4 CONSTANT H  5 CONSTANT L 7 CONSTANT A  6 CONSTANT PSW
2 CONSTANT D  3 CONSTANT E 0 CONSTANT B  1 CONSTANT C
6 CONSTANT M  6 CONSTANT SP     DECIMAL
 1 !LT 1#:   2 !LT  2#:  3 !LT  3#:  4 !LT  4#:  5 !LT  5#:
 6 !LT 6#:   7 !LT  7#:  8 !LT  8#:  9 !LT  9#: 10 !LT 10#:
11 !LT 11#: 12 !LT 12#: 13 !LT 13#: 14 !LT 14#: 15 !LT 15#:
--
 1 @LT  1#   2 @LT  2#   3 @LT  3#   4 @LT  4#   5 @LT  5#
 6 @LT  6#   7 @LT  7#   8 @LT  8#   9 @LT  9#  10 @LT 10#
11 @LT 11#  12 @LT 12#  13 @LT 13#  14 @LT 14#  15 @LT 15#
 HEX
00 1MI NOP   76 1MI HLT   F3 1MI DI    FB 1MI EI
07 1MI RLC   0F 1MI RRC   17 1MI RAL   1F 1MI RAR
E9 1MI PCHL  F9 1MI SPHL  E3 1MI XTHL  EB 1MI XCHG
27 1MI DAA   2F 1MI CMA   37 1MI STC   3F 1MI CMC
80 2MI ADD   88 2MI ADC   90 2MI SUB   98 2MI SBB
A0 2MI ANA   A8 2MI XRA   B0 2MI ORA   B8 2MI CMP
09 3MI DAD   C1 3MI POP   C5 3MI PUSH  02 3MI STAX
0A 3MI LDAX  04 3MI INR   05 3MI DCR   03 3MI INX
0B 3MI DCX   C7 3MI RST   D3 4MI OUT   DB 4MI IN
C6 4MI ADI   CE 4MI ACI   D6 4MI SUI   DE 4MI SBI
E6 4MI ANI   EE 4MI XRI   F6 4MI ORI   FE 4MI CPI
22 5MI SHLD  2A 5MI LHLD  32 5MI STA   3A 5MI LDA
C4 5MI CNZ  0CC 5MI CZ    D4 5MI CNC   DC 5MI CC
E4 5MI CPO   EC 5MI CPE   F4 5MI CP    FC 5MI CM
CD 5MI CALL  C9 1MI RET   C3 5MI JMP
C0 1MI RNZ   C8 1MI RZ    D0 1MI RNC   D8 1MI RC
E0 1MI RPO   E8 1MI RPE   F0 1MI RP    F8 1MI RM
C2 5MI JNZ   CA 5MI JZ    D2 5MI JNC   DA 5MI JC
E2 5MI JPO   EA 5MI JPE   F2 5MI JP    FA 5MI JM
--
:: MOV SWAP 8* 40 + + TC, ?FL ;
:: MVI SWAP 8* 6  + TC, TC, ?FL ;
:: LXI SWAP 8* 1 + TC, EXEC-T, ;
--
:: 1MI    <CREATE-DOES> TC, ;
:: 2MI    <CREATE-DOES> TC, ;
:: 3MI    <CREATE-DOES> TC, ;
:: 4MI    <CREATE-DOES> TC, ;
:: 5MI    <CREATE-DOES> TC, ;
--
:: !LT    <CREATE-DOES> T, ;
:: @LT    <CREATE-DOES> T, ;
  -- KOdy uClOBij dlq CTPuKTuP upPABlEHiq
C2 CONSTANT 0=   D2 CONSTANT CS
E2 CONSTANT PE  F2 CONSTANT 0<
--
:: NOT    8 + ;
:: THEN   2 ?PAIRS THERE SWAP T! ;
:: IF     TC, THERE 0 T, 2 ;
:: ELSE   2 ?PAIRS C3 [MCOMPILE] IF
          ROT SWAP [MCOMPILE] THEN  2 ;
:: BEGIN  THERE 1 ;
:: UNTIL  SWAP 1 ?PAIRS TC, T, ;
:: AGAIN  1 ?PAIRS C3 TC, T, ;
:: WHILE  [MCOMPILE] IF 2 + ;
:: REPEAT >R >R [MCOMPILE] AGAIN
          R> R> 2 - [MCOMPILE] THEN ;
 MFORTH >META EX-FORTH >META
    EX-FORTH  !CURRENT
:: BEG-ASM FRCLR TASSEMBLER >TARGET  MASSEMBLER >META
           !CSP ;
:: END-ASM FRCHK MFORTH >META  TFORTH >TARGET ?CSP ;
    MFORTH !CURRENT
:: CODE    T?EXEC TCREATE ITSMUDGE
           TCFL TH -! [MCOMPILE] BEG-ASM ;
:: 83CODE  [MCOMPILE] CODE ;
:: ;CODE   T?COMP ?CSP [MCOMPILE] (DOES>)
           TCFL TH -! T[ [MCOMPILE] BEG-ASM ;
:: END-CODE T?EXEC [MCOMPILE] END-ASM ITSMUDGE ;
:: LABEL   T?EXEC TCREATE TNEXT T(!CODE) ITSMUDGE
           [MCOMPILE] BEG-ASM ;
  MASSEMBLER >META MASSEMBLER !CURRENT
:: NEXT;   TNEXT [MCOMPILE] JMP [MCOMPILE] END-CODE ;
    MFORTH >META  METAFORT DEFINITIONS
 METAFORT DEFINITIONS MFORTH >META
HEX
: NOOP ;  VARIABLE VP
: VL0   HEX
        BEGIN DUP @
        WHILE @ DUP NAME> VP @ EXECUTE @ 4 .0 4 SPACES
              DUP COUNT 1F AND TYPE >OUT @ DUP 14 U/
              1+ 14 * SWAP - SPACES  >OUT @ 50 =
              IF CR THEN   N>LINK
        REPEAT DROP ;
: VL    ['] NOOP VP ! VL0 ;
: VLAB  LAB ['] >BODY VP ! VL0 ;
TRUE WARNING !
;J
