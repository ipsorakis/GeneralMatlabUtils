function I = get_normalized_mutual_information(N)

if isscalar(N)
    I = 0;
    return
end

a=size(N,1);
b=size(N,2);

Na = sum(N,2);
Nb = sum(N,1);
n = sum(sum(N));

nominator = 0;
for i=1:a
    for j=1:b
        
        ratio = (N(i,j)*n)/(Na(i)*Nb(j));
        if isnan(ratio)
            ratio = 1;
        end
        
        aux = log(ratio);
        if isinf(aux)
            aux=0;
        end
        nominator = nominator + N(i,j)*aux;
    end
end
nominator = -2*nominator;

denominator =0;
for i=1:a
    summand = Na(i)*log(Na(i)/n);
    if isnan(summand)
        summand = 0;
    end
    
    denominator = denominator + summand;
end

for i=1:b
    summand = Nb(i)*log(Nb(i)/n);
    if isnan(summand)
        summand = 0;
    end
    
    denominator = denominator + summand;
end

I = nominator/denominator;

end