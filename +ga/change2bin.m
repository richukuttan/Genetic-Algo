%% change2bin: change values to binary
 function [outputs] = change2bin(SampleSize, nvars, minimum, maximum, nbits, inputs)
 	minimum = (minimum)';
 	maximum = (maximum)';
 	nbits = (nbits)';
 	range = maximum - minimum;
 	accu = range ./ (2 .^ nbits);
 	outputs = [];
 	for i = 1:nvars
 		zt = (inputs (:, i) - minimum(1, i)) ./ accu(1, i);
 		z = dec2bin(zt, nbits(1, i)) - '0';
 		outputs = [outputs, z];
 	end
 end 
