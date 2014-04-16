function F = get_cummulative_distribution_from_vector(f)

N = length(f);
F = zeros(N,1);

F(1) = f(1);
for i=2:N
    F(i) = sum(f(1:i));
end

end