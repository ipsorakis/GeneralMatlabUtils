function [vs is] = sort_vector(v)
n = length(v);
vs = zeros(size(v));
is = zeros(size(v));

for i=1:n
    max_elem = max(v);
    max_index = find(v==max_elem,1);
    
    vs(i) = max_elem;
    is(i) = max_index;
    
    v(max_index) = -inf;
end

end