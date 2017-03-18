%% crossover: One crossover function
function [z1, z2] = crossover(nvars, nbits, parent1, parent2, prob)
	sz = sum(nbits);
	pn = 1 - ((1 - prob) ^ (1 / sz));
	t = rand(1, sz);
	z1 = zeros(1, sz);
	z2 = zeros(1, sz);
	for i = 1:sz
		if (t(1, i) < pn)
			z1(1, i) = parent2(1, i);
			z2(1, i) = parent1(1, i);
		else
			z1(1, i) = parent1(1, i);
			z2(1, i) = parent2(1, i);
		end
	end
end