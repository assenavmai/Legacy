/*Vanessa White
	Recurisve Ackermann function with timing*/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>

/*Recursive Ackermann function*/
int ackermann(int m, int n){

	if(m == 0)
	{
		return n + 1;
	}
	else if(n == 0)
	{
		return ackermann(m - 1, 1);
	}
	else
	{
		return ackermann(m - 1, ackermann(m, n - 1));
	}

}

int main(int argc, char const *argv[])
{
	int m, n, i , j,result;
	struct timeval t1, t2, tv;

	printf("Enter m and n: ");
	scanf("%d%d", &m, &n);

	gettimeofday(&t1, NULL);

	for(i = 0; i <= m; i++)
	{
		for(j = 0; j <= n - m; j++)
		{
			result = ackermann(m, n);
		}
	}
	
	gettimeofday(&t2, NULL);

	printf("Result %d\n", result);
	
	timersub(&t2, &t1, &tv);
	printf("%ld milliseconds\n", (1000000 * tv.tv_sec + tv.tv_usec)/1000);
	
	return 0;
}