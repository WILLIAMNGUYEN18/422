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
    CLR D4
    CLR D5
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
    CMP.L   #0,D7
    BEQ     PUSHD0
    CMP.L   #1,D7
    BEQ     PUSHD1
    CMP.L   #2,D7
    BEQ     PUSHD2
    CMP.L   #3,D7
    BEQ     PUSHD3
    CMP.L   #4,D7
    BEQ     PUSHD4
    CMP.L   #5,D7
    BEQ     PUSHD5
    CMP.L   #6,D7
    BEQ     PUSHD6
    CMP.L   #7,D7
    BEQ     PUSHD7
    BRA ERROR

PUSHD0
    MOVE.L  DZERO,(A1)+
    BRA FINISH   
PUSHD1
    MOVE.L  DONE,(A1)+
    BRA FINISH
PUSHD2
    MOVE.L  DTWO,(A1)+
    BRA FINISH
PUSHD3
    MOVE.L  DTHREE,(A1)+
    BRA FINISH
PUSHD4
    MOVE.L  DFOUR,(A1)+
    BRA FINISH
PUSHD5
    MOVE.L  DFIVE,(A1)+
    BRA FINISH
PUSHD6
    MOVE.L  DSIX,(A1)+
    BRA FINISH
PUSHD7
    MOVE.L  DSEVEN,(A1)+
    BRA FINISH

    
ADDREG      
    CMP.L   #0,D7
    BEQ     PUSHA0
    CMP.L   #1,D7
    BEQ     PUSHA1
    CMP.L   #2,D7
    BEQ     PUSHA2
    CMP.L   #3,D7
    BEQ     PUSHA3
    CMP.L   #4,D7
    BEQ     PUSHA4
    CMP.L   #5,D7
    BEQ     PUSHA5
    CMP.L   #6,D7
    BEQ     PUSHA6
    BRA ERROR

PUSHA0
    MOVE.L  AZERO,(A1)+
    BRA FINISH
PUSHA1
    MOVE.L  AONE,(A1)+
    BRA FINISH
PUSHA2
    MOVE.L  ATWO,(A1)+
    BRA FINISH
PUSHA3
    MOVE.L  ATHREE,(A1)+
    BRA FINISH
PUSHA4
    MOVE.L  AFOUR,(A1)+
    BRA FINISH
PUSHA5
    MOVE.L  AFIVE,(A1)+
    BRA FINISH
PUSHA6
    MOVE.L  ASIX,(A1)+
    BRA FINISH   
    

INDIRECT    
    BRA ERROR
DECREMENT   
    BRA ERROR

INCREMENT   
    BRA ERROR


*For absolute, try storing address in data register, then converting all values to string
*subtraction for letters and numbers
*Josh may have something
*
ABSOLUTE
    
    
    BRA ERROR
    *load corresponding registers
    
    
    
    *Move to data register
    MOVE.L (A1),D5
    
    

ERROR       NOP



FINISH    NOP 

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


CR      EQU     $0D         
LF      EQU     $0A 

DZERO   DC.B    'D0',0
DONE    DC.B    'D1',0
DTWO    DC.B    'D2',0
DTHREE  DC.B    'D3',0  
DFOUR   DC.B    'D4',0
DFIVE   DC.B    'D5',0
DSIX    DC.B    'D6',0
DSEVEN  DC.B    'D7',0

AZERO   DC.B    'A0',0
AONE    DC.B    'A1',0
ATWO    DC.B    'A2',0
ATHREE  DC.B    'A3',0
AFOUR   DC.B    'A4',0
AFIVE   DC.B    'A5',0
ASIX    DC.B    'A6',0

IZERO   DC.B    '(A0)',0
IONE    DC.B    '(A1)',0
ITWO    DC.B    '(A2)',0
ITHREE  DC.B    '(A3)',0
IFOUR   DC.B    '(A4)',0
IFIVE   DC.B    '(A6)',0
ISIX    DC.B    '(A7)',0

PREZERO DC.B    '-(A0)',0
PREONE  DC.B    '-(A1)',0
PRETWO  DC.B    '-(A2)',0
PRETHREE DC.B   '-(A3)',0
PREFOUR DC.B    '-(A4)',0
PREFIVE DC.B    '-(A5)',0
PRESIX  DC.B    '-(A6)',0

POZERO  DC.B    '(A0)+',0
POONE   DC.B    '(A1)+',0
POTWO   DC.B    '(A2)+',0
POTHREE DC.B    '(A3)+',0
POFOUR  DC.B    '(A4)+',0
POFIVE  DC.B    '(A5)+',0
POSIX   DC.B    '(A6)+',0





* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
