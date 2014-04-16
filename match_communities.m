function C = match_communities(W1,W2,D,E)

% if ~exist('methodology','var')
%    methodology = 'I'; 
% end
% 
% if strcmp(methodology,'I')
%    
% end

% % INITIALIZATION OF MATRICES
A1 = W1~=0;
A2 = W2~=0;

%build joint matrix
A3 = or(A1,A2);

%build correspondence matrix
C = zeros(length(D),length(E));

% COMMUNITY DETECTION ON JOINT GRAPH
%V = cm_nmf(A3,max(length(D),length(E)),0);
V = {[1 2 3 4 5 6]};

% COMMUNITY MATCHING
Contains_D = zeros(length(D),length(V));
Contains_E = zeros(length(E),length(V));

for v=1:length(V)
    
    for d=1:length(D)
       if contains(V{v},D{d})
          Contains_D(d,v) = 1; 
       end
    end
    
    for e=1:length(E)
       if contains(V{v},E{e})
           Contains_E(e,v) = 1;
       end
    end
    
    Dgroups = find(Contains_D(:,v));
    Egroups = find(Contains_E(:,v));
    
    J = zeros(length(Dgroups),length(Egroups));
    for i=1:size(J,1)
        for j=1:size(J,2)
            J(i,j) = get_jaccard_index(D{Dgroups(i)},E{Egroups(j)});
        end
    end 
    
    [x y Jmax] = find_matrix_max(J); 
    while Jmax~=0
       J(x,y) = 0;
       C(x,y) = 1;
       [x y Jmax] = find_matrix_max(J); 
    end
end


end