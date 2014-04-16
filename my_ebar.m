function my_ebar(m,su,sl,col,lineCol,X);

if (nargin < 6)
    X = [1:length(m)];
end;
if (nargin < 5)
    lineCol = 'r';
end;
if (nargin < 4)
    col = [1 .78 .78];
end;

fill([X,fliplr(X)],[m+su, fliplr(m-sl)],col,'lineStyle','none')

hold on;
plot(X,m,lineCol);
hold off;

