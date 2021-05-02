HEX
:  ;
VARIABLE 
CODE SAVEB >PRE
     MOV  L C
     MOV  H B
     SHLD 
     RET
END-CODE
CODE LOADB >PRE
     LHLD 
     MOV  C L
     MOV  B H
     RET 
END-CODE
SCRATCH 

CODE WrSeq >PRE
@1:  CALL 0F80C
     DCR  B
     JNZ  @1
     RET
END-CODE

CODE Write ( end cnt_name start )
     CALL ' SAVEB
     LXI  B 60D1
     CALL  '  WrSeq
     LXI  B 6000
     CALL  ' WrSeq
     MVI  C 0E6
     CALL 0F80C
     LXI  B 5FF
     CALL ' WrSeq
     POP  D
     MVI  C 0E6
     CALL 0F80C
     MOV  C E
     CALL 0F80C
     MOV  C D
     CALL 0F80C
     POP  H
     PUSH D
     LXI  B 500
     CALL ' WrSeq
     MVI  C 0E6
     CALL 0F80C
     MOV  B M
     MOV  C B
     CALL 0F80C
     INX  H
@1:  MOV  C M
     CALL 0F80C
     INX  H
     DCR  B
     JNZ  @1
     POP  H
     POP  D
     PUSH H
     CALL 0F82A
     POP  H
     CALL 0F827
     CALL 0F82D
     CALL ' LOADB
NEXT;
: ZSAVE  ( end start | fname )
    BL WORD SWAP Write
;
CODE RdBS
     MVI  A 0FF
     JMP  0F806
END-CODE
CODE RdB
     MVI  A 08
     JMP  0F806
END-CODE

CODE RdHead ( fname -- start )
     CALL ' SAVEB
@2:  MVI  C 5
     MVI  A 0FF
@1:  CALL 0F806
     INR  A
     JNZ  @2
     DCR  C
     MVI  A 08
     JNZ  @1
     CALL ' RdBS
     MOV  E A
     CALL ' RdB
     MOV  D A
     POP  H
     PUSH D
     CALL ' RdBS
     MOV  C A
     INR  C
@1:  MOV  M A
     INX  H
     CALL ' RdB
     DCR  C
     JNZ  @1
     CALL 0F82D
     CALL ' LOADB
NEXT;
CODE RdBody ( offset -- status )
     CALL ' SAVEB
     POP  H
     CALL 0F824
     PUSH B
     CALL 0F82A
     POP  H
     MOV  A C
     SUB  L
     MOV  L A
     MOV  A B
     SUB  H
     MOV  H A
     PUSH H
     CALL ' LOADB
NEXT;
: .LOAD
  HERE RdHead U. HERE COUNT TYPE 0 RdBody
  0= IFNOT CR ." Tape error " THEN
;
: TLOAD ( fname start len type )
BEGIN
   2DUP 2DUP
   HERE RdHead HERE COUNT + ??? ROT ( offset flag fname )
   1+ HERE COUNT 2DUP TYPE ( offset flag fn1 fn2 len )
   IF

;S
MP  0F806
END-CODE
CODE RdB
     MVI  A 08
     JMP  0F806
END-CODE

CODE RdHead ( fname -- start )
     CALL ' SAVEB
@2:  MVI  C 5
     MVI  A 0FF
@1:  CALL 0F806
     INR  A
     JNZ  @2
     DCR  C
     MVI  A 08
     JNZ  @1
     CALL ' RdBS
     MOV  E A
     CALL ' RdB
     MOV  D A
     POP  H
     PUSH D
     CALL ' RdBS
     MOV  C A
     INR  C
@1:  MOV  M A
     INX  H
     CALL ' RdB
     DCR  C
     JNZ  @1
     CALL 0F82D
     CALL ' LOADB
NEXT;
CODE RdBody ( offset -- status )
     CALL ' SAVEB
     POP  H
     CALL 0F824
     PUSH B
     CALL 0F82A
     POP  H
     MOV  A C
     SUB  L
     MOV  L A
     MOV  A B
     SUB  H
     MOV  H A
     PUSH H
     CALL ' LOADB
NEXT;
: .LOAD
  HERE RdHead U. HERE COUNT TYPE 0 RdBody
  0= IFNOT CR ." Tape error " THEN
;
: TLOAD ( fname start len type )
BEGIN
   2DUP 2DUP
   HERE RdHead HERE COUNT + ??? ROT ( offset flag fname )
   1+ HERE COUNT 2DUP TYPE ( offset flag fn1 fn2 