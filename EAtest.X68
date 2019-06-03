*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
*hard code sample EA bits
*technically, only need to store 6 bits per, (< 1 byte)
*Can store them in longs anyways
DNEX1   EQU $9000
DNEX2   EQU $9050

ANEX1   EQU $9008
ANIEX1  EQU $9010
INCEX1  EQU $9018
DECEX1  EQU $9020
ABSWEX1 EQU $9028
ABSLEX1 EQU $9030
IMEX1   EQU $9038
ERREX1  EQU $9040
FULLEX1 EQU $9048
FULLEX2 EQU $9058


*NEED TO MARK GOOD BUFFER
*GOODBUFFER nop

*Load a full test to be split and identified
*assumption that ordering is source, so Mode, then Register
* bits --> 00000111 --> 2 empty bits, 
*3 bits identifying as data register mode
*3 bits identifying as register number 7
        LEA FULLEX1,A1
        MOVE.B #7,(A1)
        
        
*LOAD ALT FULL TEST
*REGISTER THEN MODE
*3 bits as register 7
*3 bits as data register mode
*00111000

        LEA FULLEX2,A1
        MOVE.B #56,(A1)


        
        

*Load MODE values
        LEA DNEX1,A1
        MOVE.B #0,(A1)
        
        LEA DNEX2,A1
        MOVE.B #5,(A1)
        
        LEA ANEX1,A1
        MOVE.B #1,(A1)
        
        LEA ANIEX1,A1
        MOVE.B #2,(A1)
        
        LEA INCEX1,A1
        MOVE.B #3,(A1)
        
        LEA DECEX1,A1
        MOVE.B #4,(A1)
        
        LEA ABSWEX1,A1
        MOVE.B #7,(A1)
        
        LEA ABSLEX1,A1
        MOVE.B #7,(A1)
        
        LEA IMEX1,A1
        MOVE.B #7,(A1)

        LEA ERREX1,A1
        MOVE.B #15,(A1)        



*Load a full test to be split and identified
*assumption that ordering is source, so Mode, then Register
* bits --> 00000111 --> 2 empty bits, 
*3 bits identifying as data register mode
*3 bits identifying as register number 7
*        LEA FULLEX1,A1
*        MOVE.B #7,(A1)



*May need to clear and initialize data registers

*
*
*REG/MODE SPLIT
*
*
SPLITREGSET    
    CLR     D4
    CLR     D5
    *REMOVE THIS TEST LATER
    LEA     FULLEX1,A1
    MOVE.L  (A1),D3
    MOVE.L  #1,D4
    MOVE.L  #4,D5
    
    *setup loop
SPLITREG
    CMP.L   D4,D5
    BEQ     SPLITMODESET
    LSR.L   #$1,D3
    *Check for carry flag set from logical right shifting
    BCS     REGCHANGE
    *If not, just add and loop. (No changes to output D7)
    ADDQ.L  #1,D4
    BRA     SPLITREG
    
    *loop 3x
    *OVE.B
    

*Check for current iteration (each loop is on a different bit)
REGCHANGE
    CMP.L   #1,D4
    BEQ     REG1BIT
    CMP.L   #2,D4
    BEQ     REG2BIT
    CMP.L   #3,D4
    BEQ     REG3BIT
    
    ADDQ.L  #1,D4
    BRA     SPLITREG

*If carry set and 1st bit
*add 1 to D7
*which sets first bit of D7 to 1
REG1BIT
    ADDQ.L  #1,D7
    ADDQ.L  #1,D4
    BRA     SPLITREG
REG2BIT
    ADDQ.L  #2,D7    
    ADDQ.L  #1,D4
    BRA     SPLITREG
REG3BIT
    ADDQ.L  #4,D7    
    ADDQ.L  #1,D4
    BRA     SPLITREG
    
SPLITMODESET
    CLR D4
    CLR D5
    MOVE.L  #1,D4
    MOVE.L  #4,D5
    
SPLITMODE
    CMP.L   D4,D5
    BEQ     MODE
    LSR.L   #$1,D3
    BCS     MODECHANGE
    ADDQ.L  #1,D4
    BRA     SPLITMODE
    
    
MODECHANGE
    CMP.L   #1,D4
    BEQ     MODE1BIT
    CMP.L   #2,D4
    BEQ     MODE2BIT
    CMP.L   #3,D4
    BEQ     MODE3BIT
    ADDQ.L  #1,D4
    BRA     SPLITMODE
    
MODE1BIT
    ADDQ.L  #1,D6
    ADDQ.L  #1,D4
    BRA     SPLITMODE
MODE2BIT
    ADDQ.L  #2,D6
    ADDQ.L  #1,D4
    BRA     SPLITMODE
MODE3BIT
    ADDQ.L  #4,D6
    ADDQ.L  #1,D4
    BRA     SPLITMODE    

*
*
*MODE/REG SPLIT
*
*

MODESPLITSET
    CLR D4
    CLR D5
    MOVE.L  #1,D4
    MOVE.L  #4,D5
    
MODESPLIT
    CMP.L   D4,D5
    BEQ     REGSPLITSET
    LSR.L   #$1,D3
    BCS     CHANGEMODE
    ADDQ.L  #1,D4
    BRA     MODESPLIT
    
    
CHANGEMODE
    CMP.L   #1,D4
    BEQ     BITMODE1
    CMP.L   #2,D4
    BEQ     BITMODE2
    CMP.L   #3,D4
    BEQ     BITMODE3
    ADDQ.L  #1,D4
    BRA     MODESPLIT

BITMODE1
    ADDQ.L  #1,D6
    ADDQ.L  #1,D4
    BRA     MODESPLIT
BITMODE2
    ADDQ.L  #2,D6
    ADDQ.L  #1,D4
    BRA     MODESPLIT
BITMODE3
    ADDQ.L  #4,D6
    ADDQ.L  #1,D4
    BRA     MODESPLIT 

REGSPLITSET  
    CLR D4
    CLR D5
    MOVE.L  #1,D4
    MOVE.L  #4,D5
    
REGSPLIT
    CMP.L   D4,D5
    BEQ     MODE
    LSR.L   #$1,D3
    BCS     CHANGEREG
    ADDQ.L  #1,D4
    BRA     REGSPLIT

CHANGEREG  
    CMP.L   #1,D4
    BEQ     BITREG1
    CMP.L   #2,D4
    BEQ     BITREG2
    CMP.L   #3,D4
    BEQ     BITREG3
    ADDQ.L  #1,D4
    BRA     REGSPLIT
    
BITREG1
    ADDQ.L  #1,D7
    ADDQ.L  #1,D4
    BRA     REGSPLIT
BITREG2
    ADDQ.L  #2,D7
    ADDQ.L  #1,D4
    BRA     REGSPLIT
BITREG3
    ADDQ.L  #4,D7
    ADDQ.L  #1,D4
    BRA     REGSPLIT 

      
*can keep Mode D6, Register D7
*will always be same case from MODE onwards


*
*
*MODE SECTION
*if mode =
*    

    *REMOVE TEST!?!?!?
    *Load test
    LEA DNEX1,A1

MODE
    *Move to data register
    MOVE.L (A1),D5

    *if D5
    
    *0 == da
    *CMP.L   #0,D5
    *BEQ     DATAREG
    
    *CMP.L   #1,D5
    *BEQ     ADDREG
    
    *CMP.L   #2,D5
    *BEQ     INDIRECT
    
    *CMP.L   #3,D5
    *BEQ     INCREMENT
    
    *CMP.L   #4,D5
    *BEQ     DECREMENT
    
    *CMP.L   #7,D5
    *BEQ     ABSOLUTE
    
    *BRA     ERROR
    
    CMP.L   #0,D6
    BEQ     DATAREG
    
    CMP.L   #1,D6
    BEQ     ADDREG
    
    CMP.L   #2,D6
    BEQ     INDIRECT
    
    CMP.L   #3,D6
    BEQ     INCREMENT
    
    CMP.L   #4,D6
    BEQ     DECREMENT
    
    CMP.L   #7,D6
    BEQ     ABSOLUTE
    
    BRA     ERROR


*different addresses


*If data register, 
*check correct register
*return char value
DATAREG     
    LEA DNEX2,A1
    MOVE.L  (A1),D5

            NOP       

ADDREG      NOP

INDIRECT    NOP

DECREMENT   NOP

INCREMENT   NOP

ABSOLUTE    NOP
    *load corresponding registers
    
    
    
    *Move to data register
    MOVE.L (A1),D5
    
    

ERROR       NOP

*REGISTER SECTION 

*Calculate hex equivalent of bit values
*MODES
*000 --> 0
*001 --> 1
*010 --> 2
*011 --> 3
*100 --> 4
*111 --> 7
*ELSE, BAD FLAG

*Register Values
*0 through 7

*Absolute Register Values
*000 --> 0 = Absolute Addressing Word
*001 --> 1 = Absolute Addressing Long
*100 --> 4 = Immediate Data






* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
