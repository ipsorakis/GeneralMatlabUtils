function n = get_triu_number_of_elements(X)

if ~isscalar(X)
    N = size(X,1);
else
    N = X;
end

n = sum_arithmetic_progression(N-1,1,1);

end