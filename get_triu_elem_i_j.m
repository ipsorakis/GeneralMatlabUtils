function [i, j] = get_triu_elem_i_j(e,N)

if e<N
    i = 1;
    j = e+1;
else    
    max_elem_index_per_row = zeros(N-1,1);
    for n=1:N-1
        max_elem_index_per_row(n) = get_triu_elem_index(n,N,N);
    end
    
    i = find(e<=max_elem_index_per_row,1);
    j = e-max_elem_index_per_row(i-1)+i;
    
end
end