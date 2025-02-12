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


// BOOL GetBit(uint16_t *bits, uint32_t row, uint32_t col) ;

        .global     GetBit
        .thumb_func
        .align

        //.set        BITBANDING,1        // Comment out if not using bit-banding

GetBit: 			
		SUB R0,R0,0x20000000		// R0 = bits - 0x20000000
		LSL	R0,R0,5					// R0 = ((bits - 0x20000000) << 5)
		ADD R0,R0,0x22000000		// R0 = (0x22000000 + ((bits - 0x20000000) << 5)
		ADD R1,R2,R1, LSL 2			// R1 = 4*row + col
		LDR R0, [R0,R1,LSL 2]		// R0 = R0 + (bitpos << 2) i.e, Add offset and retrieve bit
        BX          LR


// void PutBit(BOOL value, uint16_t *bits, uint32_t row, uint32_t col)

        .global     PutBit
        .thumb_func
        .align

PutBit:
		SUB R1, R1, 0x20000000		// R1 = bits - 0x20000000
		LSL R1,R1,5					// R1 = ((bits - 0x20000000) << 5)
		ADD R1,R1,0x22000000		// R1 = (0x22000000 + ((bits - 0x20000000) << 5)
		ADD R2,R3,R2,LSL 2			// R2 = 4*row + col
		STR R0,[R1,R2,LSL 2]		// R0 -> R1 + (bitpos << 2) i.e, Add offset and store bit
        BX          LR

        .end
