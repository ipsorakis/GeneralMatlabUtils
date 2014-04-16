function [x y minimum] = find_matrix_min(M)

minimum = min(min(M));

logic = M==minimum;

for i=1:size(logic,1)
    for j=1:size(logic,2)
        if logic(i,j)
            x=i;
            y=j;
            return;
        end
    end
end
end