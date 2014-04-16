function I = get_mutual_information(C)

C = C/sum(sum(C));

lx = size(C,1);
ly = size(C,2);

px = sum(C,2);
py = sum(C,1);

PX = repmat(px,1,ly);
PY = repmat(py,lx,1);

RATIO = (PX.*PY) ./ C;
RATIO(isnan(RATIO)) = 1;

LOG_RATIO = log(RATIO);
LOG_RATIO(isinf(LOG_RATIO)) = 0;

I = -1*sum(sum(C.*LOG_RATIO));
end