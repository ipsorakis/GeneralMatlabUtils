function export_CFinder(W,filename)
fid = fopen(filename,'w');

N = size(W,1);
for i=1:N-1
    for j=i+1:N
        if W(i,j)~=0
            fprintf(fid,'%d %d %d\r\n',i,j,W(i,j));
        end
    end
end
fclose(fid);
end