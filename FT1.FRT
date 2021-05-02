--    fOPT-CiCTEMA                 13.10.86
HEX
DL: FORTH-DATA
--       BEKTOP AlxTEPHATiBHyX  ClOB
DL: UQUIT        2  ALLOT    -- 00
DL: UABORT       2  ALLOT    -- 02
DL: UINTERPRET   2  ALLOT    -- 04
DL: UFIND        2  ALLOT    -- 06
DL: UEXPECT      2  ALLOT    -- 08
DL: UTITLE       2  ALLOT    -- 0A
DL: UKEY         2  ALLOT    -- 0C
DL: UEMIT        2  ALLOT    -- 0E
DL: UCR          2  ALLOT    -- 10
DL: UTYPE        2  ALLOT    -- 12
DL: UCONSOLE     2  ALLOT    -- 14
DL: UWORD        2  ALLOT    -- 16
DL: UINIT        2  ALLOT    -- 18   -- iHiciAlizAciq
DL: EV
-- iHiciAlizAciq pPi zAgPuzKE
     BEG-ASM
--
              INITCOLD JMP    INITWARM JMP
 L:  INITCOLD  D FORTHF0 LXI  H FORTHDS LXI
              B 11 MVI
         1#:  D LDAX  M A MOV  H INX  D INX  B DCR
              1# JNZ
              B EV FORTH-DATA - MVI  H FORTH-DATA LXI
              A SUB
         2#: M A MOV  H INX  B DCR  2# JNZ
              RPF0 LHLD  R0CF SHLD
              SPF0 LHLD  S0CF SHLD  HF0 LHLD  HCF SHLD
              FENCEF0 LHLD  FENCECF SHLD
              VOC-LINKF0 LHLD     VOC-LINKCF SHLD
 L: INITWARM  S0CF LHLD  SPHL  R0CF LHLD  RPCF SHLD
              B RRESTART LXI  NEXTR JMP
   END-ASM
L: RRESTART ] UINIT @ ?DUP IF EXECUTE EXIT THEN
              CONSOLE TITLE
              TRUE WARNING ! DECIMAL QUIT [
--
 L: FORTHF0
   VOCABULARY FORTH
DL: R0CF        VARIABLE R0
DL: S0CF        VARIABLE S0
DL: RPCF        VARIABLE RP  -- uKAzATElx CTEKA BOzBPATOB
DL: HCF         VARIABLE H
DL: VOC-LINKCF  VARIABLE VOC-LINK
DL: FENCECF     VARIABLE FENCE
DL: W-LINKCF    VARIABLE W-LINK
VARIABLE BASE
VARIABLE STATE
VARIABLE CONTEXT
VARIABLE CURRENT
VARIABLE DPL
VARIABLE HLD
VARIABLE CSP
VARIABLE INB          -- AdPEC BBEdEHHOj CTPOKi
VARIABLE #TIB         -- dliHA BBEdEHHOj CTPOKi
VARIABLE >IN          -- uKAzATElx B BBEdEHHOj CTPOKE
VARIABLE OUTB         -- AdPEC ByBOdiMOj CTPOKi
VARIABLE #TOB         -- dliHA ByBOdiMOj CTPOKi
VARIABLE SPAN
VARIABLE >OUT         -- uKAzATElx B ByBOdiMOj CTPOKE
VARIABLE WARNING      -- TRUE - pE~ATx pPEdupPEvdEHij
VARIABLE GPTR         -- ukazatelx, ispolxzuemyj GETSYM
VARIABLE DMA          -- adres bufera dannyh pri diskowyh operaciqh
VARIABLE LEVEL        -- nomEr perwogo swobodnogo FCB
 DL:  FORTHDS 11  ALLOT
   FORTHDS 0F + [[ TVOC-LINK ! ]] -- *** dlq pzu ******
   FORTHDS ' R0 2- !              -- *** dlq pzu ******
 DL:  RSTCK  RSTCKLEN 4 +  ALLOT -- CTEK BOzBPATOB
  VARIABLE TIB   (TIBLEN)  ALLOT -- bufEP BBOdA
 DL:  DSTCK  DSTCKLEN 4 +  ALLOT -- APifMETi~ECKij CTEK
 L:   RPF0 RSTCK RSTCKLEN + ,
 L:   SPF0 DSTCK DSTCKLEN + ,
 L:   HF0 MAXDATA ,      -- HA~AlxHOE zHA~EHiE H
 L:   FENCEF0  MAXDATA , -- HA~AlxHOE zHA~EHiE FENCE
 L:   VOC-LINKF0 0 , -- HA~AlxHOE zHA~EHiE VOC-LINK
  CODE  COLD  INITCOLD JMP  END-CODE
--        AdPECHyj iHTEPpPETATOP
       BEG-ASM
 L:  CALLR  RPCF LHLD  H DCX  M B MOV  H DCX
              M C MOV  RPCF SHLD  B POP
 L:  NEXTR  B LDAX  L A MOV  B INX  B LDAX  H A MOV
              B INX  PCHL
       END-ASM
   NEXTR CONSTANT NEXT
   CALLR CONSTANT CALL
83CODE  EXIT
 L: EXITR   RPCF LHLD  C M MOV  H INX  B M MOV  H INX
            RPCF SHLD  NEXT JMP END-CODE
83CODE  EXECUTE RET  END-CODE
--     PSW1 HL1 DE1 BC1 ADDR --- PSW2 HL2 DE2 BC2
  CODE  ASMCALL RPCF LHLD  H DCX  M B MOV  H DCX
              M C MOV  RPCF SHLD  H POP  B POP
              D POP  XTHL  ASMCLH SHLD  H POP
              PSW POP  H PUSH  H 1# LXI
              XTHL  H PUSH  ASMCLH LHLD  RET
       1#:    PSW PUSH  H PUSH  D PUSH  B PUSH
              EXITR JMP END-CODE
 DL:  ASMCLH  2  ALLOT
83CODE  OVER  H POP  D POP  D PUSH  H PUSH  D PUSH
              NEXT JMP  END-CODE
83CODE  PICK  H POP  H DAD  SP DAD  E M MOV
              H INX  D M MOV  D PUSH  NEXT JMP
              END-CODE
83CODE  DROP  H POP  NEXT JMP  END-CODE
83CODE  SWAP  H POP  XTHL  H PUSH  NEXT JMP
              END-CODE
  CODE 2SWAP  H POP  D POP  XTHL  H PUSH  H 4 LXI  SP DAD
              A M MOV  M E MOV  E A MOV H INX  A M MOV
              M D MOV  D A MOV  H POP  D PUSH  H PUSH
              NEXT JMP  END-CODE
83CODE  ROT   D POP  H POP  XTHL  D PUSH  H PUSH
              NEXT JMP  END-CODE
  CODE  -ROT  H POP  D POP  XTHL  H PUSH  D PUSH
              NEXT JMP  END-CODE
83CODE  DUP   H POP  H PUSH  H PUSH  NEXT JMP
              END-CODE
83CODE  ?DUP  H POP  H PUSH  A H MOV  L ORA
              NEXT JZ  H PUSH  NEXT JMP  END-CODE
  CODE  2DUP  H POP  D POP  D PUSH  H PUSH  D PUSH
              H PUSH  NEXT JMP  END-CODE
  CODE  2DROP D POP  D POP  NEXT JMP  END-CODE
  CODE  PRESS H POP  XTHL  NEXT JMP  END-CODE
   CODE 2OVER H 7 LXI  SP DAD
              D M MOV  H DCX  E M MOV  H DCX  D PUSH
              D M MOV  H DCX  E M MOV  D PUSH
              NEXT JMP    END-CODE
  CODE  SP@   H 0 LXI  SP DAD  H PUSH  NEXT JMP
              END-CODE
  CODE  SP!   H POP  SPHL  NEXTR JMP  END-CODE
83CODE  +     H POP  D POP  D DAD  H PUSH  NEXT JMP
              END-CODE
83CODE  -     H POP  D POP  A E MOV  L SUB  L A MOV
              A D MOV  H SBB  H A MOV  H PUSH
              NEXT JMP  END-CODE
83CODE  NEGATE H POP  RNEGATE CALL  H PUSH  NEXT JMP
              END-CODE
83CODE  1+    H POP  H INX  H PUSH  NEXT JMP
              END-CODE
83CODE  2+    H POP  H INX  H INX  H PUSH  NEXT JMP
              END-CODE
83CODE  1-    H POP  H DCX  H PUSH  NEXT JMP
              END-CODE
83CODE  2-    H POP  H DCX  H DCX  H PUSH  NEXT JMP
              END-CODE
83CODE  2*    H POP  H DAD  H PUSH  NEXT JMP  END-CODE
83CODE  ABS   H POP  A H MOV  A ORA  RNEGATE CM
              H PUSH  NEXT JMP  END-CODE
83CODE  MIN   D POP  H POP  D PUSH  A H MOV
              D XRA  1# JP  D XRA  2# JMP
     1#:      A L MOV  E SUB  A H MOV  D SBB
     2#:      NEXT JP  XTHL  NEXT JMP  END-CODE
83CODE  MAX   H POP  D POP  D PUSH  A H MOV
              D XRA  1# JP  H XRA  2# JMP
     1#:      A E MOV  L SUB  A D MOV  H SBB
     2#:      NEXT JP  XTHL  NEXT JMP  END-CODE
83CODE U<     D POP  H POP
              A L MOV  E SUB  A H MOV  D SBB
              H -1 LXI  1# JC  H INX
     1#:      H PUSH  NEXT JMP  END-CODE
83CODE  <     H POP  D POP
 L:  RLESS    A H MOV  D XRA  1# JP  H 0 LXI
              D XRA  2# JM  3# JMP
     1#:      A E MOV  L SUB  A D MOV  H SBB
              H 0 LXI  2# JP
     3#:      H DCX
     2#:      H PUSH  NEXT JMP  END-CODE
83CODE  >     D POP  H POP  RLESS JMP  END-CODE
83CODE  0<    H POP  A H MOV  H 0 LXI  A ORA
              1# JP  H DCX
     1#:      H PUSH  NEXT JMP  END-CODE
83CODE  0>    D POP  H 0 LXI  A D MOV  A ORA
              1# JM  E ORA  1# JZ
              H DCX
     1#:      H PUSH  NEXT JMP  END-CODE
83CODE  =     H POP  D POP  A L MOV  E SUB  E A MOV
              A H MOV  D SBB  H 0 LXI  E ORA
              1# JNZ  H DCX
     1#:      H PUSH  NEXT JMP  END-CODE
83CODE  0=    H POP  A H MOV  D 0 LXI  L ORA
              1# JNZ  D DCX
     1#:      D PUSH  NEXT JMP  END-CODE
      BEG-ASM
 L:  RNEGATE  A H MOV  CMA  H A MOV  A L MOV
              CMA  L A MOV  H INX  RET
      END-ASM
  CODE -TRAILING
              D POP  A E  MOV  A ORA  2# JZ
              H POP H PUSH  D DAD
     1#:      H DCX  A M MOV  BL CPI  2# JNZ  E DCR
              1# JNZ
     2#:      D PUSH NEXT JMP END-CODE
83CODE 2/     H POP  A H MOV  A ADD  A H MOV  RAR
              H A MOV  A L MOV  RAR  L A MOV  H PUSH
              NEXT JMP END-CODE
83CODE D+     D POP  H POP  XTHL  D DAD  D POP  XTHL
              D DAD  XTHL  1# JNC  H INX
     1#:      H PUSH  NEXT JMP             END-CODE
83CODE D<     D POP  H POP  XTHL  A H MOV  D XRA
              1# JP  D 0 LXI  H XRA  H POP  H POP
              4# JM  3# JMP
     1#:      A L MOV  E SUB  L A MOV  A H MOV  D SBB
              H A MOV  D POP  XTHL  A L MOV  E SUB
              A H MOV  D SBB  H POP  2# JNC  H DCX
     2#:      A H MOV  D 0 LXI  A ORA  4# JP
     3#:      D DCX
     4#:      D PUSH  NEXT JMP  END-CODE
83CODE DNEGATE
              H POP  XTHL  D 0 MVI  A D MOV  L SUB  L A MOV
              A D MOV H SBB  H A MOV  XTHL  A D MOV  L SBB
              L A MOV  A D MOV  H SBB H A MOV  H PUSH
              NEXT JMP  END-CODE
 CODE -TEXT  -- A1 N1 A2 --- N2  ( N2 - PAzHOCTx
             --                    HECPABHiB{iXCq liTEP )
              H B MOV  L C MOV  D POP  B POP  XTHL  XCHG
              A B MOV  C ORA  2# JZ  A C MOV  A ORA
              1# JZ  B INR  ( KOPPEKciq dliHy )
     1#:      D LDAX  M SUB  2# JNZ  D INX  H INX
              C DCR  1# JNZ  B DCR  1# JNZ
     2#:      L A MOV  H 0 MVI  3# JNC  H DCR
     3#:      B POP  H PUSH  NEXT JMP END-CODE
83CODE ROLL   H POP  A H MOV  L ORA  NEXT JZ
              H DAD  XCHG  H 0 LXI  SP DAD
              D DAD  B PUSH  C M MOV  H INX
              B M MOV  B PUSH  B H MOV  C L MOV
              B DCX  B DCX
      1#:     B LDAX  M A MOV  B DCX  H DCX  D DCX
              A D MOV  E ORA  1# JNZ
              H POP  B POP  XTHL  NEXT JMP  END-CODE
83CODE  *     H B MOV  L C MOV  B POP  D POP
              H PUSH  H 0 LXI  A C MOV  C 8 MVI
              RMULTB CALL  A B MOV  C 8 MVI
              RMULTB CALL  B POP  H PUSH  NEXT JMP
 L:  RMULTB   RAR  1# JNC  D DAD
     1#:      XCHG  H DAD  XCHG  C DCR  RMULTB JNZ  RET
              END-CODE
83CODE  UM*   H POP  D POP  B PUSH  B D MOV
              C E MOV  UMMULT CALL  B POP
              D PUSH  H PUSH  NEXT JMP
 L:  UMMULT   A XRA  D A MOV  E A MOV
     1#:      H DAD  RAR  XCHG  H DAD  2# JNC  D INX
     2#:      RAL  3# JNC  B DAD  3# JNC  D INX
     3#:      XCHG  10  ADI  1# JNC  RET  END-CODE
  CODE  DU/MOD  H DLT 1+ LXI  A 4 MVI
     1#:      D POP
              M D MOV  H INX  M E MOV  H INX
              A DCR  1# JNZ  B PUSH  B 5 LXI
              H RES LXI  E 0A MVI  H PUSH  14# CALL
              B DAD  M A MOV
     2#:      11# CALL  B INR  E DCR  9# JZ
              0F0 ANI  2# JZ  B DCR  B PUSH
     3#:      H RES LXI  11# CALL
     4#:      H PDLT LXI  D PDLM LXI  D PUSH  B PUSH
              13# CALL  B POP  H POP  6# JC
              B PUSH  D PDLM 5 + LXI
     5#:      H DCX  D DCX  D LDAX  M SBB  D STAX
              C DCR  5# JNZ  H DCX  M INR
              B POP  4# JMP
     6#:      11# CALL  B DCR  3# JNZ
     7#:      H PDLT LXI  14# CALL  B POP  A 0C MVI
              C 0A MVI  B SUB  B A MOV
     8#:      11# CALL  B DCR  8# JNZ
     9#:      H POP  H RES 7 + LXI  B POP  A 4 MVI
    10#:      E M MOV  H DCX  D M MOV  H DCX  D PUSH
              A DCR  10# JNZ  NEXT JMP
    11#:      B PUSH  D PUSH  B 0 MVI  B DAD  XCHG
    12#:      D DCX  D LDAX  L A MOV  H 0 MVI
              H DAD  H DAD  H DAD  H DAD  A L MOV
              B ADD  D STAX  B H MOV  C DCR  12# JNZ
              XCHG  D POP  B POP  RET
    13#:      D LDAX  M CMP  H INX  D INX  RNZ
              C DCR  13# JNZ  RET
 DL:  RES   4  ALLOT
 DL:  PDLT  1  ALLOT
 DL:  DLT   4  ALLOT
 DL:  PDLM  5  ALLOT
     14#:     A XRA  H PUSH  B PUSH
     15#:     M A MOV  H INX  C DCR  15# JNZ
              B POP  H POP  RET  END-CODE
     BEG-ASM
 L:  RDEVIDE  A H MOV  L ORA  RZ  B 0 LXI  B PUSH
        1#:    A E MOV  L SUB  A D MOV  H SBB
              2# JC  H PUSH  H DAD  1# JNC
        2#:    H 0 LXI
        3#:    B POP  A B MOV  C ORA  RZ  H DAD
              D PUSH  A E MOV  C SUB  E A MOV
              A D MOV  B SBB  D A MOV  4# JC
              H INX  B POP  3# JMP
        4#:    D POP  3# JMP
     END-ASM
83CODE /MOD    H POP  D POP  B PUSH  A H MOV
               D XRA  A H MOV  PSW PUSH ( zHAKi )
               A ORA  RNEGATE CM  H PUSH ( ABS dEliTElx )
               A D MOV  A ORA  XCHG  RNEGATE CM  XCHG
               RDEVIDE CALL  B POP  A D MOV  E ORA
               1# JNZ  ( OCTATOK = 0 )
               PSW POP  RNEGATE CM  B POP
               D PUSH  ( OCTATOK ) H PUSH ( ~ACTHOE )
               NEXT JMP
      1#:      ( OCTATOK HE HOlx )  PSW POP  PSW PUSH
               2# JP  H INX  RNEGATE CALL
               A C MOV  E SUB  E A MOV  A B MOV
               D SBB  D A MOV
      2#:      PSW POP  A ORA  XCHG  RNEGATE CM
               B POP  H PUSH ( OCTATOK ) D PUSH ( ~ACTHOE )
               NEXT JMP                END-CODE
  CODE U/MOD   H POP  D POP  B PUSH
               RDEVIDE CALL  B POP  D PUSH
               H PUSH  NEXT JMP   END-CODE
      REF!
;J
