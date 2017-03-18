%% Initialize function

function [initial] = Initial(minimum, maximum, SampleSize, nvars, nbits)
	initial = round1(repmat((minimum)', SampleSize, 1) + repmat((maximum - minimum)', SampleSize, 1) .* (rand(SampleSize, nvars)), repmat((minimum)', SampleSize, 1), repmat((maximum)', SampleSize, 1), repmat((nbits)', SampleSize, 1));
end


%% round1: Custom round function
function [rnd1] = round1(arg, minimum, maximum, nbits)
	range = maximum - minimum;
	accu = range ./ ((2 .^ nbits) - 1);
	rnd1 = accu .* (round(arg ./ accu));
end
