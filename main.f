\ Sistemi Embedded 18/19
\ Daniele Peri - Universita' degli Studi di Palermo
\
\ Some definitions for ANS compliance
\
\ v. 20181215

: JF-HERE   HERE ;
: JF-CREATE   CREATE ;
: JF-FIND   FIND ;
: JF-WORD   WORD ;

: HERE   JF-HERE @ ;
: ALLOT   HERE + JF-HERE ! ;

: [']   ' LIT , ;
: '   JF-WORD JF-FIND >CFA ;
: '   JF-WORD JF-FIND >CFA ;

: CELL+  4 + ;

: ALIGNED   3 + 3 INVERT AND ;
: ALIGN JF-HERE @ ALIGNED JF-HERE ! ;

\ : DOES>CUT   LATEST @ >CFA @ DUP JF-HERE @ > IF JF-HERE ! ;

: CREATE   JF-WORD JF-CREATE DOCREATE , ;
: (DODOES-INT)  ALIGN JF-HERE @ LATEST @ >CFA ! DODOES> ['] LIT ,  LATEST @ >DFA , ;
: (DODOES-COMP)  (DODOES-INT) ['] LIT , , ['] FIP! , ;
: DOES>COMP   ['] LIT , HERE 3 CELLS + , ['] (DODOES-COMP) , ['] EXIT , ;
: DOES>INT   (DODOES-INT) LATEST @ HIDDEN ] ;
: DOES>   STATE @ 0= IF DOES>INT ELSE DOES>COMP THEN ;

\ end "ans.f"

6 CONSTANT MAX_COLUMN_INDEX
5 CONSTANT MAX_ROW_INDEX

VARIABLE X \ for columns
VARIABLE Y \ for rows

: SETX X ! ; \ usage: 5 SETX; 
: SETY Y ! ; \ usage: 3 SETY;

\ creation columns
CREATE C0 0 , 0 , 0 , 0 , 0 , 0 ,
CREATE C1 0 , 0 , 0 , 0 , 0 , 0 ,
CREATE C2 0 , 0 , 0 , 0 , 0 , 0 ,
CREATE C3 0 , 0 , 0 , 0 , 0 , 0 ,
CREATE C4 0 , 0 , 0 , 0 , 0 , 0 ,
CREATE C5 0 , 0 , 0 , 0 , 0 , 0 ,
CREATE C6 0 , 0 , 0 , 0 , 0 , 0 ,

\ creation matrix
CREATE M1 C0 , C1 , C2 , C3 , C4 , C5 , C6 ,

\ get matrix value [Y, X]
: GET_VALUE 
    SETX
    SETY
    M1 X @ CELLS + @
    Y @ CELLS + @
; 
\ usage: ROW COL GET_VALUE ;

\ set matrix value [Y, X]
: SET_VALUE 
    SETX
    SETY
    M1 X @ CELLS + @
    Y @ CELLS + !
; 
\ usage: VALUE ROW COL SET_VALUE ;

VARIABLE II \ row counter
VARIABLE JJ \ column counter
VARIABLE FLAG 
VARIABLE USERVALUE \ 1 OR 2
1 USERVALUE !
VARIABLE CURRENT_COLUMN
VARIABLE CURRENT_ROW
VARIABLE COUNT \ counter
VARIABLE K \ index counter

\ utilities
: INIT_FLAG 0 FLAG ! ;
: ACTIVATE_FLAG -1 FLAG ! ;
: FLAG_VALUE FLAG @ ;
: INIT_CURRENT_COLUMN 0 CURRENT_COLUMN ! ;
: INIT_CURRENT_ROW 0 CURRENT_ROW ! ;
: INIT_COUNT 0 COUNT ! ;
: COUNT_LIMIT COUNT @ 4 >= ;
: INCREMENT_COUNT 1 COUNT +! ;
: INIT_K_COUNTER 0 K ! ;
: INCREMENT_K_COUNTER 1 K +! ;
: K_VALUE K @ ;
: USERVALUE_VALUE USERVALUE @ ;
: INIT_ROW_COUNTER 0 II ! ;
: INIT_COLUMN_COUNTER 0 JJ ! ;
: INCREMENT_ROW_COUNTER 1 II +! ;
: DECREMENT_ROW_COUNTER 1 II -! ;
: INCREMENT_COLUMN_COUNTER 1 JJ +! ;
: ROW_COUNTER_VALUE II @ ;
: COLUMN_COUNTER_VALUE JJ @ ;
: ROW_LIMIT MAX_ROW_INDEX ROW_COUNTER_VALUE < ;
: COLUMN_LIMIT MAX_COLUMN_INDEX COLUMN_COUNTER_VALUE < ;
: CURRENT_COLUMN_VALUE CURRENT_COLUMN @ ;
: CURRENT_ROW_VALUE CURRENT_ROW @ ;
: PIPE 124 EMIT ;
: HYPHEN 45 EMIT ; 
: O 79 EMIT ; \ symbol 'O' for player 1
: AT 64 EMIT ; \ symbol '@' for player 2

\ variables and utilities for diagonals
VARIABLE FLAG45
VARIABLE FLAG135
VARIABLE SIZE45 \ length of the 45 diagonal
VARIABLE UPPERSIZE45 \ length of the part of the 45 diagonal over the element selected
VARIABLE SIZE135 \ length of the 135 diagonal
VARIABLE UPPERSIZE135 \ length of the part of the 135 diagonal over the element selected
VARIABLE TEMP_COL_INDEX \ temporary column index
VARIABLE TEMP_ROW_INDEX \ temporary row index
: INIT_FLAG45 0 FLAG45 ! ;
: FLAG45_VALUE FLAG45 @ ;
: ACTIVATE_FLAG45 -1 FLAG45 ! ;
: INIT_FLAG135 0 FLAG135 ! ;
: FLAG135_VALUE FLAG135 @ ;
: ACTIVATE_FLAG135 -1 FLAG135 ! ;
: TEMP_COL_INDEX_VALUE TEMP_COL_INDEX @ ;
: TEMP_ROW_INDEX_VALUE TEMP_ROW_INDEX @ ;
: INCREMENT_TEMP_COL_INDEX 1 TEMP_COL_INDEX +! ;
: DECREMENT_TEMP_COL_INDEX 1 TEMP_COL_INDEX -! ;
: INCREMENT_TEMP_ROW_INDEX 1 TEMP_ROW_INDEX +! ;
: DECREMENT_TEMP_ROW_INDEX 1 TEMP_ROW_INDEX -! ;
: INIT_SIZE45 0 SIZE45 ! ;
: SIZE45_VALUE SIZE45 @ ;
: INCREMENT_SIZE45 1 SIZE45 +! ;
: DECREMENT_SIZE45 1 SIZE45 -! ;
: INIT_UPPERSIZE45 0 UPPERSIZE45 ! ;
: INCREMENT_UPPERSIZE45 1 UPPERSIZE45 +! ;
: DECREMENT_UPPERSIZE45 1 UPPERSIZE45 -! ;
: UPPERSIZE45_VALUE UPPERSIZE45 @ ;
: INIT_SIZE135 0 SIZE135 ! ;
: SIZE135_VALUE SIZE135 @ ;
: INCREMENT_SIZE135 1 SIZE135 +! ;
: DECREMENT_SIZE135 1 SIZE135 -! ;
: INIT_UPPERSIZE135 0 UPPERSIZE135 ! ;
: INCREMENT_UPPERSIZE135 1 UPPERSIZE135 +! ;
: DECREMENT_UPPERSIZE135 1 UPPERSIZE135 -! ;
: UPPERSIZE135_VALUE UPPERSIZE135 @ ;

\ for matrix printing
: PRINT_ARROWS
    \ output: ▼ ▼ ▼ ▼ ▼ ▼ ▼ 
    SPACE 31 EMIT 
    SPACE 31 EMIT
    SPACE 31 EMIT
    SPACE 31 EMIT
    SPACE 31 EMIT
    SPACE 31 EMIT
    SPACE 31 EMIT
    CR
;

: PRINT_COLUMN_NUMBERS
    6 5 4 3 2 1 0 SPACE . . . . . . . CR
;

\ MATRIX WILL BE PRINTED THIS WAY:    0     1     2   ...   6  ;
\ --------------------------------:   ▼     ▼     ▼   ...   ▼  ;
\ --------------------------------: [0,0] [0,1] [0,2] ... [0,6];
\ --------------------------------: [1,0] [1,1] [1,2] ... [1,6];
\ --------------------------------: [2,0] [2,1] [2,2] ... [2,6];
\ --------------------------------:  ...   ...   ...  ...  ... ;
\ --------------------------------: [5,0] [5,1] [5,2] ... [5,6];

\ draw bottom line
: BOTTOM_LINE
    INIT_COLUMN_COUNTER
    BEGIN
        HYPHEN
        INCREMENT_COLUMN_COUNTER
        14 COLUMN_COUNTER_VALUE <
        \ 14 for graphics reason
    UNTIL
    INIT_COLUMN_COUNTER
;

\ print player symbol on matrix
: PRINT_SYMBOL
    DUP \ in case you enter the second nested if
    0 =
    IF
        SPACE
        DROP \ in case you don't enter the second nested if
    ELSE
        1 =
        IF O
        ELSE AT
        THEN
    THEN
;

: PRINT_MATRIX
    CR
    PRINT_COLUMN_NUMBERS
    PRINT_ARROWS
    INIT_ROW_COUNTER
    BEGIN
        INIT_COLUMN_COUNTER
        BEGIN
            PIPE
            ROW_COUNTER_VALUE COLUMN_COUNTER_VALUE GET_VALUE
            PRINT_SYMBOL
            INCREMENT_COLUMN_COUNTER
            COLUMN_LIMIT
        UNTIL
        PIPE CR
        INCREMENT_ROW_COUNTER
        ROW_LIMIT
    UNTIL
    BOTTOM_LINE
    INIT_ROW_COUNTER
    INIT_COLUMN_COUNTER
    CR
;

: RESET_MATRIX
    1 USERVALUE !
    INIT_CURRENT_COLUMN
    INIT_CURRENT_ROW
    INIT_COUNT
    INIT_K_COUNTER
    INIT_FLAG
    INIT_ROW_COUNTER
    BEGIN
        INIT_COLUMN_COUNTER
        BEGIN
            0 ROW_COUNTER_VALUE COLUMN_COUNTER_VALUE SET_VALUE
            INCREMENT_COLUMN_COUNTER
            COLUMN_LIMIT
        UNTIL
        INCREMENT_ROW_COUNTER
        ROW_LIMIT
    UNTIL
    INIT_ROW_COUNTER
    INIT_COLUMN_COUNTER
;

\ get matrix value writing column index first, then row index
: COL_GET_VALUE 
    SETY
    SETX
    M1 X @ CELLS + @
    Y @ CELLS + @
; 
\ usage: COL ROW COL_GET_VALUE ;

\ function to check if the column selected contains 4 consecutive values
: COLUMN_CONTAINS_4
    INIT_FLAG
    INIT_COUNT
    INIT_K_COUNTER \ it's a row index
    BEGIN
        CURRENT_COLUMN_VALUE K_VALUE COL_GET_VALUE USERVALUE_VALUE =
        IF
            INCREMENT_COUNT 
            COUNT_LIMIT 
            IF
                ACTIVATE_FLAG
            THEN
        ELSE
            INIT_COUNT \ because they need to be consecutive
        THEN
        INCREMENT_K_COUNTER
        MAX_ROW_INDEX K_VALUE <
    UNTIL
    FLAG_VALUE
;

\ function to check if the row selected contains 4 consecutive values
: ROW_CONTAINS_4
    INIT_FLAG
    INIT_COUNT
    INIT_K_COUNTER \ it's a column index
    BEGIN
        K_VALUE CURRENT_ROW_VALUE COL_GET_VALUE USERVALUE_VALUE =
        IF
            INCREMENT_COUNT 
            COUNT_LIMIT 
            IF
                ACTIVATE_FLAG
            THEN
        ELSE
            INIT_COUNT \ because they need to be consecutive
        THEN
        INCREMENT_K_COUNTER
        MAX_COLUMN_INDEX K_VALUE <
    UNTIL
    FLAG_VALUE
;

: PRINT_WINNER
    CR CR
    84 EMIT 72 EMIT 69 EMIT SPACE \ THE
    87 EMIT 73 EMIT 78 EMIT 78 EMIT 69 EMIT 82 EMIT SPACE \ WINNER
    73 EMIT 83 EMIT 58 EMIT SPACE \ IS: 
    USERVALUE_VALUE . USERVALUE_VALUE 40 EMIT PRINT_SYMBOL 41 EMIT
    CR CR
    40 EMIT 77 EMIT 65 EMIT 84 EMIT 67 EMIT 72 EMIT 32 EMIT 82 EMIT 69 EMIT 83 EMIT 69 EMIT 84 EMIT 41 EMIT
    CR CR
;

\ --- diagonal 45 degree ---

: IS_COLUMN_INDEX_VALID
    TEMP_COL_INDEX_VALUE 0 >=
    TEMP_COL_INDEX_VALUE MAX_COLUMN_INDEX <=
    AND
    IF
        -1
    ELSE
        0
    THEN
;

: IS_ROW_INDEX_VALID
    TEMP_ROW_INDEX_VALUE 0 >=
    TEMP_ROW_INDEX_VALUE MAX_ROW_INDEX <=
    AND
    IF
        -1
    ELSE
        0
    THEN
;

\ add the elements of the lower part of the diagonal of 45 degrees to the stack
: BUILD_LOWER_45
    INIT_FLAG
    INIT_K_COUNTER
    BEGIN
        \ start from the element that has just been changed and
        \ - decrease column index by 1
        \ - increase row index by 1
        \ - then push the value [row + 1, col - 1] to the stack
        \ (repeat this until indexes are valid. If they are not valid, it means they went out of the edge)
        INCREMENT_K_COUNTER 
        CURRENT_COLUMN_VALUE K_VALUE - TEMP_COL_INDEX !
        CURRENT_ROW_VALUE K_VALUE + TEMP_ROW_INDEX !
        IS_COLUMN_INDEX_VALID IS_ROW_INDEX_VALID AND
        IF
            INCREMENT_SIZE45 \ keep the count of the elements pushed to the stack
            TEMP_COL_INDEX_VALUE TEMP_ROW_INDEX_VALUE COL_GET_VALUE \ push the element to the stack
        ELSE
            ACTIVATE_FLAG
        THEN
        FLAG_VALUE
    UNTIL
;

\ add the elements of the upper part of the diagonal of 45 degrees to the stack
: BUILD_UPPER_45
    INIT_FLAG
    INIT_K_COUNTER
    INIT_UPPERSIZE45
    BEGIN
        \ start from the element that has just been changed and
        \ - increase column index by 1
        \ - decrease row index by 1
        \ - then increase the count of this part of the diagonal (UPPERSIZE45)
        \ (repeat this until indexes are valid. If they are not valid, it means they went out of the edge)
        INCREMENT_K_COUNTER
        CURRENT_COLUMN_VALUE K_VALUE + TEMP_COL_INDEX !
        CURRENT_ROW_VALUE K_VALUE - TEMP_ROW_INDEX !
        IS_COLUMN_INDEX_VALID IS_ROW_INDEX_VALID AND
        IF
            INCREMENT_SIZE45
            INCREMENT_UPPERSIZE45
        ELSE
            ACTIVATE_FLAG
        THEN
        FLAG_VALUE
    UNTIL
    UPPERSIZE45_VALUE 0 >
    IF
        BEGIN
            \ now temporary indexes are out the border of the matrix, 
            \ so let's increase/decrease them by 1, and at every step
            \ push the element on the stack. Do this until the uppersize45 is consumed (its values reaches 0)
            \ NOTE: I do this double loop to keep the order of the elements on the stack;
            DECREMENT_TEMP_COL_INDEX
            INCREMENT_TEMP_ROW_INDEX
            TEMP_COL_INDEX_VALUE TEMP_ROW_INDEX_VALUE COL_GET_VALUE
            DECREMENT_UPPERSIZE45
            UPPERSIZE45_VALUE 0 <=
        UNTIL
    THEN
;

\ function to check if the 45 degrees diagonal contains 4 consecutive values
: CHECK_DIAGONAL_45
    INIT_FLAG45
    INIT_SIZE45
    BUILD_UPPER_45
    CURRENT_COLUMN_VALUE CURRENT_ROW_VALUE COL_GET_VALUE
    BUILD_LOWER_45 \ keep the order (upper - element - lower)
    INCREMENT_SIZE45 \ because we added the selected element
    INIT_COUNT
    BEGIN
        USERVALUE_VALUE =
        IF
            INCREMENT_COUNT 
            COUNT_LIMIT 
            IF
                ACTIVATE_FLAG45
            THEN
        ELSE
            INIT_COUNT \ because they need to be consecutive
        THEN
        DECREMENT_SIZE45
        SIZE45_VALUE 0 <= 
    UNTIL
    FLAG45_VALUE
;

\ --- END diagonal 45 degree ---

\ --- diagonal 135 degree ---

\ NOTE: SEE 45 diagonal code
\ to check the 135 degrees diagonal, we use the specular of the 45 degrees diagonal;
: BUILD_LOWER_135
    INIT_FLAG
    INIT_K_COUNTER
    BEGIN
        INCREMENT_K_COUNTER
        CURRENT_COLUMN_VALUE K_VALUE + TEMP_COL_INDEX !
        CURRENT_ROW_VALUE K_VALUE + TEMP_ROW_INDEX !
        IS_COLUMN_INDEX_VALID IS_ROW_INDEX_VALID AND
        IF
            INCREMENT_SIZE135
            TEMP_COL_INDEX_VALUE TEMP_ROW_INDEX_VALUE COL_GET_VALUE
        ELSE
            ACTIVATE_FLAG
        THEN
        FLAG_VALUE
    UNTIL
;

: BUILD_UPPER_135
    INIT_FLAG
    INIT_K_COUNTER
    INIT_UPPERSIZE135
    BEGIN
        INCREMENT_K_COUNTER
        CURRENT_COLUMN_VALUE K_VALUE - TEMP_COL_INDEX !
        CURRENT_ROW_VALUE K_VALUE - TEMP_ROW_INDEX !
        IS_COLUMN_INDEX_VALID IS_ROW_INDEX_VALID AND
        IF
            INCREMENT_SIZE135
            INCREMENT_UPPERSIZE135
        ELSE
            ACTIVATE_FLAG
        THEN
        FLAG_VALUE
    UNTIL
    UPPERSIZE135_VALUE 0 >
    IF
        BEGIN
            INCREMENT_TEMP_COL_INDEX
            INCREMENT_TEMP_ROW_INDEX
            TEMP_COL_INDEX_VALUE TEMP_ROW_INDEX_VALUE COL_GET_VALUE
            DECREMENT_UPPERSIZE135
            UPPERSIZE135_VALUE 0 <=
        UNTIL
    THEN
;

: CHECK_DIAGONAL_135
    INIT_FLAG135
    INIT_SIZE135
    BUILD_UPPER_135
    CURRENT_COLUMN_VALUE CURRENT_ROW_VALUE COL_GET_VALUE
    BUILD_LOWER_135
    INCREMENT_SIZE135
    INIT_COUNT
    BEGIN
        USERVALUE_VALUE =
        IF
            INCREMENT_COUNT 
            COUNT_LIMIT 
            IF
                ACTIVATE_FLAG135
            THEN
        ELSE
            INIT_COUNT
        THEN
        DECREMENT_SIZE135
        SIZE135_VALUE 0 <= 
    UNTIL
    FLAG135_VALUE
;

\ --- END diagonal 135 degree ---

: CHECK_VICTORY
    COLUMN_CONTAINS_4
    ROW_CONTAINS_4
    OR
    CHECK_DIAGONAL_45
    OR
    CHECK_DIAGONAL_135
    OR
    IF
        PRINT_MATRIX
        PRINT_WINNER
        \ PRINT_MATRIX
        RESET_MATRIX
    ELSE
        PRINT_MATRIX
    THEN
;

\ user adds an element
: ADD
    MAX_ROW_INDEX II ! \ first element of the column to be "inserted" is the the element [5, col]
    INIT_FLAG
    BEGIN
        DUP CURRENT_COLUMN !
        DUP \ to keep inserted column index
        ROW_COUNTER_VALUE COL_GET_VALUE 0 = \ if the spot is empty, add the value, else ...
        IF
            USERVALUE_VALUE ROW_COUNTER_VALUE ROT SET_VALUE
            ROW_COUNTER_VALUE CURRENT_ROW !

            CHECK_VICTORY

            USERVALUE_VALUE 1 =
            IF
                2 USERVALUE ! \ change user
            ELSE
                1 USERVALUE !
            THEN
            ACTIVATE_FLAG \ element has been inserted, loop can end
        ELSE
            DECREMENT_ROW_COUNTER \ ... else decrease row index, so find an upper spot
        THEN
        -1 ROW_COUNTER_VALUE = FLAG_VALUE OR 
        \ close the loop if element has been inserted 
        \ or row index went out of range (column is full)
    UNTIL
;
\ usage: 2 ADD;

: INSTRUCTIONS
    85 EMIT 83 EMIT 69 EMIT 82 EMIT 32 EMIT 49 EMIT 32 EMIT 80 EMIT 76 EMIT 65 EMIT 89 EMIT 83 EMIT 32 EMIT 87 EMIT 73 EMIT 84 EMIT 72 EMIT 32 EMIT 83 EMIT 89 EMIT 77 EMIT 66 EMIT 79 EMIT 76 EMIT 32 EMIT 39 EMIT 79 EMIT 39 EMIT CR 
    \ USER 1 PLAYS WITH SYMBOL 'O'
    85 EMIT 83 EMIT 69 EMIT 82 EMIT 32 EMIT 50 EMIT 32 EMIT 80 EMIT 76 EMIT 65 EMIT 89 EMIT 83 EMIT 32 EMIT 87 EMIT 73 EMIT 84 EMIT 72 EMIT 32 EMIT 83 EMIT 89 EMIT 77 EMIT 66 EMIT 79 EMIT 76 EMIT 32 EMIT 39 EMIT 64 EMIT 39 EMIT CR 
    \ USER 2 PLAYS WITH SYMBOL '@'
    84 EMIT 89 EMIT 80 EMIT 69 EMIT 32 EMIT 39 EMIT 110 EMIT 32 EMIT 65 EMIT 68 EMIT 68 EMIT 39 EMIT 32 EMIT 84 EMIT 79 EMIT 32 EMIT 73 EMIT 78 EMIT 83 EMIT 69 EMIT 82 EMIT 84 EMIT CR
    \ TYPE 'n ADD' TO INSERT
    85 EMIT 83 EMIT 69 EMIT 82 EMIT 32 EMIT 49 EMIT 32 EMIT 66 EMIT 69 EMIT 71 EMIT 73 EMIT 78 EMIT 83 EMIT CR 
    \ USER 1 BEGINS
    CR
;

INSTRUCTIONS
