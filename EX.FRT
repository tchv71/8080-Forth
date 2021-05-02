HEX
CODE P. >PRE
    POP   H
    PUSH  D
    PUSH  B
    MOV   D M
    INX   H
@1: MOV   E M
    PUSH  D
    PUSH  H
    MVI   C 2
    CALL  5
    POP   H
    POP   D
    INX   H
    DCR   D
    JNZ   @1
    POP   B
    POP   D
    NEXT;

;S
C 2
    CALL  5
    POP   H
    POP   D
    INX   H
    DCR   D
    JNZ   @1
    POP   B
    POP   D
    NEXT;