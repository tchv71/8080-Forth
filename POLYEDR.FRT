( -- ob}. ~astx --)
: REP ' SWAP 0 DO DUP EXECUTE LOOP DROP ;
4 REP VECT A0 B0 C0 D0
: VECTOR CREATE 2* ALLOT DOES> SWAP 2* + ;
: 2VECTOR CREATE 2* 2* ALLOT DOES> SWAP 2* 2* + ;
: VECTR3 CREATE 6 * ALLOT DOES> SWAP 6 * + ;
: rebro 2 VECTOR ; : to~ka 3 VECTOR ; : wektor to~ka ;
: rebro! TO D0 2@ 0 D0 ! 1 D0 ! ; wektor F
: 3VECT! TO A0 TO B0 3 0 DO I B @ I A ! LOOP ;
: mnogougolxnik 6 2VECTOR ; mnogougolxnik granx
: SET.SIZE TO D0 0 D0 @ ;
: SET.SMB  TO C0 TO A0 0 C0 @ AT A0 rebro! ;
;S





( -- ispolniteli "poli|dr" i " stereometr " --)
VOCABULARY poli|dr poli|dr DEFINITIONS
10 VECTR3 wer{iny to~ka ND 10 6 MAT grani
: R3 VECTR3 3 0 DO DUP @ I ND ! 2+ LOOP DROP ['] ND ;
FORTH DEFINITIONS VOCABULARY
stereometr stereometr DEFINITIONS
: V+ TO A TO B TO C 3 0 DO I A @ I B @ + I C ! LOOP ;
: V- TO A TO B TO C 3 0 DO I A @ I B @ - I C ! LOOP ;
: V* TO A 3 0 DO DUP I A @ * I A ! LOOP DROP ;
: V/ TO A 3 0 DO DUP I A @ SWAP / I A ! LOOP DROP ;
: VSCAL* TO A TO B 0 3 0 DO I A @ I B @ * + LOOP ;
: VVECT* TO C TO B TO A 3 0 DO I 1+ 3 MOD DUP A @
I 2+ 3 MOD DUP B @ ROT * -ROT A @ SWAP B @ * - I C !
LOOP ;
: VMIX* TO C0 TO B0 TO A0 AT A0 AT B0 ['] VVECT*
['] F AT C0 VSCAL* ; FORTH DEFINITIONS
;S

VOCABULARY otrezki otrezki DEFINITIONS
: ?wyrovd TO A 0 A @ 1 B @ < NOT ; VECT D
: polu~_razH TO D TO C TO B TO A 0 A @ 0 C ! 1 A @
0 B @ MIN 1 C ! 1 A @ 1 D ! 0 A @ 1 B @ MAX 0 D ! ;
: perese~x TO B TO A 0 A @ 0 B @ MAX 0 A !
1 A @ 1 B @ MIN 1 A ! ; FORTH DEFINITIONS
;S










( -- ispolnitelx "geometr" -- )
VOCABULARY geometr geometr DEFINITIONS 2 REP
to~ka X1 X0 wektor P 0 CONSTANT T0 256 CONSTANT T1
: na~atx ['] P 3VECT! TO B 0 B [ poli|dr ] R3 [']
X0 3VECT! 1 B R3 ['] X0 3VECT! ;
rebro T wektor SUM
: centr TO A0 3 0 DO I F 0! LOOP AT A0 SET.SIZE 1+ 1
DO I A0 ['] T rebro! [ poli|dr ] 0 T R3 F 3VECT! [']
F ['] SUM ['] SUM [ stereometr ] V+ [ poli|dr ] 1 T
R3 F 3VECT! ['] F ['] SUM ['] SUM [ stereometr ] V+
LOOP AT A0 SET.SIZE 2* ['] SUM V/ ;
VECT D 2 REP wektor V1 V2
: ?wertik TO D 1 D ['] T rebro! 0 T [ poli|dr ] R3
['] V1 3VECT! 1 T R3 ['] V2 ['] V1 [ stereometr ] V-
3 D @ [ poli|dr ] R3 ['] V2 DUP [ stereometr ] V- [']
V1 ['] V2 ['] P VMIX* 0= ;
3 REP QUAN T_ L0 L1 3 REP VECT E H G
3 REP wektor AB AC N ;S

geometr DEFINITIONS
: per_s TO G TO H TO E ['] X0 AT E [ stereometr ]
['] AB V- ['] X1 AT E ['] AC V- AT H ['] AB
VSCAL* TO L0 AT H ['] AC VSCAL* TO L1
L0 0< L1 0< OR NOT IF T1 0 G ! T0 1 G ! ELSE
L0 0< L1 0< AND IF T0 0 G ! T1 1 G ! ELSE L0 NEGATE
T1 T0 - * L1 L0 - / T0 + TO T_ L0 0<
IF T0 0 G ! T_ 1 G ! ELSE L1 0< IF T_ 0 G ! T1 1 G !
ELSE ABORT" o{ibka " THEN THEN THEN THEN ;
: goriz_perese~ TO D0 TO C0 TO B0 TO A0 [ stereometr ]
AT B0 AT A0 ['] AB V- AT C0 AT A0 ['] AC V-
['] N ['] P VSCAL* 0< IF -1 ['] N V*
THEN AT A ['] N AT D0 per_s ;
: wert_perese~ TO D0 TO C0 TO B0 TO A0 [ stereometr ]
AT B0 AT A0 ['] AB V- AT C0 AT A0 ['] AC V-
['] N ['] P VSCAL* 0< IF -1 ['] N V*
THEN AT A ['] N AT D0 per_s ;
;S
geometr DEFINITIONS 2 REP VECT SIZ ANS
3 REP to~ka AX BX CX 2 REP rebro RBR Z
: GETPN 0 RBR [ poli|dr ] R3 ['] AX 3VECT! 1 RBR R3
['] BX 3VECT! ;
: tenx TO ANS TO SIZ AT SIZ ?wertik IF T1 0 ANS !
T0 1 ANS ! ELSE AT SIZ ['] CX centr ['] RBR ['] SIZ
SET.SMB GETPN ['] AX ['] BX ['] CX AT ANS goriz_perese~
 0 SIZ @ 0 DO I SIZ ['] RBR rebro! GETPN ['] AX
['] BX ['] CX ['] Z wert_perese~ [ otrezki ]
AT ANS ['] Z perese~x  LOOP THEN ;
FORTH DEFINITIONS







VOCABULARY L1. L1. DEFINITIONS ( lin. odnonapr. spisok)
5 CONSTANT MAXIND MAXIND 1+ VECTOR PNT
MAXIND 1+ 2VECTOR L1 QUAN IBP QUAN IAP
: INIT 0 DUP TO IBP TO IAP 0 PNT 0!
MAXIND 1 DO I 1+ I PNT ! LOOP 1 MAXIND PNT ! ;
: GETM 1 PNT @ DUP PNT @ 1 PNT ! ;
: ?FRE 1 PNT @ 1 <> ;
: ?END IAP 0 = ;
: ?NUL 0 PNT @ 0= ;
: MOVF ?END ABORT" dalx{e nekuda" IAP DUP TO IBP
PNT @ TO IAP ;
: ADD ?FRE NOT ABORT" net mesta" GETM IAP OVER DUP
IBP PNT ! PNT ! TO IAP IAP L1 2! ;
: COPY ?END ABORT" net |lementa" IAP L1 2@ ;
: BEG 0 DUP TO IBP PNT @ TO IAP ;
: DEL ?END ABORT" ne mogu udalitx" 1 PNT @ IBP 1 PNT !
IBP PNT ! IAP TO IBP IAP PNT @ TO IAP ;
: GET COPY DEL ; ;S
VOCABULARY izobr_rebra izobr_rebra DEFINITIONS
2 REP VECT REB GRAN 4 REP otrezok tenx_ prosweT
lew-komp praw-komp
: na~atx AT REB [ proektor ] wektor  [ geometr ] na~atx
[ L1. ] INIT 0 REB 1 REB ADD ;
: u~estx_tenx TO GRAN AT GRAN ['] tenx_ [ geometr ]
tenx [ otrezki ] ['] tenx ?wyrovden IFNOT [ L1. ] BEG
BEGIN ?END NOT WHILE GET 1 proswet ! 0 proswet !
['] proswet ['] tenx ['] lew-komp ['] praw-komp
[ otrezki ] polu~_razn
['] lew-komp ?wyrovd IFNOT [ L1. ] 0 lew-komp @
1 lew-komp @ ADD MOVF THEN
['] praw-komp ?wyrovd IFNOT [ L1. ] 0 praw-komp @
1 praw-komp @ ADD MOVF THEN REPEAT THEN ;
: kon~itx [ L1. ] BEG BEGIN ?NUL NOT WHILE
GET [ proektor ] izobr_otr REPEAT ;


( -- MAIN -- )

OVF THEN REPEAT THEN ;
: kon~itx [ L1. ] BEG BEGIN ?NUL NOT WHILE
GET [ proektor ] izobr_otr