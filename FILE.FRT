-- *******************************************************************
--                   rabota s diskEtnymi fajlami
-- *******************************************************************
HEX
5C CONSTANT FCB0
   VARIABLE FCB1  A2 ALLOT
: DMA!  DUP DMA ! 1A FDOS 2DROP ;
: FCB   LEVEL @ >DIG HERE 4604 OVER ! 2+ 4243 OVER ! 2+ !
        HERE FIND 0= ABORT" ne najden" EXECUTE ;
--
-- preobrazowatx stroku w FCB --    stroka2 stroka1 FCB --> flag
-- DE - ukazat. wo whodnoj stroke
-- B  - rabo~ij, s~et~ik
-- s  - s~et~ik simwolow wo whodnoj stroke
-- HL - ukazatelx w FCB
CODE ?FNAME H POP   D POP   B PUSH   D LDAX   C A MOV   D INX
           2 CPI   A 0 MVI   1# JC   D INX   D LDAX   D DCX   C" : CPI
           A 0 MVI   1# JNZ   D LDAX   D INX   D INX   C DCR   C DCR
           C" A SUI   4 CPI   6# JNC   A INR
1#:        M A MOV   H INX   B 9 MVI
2#:        D LDAX   D INX   C" . CPI   4# JZ   M A MOV   H INX
           C DCR   6# JM   3# JZ
           B DCR   2# JNZ   6# JMP
3#:        B DCR   6# JZ   11# CALL
           B POP   D POP   D PUSH   B PUSH   B 3 MVI   D LDAX   C A MOV
           A D MOV   E ORA   D INX   5# JNZ   7# JMP
4#:        11# CALL   C DCR  B 3 MVI
5#:        D LDAX   D INX   C DCR   7# JM   M A MOV   H INX
           8# JZ   B DCR   5# JNZ
6#:    ( o{ibka) H 0 LXI   10# JMP
7#:        B INR
8#:    ( uspe{no) 11# CALL   A 4 MVI
9#:        M 0 MVI  H INX  A DCR   9# JNZ   H -1 LXI
10#:        B POP   XTHL   NEXT JMP
11#:       B DCR   RZ   M BL MVI   H INX   11# JMP     END-CODE
--
: FSET  -- FCB stroka2 --> FCB
        OVER BL WORD SWAP ?FNAME 0= ABORT" plohoe imq fajla" ;
: PNAME DUP C@ ?DUP IFNOT 0 19 FDOS DROP 1+ THEN
        40 + EMIT C" : EMIT
        DUP 1+ 8 TYPE C" . EMIT 9 + 3 TYPE ;
: ?FERR 0FF = IF FCB PNAME ."   ne najden" ABORT THEN ;
: DIR   DMA @ BASE @ DECIMAL FCB >R -- nape~atatx oglawlenie diska
        0 " ????????.???" R@ ?FNAME DROP C" ? 0C R@ + C!
        R@ 24 + DMA! 11 BEGIN
          R@ SWAP FDOS DROP   DUP 4 U< WHILE
          20 * 80 + DUP PNAME DUP 0C + C@ 10 * SWAP 0F + C@ 7 +
          8 U/ +   8 .R  C" K EMIT  CR   12 REPEAT RDROP DROP BASE ! DMA! ;
: ?OPEN 0F FDOS PRESS   ; -- FCB --> flag o{ibki
: &ERA  13 FDOS PRESS ?FERR ;  -- FCB -->       -- udalitx fajl
: ERA   FCB 0 FSET &ERA ; -- udalitx ukazannyj fajl s diska
: REN   FCB DUP 10 + 0 FSET DROP        -- pereimenowatx fajl
        0 FSET 17 FDOS PRESS ?FERR ;
: A:    0 0E FDOS 2DROP ; -- wybratx disk a
: B:    1 0E FDOS 2DROP ; -- wybratx disk B
: RESET 0 0D FDOS 2DROP ; -- sbros sistemy (smena diskow)
: &READ --   A1 FCB --> A2   --   pro~. fajl w ozu, FCB ustanowlen
        DMA @ >R DUP ?OPEN ?FERR DUP 20 + 4 ERASE SWAP BEGIN -- FCB A1
          DUP DMA! OVER 14 FDOS PRESS 0= WHILE -- FCB A1'
          80 + REPEAT PRESS R> DMA! ;
: READ  FCB 0 FSET &READ U. CR ;
: &MAKE 16 FDOS PRESS 0FF = IF FCB PNAME ."   oglawlenie perepolneno"
        ABORT THEN ;
: &WRITE --   a1 N FCB -->     -- zapisatx N bajt, na~. s a1 na disk
        DMA @ >R DUP >R ?OPEN 0FF <> IF R@ PNAME ."    uve estx, steretx?  -"
          KEY DUP EMIT C" Y <> IF ABORT THEN CR R@ &ERA THEN  -- A1 N
    ееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееее   ABORT" net mesta na diske" 80 + LOOP R> 10 FDOS 2DROP -- A1'
        DROP R> DMA! ;
: WRITE FCB 0 FSET &WRITE ; -- Adr. dlina -->   -- zapisatx fajl
: SAVE  1 F-CODE C! ( wmesto JMP budet LXI B)
        F-CODE HERE OVER - FCB " COM" FSET &WRITE ;
--
--             zagruzka disketnyh fajlow
--
: GETSYM  -- polu~enie odnogo simwola iz disketnogo fajla --   --> C
           GPTR @ 23 + DUP C@ 80 =
           IF GPTR @ 14 FDOS PRESS ABORT" konec fajla" 0 GPTR @ 23 + C! THEN
           DUP  1+! DUP C@ + C@ ;
: GETLINE  #TIB 0! >IN 0! TIB INB !
           50 0 DO GETSYM DUP 0D = IF DROP LEAVE THEN
           DUP 0A = IF DROP 0 ELSE I TIB + C! #TIB 1+! 1 THEN
           +LOOP      TIB #TIB @ TYPE CR    ;
: INITFILE --  FCB -->      -- iniciliziro