for i=1:length(output)
   output(i).Wframes(isnan(output(i).Wframes)) = 0;
   output(i).Wframes(isnan(output(i).Wframes_null_mean)) = 0;
   output(i).Wframes(isnan(output(i).Wframes_null_std)) = 0;
end