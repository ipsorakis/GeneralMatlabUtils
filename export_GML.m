function export_GML(W,filename,node_labels)

if length(strsplit(filename,'.'))==1
    strcat(filename,'.gml');
end

has_node_label =  exist('node_labels','var');


[N K] = size(W);
%M = sum(sum(1*(W>0)))/2;
is_unipartite = N==K;
is_bipartite = ~is_unipartite;

if ~has_node_label
    node_labels = cell(N,1);
   for i=1:N
       node_labels{i} = num2str(i);
   end
   has_node_label = true;
end

fid = fopen(filename,'w');
fprintf(fid,'graph\r\n');
fprintf(fid,'[\r\n');

if is_unipartite
    isdirected = ~is_symmetric(W);
else
    isdirected = true;
end

fprintf(fid,'\tdirected %d\r\n',isdirected);

if is_unipartite
    %% UNI-PARTITE
    for i=1:N
        fprintf(fid,'\tnode\r\n\t[\r\n');
        %fprintf(fid,'\t\tid %d\r\n\t]\r\n',i);
        fprintf(fid,'\t\tid %d\r\n',i);
        
        % junk attribute
        fprintf(fid,'\t\tattribute %d\r\n',1);
        
        if has_node_label
            fprintf(fid,'\t\tlabel \"%s\"\r\n\t]\r\n',node_labels{i});
        else
            fprintf(fid,'\t]\r\n');
        end
    end
    
    if ~isdirected
        for i=1:N-1
            for j=i+1:N
                if W(i,j)~=0
                    fprintf(fid,'\tedge\r\n\t[\r\n');
                    fprintf(fid,'\t\tsource %d\r\n',i);
                    fprintf(fid,'\t\ttarget %d\r\n',j);
                    fprintf(fid,'\t\tweight %d\r\n\t]\r\n',W(i,j));
                end
            end
        end
    else
        for i=1:N
            for j=1:K
                if W(i,j)~=0
                    fprintf(fid,'\tedge\r\n\t[\r\n');
                    fprintf(fid,'\t\tsource %d\r\n',i);
                    fprintf(fid,'\t\ttarget %d\r\n',j);
                    fprintf(fid,'\t\tweight %d\r\n\t]\r\n',W(i,j));
                end
            end
        end
    end
else
    %% BI-PARTITE
    for i=1:N
        fprintf(fid,'\tnode\r\n\t[\r\n');
        %fprintf(fid,'\t\tid %d\r\n\t]\r\n',i);
        fprintf(fid,'\t\tid %d\r\n',i);
        fprintf(fid,'\t\ttype %d\r\n',1);
        
        if has_node_label
            fprintf(fid,'\t\tlabel \"%s\"\r\n\t]\r\n',node_labels{1}{i});
        else
            fprintf(fid,'\t]\r\n');
        end
    end
    
    for i=1:K
        fprintf(fid,'\tnode\r\n\t[\r\n');
        %fprintf(fid,'\t\tid %d\r\n\t]\r\n',i);
        fprintf(fid,'\t\tid %d\r\n',N+i);
        fprintf(fid,'\t\ttype %d\r\n',2);
        
        if has_node_label
            fprintf(fid,'\t\tlabel \"%s\"\r\n\t]\r\n',node_labels{2}{i});
        else
            fprintf(fid,'\t]');
        end
    end
    
    for i=1:N
        for j=1:K
            if W(i,j)~=0
                fprintf(fid,'\tedge\r\n\t[\r\n');
                fprintf(fid,'\t\tsource %d\r\n',i);
                fprintf(fid,'\t\ttarget %d\r\n',N+j);
                fprintf(fid,'\t\tweight %d\r\n\t]\r\n',W(i,j));
            end
        end
    end
end
fprintf(fid,']');
fclose(fid);
end