function nth_approx = newton(nth_par)
% This function uses the nth partial sum in Newton's approximation of pi
% to approximate pi.
% Returns symbolic output.
nth_approx = sym(24*(sym(sqrt(3)/32)-nth_par));