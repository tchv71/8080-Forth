--   zagruzka tekstow iz |l-60 ~erez  V24
HEX
07 CONSTANT BITLEN
CODE BYTEG  DI   D 8 MVI
   1#:      A 10 MVI   0E OUT   0E IN   08 ANI   1# JZ
            H 0 MVI
   2#:      A 10 MVI   0E OUT   0E IN   H INR   08 ANI   2# JNZ
            A H MOV   BITLEN CPI   A L MOV   RAR   L A MOV
            D DCR   1# JNZ    H 0 MVI   H PUSH   NEXT JMP
            END-CODE
 QUAN TPTR0   -- ukazatalx na na~alo teksta
 QUAN TPTR1   -- ukazatelx na konec teksta
: TEXT      HERE 100 + DUP TO TPTR0 BEGIN BYTEG DUP 3 <> WHILE
            OVER C! 1+ REPEAT DROP TO TPTR1 ;
: SAVTX TPTR0 TPTR1 DUP 80 BLANK OVER - WRITE ;
;J