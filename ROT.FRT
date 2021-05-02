
: MAT! TO A TO B AT B SIZE * AT A SIZE *
OVER <> ABORT" razmernosti ne sowpada`t"
AT A 7 + AT B 7 + ROT 0 DO SWAP DUP @
2 PICK ! 2+ SWAP 2+ LOOP 2DROP ;
4 4 MAT TRANS 4 4 MAT X0 4 4 MAT Y0 WITH TRANS
: na~ ['] TRANS MAT256E! ;
: TRNS ['] X0 ['] TRANS MAT! ['] Y0 PROC
['] Y0 ['] X0 ['] TRANS NMAT* ;
: wokrug-X ['] XROT TO PROC TRNS ;
: wokrug-Y ['] YROT TO PROC TRNS ;
: wokrug-Z ['] ZROT TO PROC TRNS ;
: sdwig ['] SHIFT TO PROC TRNS ;
: PLSDV TO C AT C MAT256E! DUP COS NEGATE 2/
NORM 0 2 C ! SIN 2/ NORM 1 2 C ! ;
: plosk-sdwig ['] PLSDV TO PROC TRNS ;
: 1-proekc na~ 30 wokrug-Y 30 wokrug-X ;
: 2-proekc na~ 30 plosk-sdwig ;
;S
 C ! ;
: plosk-sdwig ['] PLSDV TO PROC TRNS ;
: 1-proekc na~ 30 wokrug-Y 30 wokrug-X ;
: 2-proekc na~ 30 plosk-