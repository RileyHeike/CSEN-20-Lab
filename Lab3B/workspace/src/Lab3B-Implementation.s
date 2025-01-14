        .syntax         unified
        .cpu            cortex-m4
        .text


// int32_t Return32Bits(void) ;
        .global         Return32Bits
        .thumb_func
        .align

Return32Bits:
		LDR R0,=10    	//Load value of 10 into R0
        BX              LR


// int64_t Return64Bits(void) ;
        .global         Return64Bits
        .thumb_func
        .align

Return64Bits:
		LDR R0,=-10		//Load value of -10 into R0
		LDR R1,=-1		//Load value -1 into R1
        BX              LR


// uint8_t Add8Bits(uint8_t x, uint8_t y) ;
        .global         Add8Bits
        .thumb_func
        .align
		
Add8Bits:
		ADD R0,R0,R1	//Add R0 and R1, and then store result in R0
		UXTB R0,R0		//Extend 8-bit result to 32-bits
        BX             LR


// uint32_t FactSum32(uint32_t x, uint32_t y) ;
        .global         FactSum32
        .thumb_func
        .align
FactSum32:
		PUSH {R4, LR}	//Push R4 and LR to the stack
		ADD R0,R0,R1	//Add R0 and R1, store result in R0
		BL Factorial	//Call Factorial function (R0 = Factorial(x, y))
		POP {R4, PC}		//Pop R4 and LR from the stack
        BX             LR


// uint32_t XPlusGCD(uint32_t x, uint32_t y, uint32_t z) ;
        .global         XPlusGCD
        .thumb_func
        .align
XPlusGCD:
		PUSH {R4, LR}	//Push R4 and LR to the stack
		MOV R4, R0		//Move x value to R4
		MOV R0, R1		//Move y value to R0
		MOV R1, R2		//Move z value to R1
		
		BL gcd			//Call gcd function (R0 = gcd(z,y))
		ADD R0,R0,R4	//Add x to result from gcd
		
		POP {R4, PC}		//Pop R4 and LR from the stack
        BX             LR

        .end


