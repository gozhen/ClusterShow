function qq = perfectQ(clusts)    
n = 0;
for i = 1:length(clusts)
    n = n + length(clusts{i});
end

a = 0;
b = 0;
for i = 1:length(clusts)
    alpha = length(clusts{i}) / n;
    a = a + alpha^4;
    b = b + alpha^2;
end

qq = 1 - a / b^2;

