 -- BBOd-ByBOd dlq CP/M
  CODE FDOS ( N1 B1 --> N2 B2)
           H POP   D POP   B PUSH   C L MOV   05 CALL
           B POP   H PUSH   H 0 MVI   L A MOV   H PUSH
           NEXT JMP      END-CODE
  : BYE    0 EXECUTE ;  -- ByXOd B CP/M
  : (EMIT) 2 FDOS 2DROP ;
  : (KEY)  BEGIN 0FF 6 FDOS PRESS ?DUP UNTIL ;
  : (CR)   0D EMIT 0A EMIT ;
  : ?KEY   ( --> C TRUE / FALSE )
ееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееDROP ;  -- ByBOd CiMBOlA HA pE~ATx
  : PRINT ( AdPEC dliHA --> )
          0 ?DO DUP C@ LEMIT 1+ LOOP DROP ;
  : (LEMIT) DUP (EMIT) LEMIT ;
  : +COPY  ['] (LEMIT) UEMIT ! ;
  : -COPY  ['] (EMIT) UEMIT ! ;
--
REF!
;J
