function S = sigmoid(x,x0,y0)
if ~exist('x0','var')
    x0 = 0;
end

if ~exist('y0','var')
   y0 = 0;
end

S = (1 + exp(-(x-x0))).^(-1) - y0;
end