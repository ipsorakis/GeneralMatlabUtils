function h = safe_plogq(p,q,base)

if ~exist('base','var')
    base = 'nats';
end

% if p == 0 && q == 0
%     h = 0;
%     return;
% end
% 
% if q == 0
%     q = eps;
% end


p = (p+eps)/sum(p+eps);
q = (q+eps)/sum(q+eps);

if strcmp(base,'bits')
    h = p.*log2(q);
    h(isnan(h)) = 0;
elseif strcmp(base,'nats')
    h = p.*log(q);
    h(isnan(h)) = 0;
end

end