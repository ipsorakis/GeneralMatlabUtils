function [p Xs] = do_fisher_test(pi)

Xs = -2 * sum(log(pi));

p = 1 - chi2cdf(Xs,2*length(pi));

end