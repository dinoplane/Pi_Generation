function nth_term = gregorySum(n)
% This function calculates the nth term of the series under the summation
% operator of the Gregory series used to approximate pi.
% Returns symbolic output.
nth_term = sym(((-1)^(n))/(2*(n+1)-1));