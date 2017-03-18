classdef gaclass < matlab.System
	properties
		SampleSize
		nvars
		minimum
		maximum
		nbits
		ngen
		accu
		value
		popn
		xover
		mut
		xoverprob
		mutprob
		out
	end
	methods
		%% gaclass: consructor
		function [obj] = gaclass()
			obj = obj@matlab.System();
			obj.ngen = NaN;
			obj.accu = NaN;
			obj.value = NaN;
			obj.popn = NaN;
			obj.xover = @crossover;
			obj.mut = @mutate;
			obj.xoverprob = NaN;
			obj.mutprob = NaN;
			obj.out = @output;
		end
	end
end 
