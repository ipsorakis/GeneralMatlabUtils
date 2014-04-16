function [x y] = swap_values(x,y)
    x = x-y;
    y = y+x;
    x = y-x;
end