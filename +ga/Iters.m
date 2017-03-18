%% Iters: One iteration of GA
function [children, min2, avg2] = Iters(SampleSize, nvars, minimum, maximum, nbits, parents, xover, mut, xoverprob, mutprob, out)
	[x, min2, avg2] = out(SampleSize, nvars, parents);
	total = sum(x);
	probs = x / total;
	cumlv = cumsum(probs, 1);
	t = rand(SampleSize, 1);
	children1 = zeros(SampleSize, nvars);
	for i = 1:SampleSize
		for j = 1:SampleSize
			if (t(i, 1) <= cumlv(j, 1))
				children1(i, :) = parents(j, :);
				break;
			end
		end
	end
	t = randperm(SampleSize);
	temp = 1;
	children3 = ga.change2bin(SampleSize, nvars, minimum, maximum, nbits, children1);
	for i = 1:2:SampleSize
		[children2(i, :), children2(i + 1, :)] = xover(nvars, nbits, children3(t(1, i), :), children3(t(1, i + 1), :), xoverprob);
	end
	for i = 1:SampleSize
		children3(i, :) = mut(children2(i, :), mutprob);
	end
	children = ga.change2dec(SampleSize, nvars, minimum, maximum, nbits, children3);
end