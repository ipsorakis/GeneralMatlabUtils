function c = contains(big,small)

c = length(intersect(small,big))==length(small);

end