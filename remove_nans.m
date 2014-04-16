function W = remove_nans(W)

if ~iscell(W)
    [N K T] = size(W);
    
    for t=1:T
        for i=1:N-1
            for j=i+1:K
                if isnan(W(i,j,t))
                    W(i,j,t) = 0;
                    W(j,i,t) = 0;
                end
            end
        end
    end
else
    T = length(W);
    N = size(W{1},1);
    
    parfor t=1:T
        for i=1:N-1
            for j=i+1:N
                if isnan(W{t}(i,j))
                    W{t}(i,j) = 0;
                    W{t}(j,i) = 0;
                end
            end
        end
    end
end

end