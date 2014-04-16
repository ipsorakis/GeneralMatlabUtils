function output = test_function(A,g)
N = size(A,1);
time_window_value_range = 15:15:300;
total_iterations = length(time_window_value_range);

Lsqr = zeros(total_iterations,1);
NMI = zeros(total_iterations,1);
CCE = zeros(total_iterations,1);

for t=1:total_iterations
    tw = time_window_value_range(t);
    DATA = create_data_stream_given_graph_cliques(A,1000,60,320);
    
    Wtw = build_weights_matrix_dumb_time_window(DATA,N,tw);
    
    try
        g_tw = louvain(Wtw);
        NMI(t) =get_partition_similarity_NMI(g,g_tw);
    catch ME
        NMI(t) = 0;
    end
    Lsqr(t) = get_matrix_square_distance(A,Wtw);
    CCE(t) = (mean(get_clustering_coefficient(A)) - mean(get_clustering_coefficient(1*logical(Wtw))))^2;
end

output = struct('NMI',NMI,'Lsqr',Lsqr,'CCE',CCE);
end