( Allow multiple line comments in files. )
( Based on COMMENT.SEQ by Tom Zimmer     )
HEX
VARIABLE $
>PRE
CODE  COMP
     MOV  L C
     MOV  H B
     POP  D
     POP  B
     XTHL
     MOV  A E
     ORA  D
     0= NOT IF
        LDAX B
        CMP  M
        INX  H
        INX  B
        DCX  D
        JZ   HERE 0A -
        0< IF
           LXI  D 1
        ELSE
           LXI  D -1
        THEN
      THEN
      POP  B
      PUSH D
      NEXT;
: ?LOADING
   BLK @ 0=
   ABORT" should ONLY be used while loading"
;
: ">$ DROP 1- ;
: \ ?LOADING INB @ >IN @ + 0D0D HELEN
             >IN +!
; IMMEDIATE
: <COMMENT:>
     BEGIN
       BL WORD         1+ $ @ COUNT COMP
       0= IF   EXIT         THEN
     AGAIN
;
: /*
        " */" $ !       <COMMENT:>
;
: COMMENT: [COMPILE] \
           " COMMENT;" $ ! <COMMENT:>
;
: <#IF> ?LOADING BEGIN
            BL WORD 1+ DUP " #ELSE" COUNT COMP 0=
   SWAP " #ENDIF" COUNT COMP 0= OR
   IF             EXIT THEN
  AGAIN
;
: #IF ?EXEC IFNOT <#IF> THEN ; IMMEDIATE
: #ELSE ?EXEC <#IF> ; IMMEDIATE
: #ENDIF ; IMMEDIATE
SCRATCH $
;S


E  COMP
     MOV  L C
     MOV  H B
     POP  D
     POP  B
     XTHL
     MOV  A E
     ORA  D
     0= NOT IF
        LDAX B
        CMP  M
        INX  H
        INX  B
        DCX  D
        JZ   HERE 0A -
        0< IF
           LXI  D 1
        ELSE
           LXI  D -1
        THEN
      THEN
      POP  B
      PUSH D
      NEXT;
: ?LOADING
   BLK @ 0=
   ABORT" should ONLY be used while loading"
;
: ">$ DROP 1- ;
: \ ?LOADING INB @ >IN @ + 0D0D HELEN
             >IN +!
; IMMEDIATE
: <COMMENT:>
     BEGIN
       BL WORD         1+ $ @ COUNT COMP
       0= IF   EXIT         THEN
     AGAIN
;
: /*
        " */" $ !       <COMMENT:>
;
: COMMENT: [COMPILE] \
           " COMMENT;" $ ! <COMMENT:>
;
: <#IF> ?LOADING BEGIN
            BL WORD 1+ DUP " #ELSE" COUNT COMP 0=
   SWAP " #ENDIF" COUNT COMP 0= OR
   IF             EXIT THEN
  AGAIN
;
: #