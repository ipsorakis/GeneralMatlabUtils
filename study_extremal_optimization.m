function [] = study_extremal_optimization(A,max_repeats,max_steps,full_clustering_flag)

PLOTDATA = zeros(max_repeats,max_steps+1);

for i=1:max_repeats
    [Groups PLOTDATA(i,:)] = extremal_optimization(A,max_steps,full_clustering_flag);
end

meanplot = mean(PLOTDATA,1);
stdplot = std(PLOTDATA,1);

errorbar(meanplot,stdplot);