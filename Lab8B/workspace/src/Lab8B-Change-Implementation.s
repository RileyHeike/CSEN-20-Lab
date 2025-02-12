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

// void Bills(uint32_t dollars, BILLS *bills) ;

        .global     Bills
        .thumb_func
        .align

Bills:  // R0 = dollars, R1 = bills

        LDR         R2,=0xCCCCCCCD
        UMULL       R3,R2,R2,R0
		LSRS		R3, R2, 4				// R3 = dollars / 20
		STR			R3,	[R1]				// bills->twenties = R3
		ADD			R3, R3, R3, LSL 2		// R3 = 5 * bills->twenties
		SUB 		R0, R0, R3, LSL 2		// dollars -= 20 * bills->twenties
		B           Common

// void Coins(uint32_t cents, COINS *coins) ;

        .global     Coins
        .thumb_func
        .align

Coins:  // R0 = cents, R1 = coins

        LDR         R2,=0x51EB851F
        UMULL       R3,R2,R2,R0 
		LSRS		R3, R2, 3				// R3 = cents / 25
        STR 		R3, [R1]				// coins->quarters = R3
		ADD			R2, R3, R3, LSL 1		// R2 = 3 * coins->quarters
		ADD			R3, R3, R2, LSL 3		// R3 = 25 * coins->quartes
		SUB			R0, R0, R3				// cents -= 25 * coins->quarters

Common: // R0 = amount, R1 = structure pointer

        LDR         R2,=0xCCCCCCCD
        UMULL       R3,R2,R2,R0
		LSRS 		R3, R2, 3				//R3 = amount / 10
		STR			R3, [R1, 4]				//pointer->slot 1 = R3
		ADD			R3, R3, R3, LSL 2		// R3 = 5 * pointer->slot 1
		SUB			R0, R0, R3, LSL 1		//Amount -= 10 * pointer->slot 1

        LDR         R2,=0xCCCCCCCD
        UMULL       R3,R2,R2,R0
		LSRS 		R3, R2, 2				//R3 = amount / 5
		STR			R3, [R1, 8]				//pointer->slot 2 = R3
		ADD			R3, R3, R3, LSL 2		// R3 = 5 * pointer->slot 2
		SUB			R0, R0, R3				//Amount -= 5 * pointer->slot 2
		
		STR			R0, [R1, 12]			//pointer->slot 3 = R0
		
        BX          LR

        .end


