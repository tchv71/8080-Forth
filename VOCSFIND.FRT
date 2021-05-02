( ONLY ALSO vocabulary operators. by Tom Zimmer )

8 CONSTANT #VOCS
CONTEXT
VARIABLE    CONTEXT #VOCS 2* ALLOT
@ DUP CONTEXT 2!
  NEW CONTEXT
VOCABULARY ROOT ROOT DEFINITIONS
: ALSO CONTEXT DUP 2+ #VOCS 2- 2* CMOVE> ;
: ONLY ['] ROOT >BODY 2+ CONTEXT #VOCS 1- 2*
        2DUP ERASE + ! ROOT ;
: SEAL ' >BODY 2+ CONTEXT #VOCS 2* ERASE CONTEXT ! ;
: PREVIOUS
     CONTEXT DUP 2+ SWAP #VOCS 2- 2* CMOVE
     CONTEXT #VOCS 2- 2* + 0!
;
: FORTH FORTH ;
: DEFINITIONS DEFINITIONS ;
: .VOC   2- BODY> >NAME ID. ;
: ORDER
  CURRENT ." Current: " @ .VOC
  CONTEXT CR ." Context: "
  #VOCS 0 DO
    DUP @ ?DUP
    IF .VOC SPACE THEN
    2+
  LOOP
  DROP
;
: VOCS VOC-LINK @
  BEGIN   DUP
    2- .VOC SPACE  @ ?DUP
  0= UNTIL
;
HEX
VARIABLE PRIOR
CODE AP1 ( DROP CONTEXT I 2* + @ DUP )  >PRE
     POP  D
     LXI  D CONTEXT
     LHLD 601A
     MOV  A M
     INX  H
     MOV  H M
     MOV  L A
     DAD  H
     DAD  D
     MOV  A M
     INX  H
     MOV  H M
     MOV  L A
     PUSH H
     PUSH H
NEXT;
CODE AP2   ( DUP DUP PRIOR DUP @ -ROT ! = )
     LHLD PRIOR
     POP  D
     XCHG
     SHLD PRIOR
     PUSH H
     MOV  A L
     CMP  E
     JNZ  @1
     MOV  A H
     CMP  D
@1:  LXI  H 0
     JNZ  @2
     DCX  H
@2:  PUSH H
NEXT;
CODE AP3  ( DUP NAME> SWAP C@ 80 AND IF 1 ELSE -1 THEN )
     POP  H
     MOV  A M
     PUSH PSW
     ANI  3F
     ADI  3
     MOV  E A
     MVI  D 0
     DAD  D
     POP  PSW
     PUSH H
     ANI  80
     LXI  H 1
     JNZ  @1
     LXI  H -1
@1:  PUSH H
NEXT;
CODE AP4 ( 0 PRIOR 0! #VOCS 0 )
     LXI  H 0
     SHLD PRIOR
     PUSH H
     LXI  D #VOCS
     PUSH D
     PUSH H
NEXT;
: FIND
     AP4
     DO
       AP1
       IF
         AP2
         IFNOT
            ?WORD
            IF
              AP3
              LEAVE
            ELSE 0 THEN
         THEN
       THEN
     LOOP
;
.( Setup vocabs )
HEX
ONLY
' FIND 6006 !
FORTH
ALSO DEFINITIONS
;S
INX  H
     MOV  H M
     MOV  L A
     PUSH H
 