    %% AUXILIARY FUNCTION
    function [min_indices min_lamdas] = find_minimums(indices,lamdas,num)
       min_indices = zeros(num,1);
       min_lamdas = zeros(num,1);
       
       for min_i = 1:num
          
           try
           min_lamdas(min_i) = min(lamdas);
           min_index = find(lamdas == min(lamdas),1);
           min_indices(min_i) = indices(min_index);
           
           lamdas(min_index)=[];
           indices(min_index)=[];
           catch ME
               ME.stack
           end
       end
    end