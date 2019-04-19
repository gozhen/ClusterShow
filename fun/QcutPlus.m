function [cluster, q] = QcutPlus (A, cluster)

% [cluster, q] = QcutPlus (A) finds a graph partitioning that (approximately) optimizes Q, by iteratively executing Qcut and QRefineCommunity.
% input:
% A - an adjacency matrix. It needs to be symmetric.
% output:
% cluster - the community structure stored in a cell array. 
% Each element is a row vector containing the node IDs in a community. 
% If the network is small (say, < 2000 vertices), you can view it with showClusters(cluster, A)
% q: the Q value of the community structures. 

q = [];
if (nargin < 2)
cluster = {1:length(A)};
end
[kc, q(end+1)] = Qcut_2(cluster, A, 2:3, 0);
if (length (kc) < 2)
    cluster = kc;
    q = q(end);
    return;
end
while (1)
%    q(end)
    [skc, q(end+1)] = QRefineCommunity2(kc, A, 20000);
    if (q(end) - q(end-1) <= eps)
        break;
    end
%    q(end)
    [kc, q(end+1)] = Qcut_2(skc, A, 2:3, 0);
    if (length(skc) == length(kc))
        break;
    end
end

cluster = skc;
q = q(end);