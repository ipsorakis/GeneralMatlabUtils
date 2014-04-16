function I = get_partition_similarity_NMI(A,B)
N = get_confusion_matrix(A,B);

I = get_normalized_mutual_information(N);
end

function N = get_confusion_matrix(A,B)
a=length(A);
b=length(B);

N = zeros(a,b);

for i=1:a
    for j=1:b
        N(i,j) = length(intersect(A{i},B{j}));
    end
end
end