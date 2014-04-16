function [Groups partitions] = remove_empties(Groups_initial)
max_partitions = size(Groups_initial(1,:),2);
partitions = 0;
for row_index = 1:max_partitions
    if ~isempty(Groups_initial{1,row_index})
        partitions = partitions+1;
    end
end

Groups = cell(partitions,1);
aux_it=1;
for row_index=1:max_partitions
    if ~isempty(Groups_initial{1,row_index})
        Groups{aux_it} = Groups_initial{1,row_index};
        aux_it=aux_it+1;
    end
end

end