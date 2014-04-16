function r = get_pearson_coefficient(X,Y)
N = length(X);

meanX = repmat(mean(X),N,1);
meanY = repmat(mean(Y),N,1);

stdX = std(X);
stdY = std(Y);

r = ((X-meanX)' * (Y-meanY)) / ( (N-1)*stdX*stdY);

end