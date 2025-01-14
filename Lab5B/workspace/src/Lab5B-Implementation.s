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

// uint8_t *BitmapAddress(char ascii, uint8_t *fontTable, int charHeight, int charWidth) ;

        .global     BitmapAddress
        .thumb_func
        .align

BitmapAddress:
		ADD 	R3, R3, #7 			// R3 <-- charWidth + 7
        LSRS.N	R3, R3, #3			// R3 <-- (charWidth + 7) / 8		
        SUB 	R0, R0, ' '			// R0 <-- ascii - ' '
		MUL		R0, R0, R3			// R0 <-- (ascii - ' ')((charWidth + 7)/8)
		MUL		R0, R0, R2			// R0 <-- (ascii - ' ')((charWidth + 7)/8)(charHeight)
		ADD		R0, R1, R0			// R0 <-- fontTable + (ascii - '')((charWidth + 7)/8)(charHeight)     
        BX          LR

// uint32_t GetBitmapRow(uint8_t *rowAdrs) ;

        .global     GetBitmapRow
        .thumb_func
        .align

GetBitmapRow:
        LDR	 	R0, [R0]	// R0 <-- *rowAdrs
		REV		R0, R0		// R0 <-- ReverseBits(R0)
        BX          LR

// void WritePixel(int x, int y, uint8_t colorIndex, uint8_t frameBuffer[256][240]) ;

        .global     WritePixel
        .thumb_func
        .align

WritePixel:

		ADD R3, R3, R0			// R3 <-- &frameBuffer + x
		LDR R0, =240			// R0 <-- 240
		MUL R1, R1, R0			// R1 <-- 240*y
        STRB	R2, [R3, R1]	// colorIndex --> frameBuffer[240*y+x]
        BX          LR

        .end

