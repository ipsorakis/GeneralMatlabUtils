function bootstrap_sample_poisson_distribution(x,n_step)

means = [];
vars = [];

mean_error_curr = inf;
var_error_curr = inf;

sample_

sample_length = n_step;
while sample_length<length(x)
    x_sample = x(1:sample_length);
    
    sample_mean = mean(x_sample);
    sample_var = var(x_sample);
    
    mean_error_curr = (sample_mean-5)^2;
    var_error_curr = (sample_var-5)^2;
    
    means = [means;sample_mean];
    vars = [vars;sample_var];
    
    hold on;
    subplot(1,2,1);
    plot(means);    
    hline(mean(x),'r');
    subplot(1,2,2);
    plot(vars);
    hline(var(x),'r');
    drawnow;    
    hold off
    
    sample_length = sample_length + n_step;
end
end