function n = get_triu_elem_index(i,j,N)

if i==1
    n = j-1;
else
   n = get_triu_elem_index(i-1,N,N) + j - i; 
end

end