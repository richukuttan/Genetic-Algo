%% mutate: One mutate function
function [z1] = mutate(parent1, prob) %size = 20
	sz = length(parent1);
	pn = 1 - ((1 - prob) ^ (1 / sz));
	t = rand(1, sz);
	z1 = zeros(1, sz);
	for i = 1:sz
		if (t(1, i) < pn)
			z1(1, i) = 1 - parent1(1, i);
		else
			z1(1, i) = parent1(1, i);
		end
	end
end