// ConsoleApplication1.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>
#include <ctime>
struct Material
{
	short int id;
	time_t date;
	unsigned short int storage;
	unsigned short int number;
	unsigned short int cost;
};

Material materials[500];

void ChangeCost(Material arr[], int n, unsigned short int new_cost) {
	arr[n].cost = new_cost;
}

void ChangeAll(Material arr[], int n, short int new_id, time_t new_date, unsigned short int new_storage,
	unsigned short int new_number, unsigned short int new_cost) {
	arr[n].id = new_id;
	arr[n].date = new_date;
	arr[n].storage = new_storage;
	arr[n].number = new_number;
	arr[n].cost = new_cost;
}

void fill_adressed(Material inp[]) {
	for (int i = 0; i < 500; i ++) {
		materials[i].id = -1;
	}
	for (int i = 0; i < 500; i+= 3) {
		srand(i);
		materials[i].id = i;
		materials[i].date = time(0);
		materials[i].storage = rand() % 1000;
		materials[i].number = rand() % 10000;
		materials[i].cost = rand() % 10000;
	}
}

void fill_adressed_full(Material inp[]) {
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

void Merge(Material* A, int first, int last)
{
	int middle, start, final, j;
	Material* mas = new Material[500];
	middle = (first + last) / 2;
	start = first; 
	final = middle + 1; 
	for (j = first; j <= last; j++) 
		if ((start <= middle) && ((final > last) || (A[start].cost < A[final].cost)))
		{
			mas[j] = A[start];
			start++;
		}
		else
		{
			mas[j] = A[final];
			final++;
		}

	for (j = first; j <= last; j++) A[j] = mas[j];
	delete[]mas;
};

void MergeSort(Material* A, int first, int last)
{
	{
		if (first < last)
		{
			MergeSort(A, first, (first + last) / 2); 
			MergeSort(A, (first + last) / 2 + 1, last);
			Merge(A, first, last); 
		}
	}
};

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
	std::cout << "Address search: \n";
	for (int i = 0; i < 20; i++) {
		Material m = searchByAddr(i, materials);
		if (m.id != -1) {
			std::cout << "address: " << i << " id: " << m.id << " cost: " << m.cost << " storage: " << m.storage << "\n";
		}
		else {
			std::cout << "address: " << i << " <no element with such addr> \n";
		}
	}

	fill_adressed_full(materials);
	//std::cout << materials[15].id << " " << materials[15].date << " " << materials[15].cost << "\n";
	//std::cout << sizeof(time_t) << " " << sizeof(short int);

	//ShellSort(materials, 500);
	MergeSort(materials, 0, 499);
	std::cout << "\n\n\n\ Sorted : \n";
	for (int i = 0; i < 20; i++) std::cout << "id: " << materials[i].id << " cost: " << materials[i].cost << "\n";

	Material res;
	std::cout << "\n Binary search trace: \n";
	int fl = BinarySearch(materials, 500, 106, res);
	std::cout << "\n id, cost, storage for cost=106  elem: \n";
	// cost=101 dont exist?
	if (fl != -1) {
		std::cout << "id: " << res.id << " cost: " << res.cost << " storage: " << res.storage << "\n\n\n";
	}
	else {
		std::cout << "<no such element> \n";
	}

	//std::cout << "\n Hello World!\n";
}

