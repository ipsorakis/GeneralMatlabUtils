function pairs = get_dyad_combinations(N)

total_pairs = sum_arithmetic_progression(N-1,1,1);
pairs = zeros(total_pairs,2);

n = 0;
for i=1:N-1
    for j=i+1:N
        n = n+1;
        pairs(n,:) = [i j];
    end
end


end