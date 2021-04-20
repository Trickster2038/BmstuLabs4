#include <iostream>
#include "printer.h"
#include <string.h>

extern void __stdcall PRINT(char* str) {
	int lg;
	lg = strlen(str);
	if (lg > 0) {
		printf("\nResult: %s", str);
	}
	else {
		std::cout << "\nNo repeats found\n";
	}

}