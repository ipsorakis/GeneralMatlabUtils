function [groups Qmonitor best_iteration best_group] = simulated_annealing(W,T,max_steps,plot_flag)
%% INITIALIZATIONS
N = size(W,1);
converged = false;
c=.995;
Qmonitor = [];
Best_E = 1;
current_step=1;

if ~exist('T','var')
    T=10;
end

if ~exist('max_steps','var')
    max_steps = N*10;
end

if ~exist('plot_flag','var')
    plot_flag=true;
end

%make a random partition
indices = randperm(N);
groups=cell(1,2);
groups{1} = sort(indices(1:ceil(N/2)));
groups{2} = sort(indices(ceil(N/2)+1:N));

%calculate initial Energy
Cf = get_E(groups,W);

%% MAIN ENGINE
while ~converged
    candidate_partition = groups;
    
    %energy before update
    Ci = Cf;
    
    %do N^2 local moves
    for i=1:N^2
        candidate_partition = local_move(candidate_partition,W);
    end
    
    %do N global moves
    for i=1:N
        candidate_partition = global_move(candidate_partition,W);
    end
    
    %energy after the update
    Cf = get_E(candidate_partition,W);
    
    %store best partition
    if Cf<Best_E
        Best_E = Cf;
        best_group = candidate_partition;
        best_iteration=T;
    end
    
    %DECISION
    if Cf<=Ci
        groups = candidate_partition;
    else
        decision_boundary = exp(-1*(Cf-Ci)/T );
        dice = rand();
        if dice<decision_boundary
            groups = candidate_partition;
        end
    end
    
    
    %convergence TO UPDATE!!!
    if T<1 || current_step==max_steps
        converged=true;
    end
    
    %plots
    if plot_flag
        Qmonitor = [Qmonitor,-1*Cf];
        figure(1)
        plot(Qmonitor)
        title('Modularity Q');
        drawnow;
        
        %         figure(2)
        %         community_graph(groups,W)
        %         title('Community Graph');
        %         drawnow;
        %
        %         figure(3)
        %         clf
        %         group_indices=cat(2,groups{:});
        %         imagesc(W(group_indices,group_indices));
        %         title('W colormap');
        %         drawnow;
        
    end
    
    %lower temperature and increment
    T = c*T;
    current_step = current_step+1;
end

end
%% GET ENERGY
function E = get_E(groups,W)
E = -1* get_modularity(groups,W);
end

%% DO LOCAL MOVE
function groups = local_move(old_groups,W)
groups=old_groups;
k = length(groups);

lamdas = get_lamdas_nodes(W,groups);
worst_elem = find(lamdas==min(lamdas),1);
[group1 group1_index worst_elem_index] = get_individual_membership(worst_elem,groups);
group1(worst_elem_index)=[];

group2_index = ceil(k*rand());
while group1_index == group2_index
    group2_index = ceil(k*rand());
end
group2 = groups{group2_index};
group2 = [group2 worst_elem];

groups{group1_index} = group1;
groups{group2_index} = group2;

% if k>1
%     group1_index = ceil(k*rand());
%     group2_index = ceil(k*rand());
%     while group1_index==group2_index %|| length(groups{group1_index})==1
%         group1_index = ceil(k*rand());
%         group2_index = ceil(k*rand());
%     end
%     
%     group1 = groups{group1_index};
%     group1_size = length(group1);
%     node_selector = ceil(group1_size*rand());
%     
%     elem = group1(node_selector);
% 
%     group1(group1==elem)=[];
%     
%     group2 = groups{group2_index};
%     group2 = [group2 elem];
%     
%     
%     groups{group1_index} = group1;
%     groups{group2_index} = group2;
% end

groups = remove_empties(groups)';
end

%% DO GLOBAL MOVE
function new_groups = global_move(groups,W,move)
k = length(groups);

if ~exist('move','var')
    global_moves = {'split','merge'};
    if k<=2
        move = 'split';
    else
        move = global_moves{ceil(2*rand())};
    end
end

node_lamdas = get_lamdas_groups(W,groups);

if strcmp(move,'merge')
    %% MERGE PARTITIONS
    group1_index = find(node_lamdas==min(node_lamdas),1);
    %group1_index = ceil(k*rand());
    group2_index = ceil(k*rand());
    while group1_index==group2_index
        group2_index = ceil(k*rand());
    end
    
    group1 = groups{group1_index};
    group2 = groups{group2_index};
    new_group = [group1,group2];
    
    groups{group1_index} = new_group;
    groups{group2_index} = [];
    new_groups = remove_empties(groups)';
elseif strcmp(move,'split')
    %% SPLIT PARTITION
    group_index = find(node_lamdas==min(node_lamdas),1);
    group = groups{group_index};
    if length(group)==1
        new_groups = global_move(groups,W,'merge');
    else
        %split the group
        n = length(group);
        split_index = ceil((n-1)*rand());
        group1 = group(1:split_index);
        group2 = group(split_index+1:end);
        
        %update groups
        groups{group_index} = group1;
        groups{k+1} = group2;
        new_groups = groups;
    end
%     populations = get_group_population(groups);
%     singletons = populations==1;
%     if sum(singletons)~=k
%         %select a random group (size>1) to split
%         non_singletons_length = sum(~singletons);
%         non_singleton_groups = ceil(non_singletons_length*rand());
%         non_singleton_indices = find(~singletons,non_singleton_groups);
%         group_selector = non_singleton_indices(length(non_singleton_indices));
%         group = groups{group_selector};
%         
%         %split the group
%         n = length(group);
%         split_index = ceil((n-1)*rand());
%         group1 = group(1:split_index);
%         group2 = group(split_index+1:end);
%         
%         %update groups
%         groups{group_selector} = group1;
%         groups{k+1} = group2;
%         new_groups = groups;
%     else
%         new_groups = global_move(groups,'merge');
%     end
end
end

%% GET PARTITION POPULATION
function populations = get_group_population(groups)
k = length(groups);
populations = zeros(k,1);

for i=1:k
    populations(i) = length(groups{i});
end

end

%% GET LAMDAS VECTOR FOR EACH NODE
function lamdas = get_lamdas_nodes(W,groups)
N = size(W,1);
lamdas = zeros(N,1);
for i=1:N
   lamdas(i) =  get_individual_modularity(W,groups,i);
end
end

%% GET LAMDAS VECTOR FOR EACH GROUP
function lamdas = get_lamdas_groups(W,groups)
k = length(groups);
lamdas = zeros(k,1);
lamdas_nodes = get_lamdas_nodes(W,groups);
for i=1:k
   lamdas(i) = sum(lamdas_nodes(groups{i})); 
end
end

%% GET INDIVIDUAL CONTRIBUTION TO MODULARITY
function lamda = get_individual_modularity(W,groups,elem,gi)
if ~exist('gi','var')
    [elem_group gi] = get_individual_membership(elem,groups);
end

%N=size(W,1);
total_edges = sum(sum(W))/2;

try
lamda = sum(W(elem,elem_group))/sum(W(elem,:)) -...
    (sum(sum(W(elem_group,elem_group)))/2 + ...
    sum(sum( W(elem_group,get_other_group_indices(groups,gi)))))...
    /total_edges;
catch ME
    ME.stack;
end
end

%% GET INDICES OF GROUPS EXCEPT INPUT
function other = get_other_group_indices(groups,i)
groups{i}=[];
other = cat(2,groups{:});
end