function L = get_matrix_square_distance(A,B)

A = 1*logical(A);
B = 1*logical(B);

N = size(A,1);

elemsA = get_triu_vector(A);
elemsB = get_triu_vector(B);

L = mean((elemsA - elemsB).^2);

end