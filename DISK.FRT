--
--                 rabota s diskom na fizi~eskom urowne
HEX
: BIOS    -- N nomer --> N1 N2
          0 -ROT 0 -ROT 0 -ROT 1- 3 * 1 @ + ASMCALL
          2DROP SWAP 100 U/ ;
: SETTRK  -- N -->
          0A BIOS 2DROP ;
: SETSEC  -- N -->
          0B BIOS 2DROP ;
: SETDMA  -- N -->
          0C BIOS 2DROP ;
: READS    -- --> 
          0 0D BIOS PRESS ABORT" s~itywanie nowozmovno" ;
: WRITES   -- --> 
          0 0E BIOS PRESS ABORT" zapisx newozmovna" ;
: DUMPS   -- dorovka sektor
          SETSEC SETTRK HERE 100 + FFF0 AND DUP SETDMA
          READS 80 DUMP ;
;J
