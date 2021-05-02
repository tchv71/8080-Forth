HEX     ( 08/02/91 FA )
ASSEMBLER DEFINITIONS
VARIABLE COM  2 ALLOT
VARIABLE PA80
10 CONSTANT LBLMAX
VARIABLE LTABLE LBLMAX 2* 2* ALLOT
: I::  R> COM ! ;
: INITPA80   I:: DROP ;
: CDOCOM [ FORTH ]
    PA80 @ IF COM @ >R COM 2+ @ INITPA80 THEN
;
: C::
     [ FORTH ]
     >R PA80 @
     IF
        >R CDOCOM R> R> COM  !
        COM 2+ !
     THEN
;
: (NOT) HERE 1- 8 SWAP +! ;
: GLO >R CDOCOM ;
: >PRE -1 PA80 ! INITPA80 ; IMMEDIATE
: PRE> CDOCOM PA80 0! ; IMMEDIATE
: C>>   CD OVER C! 1+ ! ;
: C>>> ( cfasrc cfatag -- ) 1+ @
           C>>
;
: CLRLOC LTABLE LBLMAX 2* ERASE ;
: (CODE) >R INITPA80 CLRLOC ;
: R8SC+ ROT [ ASSEMBLER ] 8* [ FORTH ] SWAP C@ + ;
: B:: ( pfa ) R> ( pfa nextcfa ) C:: ;
FORTH DEFINITIONS
: NOOP ;
: SNOOP ['] NOOP SWAP ! ;
ASSEMBLER DEFINITIONS
' IF 3 + SNOOP
' UNTIL DUP 3 + SNOOP 9 + SNOOP
' (NOT) >>> NOT
: 1MIP CREATE C, DOES> >R CDOCOM R> C@ C, ;
: 6MI CREATE C, DOES> B:: R8SC+ + C, ;
: 7MI CREATE C, DOES> B:: R8SC+ C, C, ;
: 8MI CREATE C, DOES> B:: R8SC+ C, , ;
  SCRATCH MOV    40 6MI MOV
  SCRATCH MVI     6 7MI MVI
  SCRATCH LXI     1 8MI LXI
  SCRATCH ELSE
  SCRATCH 0=      C2 1MIP 0=
  SCRATCH NEXT;
: ,JMP C3 C, ;
: NEXT; CDOCOM ,JMP NEXT , [COMPILE] END-CODE ;
: A>MARK HERE 0 , ;
: A>RESOLVE HERE SWAP ! ;
: A<RESOLVE , ;
: ELSE CDOCOM 2 ?PAIRS ,JMP  A>MARK SWAP A>RESOLVE 2 ;
SCRATCH REPEAT
: REPEAT  CDOCOM 2SWAP ,JMP UNTIL 4 ?PAIRS A<RESOLVE ;

FORTH DEFINITIONS
: STUFF     [ ASSEMBLER ]
        ['] C:: DUP ['] NOP C>>>   DUP   ['] ADD
        C>>>  DUP [']  ADI C>>>        DUP   ['] DAD C>>>
        ['] SHLD C>>>
        ['] GLO DUP  ['] THEN C>>  DUP  ['] BEGIN C>>
                DUP  ['] AGAIN C>>      ['] END-CODE C>>
        ['] (CODE)  DUP ['] CODE C>>    ['] ;CODE C>>
   ['] 0=  1+ @ ( DUP  ['] 0= C>> )  DUP  ['] CS    C>>
                DUP  ['] PE C>>         ['] 0<    C>>

[COMPILE]  >PRE
;  FORTH
HEX
ASSEMBLER DEFINITIONS FORTH
: ON -1 SWAP ! ;
: :RESOLVE ( addr val -- ) [ FORTH ]
  SWAP  ( v a )
  BEGIN
    2DUP ( v a v a ) @ 2SWAP !
    ?DUP  0=
  UNTIL DROP
;
: !LT
      2* 2* LTABLE + CREATE ,
      DOES> [ FORTH ]
       >R CDOCOM R> @
       DUP 2+ DUP @ SWAP ON
       IF HERE SWAP !
       ELSE
        HERE :RESOLVE
       THEN
;
: @LT
   [ FORTH ]  2*  2*
   LTABLE + CREATE , DOES> @ DUP @ SWAP DUP 2+
      @ IF
        DROP
      ELSE
        HERE 1+ SWAP !
      THEN
;
: CLRALL  LTABLE LBLMAX 2* 2* ERASE ;
: CLRLBL  ' >BODY @ DUP 0! 2+ 0! ;
CR .( Create local labels )
CLRALL
0 !LT @1:  0 @LT @1
1 !LT @2:  1 @LT @2
2 !LT @3:  2 @LT @3
3 !LT @4:  3 @LT @4
4 !LT @5:  4 @LT @5
5 !LT @6:  5 @LT @6
6 !LT @7:  6 @LT @7
7 !LT @8:  7 @LT @8
FORTH DEFINITIONS
;S
>
        ['] (CODE)  DUP ['] CODE C>>    ['] ;CODE C>>
   ['] 0=  1+ @ ( DUP  ['] 0= C>> )  DUP  ['] CS    C>>
                DUP  ['] PE C>>         ['] 0<    C>>

[COMPILE]  >PRE
;  FORTH
HEX
ASSEMBLER DEFINITIONS FORTH
: ON -1 SWAP ! ;
: :RESOLVE ( addr val -- ) [ FORTH ]
  SWAP  ( v a )
  BEG