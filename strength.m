function k = strenght(W,nodes)

if ~exist('nodes','var')
    nodes = 1:1:size(W,1);
end

k=sum(W(nodes,:),2);
end