HEX : Q 3B70 0DFE OVER ! 2+ 77C2 OVER ! 2+ 3E3B OVER !
2+ BB20 OVER ! 2+ 230B OVER ! 2+ C9 SWAP C! 3AF5 70CD
OVER ! 2+ 3B SWAP C! 3B02 70CD OVER ! 2+ 3B SWAP C! ;
CODE HELEN D 0 LXI  PSW POP H POP B PUSH C A MOV BEGIN
           A M MOV  C      CMP  H      INX
           D   INX  0=          UNTIL
           B   POP  D      PUSH NEXT;
CODE %!>   B   LDAX L A    MOV  B      INX
           B   LDAX H A    MOV  B      INX
           H   INX  H      INX  H      INX
           D   POP  M E    MOV  H      INX
           M D MOV  NEXT;
: (BLOCK) DROP 9000 ;
: FLD 0 (BLOCK) -1  HELEN  %!> B/BUF 1 LOAD ;
: >>>     ' C3 OVER C! 1+  ! ;   ;S  07/30/91  V1.1

 BL WORD         1+ $ @ COUNT COMP
       0= IF   EXIT         THEN
     AGAIN
;
: /*
     C�E��E   C C C C��OM77�:N�  C C��`�  C C  ILE]�  }�� " COMME�;" $ ! <��MMENT:>
;
: <#IF> ?LOADING BEGIN
HEX : Q 3B70 0DFE OVER ! 2+ 77C2 OVER ! 2+ 3E3B OVER !WAP " #ENDIF" COUNT COMP 0= OR
   IF             EXIT THEN
  AGAIN
;
: #