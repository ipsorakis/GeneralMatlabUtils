function deltas = get_deltas(W,Groups)
N = size(W,1);

deltas = zeros(N,N);
for i=1:N-1
    for j=i+1:N
        deltas(i,j) = get_delta(Groups,i,j);
    end
end

deltas = deltas + triu(deltas)' + eye(N);
end

function delta = get_delta(Groups,u,y)
groups = max(size(Groups));
delta = 0;

if u==y
    delta=1;
    return;
else
    for i=1:groups
        if sum(ismember(Groups{i},[u y]))==2
            delta=1;
            return;
        end
    end
end

end