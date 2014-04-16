function y = safe_str2num(x)
z = str2double(x);

if isnan(z)
    y=x;
else
    y = z;
end
end