@ Q2   
@ This is data section, to store initialized data or constants; 
        .data                     @ define the string; 
        .balign 	4				@ alignment with 4 bytes;	
        length_input: .asciz "\nEnter a positive decimal number Length1 (meters): "	@ user input length1;
        width_input: .asciz "\nEnter a postive decimal number Width1 (meters): " @user input width1;
        output: .asciz "\nOutput: %d\n" @output of total area;
        scanformat: .string "%d"
        result:	.word 0	
        a:  .word 20    		@ define value of a;
        b:	.word 15			@ define value of b;
        c:	.word 0			    @ c will store value of s;
        d:  .word 0             @ area of tri before sqrt

        length:   .word 0
        width:    .word 0
        rectarea: .word 0
        triarea:  .word 0

@text section is for actual code;
        .text
        .global main
        .extern printf
        .extern scanf
        

        main:
@ retrive user input
            LDR     R0, =length_input
            BL      printf
            LDR     R0, =scanformat
            LDR     R1, =length
            BL      scanf
            
            LDR     R0, =width_input
            BL      printf
            LDR     R0, =scanformat
            LDR     R1, =width
            BL      scanf
    

@ calculate s with formula (a+b+length)/2
            LDR     R1, =a
            LDR     R1, [R1]
            LDR     R2, =b
            LDR     R2, [R2]
            LDR     R3, =length
            LDR     R3, [R3]
            ADD     R1, R1, R2
            ADD     R1, R1, R3
            ASR     R1, #1   
            LDR     R2, =c
            STR     R1, [R2]

            
           

@calculate area of triangle
            LDR     R1, =a
            LDR     R1, [R1]
            LDR     R2, =b
            LDR     R2, [R2]
            LDR     R3, =length
            LDR     R3, [R3]
            LDR     R4, =c
            LDR     R4, [R4]

            SUB     R1, R4, R1 
            SUB     R2, R4, R2
            SUB     R3, R4, R3

            MUL     R1, R4
            MUL     R1, R2
            MUL     R1, R3

            LDR     R2, =d
            STR     R1, [R2]

            LDR     R2,=d
            LDR     R2, [R2]
            MOV     R3, #0
            MOV     R4, R1

        LOOP:
            CMP     R3, #50
            BGE     END 
            SDIV    R2, R1, R4
            ADD     R2, R4
            MOV     R2, R2, ASR #1
            MOV     R4, R2
            ADD     R3, #1
            B       LOOP
        END:
            LDR     R1, =triarea
            STR     R2, [R1]


            
@calculate area of rectangle
            LDR     R1, =length
            LDR     R1, [R1]
            LDR     R2, =width
            LDR     R2, [R2]

            MUL     R1, R2
            LDR     R2, =rectarea   
            STR     R1, [R2]

            

@calculate total area
            LDR    R1, =rectarea
            LDR    R1, [R1]
            LDR    R2, =triarea
            LDR    R2, [R2]
            ADD    R1, R2

            LDR    R2, =result
            STR    R1, [R2]

            LDR    R1, =result
            LDR    R1, [R2]
            LDR    R0, =output
            BL     printf
            BX     LR
    
    
           

            