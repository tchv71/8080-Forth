-- preobrazowanie fajlow iz formata FORTH.FRT w tekstowyj format
HEX
: NS     40 OVER 40 + BEGIN 1- 2DUP C@ BL = AND WHILE 
         SWAP 1- SWAP REPEAT DROP ;
: CONV   -- otkuda  kol.-strok --> dlina
         OVER 400 + SWAP 0 DO -- ADDR2 ADDR1
         2DUP NS              -- ADDR2 ADDR1 ADDR2 ADDR1 N
         SWAP >R DUP >R       -- ADDR2 ADDR1 ARRD2 N         !!  ADDR1 N
         <CMOVE> R> + 0A0D OVER ! 2+ -- ADDR2'               !!  ADDR1
         R> 40 +      LOOP DROP ;
;J
