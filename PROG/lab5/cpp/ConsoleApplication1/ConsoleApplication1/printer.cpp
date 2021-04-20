#include <iostream>
#include "printer.h"

extern void __stdcall PRINT(char* str) {
	printf("\n%s", str);
	std::cout << "\nModule 3\n";
}