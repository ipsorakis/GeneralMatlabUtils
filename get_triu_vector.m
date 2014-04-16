function v = get_triu_vector(A)
% A vector
% K-th diagonal

N = size(A,1);

v = [];
%n = sum_arithmetic_progression(N,1,1);

for i=2:N
    v = [v; A(1:i-1,i)];
end

end