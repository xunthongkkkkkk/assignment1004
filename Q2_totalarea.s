@ Q2 to find the total area of triangle and rectangle after user input length and width of rectangle;
@ This is data section, to store initialized data or constants; 
        .data                     @ define the string; 
        .balign 	4				@ alignment with 4 bytes;	
        length_input: .asciz "\nEnter a positive decimal number Length1 (meters): "	@ prompt user to input length1;
        width_input: .asciz "\nEnter a postive decimal number Width1 (meters): " @ prompt user to input width1;
        output: .asciz "\nOutput: %d\n" @ output of total area;
        scanformat: .asciz "%d"    @ format pattern for scanf;
        result:	.word 0	        @ result wil store the value of the total area (output);
        a:  .word 20    		@ define value of a;
        b:	.word 15			@ define value of b;
        c:	.word 0			    @ c will contain the value of s;
        d:  .word 0             @ d will contain the area of triangle before sqrt;

        length:   .word 0       @ length will contain the value of the user input for length;
        width:    .word 0       @ width  will contain the value of the user input for width;
        rectarea: .word 0       @ rectarea will contain the value of the calculated area for rectangle alone; 
        triarea:  .word 0       @ triarea will contain the value of the calculated area for triangle alone;

@text section is for actual code;
        .text
        .global main            @ start the assembly code;  
        .extern printf          @ external function printf;
        .extern scanf           @ external function scanf;
        

        main:

        retrieve_user_input: @ retrieve user input;
            LDR     R0, =length_input       @ load length_input into R0 to perform procedural call;
            BL      printf                  @ branch link to printf, print length_input to prompt user to input length;
            LDR     R0, =scanformat         @ get address of scanformat into R0;
            LDR     R1, =length             @ get address of length into R1;
            BL      scanf                   @ branch link to scanf, scan length with scanformat;
            
            LDR     R0, =width_input        @ load width_input into R0 to perform procedural call;
            BL      printf                  @ branch link to printf, print width_input to prompt user to input width;
            LDR     R0, =scanformat         @ get address of scanformat into R0
            LDR     R1, =width              @ get addreess of width into R1;
            BL      scanf                   @ branch link to scanf, scan width with scanformat;
    
        
        calculate_s: @ calculate s with formula (a+b+length)/2;
            LDR     R1, =a                  @ get address of a into R1;
            LDR     R1, [R1]                @ get value of a into R1;
            LDR     R2, =b                  @ get address of b into R2;
            LDR     R2, [R2]                @ get value of b into R2;
            LDR     R3, =length             @ get address of length into R3;
            LDR     R3, [R3]                @ get value of length into R3;
            ADD     R1, R1, R2              @ add R1 and R2, and store at R1;
            ADD     R1, R1, R3              @ add R1 and R3, and store at R3;
            ASR     R1, #1                  @ arithmetic shift right R1 by 1 bit, which is equivalent to divide R1 by 2
            LDR     R2, =c                  @ get address of c into R2;
            STR     R1, [R2]                @ store value of R1 into C;

            
           

        calculate_triarea:  @ calculate area of triangle with formula sqrt(s * (s - s1) * (s - s2) * (s -s3));
            LDR     R1, =a                  @ get address of a into R1;
            LDR     R1, [R1]                @ get value of a into R1;
            LDR     R2, =b                  @ get address of b into R2;
            LDR     R2, [R2]                @ get value of b into R2;
            LDR     R3, =length             @ get address of length into R3;
            LDR     R3, [R3]                @ get value of length into R3;
            LDR     R4, =c                  @ get address of c into R4;
            LDR     R4, [R4]                @ get value of c into R4;

            SUB     R1, R4, R1              @ R4 - R1, and store at R1;
            SUB     R2, R4, R2              @ R4 - R2, and store at R2;  
            SUB     R3, R4, R3              @ R4 - R3, and store at R3;

            MUL     R1, R4                  @ Multiply R1 and R4, and store at R1;
            MUL     R1, R2                  @ Multiply R1 and R2, and store at R1;
            MUL     R1, R3                  @ Multiply R1 and R3, and store at R1;

            LDR     R2, =d                  @ get address of d into R2;
            STR     R1, [R2]                @ store value of R1 into d;

            LDR     R2,=d                   @ get addresss of d into R2;
            LDR     R2, [R2]                @ get value of d into R2;
            MOV     R3, #0                  @ R3 = 0, set initial variable i to 0 for loop similar to C programming;
            MOV     R4, R1                  @ R4 = R1, where R1 is the value before square root;

        LOOP:
            CMP     R3, #50                 @ compare if i == 50;
            BGE     END                     @ branch to end when i >= 50;
            SDIV    R2, R1, R4              @ divide R1 by R4, and store in R2;
            ADD     R2, R4                  @ add R2 and R4, and store at R2;
            MOV     R2, R2, ASR #1          @ arithmetic shift right R2 by 1 bit which is equivalent to divide R2 by 2 and store in R2;
            MOV     R4, R2                  @ R4 = R2;
            ADD     R3, #1                  @ add R3 by 1, and store in R3 which is similar to i += 1 in C programming;
            B       LOOP                    @ branch back to loop as i < 50;

        END:
            LDR     R1, =triarea            @ get address of triarea into R1;   
            STR     R2, [R1]                @ store value of R2 into triarea;


            
        calcualate_rectarea:    @ calculate area of rectangle with formula length * width;
            LDR     R1, =length             @ get address of length into R1;  
            LDR     R1, [R1]                @ get value of length into R1;
            LDR     R2, =width              @ get address of width into R2;
            LDR     R2, [R2]                @ get value of width into R2;

            MUL     R1, R2                  @ multiply R1 and R2, and store in R1;
            LDR     R2, =rectarea           @ get address of rectarea into R2;
            STR     R1, [R2]                @ store value of R1 into rectarea;

            

        calculate_totalarea:    @calculate total area
            LDR    R1, =rectarea            @ get address of rectarea into R1;
            LDR    R1, [R1]                 @ get value of rectarea into R1;
            LDR    R2, =triarea             @ get address of triarea into R2;
            LDR    R2, [R2]                 @ get value of triarea into R2;
            ADD    R1, R2                   @ add R1 and R2, and store at R1;

            LDR    R2, =result              @ get address of result into R2;
            STR    R1, [R2]                 @ store value of R1 into result;

            LDR    R1, =result              @ get address of result into R1;
            LDR    R1, [R1]                 @ get value of result into R1;
            LDR    R0, =output              @ load output into R0 to perform procedural call;
            BL     printf                   @ branch link to printf, print output and value of result;
            BX     LR                       @ end; return address;
    
    
           

            