function KL = get_KL_divergence(p,q,base)
% p: BASELINE distribution
% q: an APPROXIMATION or MODEL about p

if sum(isnan(p))>0 || sum(isnan(q))>0
    KL = nan;
    return;
end

p = p/sum(p);
q = q/sum(q);

if ~exist('base','var')
    base = 'nats';
end

cross_entropy_term = safe_plogq(p,q,base);

entropy_term = safe_plogq(p,p,base);

KL = -1*sum(cross_entropy_term - entropy_term);


% p = (p+eps)/sum(p+eps);
% q = (q+eps)/sum(q+eps);
% 
% ratio = q./p;
% %ratio(isnan(ratio)) = 0;
% 
% KL = -1*sum(p.* safe_log(ratio,base));
end