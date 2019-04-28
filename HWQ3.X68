*-----------------------------------------------------------
* Title      :Homework 1 Question 3
* Written by :William Nguyen
* Date       :4/26/19
* Description:
*-----------------------------------------------------------
INPUT1   EQU $A000
INPUT2 EQU $A001
Addr1 EQU $00004000



    ORG    $1000
START:                  ; first instruction of program

    *Intaking 2 numbers
    MOVE.B  #5,D0           *Trap # 5 in D0
    TRAP    #15             *Read a number from the keyboard into D1.L. 
    MOVE.B  D1,$A000      
    TRAP    #15
    MOVE.B  D1,$A001
    
    *Converting values at $A000 and $A000 (2 individual characters) to hex
    
    *check if $A000 and $A001 are 41 - 46
    
    *else, assuming proper input, they are 30 - 39
    
    
    
    


    
* will need to use string or 
* single character input and convert to hex.
* Put program code here


* Assuming you want to convert each digit to 
* an individual ASCII character you 
* would proceed something like this:

* If the digit is 0 through 9 add $30 to convert to ASCII.
* If the digit is A through F add $37 to convert to ASCII.

*If the digit is '0' through '9' subtract $30 
*to convert to binary. This works because the 
*ASCII code for '0' is $30. 
*The ASCII code for '1' is $31 etc.
*If the digit is 'A' through 'F' subtract 
*$37 to convert to binary. Take a look at the 
*ASCII codes for 'A' through 'F' to see why this works.

    SIMHALT             ; halt simulator
    
MESSAGE DC.B    'Enter a number: ',0

* Put variables and constants here

    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
