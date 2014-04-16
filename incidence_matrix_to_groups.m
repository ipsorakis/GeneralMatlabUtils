function groups = incidence_matrix_to_groups(B)
N = size(B,1);
K = size(B,2);

groups = cell(K,1);

P = zeros(N,K);
for i=1:N
    P(i,:) = B(i,:)==max(B(i,:));
    if sum(P(i,:))>1
       f = find(P(i,:),1);
       P(i,:)=zeros(1,K);
       P(i,f) = 1;
    end
end

for i=1:K
   groups{i} = find(P(:,i))'; 
end
end