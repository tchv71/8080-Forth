DASM DEFINITIONS HEX
: ?BS 8 EMIT SPACE 8 EMIT OUT @ IF OUT_BUF 1-! THEN ;
: DA 0 DO ADR @ . ?TAB (D) ?CR LOOP ;
: DW1 5 MIN 0 ADR @ . ?TAB ?" DW" ?TAB DO ADR @ @
  >NAME COUNT 1F AND ADR DUP @ 2+ SWAP !
  ?TYPE CO LOOP ?BS ?CR ;
: DW2 5 MIN 0 ADR @ . ?TAB ?" DW" ?TAB DO ADR @ @ ?" L" (A.)
  CO ADR DUP @ 2+ SWAP ! LOOP ?BS ?CR ;
: DL ADR @ DUP . ?TAB ?" DB" ?TAB COUNT DUP A. CO AP
  DUP 1+ ADR +! 1F AND ?TYPE AP ?CR ;
: DB 8 MIN 0 ADR @ . ?TAB ?" DB" ?TAB DO ADR @ C@ A.
  CO ADR 1+! LOOP ?BS ?CR ;
: LAB ?" L" ADR @ (A.) ?" :" ;
: HEAD DUP LAB DUP COUNT ?TAB ?" DB" ?TAB DUP A. 1F AND CO AP
  ?TYPE AP ?CR ?TAB ?" DW" ?TAB DUP N>LINK @ ?" L" (A.) ?CR
  DUP COUNT 1F AND ?TYPE ?" :" ?CR NAME> ADR ! 1 DA ;
: HE ADR @ HEAD ;
: A? ADR @ ." Adr = " U. ;
: O? HEX BUF_BEG U. ." ... " OUT_BUF @ U. 3 SPACES
  OUT @ IF ." ON" ELSE ." OFF" THEN ;
: LIST_BUF OUT @
  OUT_OFF BUF_BEG BEGIN DUP C@ DUP FF = NOT WHILE
  DUP D = IF CR DROP ELSE DUP 9 = IF ?TAB DROP ELSE
  EMIT THEN THEN 1+ REPEAT 2DROP IF OUT_ON THEN ;
FORTH DEFINITIONS DASM ;S
8 EMIT OUT @ IF OUT_BUF 1-! THEN ;
: DA 0 DO ADR @ . ?TAB (D) ?CR LOOP ;
: DW1 5 MIN 0 ADR @ . ?TAB ?" DW" ?TAB DO ADR @ @
  >NAME COUNT 1F AND ADR DUP @ 2+ SWAP !
  ?TYPE CO LOOP ?BS ?CR ;
: DW2 5 MIN 0 ADR @ . ?TAB ?" DW" ?TAB DO ADR @ @ ?" L" (A.)
  CO ADR DUP @ 2+ SWAP ! LOOP ?BS ?CR ;
: DL ADR @ DUP . ?TAB ?" DB" ?TAB COUNT DUP A. CO AP
  DUP 1+ ADR +! 1F AND ?TYPE AP ?CR ;
: DB 8 MIN 0 ADR @ . ?TAB ?" DB" ?TAB DO ADR @ C@ A.
  CO ADR 1+! LOOP ?BS ?CR ;
: LAB ?" L" ADR @ (A.) ?" :" ;
: HEAD DUP LAB DUP COUNT ?TAB ?" DB" ?TAB DUP A. 1F AND CO AP
  ?TYPE AP ?CR ?TAB ?" DW" ?TAB DUP N>LINK @ ?" L" (A.) ?CR
  DUP COUNT 1F AND ?TYPE ?" :" ?CR NAME> ADR ! 1 DA ;
: HE ADR @ HEAD ;
: A? ADR @ ." Adr = " U. ;
: O? HEX BUF_BEG U. ." ... " OUT_BUF @ U. 3 SPACES
  OUT @ IF ." ON" ELSE ." OFF" THEN ;
: LIST_BUF OUT @
  OUT_OFF BUF_BEG BEGIN DUP C@ DUP FF = NOT WHILE
  DUP D = IF CR DROP ELSE DUP 9 = IF ?TAB DROP ELSE
  EMIT THEN THEN 1+ REPEAT 2DROP IF OU