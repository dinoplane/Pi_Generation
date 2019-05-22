function nth_approx = chudnovsky(nth_par)
% This function uses the nth partial sum in the Chudnovsky Series to 
% approximate pi.
% Returns symbolic output.
nth_approx = sym((1/12)*nth_par^(-1));