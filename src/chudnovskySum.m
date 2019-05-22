function nth_term = chudnovskySum(n)
% This function calculates the nth term of the series under the summation
% operator of the Chudnovsky series used to approximate pi.
% Returns symbolic output.
top = sym(((-1)^n)*factorial(6*n)*sym((13591409+545140134*n)));
bot = sym((factorial(n)^3)*factorial(3*n)*sym((640320^3)^(n+0.5)));
nth_term = sym(top/bot);
