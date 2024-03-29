HEX
VARIABLE OUT   VARIABLE OUT_BUF
A000 CONSTANT BUF_BEG DFFF CONSTANT BUF_END
: OUT_ON OUT_BUF @ BUF_BEG U< IF BUF_BEG OUT_BUF !
  THEN TRUE OUT ! ;
: OUT_OFF FALSE OUT ! FF OUT_BUF @ C! ;
: OUT? OUT_BUF @ BUF_END U< ;
: ?EMIT OUT @ IF
              OUT? IF DUP OUT_BUF @ C! OUT_BUF 1+!
                   ELSE CR ." Buffer full" OUT_OFF
                   THEN
              THEN EMIT ;
: ?CR D ?EMIT A EMIT ;
: ?TAB 8 E602 C@ 8 MOD - SPACES OUT @ OUT? AND IF
  9 OUT_BUF @ C! OUT_BUF 1+! THEN ;
: ?TYPE 0 DO DUP C@ ?EMIT 1+ LOOP DROP ;
: (?") R@ COUNT DUP 1+ R> + >R ?TYPE ;
: ?" ?COMP COMPILE (?") 22 WORD ", ; IMMEDIATE
: (A.) HEX 0 DUP >R DABS <# #S R> SIGN #> ?TYPE ;
: A. ?" 0" (A.) ?" H" ;
VOCABULARY DASM  DASM DEFINITIONS
: AP 27 ?EMIT ;       : CO 2C ?EMIT ;
: (REG) ." BCDEHLMA" ;
: (RP)  ." BDH " ; ( !!! )
: REG 7 AND ['] (REG) + 6 + C@ ?EMIT ;
: RP1 3 AND ['] (RP)  + 6 + C@ ?DUP IF ?EMIT ELSE
      ?" SP" THEN ;
: RP2 3 AND ['] (RP)  + 6 + C@ ?DUP IF ?EMIT ELSE
      ?" PSW" THEN ;
: (COND) ." NZ Z  NC C  PO PE P  M  " ;
: (WOP)  ." RLCRRCRALRARDAACMASTCCMC" ;
: (LOI)  ." ADIACISUISBIANIXRIORICPI" ;
: (LOR)  ." ADDADCSUBSBBANAXRAORACMP" ;
: 3TYPE SWAP 3 * + 6 + 3 ?TYPE ;
: COND 7 AND ['] (COND) 3TYPE ;
: WOP  7 AND ['] (WOP)  3TYPE ;
: LOI  7 AND ['] (LOI)  3TYPE ;
: LOR  7 AND ['] (LOR)  3TYPE ;
: ?MVI C7 AND  6 = ;    : ?LOI C7 AND C6 = ;
: ?LOR C0 AND 80 = ;    : ?WOP C7 AND  7 = ;
: ?C-C C7 AND C4 = ;    : ?J-C C7 AND C2 = ;
: ?RST C7 AND C7 = ;    : ?LXI CF AND  1 = ;
: ?POP CF AND C1 = ;    : ?DAD CF AND  9 = ;
: ?PSH CF AND C5 = ;    : ?INX CF AND  3 = ;
: ?INR C7 AND  4 = ;    : ?DCX CF AND  B = ;
: ?DCR C7 AND  5 = ;    : ?STX EF AND  2 = ;
: ?LDX EF AND  A = ;    : ?R-C C7 AND C0 = ;
: ?EI  FB = ;    : ?DI  F3 = ;    : ?CALL CD = ;
: ?IN  DB = ;    : ?OUT D3 = ;    : ?XTHL E3 = ;
: ?HLT 76 = ;    : ?RET C9 = ;    : ?PCHL E9 = ;
: ?NOP 0=   ;    : ?JMP C3 = ;    : ?SPHL F9 = ;
: ?STA 32 = ;    : ?LDA 3A = ;    : ?XCHG EB = ;
: ?LHL 2A = ;    : ?SHL 22 = ;
FORTH DEFINITIONS ;S
O PE P  M  " ;
: (WOP)  ." RLCRRCRALRARDAACMASTCCMC" ;
: (LOI)  ." ADIACISUISBIANIXRIORICPI" ;
: (LOR)  ." ADDADCSUBSBBANAXRAORACMP" ;
: 3TYPE SWAP 3 * + 6 + 3 ?TYPE ;
: COND 7 AND ['] (COND) 3TYPE ;
: WOP  7 AND ['] (WOP)  3TYPE ;
: LOI  7 AND ['] (LOI)  3TYPE ;
: LOR  7 AND ['] (LOR)  3TYPE ;
: ?MVI C7 AND  6 = ;    : ?LOI C7 AND C6 = ;
: ?LOR C0 AND 80 = ;    : ?WOP C7 AND  7 = ;
: ?C-C C7 AND C4 = ;    : ?J-C C7 AND C2 = ;
: ?RST C7 AND C7 = ;    : ?LXI CF AND  1 = ;
: ?POP CF AND C1 = ;    : ?DAD CF AND  9 = ;
: ?PSH CF AND C5 = ;    : ?INX CF AND  3 = ;
: ?INR C7 AND  4 = ;    : ?DCX CF AND  B = ;
: ?DCR C7 AND  5 = ;    : ?STX EF AND  2 = ;
: ?LDX EF AND  A = ;    : ?R-C C7 AND C0 = ;
: ?EI  FB = ;    : ?DI  F3 = ;    : ?CALL CD = ;
: ?IN  DB = ;    : ?OUT D3 = ;    : ?XTHL E3 = ;
: ?HLT 76 = ;    : ?RET C9 = ;    : ?PCHL E9 = ;
: ?NOP 0=   ;    : ?JMP C3 = ;    : ?SPHL F9 = ;
: ?STA 32 = ;    : ?LDA 3A = ;    : ?XCHG EB = ;
: ?LHL 2A = ;    : ?SHL