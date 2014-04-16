function [x y maximum] = find_matrix_max(M)

maximum = max(max(M));

logic = M==maximum;

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