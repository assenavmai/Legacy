#!/usr/bin/python
# Star Wars Quote: "Do. Or do not. There is no try." The Empire Strikes Back
#Vanessa White, 2015
# Iterative Ackermann function, using a stack

import timeit
import time

# Initializing the stack
stack = [];

#Iterative ackermann function
def ackermann(m,n):

	stack.append(m)

	while stack:
		
		m = stack.pop()
		
		if m == 0:
			n = n + 1
		elif n == 0:
			 n = 1
			 stack.append(m - 1)
		else:
			n = n - 1
			stack.append(m - 1)
			stack.append(m)
	return n

m = input("Enter m: ")
n = input("Enter n: ")
print '\n'

start = time.time()

result = ackermann(m,n)

end = time.time()

print "Result: ", result
print "Elapsed time: ", (end - start) * 1000, "ms" 
