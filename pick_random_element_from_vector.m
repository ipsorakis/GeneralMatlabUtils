function [x r] = pick_random_element_from_vector(v)

r = rand;
i = 1 + floor(r*length(v));
x = v(i);

end