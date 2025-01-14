
#include <stdint.h>

char * mag2string(uint8_t mag, int radix, char *string)
	{
		//Define digit lookup table
		static const char hex[] = "0123456789ABCDEF";
		
		//Recursively progress through number using repeated division
		if(mag >= radix) string = mag2string(mag / radix, radix, string);
		
		//Assign each string position a digit using the lookup table
		*string++ = hex[mag % radix];
		
		//End string with \0 and return string
		*string = '\0';
		return string;	
	}

//radix 8
void Bits2OctalString(uint8_t bits, char string[])
    {
		//Use main function with radix 8
		mag2string(bits, 8, string);
    }

//radix 10
void Bits2UnsignedString(uint8_t bits, char string[])
    {
		//Use main function with radix 10
		mag2string(bits, 10, string);
    }

//radix 16
void Bits2HexString(uint8_t bits, char string[])
    {
		//Use main function with radix 16
		mag2string(bits, 16, string);
    }


void Bits2TwosCompString(uint8_t bits, char string[])
    {
		//Determine sign of bits by checking value of MSB
		char sign = ((bits & (1 << 7)) != 0) ? '-':'+';
		
		//If sign is -, flip the bits and add 1
		if(sign == '-') bits = ~bits + 1;
	
		//Write the sign to the string, and then convert magnitude to base 10
		string[0] = sign;
		Bits2UnsignedString(bits, string+1);
    }

void Bits2SignMagString(uint8_t bits, char string[])
    {
		//Determine the sign of bits by checking value of MSB
		char sign = ((bits & (1 << 7)) != 0) ? '-':'+';
		
		//Mask the first bit
		unsigned mag = (bits & 0x7F);
	
		//Write the sign to the string, and then convert magnitude to base 10
		string[0] = sign;
		Bits2UnsignedString(mag, string+1);
	}



//Alternative: create magnitude to string conversion function
//and use it in Bits2OctalString, Bits2UnsignedString and Bits2HexString
