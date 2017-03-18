%% ga: none
function [values, totavg, totmin] = ga (obj)%(SampleSize, nvars, minimum, maximum, nbits, ngen = NaN, accu = NaN, value = NaN, popn = NaN, xover = @crossover, mut = @mutate, xoverprob = NaN, mutprob = NaN, out = @output)
	%% Checking Input Values 
	if length(obj.SampleSize) ~= 1
		error('SampleSize Must have Length 1')
	end
	if ~isinteger(obj.SampleSize) || (obj.SampleSize < 0)
		error('SampleSize must be a positive integer');
	end
	if length(obj.nvars) ~= 1
		error('nvars Must have Length 1')
	end
	if ~isinteger(obj.nvars) || (obj.nvars < 0)
		error('nvars must be a positive integer');
	end
	if length(obj.minimum) ~= obj.nvars
		error('minimum Must have Length equal to nvars')
	end
	if length(obj.maximum) ~= obj.nvars
		error('maximum Must have Length equal to nvars')
	end
	if sum(obj.maximum <= obj.minimum)
		error ('maximum value must be greater than minimum value')
	end
	if length(obj.nbits) ~= obj.nvars
		error('nbits Must have Length equal to nvars')
	end
	if (~isfinite(obj.ngen) && ~isfinite(obj.accu))
		error('specify either ngen or accu');
	end
	if (isfinite(obj.accu) && ~isfinite(obj.value))
		error('If accu is specified, specify value')
	end
	if isfinite(obj.ngen) && length(obj.ngen) ~= 1
		error('ngen Must have Length 1')
	end
	if isfinite(obj.ngen) && (~isinteger(obj.ngen) || (obj.ngen < 0))
		error('ngen must be a positive integer');
	end
	if isfinite(obj.accu) && length(obj.accu) ~= 1
		error('accu Must have Length 1')
	end
	if isfinite(obj.accu) && (~isreal(obj.accu) || (obj.accu < 0))
		error('accu must be a positive real number');
	end
	if isfinite(obj.value) && length(obj.value) ~= 1
		error('value Must have Length 1')
	end
	if isfinite(obj.value) && (~isreal(obj.value) || ~isfinite(obj.value))
		error('value must be a finite real number');
	end
	if isfinite(obj.xoverprob) && length(obj.xoverprob) ~= 1
		error('xoverprob Must have Length 1')
	end
	if isfinite(obj.xoverprob) && (~isreal(obj.xoverprob) || obj.xoverprob < 0 || obj.xoverprob > 1)
		error('xoverprob must be a finite real number between 0 and 1');
	end
	if isfinite(obj.mutprob) && length(obj.mutprob) ~= 1
		error('mutprob Must have Length 1')
	end
	if isfinite(obj.mutprob) && (~isreal(obj.mutprob) || obj.mutprob < 0 || obj.mutprob > 1)
		error('mutprob must be a finite real number between 0 and 1');
	end
	if isfinite(obj.popn)
		temp = size(obj.popn);
		if (temp (1, 1) ~= obj.SampleSize || temp (1, 2) ~= obj.nvars)
			error('popn does not have the right size (SampleSize, nvars)');
		end
	end

	%% Initialize popn if required
	tmp = false;
	if ~isfinite(obj.popn)
		obj.popn = ga.Initial(obj.minimum, obj.maximum, obj.SampleSize, obj.nvars, obj.nbits);
		tmp = true;
	end
	
	%% GA parameters -- Change to get required parameters
	totmin = [];
	totavg = [];
	mutprob1 = obj.mutprob;

	avg2 = NaN;
	min2 = NaN;

	if ~isfinite(obj.ngen)  % changing iters arguments
		while (~isfinite(avg2)) || (avg2 > value + accu) || (avg2 < value - accu)
			[obj.popn, min2, avg2] = ga.Iters(obj.SampleSize, obj.nvars, obj.minimum, obj.maximum, obj.nbits, obj.popn, obj.xover, obj.mut, obj.xoverprob, obj.mutprob, obj.out);
			totmin = [totmin; min2];
			totavg = [totavg; avg2];
			obj.mutprob = obj.mutprob - mutprob1 / obj.ngen;
		end
	else
		for i = 1:obj.ngen
			[obj.popn, min2, avg2] = ga.Iters(obj.SampleSize, obj.nvars, obj.minimum, obj.maximum, obj.nbits, obj.popn, obj.xover, obj.mut, obj.xoverprob, obj.mutprob, obj.out);
			totmin = [totmin; min2];
			totavg = [totavg; avg2];
			if isfinite(obj.accu)
				if (avg2 < obj.value + obj.accu) && (avg2 > obj.value - obj.accu)
					break;
				end
			end
			obj.mutprob = obj.mutprob - mutprob1 / obj.ngen;
		end
	end
	values = obj.popn;
	% returning parameters to original values
	obj.mutprob = mutprob1;
	if tmp
		obj.popn = NaN;
	end
end

%% Description of Variables
% SampleSize : Single Positive Integer, gives size of starting sample.
% nvars      : Single Positive Integer, gives number of variables.
% minimum    : Column Vector of size nvars, gives minimum value of each variable.
% maximum    : Column Vector of size nvars, gives maximum value of each variable.
% nbits      : Column Vector of size nvars, gives number of bits to encode each variable.
% ngen       : Single Positive Integer, gives number of generations to run. Optional. Give either this, or the accuracy as input.
% accu       : This is the desired accuracy. This is used for testing purposes, when the final value is already known.
% value      : Give this whenever the accu is given. This is the final value.
% xover      : This is optional. Either write a crossover function and pass it as an argument, or use this.
% mut        : This is optional. Either write a crossover function and pass it as an argument, or use this.
% popn       : This is optional. Either give a starting population, or let the algorithm use Initial.m to create one.
%              The starting population should be numerical with SampleSize rows and nvars columns, such that the maximum and minimum conditions are met.
% xoverprob  : This is optional. This is an argument essential to the default xover function.
% mutprob    : This is optional. This is an argument essential to the default mut function.
% out        : Give the output function. Its input will be a row vector of arguments, in decimal.

%% isinteger: Check if value is integer
function [output] = isinteger(x)
	output = isfinite(x) && isreal(x) && (x == round(x));
end
