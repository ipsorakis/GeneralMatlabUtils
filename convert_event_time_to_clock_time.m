function [t aux_outputs]  = convert_event_time_to_clock_time(e,t_step)

e_diff = diff(e);
mean_e_diff = mean(e_diff);
std_e_diff = std(e_diff);
max_e_diff = max(e_diff);
min_e_diff = min(e_diff);


if t_step ==-1 || ~exist('t_step','var')
    unique_diffs = unique(e_diff);
    if unique_diffs(1) ~= 0
        t_step = unique_diffs(1);
    else
        t_step = unique_diffs(2);
    end  
end

t0 = e(1);
tend = e(end);

t = t0:t_step:tend;

if t(end)<tend
    t = [t tend];
end

aux_outputs = struct('mean_time_between_events',mean_e_diff,'std_time_between_events',std_e_diff,...
    'max_time_between_events',max_e_diff,'min_time_between_events',min_e_diff,...
    't0',t0,'tend',tend,'t_step',t_step);
end