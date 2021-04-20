#include <iostream>
#include "printer.h"
#include <string.h>

extern void __stdcall PRINT(char* str) {
	int lg;
	lg = strlen(str);
	if (true) {
		printf("\nResult: %s", str);
	}
	else {
		std::cout << "\nNo repeats found\n";
	}

}