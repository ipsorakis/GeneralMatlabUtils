function [A, node_list, node_table] = import_Pajek(filename)

fid = fopen(filename);

in_comments = true;
in_nodes = false;
in_edges = false;


comments = '';

while 1
    rawline = fgetl(fid);
    if ~ischar(rawline), break, end;
    
    if strcmp(rawline(1:5),'*vert')
        in_comments = false;
        in_nodes = true;
        
        tmp = strsplit(rawline,' ');
        N = str2double(tmp{2});
        A = zeros(N,N);
        
        node_list = cell(N,1);
        node_table = containers.Map();
        
        continue
    elseif strcmp(rawline,'*arcs') || strcmp(rawline,'*edges')
        in_nodes = false;
        in_edges = true;
        
        continue
    end
    
    if in_comments
        comments = strcat(comments,'\n',rawline);
    elseif in_nodes
        rawline = strtrim(rawline);
        
        tmp = strsplit(rawline,' ');
        n = str2double(tmp{1});
        
        node_list{n} = tmp{2};
        node_table(tmp{2}) = n;
    elseif in_edges
        rawline = strtrim(rawline);
        
        tmp = strsplit(rawline,' ');
        i = str2double(tmp{1});
        j = str2double(tmp{2});
        
        if length(tmp)==2
            A(i,j) = 1;
        else
            A(i,j) = str2double(tmp{3});
        end
    end
end

%metadata = struct('comments',comments,'node_IDs',node_IDs,'N',N);
fclose(fid);
end