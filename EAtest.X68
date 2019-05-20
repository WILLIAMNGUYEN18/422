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
ANEX1   EQU $9008
ANIEX1  EQU $9010
INCEX1  EQU $9018
DECEX1  EQU $9020
ABSWEX1 EQU $9028
ABSLEX1 EQU $9030
IMEX1   EQU $9038
ERREX1  EQU $9040
FULLEX1 EQU $9048

*Load a full test to be split and identified
*assumption that ordering is source, so Mode, then Register
* bits --> 00000111 --> 2 empty bits, 
*3 bits identifying as data register mode
*3 bits identifying as register number 7
        LEA FULLEX1,A1
        MOVE.B #7,(A1)
        
        

*Load MODE values
        LEA DNEX1,A1
        MOVE.B #0,(A1)
        
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
*MODE SECTION
*if mode =

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
