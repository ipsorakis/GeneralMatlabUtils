function C = get_correlation_matrix(x,y,remove_empties_flag)

if exist('remove_empties_flag','var') && remove_empties_flag
   z = x+y;
   empties = z==0;
   
   x(empties) = [];
   y(empties) = [];
end

x_mean = mean(x);
x_std = std(x);
nx = length(x);

y_mean = mean(y);
y_std = std(y);
ny = length(y);

% ASSUMES column vectors
Cx = repmat(x,1,ny) - x_mean;
Cy = repmat(y',nx,1) - y_mean;

C = Cx.*Cy / (x_std*y_std);
end