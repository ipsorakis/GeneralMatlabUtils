function index = binary_search(value,vector)

%% INITIALISE
N = length(vector);

start_index = 1;
end_index = N;
pivot = floor((end_index+start_index)/2);

%% DO BINARY SEARCH
found = false;
while ~found
    if value == vector(pivot)
        index = pivot;
        found = true;
    elseif value > vector(pivot)
        start_index = pivot;
    elseif value < vector(pivot)
        end_index = pivot;
    end
    
    if isempty(start_index:end_index)
        index = -1;
        break;
    else
        pivot = floor((end_index+start_index)/2);
    end
end

%% IF SPECIFIED, FIND FIRST OR LAST
% if ~exist('sequence_specifier','var') && strcmp(sequence_specifier,'first')
%     
% elseif ~exist('sequence_specifier','var') && strcmp(sequence_specifier,'last')
%     
% end
end