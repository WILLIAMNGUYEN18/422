*-----------------------------------------------------------
* Title      :Homework 2 Question 3
* Written by :William Nguyen
* Date       :4/26/19
* Description:
*-----------------------------------------------------------
INPUT1   EQU $A000
INPUT2 EQU $A001
Addr1 EQU $00004000

*creating a list from $6000-8000
*LIST    DC.W    $6000,$6001,$6002

ARR     EQU     $6000



    ORG    $1000
START:                  ; first instruction of program

    *Intaking 2 numbers
    MOVE.B  #5,D0           *Trap # 5 in D0
    TRAP    #15             *Read a number from the keyboard into D1.L. 
    MOVE.B  D1,$A000      
    
    *Converting values at $A000 and $A000 (2 individual characters) to hex
    
    *check if $A000 and $A001 are 41 - 46
    
    *else, assuming proper input, they are 30 - 39
    
    **layer check. first for check bottom. then check top (0-9)
    **if higher than top, check top for A-F
    
CHECK0
    CMP.B   #$30,(INPUT1)           Compares D1 to 30
    BLT     INVALID         BLT branches if D1 is less than 30
    CMP.B   #$39,(INPUT1)           Compares D1 to 40
    BGT     CHECK1         BGT branches if D1 is greater than 39
    BRA     SUBNUM0


CHECK1
    CMP.B   #$47,(INPUT1)           Compares D1 to 47
    BGT     INVALID         BGT branches if D1 is greater than 46
    BRA     SUBLET0          

SUBNUM0
    SUBI.B  #$30,INPUT1      Reduce to Binary equiv of 0-9
    BRA STFOR

SUBLET0
    SUBI.B  #$37,INPUT1      Reduce to Binary equiv of A-F
    BRA STFOR


*byte data stored in memory between the addresses $6000 and $8000 
*and compare it to the (byte) data at address $A000 
*(hint: you can consider the memory between $6000 and $8000 an array).

STFOR
    MOVE.L  #1, D3
    MOVE.L  #2000,D4
    LEA     ARR,A0
    LEA     INPUT1,A1
    
LOOP    CMP.B   D3,D4
        BEQ     NEXT
        *Execute loop code below
        *compare each byte address to $A000
        *If the same, store address into Addr1
        CMP.W   (A0)+,A1
        BEQ     STORE
        
        
        ADDQ.L  #1, D3
        BRA     LOOP

*store address currently in A0 into Addr1
STORE      NOP   

*If no data matches 6000-8000
*default to Addr1 = $6000
NEXT       NOP

CR      EQU     $0D         
LF      EQU     $0A 
MESSAGE DC.B    'Enter a number: ',0
INV     DC.B    'That is not between 20 and 25',CR,LF,0
INVALID LEA     INV,A1
        MOVE.B  #14,D0  
        TRAP    #15
        BRA     DONE
        
DONE    MOVE.B  #9,D0
        TRAP    #15 

    SIMHALT             ; halt simulator
    
* Put variables and constants here

    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
