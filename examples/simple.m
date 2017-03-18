% declare a script file
1;

% create the helper class

A = ga.gaclass(); 

% Add values

A.SampleSize = 500; % No of samples per generation
A.nvars = 10; % no. of variables
A.minimum = -5.12 * ones(10, 1); % a column vector of minimum values for variables; size(A.minimum) must be nvars.
A.maximum = 5.12 * ones(10, 1); % a column vector of maximum values for variables; size(A.maximum) must be nvars.
A.nbits = 12 * ones(10, 1); % a column vector of no. of bits for encoding variables; size(A.nbits) must be nvars.
A.ngen = 500; % No. of generations the ga will run
A.xoverprob = 0.8; % Note that we are using the default xover function. This is the crossover probability.
A.mutprob = 0.1; % Note that we are using the default mut function.
%This is NOT the bitwise mutation probability, but the probability that at least one bit of the variable changes.
%Check the mut function for the working.

[V, Avg, Min] = ga.ga(A);

%V is the final value of the variables.
%Avg is a matrix of the average value of the output function each generation.
%Min is a matrix of the minimum value of the output function each generation.

MinVal = Min(A.SampleSize, 1) % This gives the final minimum value.