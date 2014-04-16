function p = do_simple_p_test(histogram,x,starts_from_zero,plot_flag)

if ~exist('starts_from_zero','var')
    starts_from_zero = 1;
end


if ~exist('plot_flag','var')
    plot_flag = false;
end

%normalise histogram
histogram = histogram/sum(histogram);

p = sum(histogram(floor(x+starts_from_zero):end));

if plot_flag
    bar(histogram);
    hold on
    vline(x,'r',strcat('p:',num2str(p)));
    hold off
end
end