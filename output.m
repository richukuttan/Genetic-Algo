%% Feature function

function [values, minval, avgval] = output(SampleSize, nvars, inputs)
	zt = zeros(SampleSize, 1);
	for i = 1:nvars
		zt = zt + (inputs(:, i) .^ 2) - 10 * cos(2 * 3.1416 * inputs(:, i));
	end
	f = 10 * nvars + zt;
	minval = min(f);
	avgval = sum(f)/SampleSize;
	values = 1 ./ (1 + abs(f));
end