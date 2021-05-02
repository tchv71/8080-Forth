-- fort-sistema dlq sr/m
TARGET +AR +COMP
HEX FORTH DEFINITIONS
0100 FCODE        -- adres na~ala pzu
2800 FDATA        -- adres na~ala ozu
40   EQU (C/L)    -- dlina stroki displeq
0D   EQU (ST-C)   -- kod stop-litery
08   EQU (B-SP)   -- kod BACKSPACE
1D   EQU (C<-)    -- kod "kursor wlewo"
40   EQU RSTCKLEN -- glubina steka wozwratow
50   EQU DSTCKLEN -- glubina steka dannyh
50   EQU (TIBLEN) -- razmer bufera TIB
 L: FORTH-CODE
TC FT1
TC FT2
TC FT3
TC IOCPM
TC FILE
  : TITLE  CR
     0B SPACES  ." fOPT-CiCTEMA BEPCiq  OT 10.11.87"             CR
     10 SPACES        ." (CTAHdAPT FORTH-83)"                    CR
     ." w.a.kirillin  a.a.klubowi~  n.r.nozdrunow  (lgu,matmeh)" CR
     ." adaptirowano  |.|.kasatkinym (wniira), dom.tel.2381550"  CR
            UTITLE @ ?DUP IF EXECUTE THEN ;
--
--   zABEP{EHiE KOMpilqcii
HEX   FORTH DEFINITIONS
DL: MAXDATA
REF!
END-VOC: FORTH
[[ TVOC-LINK @ ]] VOC-LINKF0 ! -- iHiciAlizAciq VOC-LINK
;J
