% % weights matrix
% W = zeros(total_birds);
% 
% % absolute bird appearances
% X = zeros(total_birds,1);
% 
% tic
% %% UNVECTORIZED VERSION
% for i=start_index:end_index
%     for j=1:total_locations
%         if sum(Occ{j}(:,i))~=0
%             for x=1:total_birds-1
%                 if Occ{j}(x,i)~=0
%                     for y=x+1:total_birds
%                         if x~=y && Occ{j}(y,i)~=0
%                             W(x,y) = W(x,y) + min(Occ{j}(x,i),Occ{j}(y,i));
%                         end
%                     end
%                 end
%             end
%         end
%     end
% end
% W = W + W';
% toc

%% VECTORISED VERSION
% weights matrix
W = zeros(total_birds);

% absolute bird appearances
X = zeros(total_birds,1);

tic
for j=1:total_locations
   for i=start_index:end_index
      x = Occ{j}(:,i);
      X1 = repmat(x,1,total_birds);
      X2 = X1';
      W = W + X1.*((X1-X2)<0) + X2.*((X1-X2)>0);
   end
end
toc

%%
% reps = 10;
% Qs = zeros(reps,5);
% for p=.1:.1:.5
%     for rep=1:reps
%         A = get_ER_graph(100,p);
%         %groups = run_commDetNMF(A,size(A,1));
%         
%         %LV = cluster_jl(A,1);
%         %groups = get_louvain_groups(LV.COM{2},100);
%         
%         [dendogram Qmonitor best_iteration group] = extremal_optimization(A,10,1,0);
%         
%         j = int32(p*10);
%         
%         %Qs(rep,j) = get_modularity(groups,A);
%         Qs(rep,j) = Qmonitor(best_iteration);
%     end
% end

% for i = 1 : 100
%     A = get_ER_graph(100,.4);
%     [groupsNMF W1 H1 P] = commDetNMF(A,100);
%     Q = get_modularity(groupsNMF,A)
%
%     bar(mean(P));
%     drawnow;
% end

% Q = 0;
% iteration = 0;
% while true
%     if Q > 0.2
%         Q
%         iteration
%         disp('---')
%     else
%         W1 = rand(size(W,1),ceil(N/2));
%         H1 = rand(ceil(N/2),size(W,1));
%     end
%
%     [groupsNMF W1 H1 P] = commDetNMF(W,ceil(N/2),0,W1,H1);
%     Q = get_modularity(groupsNMF,W);
%     iteration = iteration + 1;
% end

% Qs = zeros(100,1);
% Ls = zeros(100,1);
% for i = 1:100
% [groupsNMF W1 H1 P] = commDetNMF(W,ceil(N/2),0);
% Qs(i) = get_modularity(groupsNMF,W); Ls(i) = length(groupsNMF);
% end
