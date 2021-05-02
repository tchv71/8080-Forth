--
--                    D I S F O R T H
HEX
: &DISF 0 -ROT 0 DO ROT OVER = ROT OR SWAP LOOP DROP ;
: DISF  BASE @ HEX ' DUP C@ CD = OVER 1+ @ CALL = AND NOT
        ABORT" kodowoe slowo"  3 + BEGIN 
          DUP @ >NAME ID. SPACE DUP @ ['] LIT = IF 2+ DUP @ . SPACE ELSE
            DUP @ >R ['] BRANCH ['] ?BRANCH ['] N?BRANCH ['] (?DO)
            ['] (DO) ['] (+LOOP) ['] (LOOP) R> 7 &DISF
            IF 2+ DUP @ OVER - 2- . SPACE ELSE
              DUP @ >R ['] (ABORT") ['] (") ['] (.") R> 3 &DISF
              IF 2+ COUNT 2DUP + -ROT TYPE 2- SPACE THEN THEN THEN 2+
          SPACE KEY DUP C" N = IF CR 4 SPACES THEN BL = UNTIL U. BASE ! ;
;J
