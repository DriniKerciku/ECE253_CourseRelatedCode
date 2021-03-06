//Calculate largest number of ones,  largest number of trailing 0s and largest number of leading 0s in an array of words
//the respective calculations dont have to be part of the same word

.text
.global start
start:

	LDR R2, =NUM_TEST
    	LDR R1,[R2] // load the data word into R1
    	MOV R8, #0
    	MOV R0, #0
    	BL ONES

	LDR R2, =NUM_TEST
    	LDR R1,[R2] // load the data word into R1
    	MOV R9, #0
    	MOV R0, #32
    	BL LEAD


	LDR R2, =NUM_TEST
    	LDR R1,[R2] // load the data word into R1
    	MOV R10, #0
    	MOV R0, #32
    	BL TRAIL

	MOV R5,R8
    	MOV R6,R9
    	MOV R7,R10
    
END:
	B END
//-------------------------------------------------------------------------

UPDATE_1:

	MOV R8,R0

LOOP_1:

    	CMP R0,R8
    	BGT UPDATE_1
    	LDR R1,[R2],#4 // load the data word into R1
	MOV R0, #0 // R0 will hold the result
	CMP R2, #BOUND
	BGT EXIT 
  
ONES: 

	CMP R1, #0 // loop until the data contains no more 1’s
	BEQ LOOP_1
	LSR R4, R1, #1 // perform SHIFT, followed by AND
	AND R1, R1, R4
	ADD R0, #1 // count the string lengths so far
	B ONES

//-------------------------------------------------------------------------

UPDATE_2:

	MOV R9,R0

LOOP_2:

    	CMP R0,R9
    	BGT UPDATE_2
    	LDR R1,[R2],#4 // load the data word into R1
	MOV R0, #32 // R0 will hold the result
	CMP R2, #BOUND
	BGT EXIT 
  
LEAD:

	CMP R1, #0 // loop until the data contains no more 1’s
	BEQ LOOP_2
	LSR R1, R1, #1 // perform SHIFT
	SUB R0, #1 // Subtract from the max # of bits
	B LEAD

//-------------------------------------------------------------------------

UPDATE_3:

	MOV R10,R0

LOOP_3:

    	CMP R0,R10
    	BGT UPDATE_3
    	LDR R1,[R2],#4 // load the data word into R1
	MOV R0, #32 // R0 will hold the result
	CMP R2, #BOUND
	BGT EXIT 
  
TRAIL:

	CMP R1, #0 // loop until the data contains no more 1’s
	BEQ LOOP_3
	LSL R1, R1, #1 // perform SHIFT
	SUB R0, #1 // Subtract from the max # of bits
	B TRAIL

EXIT:
	MOV PC,LR

NUM_TEST: 
	.word 0x101f800f,0x103fe00f,0x01fc2300,0xff000ff0,0xffff00f0,0xfffff001
BOUND:
	.word 0x-1
.end	
