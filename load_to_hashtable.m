N = size(IDs,1);
IDtable = hashtable;

for i=1:N
    IDtable = put(IDtable,IDs{i,1},i);
end