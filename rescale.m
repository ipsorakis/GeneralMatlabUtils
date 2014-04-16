function y = rescale(x,a0,b0,a1,b1)

% [a0,b0] current bounds
% [a1,b1] new bounds

y = (x-a0)./(b0-a0) .* (b1 - a1) + a1;

end