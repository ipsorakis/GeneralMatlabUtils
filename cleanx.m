% Convert a vector x of random numbers (repeated) to a nice integer-index vector y
% e.g. if x = [.3 .22 .3], y = [1 2 1]
% Mark Ebden

function y = cleanx(x)
N = length(x);
seenx = []; y = zeros(1,N);
for i = 1:N,
    g = ismember(seenx,x(i));
    if sum(g) == 0, % hasn't been processed
        seenx = [seenx x(i)];
        g = ismember(x,x(i));
        y(find(g==1)) = length(seenx);
    end
end
     
    