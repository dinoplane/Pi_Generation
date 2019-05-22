function nth_term = machinSum(n)
% This function calculates the nth term of the series under the sigma
% operator of Machin's formula used to approximate pi.
% Returns symbolic output.
nth_term = sym((((-1)^n)/(2*n+1))*(4*((1/5)^(2*n+1)) - sym((1/239)^(2*n+1))));
