/*Ackermann function, iterative with timings
Code given by Michael Wirth.
Implementation used with a stack*/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>

#define STACKSIZE 1000000

struct dataT{

	int m;
};

struct stack{

	int top;
	struct dataT items[STACKSIZE];
}st;

void createStack(){
	st.top = -1;
} 

int isFull(){

	if(st.top >= STACKSIZE -1)
		return 1;

	return 0;
}

int isEmpty(){

	if(st.top == -1)
	{
		return 1;
	}

	return 0;
}

int stack_size(){

	return st.top;
}

int top(){

	return st.items[st.top].m;
}

void push(int m){

	if(isFull())
	{
		fputs("Error: Stack Overflow\n", stderr);
		exit(1);
	}
	else
	{
		st.top = st.top + 1;
		st.items[st.top].m = m;
	}
}

void pop(int * m){

	if(isEmpty())
	{
		fputs("Error: Stack Underflow\n", stderr);
		exit(1);
	}
	else
	{
		*m = st.items[st.top].m;
		st.top = st.top - 1;
	}
}

int ackermann(int m, int n){

	push(m);

	while(!isEmpty())
	{
		pop(&m);

		if(m == 0)
		{
			n = n + 1;
		}
		else if(n == 0)
		{
			n = 1;
			push(m - 1);
		}
		else
		{
			n = n - 1;
			push(m - 1);
			push(m);
		}
	}

	return n;
}

int main(int argc, char const *argv[])
{
	int r, m, n;
	struct timeval t1, t2, tv;

	createStack();

	printf("Enter m and n: ");
	scanf("%d%d", &m, &n);

	gettimeofday(&t1, NULL);

	r = ackermann(m,n);

	gettimeofday(&t2, NULL);

	printf("Result %d\n", r);

	timersub(&t2, &t1, &tv);
	printf("%ld milliseconds\n", (1000000 * tv.tv_sec + tv.tv_usec)/1000);
	return 0;
}