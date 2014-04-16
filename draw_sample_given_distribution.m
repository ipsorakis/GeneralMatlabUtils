function x = draw_sample_given_distribution(PDF,labels,number_of_samples)

if sum(PDF)>1
    PDF = PDF/sum(PDF);
end

n = length(PDF);

if ~exist('labels','var')
    labels = 1:n;
end

if ~exist('number_of_samples','var')
    number_of_samples = 1;
end

x = zeros(number_of_samples,1);
for sample_index=1:number_of_samples
    
    CDF = zeros(n,1);
    
    for i=1:n
        CDF(i) = sum(PDF(1:i));
    end
    
    u = rand(1);
    
    aux = CDF - u;
    
    xi = find(aux>=0,1);
    
    x(sample_index) = labels(xi);
    
end

end