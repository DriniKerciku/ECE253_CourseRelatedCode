// this code implements a bubble sort algorithm in assembly
// NOTE: a C code that the assembly follows is provided for clarity

int lt(int x,int y) {
   if(x < y) {
      return 0;
   } else {
      return -1;
   }
}

int gt(int x,int y) {
   if(x > y) {
      return 0;
   } else {
      return -1;
  }
}

int bs(int *x,int size, int (*compare)(int x,int y)) {
   int i = 0, res = 0, temp1 = 0, temp2 = 0, done = 0;

   if(x == NULL) {
      return -1;
   }
   if(size == 1) {
      return 0;
   }

   done = 1;
   while(done != 0) {
      done = 0;
      for(i=1;i<size;i++) {
         temp1 = x[i];
         temp2 = x[i-1];
         res = (*compare)(temp1,temp2);		//function pointer call to make it more generic
         if(res == 0) {
            x[i] = temp2;
            x[i-1] = temp1;
            done = 1;
         }
      }
   }
   return 0;
}

//---------------------------------------------------------

// implementing bubble sort in ascending order

.text
.global _start
_start:

	LDR R1,=LIST
	LDR R10,[R1]
	CMP R10,#1
	BLE END		//check corner case
	

O_LOOP:
 
	MOV R8,#0	//place holder for swap
	MOV R9,#1	//loop counter
	ADD R5,R1,#4	//load the address of the first element

I_LOOP:

	CMP R10,R9
	BEQ END_I
	MOV R0,R5
	BL SWAP

	ORR R8,R8,R0	//store the flag of the element if swapped

	ADD R9,R9,#1
	ADD R5,R5,#4	//load the address of the next element
	B I_LOOP

END_I:

	SUB R10,R10,#1
	CMP R8,#0
	BEQ END
	
	LDR R1,=LIST	//reload
	B O_LOOP
	
END:
	B END

//SWAP SUBROUTINE
//R0 has the address of the next element as the input
//return R0 = 1 if swap happened or R0 = 0 if nothing happend

SWAP:

	MOV R6,R0
	MOV R0,#0
	LDR R2,[R6]
	LDR R3,[R6,#4]
	CMP R2,R3
	BLT RETURN

	MOV R0,#1
	STR R3,[R6]
	STR R2,[R6,#4]

RETURN:
	MOV PC,LR
LIST:
	.word 10,0x1400,0x45,0x23,0x5,0x3,0x8,0x17,0x4,0x20,0x33
.end
