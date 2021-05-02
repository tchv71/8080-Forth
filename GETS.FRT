
: GETLIN INLINE IFNOT RDROP THEN ;

: GetSym BLK @ ?DUP
    IF BLOCK DUP INB !
    ELSE TIB THEN
     >IN @ #TIB @ =
    IF
     BEGIN
        GETLIN #TIB @
     UNTIL
     0 >IN ! THEN
    >IN @ + C@ >IN 1+!
;
DECIMAL
: S
 BEGIN  GetSym CASE
  13   OF CR ENDOF
  255  OF EXIT ENDOF
 [ HEX ] 40  OF EXIT ENDOF
  EMIT ENDCASE
 AGAIN
;
;S

S
 BEGIN  GetSym C