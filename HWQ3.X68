*-----------------------------------------------------------
* Title      :Homework 2 Question 3
* Written by :William Nguyen
* Date       :4/26/19
* Description:
*-----------------------------------------------------------
INPUT1   EQU $A000
INPUT2 EQU $A001
*Addr1 EQU $00006000
*ADDSUM EQU $600

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
    BRA STFORA

SUBLET0
    SUBI.B  #$37,INPUT1      Reduce to Binary equiv of A-F
    BRA STFORA


*byte data stored in memory between the addresses $6000 and $8000 
*and compare it to the (byte) data at address $A000 
*(hint: you can consider the memory between $6000 and $8000 an array).

STFOR
    MOVE.L  #1, D3
    MOVE.L  #2000,D4
    LEA     ARR,A0
    LEA     INPUT1,A1
    MOVE.B  #$0A,$6010
    
    
LOOP    CMP.B   D3,D4
        BEQ     NEXT
        *Execute loop code below
        *compare each byte address to $A000
        *If the same, store address into Addr1
        CMPA.W   (A0)+,A1
        BEQ     STORE
        
        
        ADDQ.L  #1,D3
        BRA     LOOP    
* SPLIT THIS INTO 2 PARTS of LOOP
* Put the start and end location in registers
* move addresses to data register and then compare
* Increment address register separately (at end)

* CMPA.B
*i.e compare ($A000) to D3
*need to clear just in case


STFORA  *For Loop Preparations
        MOVE.L  #1, D3
        MOVE.L  #2000,D4
        *Locations in address registers
        LEA $00006000,A3
        LEA $00008000,A4
        *Example data to trigger
        MOVE.B  #$0A,$6005
        
        *Checking for loop
LOOPA   CMP.B   D3,D4
        BEQ     NEXT
        *CLEAR D5 and D6 before moving
        CLR     D5
        CLR     D6
        *Moving address registers of locations to data registers
        MOVE.B  (A3),D5
        MOVE.B  ($A000),D6
        *comparing byte data of data registers
        CMP.B   D5,D6
        BEQ     STORE
        *Incrementing for loop
        ADDQ.L  #1,D3
        *Incrementing address register location
        MOVE.B  (A3)+,D5
        BRA     LOOPA
        



        
   

*store address currently in A0 into Addr1
STORE   
        MOVE.L A3,Addr1
        BRA   NEXT

*For sum loops
*2 data registers corresponding to 2 address registers
*Intialize with (A1)+ and (A0)+
*Put both addresses into data registers
* sum in 2nd data register
* update 1st data register with new address
* re-sum in 2nd data register

*Setting up loop for summation
NEXT    CLR D3
        CLR D4
        CLR D5
        CLR D6
        MOVE.L  #0,D3
        MOVE.L  #512,D4
        *Loading addresses regarding
        *Don't want LEA here?
        *LEA     Addr1,A3
        *LEA     Addr1,A4
        MOVE.L   Addr1,A3
        MOVE.L   Addr1,A4
        *Need to maybe increment twice due to post-increment?
        MOVE.B  (A3)+,D5
        
        MOVE.B  (A4),D6 
        **Invalid Addressing on Add.b, FIX THIS?!??!
        *MOVEA.L Addr1,A0

*Please define a WORD variable called address Addsum. 
*Add a series of bytes stored in the 512 consecutive memory locations 
*beginning at address Addr1, no matter you find the target data or not. 
*Save the sum value into Addsum.
*There is a chance that the sum might exceed $FFFF, 
*(exceeding the range of word value), so you will also need to store the carry bit 
*if an overflow occurs. Store the carry bit as a BYTE variable called CarryBit.

        *Check outer loop and move to fin if finished iterating
SUM     CMP.W   D3,D4
        BEQ     FIN
        *add current A3 byte value to D5. Post-Increment
        MOVE.B  (A3)+,D5
        *Add Incrementing Address of D5 (A3) to D6
        ADD.W   D5,D6
        *Check for carry, set carry bit in subroutine
        *Increment to 512
        ADDQ.L  #1,D3
        *Loop to beginning of SUM
        BRA     SUM
*ADD.B   (A0)+,ADDSUM

*Need to set Addsum to equal D6 value
*Need to output Addr1, Addsum Value, a
FIN     NOP
    
*add output of 3 values: Addr1, Addsum, and CarryBit    
    
CR      EQU     $0D         
LF      EQU     $0A 
MESSAGE DC.B    'Enter a number: ',0
INV     DC.B    'That is not between 30 and 46',CR,LF,0

ADDSUM DC.W    $0600
Addr1  DC.L    $00006000

CarryBit DC.B   $01
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
