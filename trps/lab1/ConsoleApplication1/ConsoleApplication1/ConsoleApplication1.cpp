// ConsoleApplication1.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>
#include <ctime>
struct Material
{
	unsigned short int id;
	time_t date;
	unsigned short int storage;
	unsigned short int number;
	unsigned short int cost;
};

Material materials[500];

void fill_adressed(Material inp[]) {
	for (int i = 0; i < 500; i++) {
		srand(i);
		materials[i].id = i;
		materials[i].date = time(0);
		materials[i].storage = rand() % 1000;
		materials[i].number = rand() % 10000;
		materials[i].cost = rand() % 10000;
	}
}

void ShellSort(Material A[], int n) 
{
	int i, j, d;
	Material buff;
	d = n;
	d = d / 2;
	while (d > 0)
	{
		for (i = 0; i < n - d; i++)
		{
			j = i;
			while (j >= 0 && A[j].cost > A[j + d].cost)
			{
				buff = A[j];
				A[j] = A[j + d];
				A[j + d] = buff;
				j--;
			}
		}
		d = d / 2;
	}
}

int BinarySearch(Material arr[], int n, int cost, Material& result)
{
	int left = 0;
	int right = n;
	int midd = 0;
	result = arr[0];
	while (left <= right)
	{
		midd = (left + right) / 2;

		std::cout << left << " " << midd << " " << right << "\n";

		if (cost < arr[midd].cost)      
			right = midd - 1;      
		else if (cost > arr[midd].cost)  
			left = midd + 1;    
		else {
			result = arr[midd];
			return midd;
		}

		if (left > right)         
			return -1;
	}
}

unsigned int addrFunc(unsigned int n) {
	return n;
}

Material searchByAddr(unsigned int n, Material arr[]) {
	unsigned int addr = addrFunc(n);
	return arr[addr];
}

int main()
{
	fill_adressed(materials);
	std::cout << materials[15].id << " " << materials[15].date << " " << materials[15].cost << "\n";
	std::cout << sizeof(time_t) << " " << sizeof(short int);

	ShellSort(materials, 500);
	std::cout << "\n Sorted cost+id: \n";
	for (int i = 0; i < 20; i++) std::cout << materials[i].cost << "+" << materials[i].id << " ";

	Material res;
	std::cout << "\n Binary search: \n";
	std::cout << BinarySearch(materials, 500, 106, res);

	std::cout << "\n id, cost, storage for cost=106  elem: \n";
	std::cout << res.id << " " << res.cost << " " << res.storage;

	std::cout << "\n Hello World!\n";
}

