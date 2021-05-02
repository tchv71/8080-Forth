HEX : Q 3B70 0DFE OVER ! 2+ 77C2 OVER ! 2+ 3E3B OVER !
2+ BB20 OVER ! 2+ 230B OVER ! 2+ C9 SWAP C! 3AF5 70CD
OVER ! 2+ 3B SWAP C! 3B02 70CD OVER ! 2+ 3B SWAP C! ;

(	 Stack: StartAddress,Code -> Length
     Computes the number of bytes between
  StartAddress and address contained Code )

CODE HELEN >PRE
  LXI  D 0
  POP  PSW
  POP  H
  PUSH B
  MOV  C A
  BEGIN
    MOV A M
    CMP C
    INX H
    INX D
    0=
  UNTIL
  POP  B
  PUSH D
  NEXT;

CODE %!>  >PRE
   LDAX B
   MOV  L A
   INX  B
   LDAX B
   MOV  H A
   INX  B
   INX  H
   INX  H
   INX  H
   POP  D
   MOV  M E
   INX  H
   MOV  M D
   NEXT;

: (BLOCK) DROP 9000 ;
: FLD 0 (BLOCK) -1  HELEN  %!> B/BUF 1 LOAD ;
: >>>     ' C3 OVER C! 1+  ! ;   ;S  07/30/91  V1.1


: (BLOCK) DROP 9000 ;
: FLD 0 (BLOCK) -1  HELEN  %!> B/BUF 1 LOAD ;
: >>>     ' C3 OVER C! 1+  ! ;   ;S  07/30/91 