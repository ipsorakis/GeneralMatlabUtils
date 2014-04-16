function Q = get_modularity2(Groups,W,deltas)
Q = get_modularity(Groups,W);
% 
% N = size(W,1);
% m = sum(sum(W))/2;
% %A = W>0;
% 
% %% UNVECTORIZED
% %tic
% % SumQ = 0;
% % if ~exist('deltas','var')
% %     deltas = get_deltas(W,Groups);
% % end
% % 
% % for i=1:N
% %     for j=i:N
% %         if i~=j
% %             multiplier=2;
% %         else
% %             multiplier=1;
% %         end
% %         SumQ = SumQ + (W(i,j)-get_strength(W,i)*get_strength(W,j)/(2*m))*deltas(j,i)*multiplier;
% %     end
% % end
% % 
% % Q1 = SumQ/(2*m);
% %toc
% %% VECTORIZED
% %tic
% group_number = max(size(Groups));
% 
% indices_by_groups = cat(2,Groups{:});
% Wij = W(indices_by_groups,indices_by_groups);
% 
% S= get_strength(Wij);
% 
% Ti = repmat(S,1,N);
% Tj = repmat(S',N,1);
% 
% DELTAS = zeros(N);
% 
% offset=0;
% for i=1:group_number
%     current_indices = offset+1:offset+1+(length(Groups{i})-1);
%     DELTAS(current_indices,current_indices)=1;
%     offset = offset+1+(length(Groups{i})-1);
%    %DELTAS(Groups{i},Groups{i})=1; 
% end
% 
% Q =sum(sum(     (Wij - (Ti.*Tj)/(2*m)).*DELTAS ))        /(2*m);
% %toc
end