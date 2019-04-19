function b = switchingRewire3(a, iter)

%% Rewire a network so that the vertex degrees are preserved
%% faster than switchingRewire2

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
sflag = issparse(b);
if (sflag)
    b = full(b);
end

% define a flip vector
if (mod(m,2))
    flipVector(1:2:m-1) = 2:2:m;
    flipVector(2:2:m) = 1:2:m-1;
    flipVector(m) = m;
else
    flipVector(1:2:m) = 2:2:m;
    flipVector(2:2:m) = 1:2:m;
end


for i = 1:iter
    edgeList = edgeList(randperm(m), :);
    flip = flipVector;
    for j = 1:2:m-1
        t = edgeList(j:j+1, :);
        if (t(1) == t(4) || t(2) == t(3) || b(t(1), t(4)) || b(t(2), t(3)))    % self edges or existing edges
            flip(j:j+1) = j:j+1; % don't swap in this case
            continue;
        end
        
        b(t(1), t(3)) = 0; % remove old edges
        b(t(2), t(4)) = 0; % remove old edges
        b(t(3), t(1)) = 0; % remove old edges
        b(t(4), t(2)) = 0; % remove old edges
        b(t(1), t(4)) = 1; % new edges
        b(t(2), t(3)) = 1; % new edges
        b(t(4), t(1)) = 1; % new edges
        b(t(3), t(2)) = 1; % new edges        
    end
    edgeList(:,2) = edgeList(flip, 2);
end
if (sflag)
b = sparse(b);
end
