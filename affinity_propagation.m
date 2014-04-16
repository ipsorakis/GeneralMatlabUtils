function [Groups Modularity Community exemplars] = affinity_propagation(A,W,iterations,similarity_metric)

if ~exist('iterations','var')
    iterations = 100;
end

if ~exist('similarity_metric','var')
    similarity_metric = 'donetti_munoz';
end

if ~exist('W','var')
   W = A; 
end

A = 1*A;
N = size(A,1);

Community = zeros(N,N,iterations);
exemplars = cell(iterations,1);
iterator=1;

%similarities
Si = node_similarity(W,similarity_metric);
%availabilities
Av = zeros(N);
%responsibilities
Re = zeros(N);

%find initial exemplars
%exemplars{iterator} = 8;
exemplars{iterator} = find(diag(Si)==max(diag(Si)));
Community(:,:,iterator) = Community(:,:,iterator)+ ...
    1*diag(diag(Si)==max(diag(Si)));

while true
    
    %update responsibilities
    for i=1:N
        for k=1:N
            k_t = 1:1:N;
            k_t(k)=[];
            Re(i,k) = Si(i,k) - max( Av(i,k_t) + Si(i,k_t));
        end
    end
    
    %update availabilities
    for i=1:N
        for k=1:N
            if i~=k
                i_t=1:1:N;
                i_t = intersect(i_t(i_t~=i),i_t(i_t~=k));
                
                Re_k = Re(i_t,k);
                Re_k = sum(Re_k(Re_k>0));
                Av(i,k) = min([0 Re(k,k)+Re_k]);
            else
                i_t=1:1:N;
                i_t = i_t(i_t~=k);
                
                Re_k = Re(i_t,k);
                Re_k = sum(Re_k(Re_k>0));
                Av(i,k) = Re_k;
            end
        end
    end
    
    iterator = iterator+1;
    
    %find the new exemplars
    criterion = Av + Re;
    for i=1:N
        new_exemplar = find(criterion(i,:)==max(criterion(i,:)),1,'first');
        Community(i,new_exemplar,iterator)=1;
    end
    
    Community(:,:,iterator) = Community(:,:,iterator)...
        - Community(:,:,iterator)'...
        + diag(diag(Community(:,:,iterator)));
    
    exemplars{iterator} = find( sum(Community(:,:,iterator)==1)>0 );
    
    
    if iterator == iterations
        break;
    end
    
    Groups = get_communities(Community(:,:,iterator),A);
    Modularity = get_modularity2(Groups',W)
    Groups
end



    function COM = get_communities(Community, A)
       N = size(A,1);
       n = [1:1:N]';
       Aux = repmat(n,1,N);
        Community = Community==1;
       Aux = (1*Community).*Aux;
       
       community_number = sum(sum(Aux)~=0);
       COM = cell(community_number,1);
       
       iterator=1;
       for i=1:N
          if sum(Aux(:,i))~=0
             COM{iterator} = find(Aux(:,i)~=0)';
             iterator=iterator+1;
          end
       end
    end
end