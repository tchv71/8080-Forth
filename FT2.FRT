ווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווווUSH  D LDAX
             C A MOV  D INX  7# JMP
        1#:  A M MOV  7F ANI  H INX  ( A&3F=dlina_o~eredn._slowa)
             C CMP    6# JNZ  A ANA  2# JNZ  H DCX  4# JMP
        2#:  B C MOV  D PUSH
        3#:  D LDAX   M CMP   5# JNZ  H INX  D INX  B DCR  3# JNZ
             D POP    A -1 MVI  B A MOV  C SUB  C A MOV  B DAD
        4#:  ( HL-NFA najdennogo slowa)  XCHG   H -1 LXI   8# JMP
        5#:  D POP ( adr. 1-go simw. |tal. stroki)   A B MOV
        6#:  3F ANI  L ADD  L A MOV  A H MOV  0 ACI  H A MOV
        7#:  W-LINKCF SHLD  A M MOV  H INX  H M MOV  L A MOV
             H ORA  1# JNZ  D DCX  ( DE-adres stroki)
        8#:  B POP  D PUSH  H PUSH  NEXT JMP  END-CODE
 CODE DIGIT     -- C BASE --- N TRUE / FALSE
               D POP  H POP  A L MOV
               C" 0 CPI  3# JC
               C" 9 1+ CPI 2# JNC  C" 0 SUI
     1#:       E CMP  3# JNC
               L A MOV  H PUSH  H -1 LXI
               H PUSH  NEXT JMP
     2#:       C" A CPI  3# JC  C" A SUI
               0A ADI  1# JMP
     3#:       H 0 LXI  H PUSH  NEXT JMP   END-CODE
83CODE  AND    H POP  D POP  A E MOV  L ANA  L A MOV
               A D MOV  H ANA  H A MOV  H PUSH
               NEXT JMP  END-CODE
83CODE  OR     H POP  D POP  A E MOV  L ORA  L A MOV
               A D MOV  H ORA  H A MOV  H PUSH
               NEXT JMP  END-CODE
83CODE  XOR    H POP  D POP  A E MOV  L XRA  L A MOV
               A D MOV  H XRA  H A MOV  H PUSH
               NEXT JMP  END-CODE
83CODE  NOT    H POP  A H MOV  CMA  H A MOV  A L MOV
              CMA  L A MOV  H PUSH  NEXT JMP
              END-CODE
83CODE  >R    D POP  RPCF LHLD  H DCX  M D MOV
              H DCX  M E MOV  RPCF SHLD  NEXT JMP
              END-CODE
83CODE  R>    RPCF LHLD  E M MOV  H INX  D M MOV
              H INX  D PUSH  RPCF SHLD  NEXT JMP
              END-CODE
83CODE  R@    RPCF LHLD  E M MOV  H INX  D M MOV
              D PUSH  NEXT JMP  END-CODE
  CODE  RP@   RPCF LHLD  H PUSH  NEXT JMP  END-CODE
  CODE  RP!   H POP  RPCF SHLD  NEXT JMP  END-CODE
  CODE  RPICK H POP  H DAD  XCHG  RPCF LHLD  D DAD
              E M MOV  H INX  D M MOV  D PUSH
              NEXT JMP  END-CODE
  CODE  RDROP RPCF LHLD  H INX  H INX  RPCF SHLD
              NEXT JMP  END-CODE
83CODE  @     H POP  E M MOV  H INX  D M MOV
              D PUSH  NEXT JMP  END-CODE
83CODE  C@    H POP  E M MOV  D 0 MVI  D PUSH
              NEXT JMP  END-CODE
83CODE  !     H POP  D POP  M E MOV  H INX  M D MOV
              NEXT JMP  END-CODE
83CODE  C!    H POP  D POP  M E MOV  NEXT JMP
              END-CODE
  CODE  2!    H POP  D POP  M E MOV  H INX
              M D MOV  H INX  D POP  M E MOV
              H INX  M D MOV  NEXT JMP END-CODE
  CODE  2@    H POP  E M MOV  H INX  D M MOV
              H INX  A M MOV  H INX  H M MOV
              L A MOV  H PUSH  D PUSH
              NEXT JMP  END-CODE
83CODE  +!    H POP  D POP  A M MOV  E ADD
              M A MOV  H INX  A M MOV  D ADC
              M A MOV  NEXT JMP  END-CODE
  CODE  -!    H POP  D POP  A M MOV  E SUB
              M A MOV  H INX  A M MOV  D SBB
              M A MOV  NEXT JMP  END-CODE
  CODE  0!    A SUB  H POP  M A MOV  H INX  M A MOV
              NEXT JMP  END-CODE
  CODE  1+!   H POP  M INR  NEXT JNZ
              H INX  M INR  NEXT JMP  END-CODE
  CODE  1-!   H POP  E M MOV  H INX  D M MOV
              D DCX  M D MOV  H DCX  M E MOV
              NEXT JMP  END-CODE
  CODE  LIT   B LDAX  L A MOV  B INX  B LDAX
              H A MOV  B INX  H PUSH  NEXT JMP
              END-CODE
  CODE  DLIT  B LDAX  E A MOV  B INX  B LDAX  D A MOV
              B INX  B LDAX  L A MOV  B INX  B LDAX
              H A MOV  B INX  H PUSH  D PUSH
              NEXT JMP     END-CODE
  CODE  (")   B PUSH  B LDAX  L A MOV  H 0 MVI
              H INX  B DAD  B H MOV  C L MOV
              NEXT JMP  END-CODE
  CODE  BRANCH
  L: BRANC1   H B MOV  L C MOV  C M MOV  H INX
              B M MOV  NEXT JMP  END-CODE
  CODE  ?BRANCH D POP  A D MOV  E ORA  BRANC1 JZ
              B INX  B INX  NEXT JMP  END-CODE
  CODE  N?BRANCH D POP  A D MOV  E ORA BRANC1 JNZ
              B INX  B INX  NEXT JMP  END-CODE
83CODE  I     RPCF LHLD  E M MOV  H INX  D M MOV
              D PUSH  NEXT JMP  END-CODE
83CODE  J     RPCF LHLD  D 6 LXI  D DAD  E M MOV
              H INX  D M MOV  D PUSH  NEXT JMP
              END-CODE
  CODE  K     RPCF LHLD  D 0C LXI  D DAD  E M MOV
              H INX  D M MOV  D PUSH  NEXT JMP
              END-CODE
  CODE  TOGGLE D POP  A E MOV  H POP  M XRA
              M A MOV  NEXT JMP  END-CODE
  CODE (DO)
--        I' I -> / ADDR I' I  HA CTEKE BOzBPATOB
 L: R(DO)      H POP  XTHL  H PUSH  RPCF LHLD
               B LDAX  D A MOV  B INX  B LDAX
               B INX  H DCX  M A MOV  H DCX  M D MOV ( ADDR)
               D POP  H DCX  M D MOV  H DCX  M E MOV ( I' )
               D POP  H DCX  M D MOV  H DCX  M E MOV ( I  )
               RPCF SHLD  NEXT JMP           END-CODE
  CODE (?DO)   H POP  D POP  D PUSH  H PUSH  A L MOV  E CMP
               R(DO)  JNZ  A H MOV  D CMP  R(DO) JNZ
               B LDAX  D A MOV  B INX  B LDAX  B A MOV
               C D MOV  H POP  H POP  NEXT JMP    END-CODE
  CODE (LOOP)  RPCF LHLD  E M MOV  H INX  D M MOV
               H INX  D INX
 L: R(LOOP)    A M MOV  H INX  E CMP  1# JNZ
               A M MOV  D CMP  1# JNZ
               H INX  H INX  H INX  RPCF SHLD
               B INX  B INX  NEXT JMP
     1#:       H DCX  H DCX  M D MOV  H DCX  M E MOV
               H B MOV  L C MOV  C M MOV  H INX  B M MOV
               NEXT JMP                      END-CODE
  CODE (+LOOP)  H POP  B PUSH  XCHG  RPCF LHLD
               C M MOV  H INX  B M MOV  H INX
               XCHG  B DAD  XCHG  B POP  R(LOOP) JMP
               END-CODE
83CODE  CMOVE  H B MOV  L C MOV  B POP  D POP
               XTHL  A C MOV  B ORA  2# JZ
 L:  CMOVEBEG  A C MOV  A ORA  1# JZ  B INR
     1#:       A M MOV  D STAX  H INX  D INX
               C DCR  1# JNZ  B DCR  1# JNZ
     2#:       B POP  NEXT JMP  END-CODE
83CODE  CMOVE> H B MOV  L C MOV  B POP  D POP
              XTHL  A C MOV  B ORA  2# JZ
 L:  LCMOVEB  B DAD  XCHG  B DAD  A C MOV  A ORA
              1# JZ  B INR
     1#:      H DCX  D DCX  D LDAX  M A MOV
              C DCR  1# JNZ  B DCR  1# JNZ
              B POP  NEXT JMP
     2#:      B POP  NEXT JMP  END-CODE
  CODE  <CMOVE> H B MOV  L C MOV  B POP  D POP
              XTHL  A C MOV  B ORA  1# JZ
              A L MOV  E SUB  A H MOV  D SBB
              CMOVEBEG JNC  LCMOVEB JMP
     1#:      B POP  NEXT JMP  END-CODE
83CODE  FILL  D POP  H POP  A H MOV  L ORA  1# JNZ
              H POP  NEXT JMP
     1#:      A E MOV  D POP  H DCX  B PUSH  B -1 LXI
     2#:      D STAX  D INX  B DAD  2# JC
              B POP  NEXT JMP  END-CODE
--  C ADR1 LEN1 --- ADR2 LEN2 ADR3 TRUE / FALSE
  CODE ENCLOSE   H B MOV  L C MOV  B POP D POP
              XTHL  XCHG  ( E - CiMBOl-OgPAHi~iTElx )
              B DCX
     1#:      A B MOV  A ORA  4# JM
              A M MOV  E CMP  B DCX  H INX  1# JZ
              H PUSH
     2#:      A B MOV  A ORA  3# JM
              A M MOV  E CMP  B DCX  H INX  2# JNZ
              H DCX
 3#: ( TRUE )  D POP  D DCX  B POP  D PUSH  H PUSH
              A L MOV  E SUB  L A MOV  A H MOV  D SBB
              H A MOV  XTHL  H INX  H PUSH
              H -1 LXI  H PUSH  NEXT JMP
 4#: ( FALSE ) B POP  H 0 LXI  H PUSH  NEXT JMP  END-CODE
 REF!
--
;J
