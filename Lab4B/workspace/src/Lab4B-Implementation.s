/*
    This code was written to support the book, "ARM Assembly for Embedded Applications",
    by Daniel W. Lewis. Permission is granted to freely share this software provided
    that this notice is not removed. This software is intended to be used with a run-time
    library adapted by the author from the STM Cube Library for the 32F429IDISCOVERY 
    board and available for download from http://www.engr.scu.edu/~dlewis/book3.
*/
        .syntax     unified
        .cpu        cortex-m4
        .text

// void OffBy0(void *dst, const void *src) ;

        .global     OffBy0
        .thumb_func
        .align
OffBy0:
        .rept       1000/8		//No Reallignment needed
		LDR R2,[R1,4]			//Load and store each word-aligned address
		LDR	R3,[R1],8
		STR R2,[R0,4]
		STR R3,[R0],8
        .endr
		
        BX          LR

// void OffBy1(void *dst, const void *src) ;

        .global     OffBy1
        .thumb_func
        .align
OffBy1:
		LDRH R2,[R1],2		//Load first 2/3 offset bytes
		STRH R2,[R0],2		//Store first 2/3 offset bytes
        LDRB R2,[R1],1		//Load other first offset byte
		STRB R2,[R0],1		//Store other first offset byte

       
		.rept       (1000/8)-1		//Load and store middle chunk of word-aligned addresses
        LDR R2,[R1,4]			
		LDR	R3,[R1],8
		STR R2,[R0,4]
		STR R3,[R0],8
        .endr
        
		LDR R2,[R1],4		//Load last aligned word
		STR R2,[R0],4		//Store last aligned word
		
		LDRB R2,[R1]		//Load last offset byte
		STRB R2,[R0]		//Store last offset byte
        
		BX          LR

// void OffBy2(void *dst, const void *src) ;

        .global     OffBy2
        .thumb_func
        .align
OffBy2:
        LDRH R2,[R1],2		//Load first 2 offset bytes
		STRH R2,[R0],2		//Store first 2 offset bytes
	
		
        .rept       (1000/8)-1		//Load and store middle chunk of word-aligned addresses
        LDR R2,[R1,4]			
		LDR	R3,[R1],8
		STR R2,[R0,4]
		STR R3,[R0],8
        .endr
		
		LDR R2,[R1],4		//Load last aligned word
		STR R2,[R0],4		//Store last aligned word

        LDRH R2,[R1]		//Load last 2 offset bytes
		STRH R2,[R0]		//Store last 2 offset bytes

		
		BX          LR
		
// void OffBy3(void *dst, const void *src) ;

        .global     OffBy3
        .thumb_func
        .align
OffBy3:

		LDRB R2,[R1],1		//Load first offset byte		
		STRB R2,[R0],1		//Store first offset byte
		
        .rept       (1000/8)-1		//Load and store middle chunk of word-aligned addresses
        LDR R2,[R1,4]			
		LDR	R3,[R1],8
		STR R2,[R0,4]
		STR R3,[R0],8
        .endr
		
		LDR R2,[R1],4		//Load last aligned word
		STR R2,[R0],4		//Store last aligned word
		
		LDRH R2,[R1],2		//Load 2/3 last offset bytes		
		STRH R2,[R0],2		//Store 2/3 last offset bytes
        LDRB R2,[R1]		//Load last offset byte		
		STRB R2,[R0]		//Store last offset byte
		
        BX          LR

        .end


