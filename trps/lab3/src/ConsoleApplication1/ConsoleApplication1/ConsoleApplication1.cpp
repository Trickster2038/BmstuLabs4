// ConsoleApplication1.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <time.h>

#include <iostream>
#include <chrono>

#include <windows.h>
#include <Psapi.h>

using namespace std;
using namespace std::chrono;

int main()
{
	high_resolution_clock::time_point t1 = high_resolution_clock::now();

	PROCESS_MEMORY_COUNTERS memCounter1;
	BOOL result = K32GetProcessMemoryInfo(GetCurrentProcess(), &memCounter1, sizeof(memCounter1));

	for (int cnt = 0; cnt < 1; cnt++) { //100k by default
		int N, halfRange, i, j, k = 0, f = 0;
		int inputN, inputHr;
		double* a;
		double pr = 1;
		srand(time(NULL));

		printf("\n%s\n", "Input length of array (<100)");
		inputN = scanf_s("%d", &N);

		if (inputN == 1 && N > 0 && N < 100) {
			a = (double*)malloc(N * sizeof(double));

			printf("\n%s\n", "Input half-range of number >=N");
			inputHr = scanf_s("%d", &halfRange);
			if (inputHr == 1 && halfRange > 0 && halfRange*2 > N) {
				
				for (i = 0; i < N; i++) {
					while (f == 0) {
						f = 1;
						a[i] = -halfRange + rand() % (2 * halfRange + 1);
						for (j = 0; j < i; j++) {
							if (a[i] == a[j]) f = 0;
						}
					}
					f = 0;
				}
				printf("\nDefault array:\n");
				for (i = 0; i < N; i++) {
					printf("%.2f\n ", a[i]);
				}
				for (i = 0; i < N; i++) {
					pr *= a[i];
				}
				printf("\nProduct:%.2f\n", pr);
			}
			else {
				printf("\n%s\n", "Invalid half-range of element");
			}

			free(a);
		}
		else {
			printf("\n%s\n", "Invalid length of array");
		}
	}

	high_resolution_clock::time_point t2 = high_resolution_clock::now();
	duration<double> time_span = t2 - t1;
	std::cout << "It took me " << time_span.count() << " seconds.";
	std::cout << std::endl;

	PROCESS_MEMORY_COUNTERS memCounter2;
	result = K32GetProcessMemoryInfo(GetCurrentProcess(), &memCounter2, sizeof(memCounter2));
	std::cout << "Memory leak: " << memCounter2.WorkingSetSize - memCounter1.WorkingSetSize << std::endl;

	std::cout << "\n(press any key to exit)\n";
	std::getchar();

	return 0;
}

// Запуск программы: CTRL+F5 или меню "Отладка" > "Запуск без отладки"
// Отладка программы: F5 или меню "Отладка" > "Запустить отладку"

// Советы по началу работы 
//   1. В окне обозревателя решений можно добавлять файлы и управлять ими.
//   2. В окне Team Explorer можно подключиться к системе управления версиями.
//   3. В окне "Выходные данные" можно просматривать выходные данные сборки и другие сообщения.
//   4. В окне "Список ошибок" можно просматривать ошибки.
//   5. Последовательно выберите пункты меню "Проект" > "Добавить новый элемент", чтобы создать файлы кода, или "Проект" > "Добавить существующий элемент", чтобы добавить в проект существующие файлы кода.
//   6. Чтобы снова открыть этот проект позже, выберите пункты меню "Файл" > "Открыть" > "Проект" и выберите SLN-файл.
