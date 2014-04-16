function iseq = simeq(a,b,e)

if ~exist('e','var')
    e=eps*10e+5;
end

iseq = abs(a-b)<e;

end