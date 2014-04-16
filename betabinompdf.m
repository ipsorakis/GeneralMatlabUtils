function p = betabinompdf(k,n,a,b)
N = length(k);

if N==1
    p = nchoosek(n,k) * beta(k+a,n-k+b) / beta(a,b);
else
    p = zeros(N,1);
    
    for i=1:N
        p(i) = nchoosek(n,k(i)) * beta(k(i)+a,n-k(i)+b) / beta(a,b);
    end
end
end