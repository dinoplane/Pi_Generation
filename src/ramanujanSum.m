function nth_term = ramanujanSum(n)
% This function calculates the nth term of the series under the summation
% operator of the Ramanujan's formula used to approximate pi.
% Returns symbolic output.
nth_term = sym(((26390*n + 1103)*factorial(4*n))/((factorial(n)^4)*(396^(4*n))));
