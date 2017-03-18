# Genetic-Algo

Fully functional Genetic algo package.

All modifiable functions are upfront, i.e., the files mutate.m, crossover.m and output.m may be changed. Alternate files may be provided using the class @gaclass.

# Steps to run a GA

1. Make a variable of type gaclass eg: A = ga.gaclass()
2. Change values of A to get required values eg: A.SampleSize = 50.
3. (Opltiona) Change mutate.m, crossover.m and output.m to get required functions, or change A.mut, A.xover and A.out to point to user-made functions.
4. Run ga.ga Eg:[Value, Min, Avg] = ga.ga(A)

This gives the final variables values, Minimum result values in each generation and Average result values in each generation.

