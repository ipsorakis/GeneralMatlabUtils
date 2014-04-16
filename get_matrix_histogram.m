function [h_norm h] = get_matrix_histogram(W,plot_flag)

t = get_triu_vector(W);

h = histc(t,0:max(t));

h_norm = h/sum(h);

if ~exist('plot_flag','var')
   plot_flag = false; 
end

if plot_flag
   bar(h_norm);
end

end