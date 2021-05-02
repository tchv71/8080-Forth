-- fort-sistema dlq sr/m s drajwerom dlq V24 ( s assemblerom )
TARGET +AR +COMP
HEX FORTH DEFINITIONS
0100 FCODE        -- adres na~ala pzu
3200 FDATA        -- adres na~ala ozu
40   EQU (C/L)    -- dlina stroki displeq
0D   EQU (ST-C)   -- kod stop-litery
08   EQU (B-SP)   -- kod BACKSPACE
1D   EQU (C<-)    -- kod "kursor wlewo"
40   EQU RSTCKLEN -- glubina steka wozwratow
50   EQU DSTCKLEN -- glubina steka dannyh
50   EQU (TIBLEN) -- razmer bufera TIB
--
L: FORTH-CODE
L: V24DRIVER         200 TALLOT
V24DRIVER CR CR READ V24DR.PRG CR CR
--
TC FT1
TC FT2
TC FT3
TC ASSEMBLR
TC IOCPM
TC FILE
  : TITLE  CR
     0B SPACES  ." fOPT-CiCTEMA BEPCiq  OT 10.11.87"             CR
     10 SPACES        ." (CTAHdAPT FORTH-83)"                    CR
     ." adaptirowano  |.|.kasatkinym (wniira), dom.tel.2381550"  CR
     ." podkl`~en drajwer dlq V24"
            UTITLE @ ?DUP IF EXECUTE THEN ;
--
CODE V24INIT -- -->   -- inicilizaciq V24
             B PUSH   106 CALL   B POP   NEXT JMP   END-CODE
CODE V24TSTB -- --> F -- testirowanie bufera wwoda, F=0,esli pust, ina~e 0FF
             10C CALL   H 0 MVI   L A MOV   H PUSH   NEXT JMP   END-CODE
CODE V24GETB -- --> B -- wzqtx bajt iz bufera
             10F CALL   H 0 MVI   L A MOV   H PUSH   NEXT JMP   END-CODE
CODE V24TST  -- --> F -- test sostoqniq V24
             B PUSH   112 CALL   B POP
             H 0 MVI   L A MOV   H PUSH   NEXT JMP   END-CODE
CODE V24SEND -- B --> -- poslatx bajt ~erez V24
             H POP   B PUSH   A L MOV   115 CALL   B POP   NEXT JMP   END-CODE
--
--   zABEP{EHiE KOMpilqcii
HEX   FORTH DEFINITIONS
DL: MAXDATA
REF!
END-VOC: FORTH
[[ TVOC-LINK @ ]] VOC-LINKF0 ! -- iHiciAlizAciq VOC-LINK
MAXDATA U. CR
;J
