//Count the largest number of consecutive ones in an array of words
.text
.global start
start:

	LDR R2, =NUM_TEST
    	LDR R1,[R2] // load the data word into R1
    	MOV R3, #0
    	MOV R0, #0
    	BL ONES
    	POP {R5}

END:
	B END 
UPDATE:

	MOV R3,R0
	PUSH {R0}

LOOP:

    	CMP R0,R3
    	BGT UPDATE
    	LDR R1,[R2],#4 // load the data word into R1
	MOV R0, #0 // R0 will hold the result
	CMP R2, #BOUND
	BGT EXIT 
  
ONES: 

	CMP R1, #0 // loop until the data contains no more 1’s
	BEQ LOOP
	LSR R6, R1, #1 // perform SHIFT, followed by AND
	AND R1, R1, R6
	ADD R0, #1 // count the string lengths so far
	B ONES

EXIT:
	MOV PC,LR

NUM_TEST: 
	.word 0x101f800f,0x103fe00f,0x01fc2300,0xff000ff0,0xffff00f0,0xfffff001
BOUND:
	.word 0x-1
.end	
