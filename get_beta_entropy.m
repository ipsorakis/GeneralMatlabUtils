function H = get_beta_entropy(a,b)

H = log(beta(a,b)) - (a-1)*digamma(a) - (b-1)*digamma(b) + (a+b-2)*digamma(a+b);

end