function Wcell = convert_3d_to_sparse(W)

N = size(W,1);
T = size(W,3);

Wcell = cell(T,1);

for t=1:T
    Wcell{t} = sparse(W(:,:,t));
end
end