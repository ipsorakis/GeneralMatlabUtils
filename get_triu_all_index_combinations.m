function ij = get_triu_all_index_combinations(N)

M = get_triu_number_of_elements(N);
ij = zeros(2,M);

i=1;
j=2;

for m=1:M
    ij(:,m) = [i,j];
    
    j=j+1;
    
    if j>N
        i = i+1;
        j = i+1;
    end
end

ij = ij';
end