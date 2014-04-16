function B = group_to_incidence_matrix(groups)
K = length(groups);
N = length(cat(2,groups{:}));

B = zeros(N,K);

for i=1:K
   B(groups{i},i) = 1; 
end
end