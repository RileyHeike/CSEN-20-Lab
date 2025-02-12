/*
    This code was written to support the book, "ARM Assembly for Embedded Applications",
    by Daniel W. Lewis. Permission is granted to freely share this software provided
    that this notice is not removed. This software is intended to be used with a run-time
    library adapted by the author from the STM Cube Library for the 32F429IDISCOVERY 
    board and available for download from http://www.engr.scu.edu/~dlewis/book3.
*/
        .syntax         unified
        .cpu            cortex-m4
        .text
// int Between(int min, int value, int max) ;
        .global         Between
        .thumb_func
        .align
Between:				// R0 = min, R1 = val, R2 = max

       SUB R2, R2, R0 	// R2 = max - min
       SUB R1, R1, R0 	// R1 = val - min
       CMP R1,R2		// (val - min) <= (max - min)?
       ITE    LS        
       LDRLS  R0, =1	// If yes, return 1
       LDRHI  R0, =0    // Else, return 0

       BX              LR
	   
// int Count(int cells[], int numb, int value) ;
        .global        Count
        .thumb_func
        .align
		
Count:              			   // R0 = cells, R1 = numb, R2 = value
        
        LDR R3, =0	        	   // count (R3) <-- 0
        ADD R1, R0, R1, LSL 2	   // R1 <-- &cells[numb]
Loop:
       		 CMP R0, R1			   // done?
        	 BEQ	Done		   // Yes: return
             
             LDR R12, [R0],4       // R12 = *cells++
								   //
								   //
        	 CMP    R12, R2		   // if (cells[numb] == value) count++
             IT     EQ
             ADDEQ  R3, R3,#1      
             
			 B               Loop
Done:
        	 MOV R0, R3		// return count
        	 BX              LR
        .end


