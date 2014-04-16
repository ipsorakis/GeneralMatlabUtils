function j = get_jaccard_index(a,b)
j = length(intersect(a,b))/length(union(a,b));
end