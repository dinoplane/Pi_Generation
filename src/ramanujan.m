function nth_approx = ramanujan(nth_par)
% This function uses the nth partial sum in Ramanujan's fomula for pi to
% approximate pi.
% Returns symbolic output.
nth_approx = sym((9801/sqrt(sym(8)))*nth_par^(-1));
