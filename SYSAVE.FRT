( 06/26/91 )
HEX CODE (SYSAVE) D POP   H POP   B PUSH
                  B H MOV C H MOV H 0 LXI
                  SP DAD  SP E6CF LXI  B PUSH
                  XTHL
                  H PUSH  F82A CALL  H POP
                  F827 CALL  H POP   SPHL
                  B POP  NEXT;
: SYSAVE F-CODE HERE (SYSAVE) ;
;S
R ELSE DROP THEN
        THEN
; SMUDGE
: CREFON  [']  ((FIND))   (;FIND) ! ;
: CREF. (;FIND) @ ." Cref " IF ." ON" ELSE ." OFF"
        THEN CR 
;
;S

L3D82
	DW	DNEGATE
L3D82:	DW	EXIT
L3D84:	DB	02H,'U/'
	DW	L3D6E
U/:
	CALL	L3195
	DW	U/MOD,PRESS,EXIT
L3D92:	DB	06H,'UM/MOD'
	DW	L3D84
UM/MOD:
	CALL	L3195
	DW	0,DU/MOD,DROP
	DW	PRESS
	DW	EXIT
L3DA8:	DB	05H,'M/MOD'
	DW	L3D92
M/MOD:
	CALL	L3195
	DW	?DUP,?BRANCH
	DW C<D��<D
 
  C C C C  P,�>N�  C9D��`� 
 C C  UM/M�	D}��>,0<,?BR�CH
	DW	��DD9
	DW	NEGATE
L3DD9:	DW	SWAP
	DW;SYSAVE F-CODE HERE (SYSAVE) ;OP   SPHLSHANCH
	DW	L3DF5
	DW	1-,R@,ROT,-,SWAP
L3DF5:	DW	RDROP,EXIT
L3DF9:	DB	05H,'*/MOD'
	