#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <time.h>
#include <iostream>

#include <chrono>
#include <windows.h>
#include <Psapi.h>
//using namespace std;
using namespace std::chrono;

int main()
{
	struct Node {
		int val;
		Node* next;
		Node* prev;
	};

	high_resolution_clock::time_point t1 = high_resolution_clock::now();
	PROCESS_MEMORY_COUNTERS memCounter1;
	BOOL result = K32GetProcessMemoryInfo(GetCurrentProcess(), &memCounter1, sizeof(memCounter1));
	for (int cnt = 0; cnt < 1; cnt++) {
		int N = 90, i = 0, f = 0;
		// int k, j = 0;
		int k = 0;
		double *a;
		double pr = 0;
		Node* list = new Node;
		Node* p;
		Node* pb;
		Node* listend;
		Node* bufptr;
		p = list;
		listend = list;
		srand(time(NULL));
		p->val = -50 + rand() % 101;
		p->next = nullptr;
		p->prev = nullptr;

		int inputN;
		std::cout << "Enter list length (N <= 100)\n";
		inputN = scanf_s("%d", &N);

		if (N > 0 && N <= 100 && inputN == 1) {
			for (int cnt3 = 0; cnt3 < 1; cnt3++) {
				p = list;
				for (i = 1; i < N; i++) {
					while (f == 0) {
						//std::cout << "while tick \n";
						bufptr = p;
						p->next = new Node;
						p = p->next;
						listend = p;
						p->prev = bufptr;
						p->val = -50 + rand() % (101);
						p->next = nullptr;
						//for (int cnt2 = 0; cnt2 < 1; cnt2++) {
						pb = list;
						f = 1;
						/*while (pb != nullptr) {
							//std::cout << "while not null tick \n";
							if (pb->val == p->val && pb != p) {
								f = 0;
								break;
							}
							pb = pb->next;
						}*/
						while (pb != nullptr) {
							//std::cout << "while not null tick \n";
							if (pb->val != p->val) k++;
							pb = pb->next;
						}
						if (k == i) f = 1;
						k = 0;
						//}
					}
					f = 0;

				}
			}

			printf("\nList:\n");
			pb = list;
			while (pb != nullptr) {
				std::cout << pb->val << "\n";
				pb = pb->next;
			}

			printf("\nList backwards:\n");
			pb = listend;
			while (pb != nullptr) {
				std::cout << pb->val << "\n";
				pb = pb->prev;
			}

			std::cout << "\n\nSum elems:";
			pb = list;
			while (pb != nullptr) {
				pr += i + pb->val - i + 1;
				printf("\nf(n) = i+n-i+1 = %d + (%d) - %d + 1 = %d", i, pb->val, i, i + pb->val - i + 1);
				pb = pb->next;
			}

			std::cout << "\n\nSum: " << pr << "\n\n";
			p = list;
			pb = list->next;
			while (pb != nullptr) {
				free(p);
				p = pb;
				pb = pb->next;
			}
		}
		else {
			std::cout << "\nN is invalid\n";
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