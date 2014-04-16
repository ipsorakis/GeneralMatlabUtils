function S = get_stochastic_matrix(W)
N = size(W,1);
C = repmat(get_strength(W),1,N);
S = W./C;
end