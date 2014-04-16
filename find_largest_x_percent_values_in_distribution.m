function [low_bound_val pivot] = find_largest_x_percent_values_in_distribution(d,v,x)

N = length(d);

for i=1:N
   if sum(d(i:end))<=x
      break; 
   end
end

low_bound_val = v(pivot);

end