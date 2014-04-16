function errorarea(input1,input2,input3)

if nargin==3
    x = input1;
    ymean = input2;
    standdev = input3;
else
    x = (1:length(input1))';
    ymean = input1;
    standdev = input2;
end

A1 = [x ymean ymean+standdev];

A2 = [x ymean ymean-standdev];
A2 = flipdim(A2,1);

A = [A1;A2];

fill(A(:,1),A(:,[2 3]), [0 0 0],'EdgeColor',[0 0 0]);

end