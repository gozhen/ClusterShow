function b = switchingRewire2(a, iter)

if (nargin < 2)
    iter = 100;
end

[I, J] = find(a);
s = find(I < J);
n = length(a);
m = length(s);

edgeList = [I(s), J(s)];
s = rand(1, m) <= .5;
edgeList(s, :) = edgeList(s, [2 1]); % so it doesn't have to be I < J;

b = a;
%b = full(a>0);
sparseflag = issparse(b);
if (sparseflag)
b = full(b);
end

for i = 1:iter
    s = randperm(m);
    edgeList = edgeList(s, :);
    for j = 1:2:m-1
%        pairInd = s(j:j+1);
%        t = edgeList(pairInd, :);
        t = edgeList(j:j+1, :);
        %    if (length(unique(t)) < 4)    % self edges
        if (t(1) == t(2) | t(1) == t(4) | t(2) == t(3) | t(3) == t(4))    % self edges
            continue;
        end
        
        if (b(t(1), t(2)) | b(t(3), t(4))) % existing edges
            continue;
        end
        
        b(t(1), t(3)) = 0; % remove old edges
        b(t(2), t(4)) = 0; % remove old edges
        b(t(3), t(1)) = 0; % remove old edges
        b(t(4), t(2)) = 0; % remove old edges
        b(t(1), t(2)) = 1; % new edges
        b(t(3), t(4)) = 1; % new edges
        b(t(2), t(1)) = 1; % new edges
        b(t(4), t(3)) = 1; % new edges
        
        edgeList(j:j+1, :) = t';    
    end
end
if (sparseflag)
b = sparse(b);
end
