% This function given a Nx by Ny matrix, returns an S Nx by Nx where each
% element Sij is the pearson corellation coefficient between line-i and
% line-j of W
function S = get_pearson_matrix(W)
Nx = size(W,1);
Ny = size(W,2);

M = repmat(mean(W,2),1,Ny);

si = repmat(std(W,1,2),1,Nx);
sj = repmat(std(W,1,2)',Nx,1);

Wi = W - M;
Wj = (W - M)';

S = (Wi*Wj) ./ (Nx*(si.*sj));
end