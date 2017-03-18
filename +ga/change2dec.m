%% change2bin: change values to binary
 function [outputs] = change2dec(SampleSize, nvars, minimum, maximum, nbits, inputs)
 	minimum = (minimum)';
 	maximum = (maximum)';
 	nbits = (nbits)';
 	range = maximum - minimum;
 	accu = range ./ (2 .^ nbits);
 	outputs = [];
 	for i = 1:nvars
 		zt = char(inputs(:, sum(nbits(1, 1:(i - 1))) + 1 : sum(nbits(1, 1:i))) + '0');
 		z = bin2dec(zt) * accu(1, i) + minimum(1, i);
 		outputs = [outputs z];
 	end
 end 
