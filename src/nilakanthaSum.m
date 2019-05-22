function nth_term = nilakanthaSum(n)
% This function calculates the nth term of the series under the summation
% operator of the Nilakantha series used to approximate pi.
% Returns symbolic output.
nth_term = sym(((-1)^(n)*4)/((2*(n)+2)*(2*(n)+3)*(2*(n)+4)));