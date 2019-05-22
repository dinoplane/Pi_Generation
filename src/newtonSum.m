function nth_term = newtonSum(n)
% This function calculates the nth term of the series under the summation
% operator of the Newton series used to approximate pi.
% Returns symbolic output.
nth_term = factorial(2*n)/(2^(4*n+2)*(factorial(n)^2)*(2*n-1)*(2*n+3));
