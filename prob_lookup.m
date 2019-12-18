% p1,c1,x1
function [prob] = prob_lookup(p,c,x)

denom=0;
num=0;

for i=1:length(x)
    if x(i,1)==p
        denom=x(i,2);
    end
end

for j=1:length(c)
    if c(j,1)==p
        num=c(j,2);
    end
end

prob=num*0.2/denom;

if isnan(prob)
    prob=0;
end

end


