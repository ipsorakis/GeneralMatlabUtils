function Y = generalised_logistic_function(t,A,K,B,v,Q,M)
% A: the lower asymptote;
% K: the upper asymptote. If A=0 then K is called the carrying capacity;
% B: the growth rate;
% ?>0 : affects near which asymptote maximum growth occurs.
% Q: depends on the value Y(0)
% M: the time of maximum growth if Q=?

%e.g. plot(x,generalised_logistic_function(x,.5,1,3.5,.001,.001,.5))

if nargin<2
   A = 0;
   K = 1;
   B = 1.5;
   Q = .5;
   v = .5;
   M = .5;
end


Y = A + (K-A) ./ ( (1 + Q.*exp(-B*(t-M))).^(1/v));

end