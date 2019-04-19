function [cluster, q] = Qcut_2 (cluster, A, m, alpha, beta)

% [cluster, q] = Qcut_2 (cluster, A, m, alpha, beta) finds a graph partitioning that (approximately) optimizes Q.
% input:
% cluster - a cell array, where each element is a row vector containing the node IDs in a community.  Initial value of cluster should be {1:length(A)}. 
% A - an adjacency matrix. It needs to be symmetric.
% m - a vector of small values, for example 2, or 2:3, or 2:4. At each step Qcut looks for the best k-way partition, where k is a value from m. I usually use m = 2:3.
% alpha - minimum improvement of Q to accept a partition. I use 0 or eps. May use negative value (e.g., -0.05) if you want the graph to be partitioned into more clusters. 
% beta - used when alpha < 0. the minimum local Q value required to accept a partition. suggested value is 0.25 or higher. 
% output:
% cluster: the community structure found
% q: the Q value of the community structures. -1 < Q < 1. The higher the better. Should be greater than 0.3 for most real networks and close to 0 for random networks.

if (nargin < 6)
    beta = 0.3;
end

n = length(cluster);
q(n) = Q(cluster, A);
i = 1;
while (i <= n)
    if (length(cluster{i}) < 2)  % if a cluster contains less than 2 nodes, continue
        i = i + 1;
        continue; 
    end
    a = A(cluster{i}, cluster{i});
    if (length(a) < max(m)) 
        clusts = gcuts_ruan(a, 2:length(a));
    else
        clusts = gcuts_ruan(a, m);
    end
    oldQ = Q(cluster(i), A);
    clear qs qsl;
    for j = 1:length(clusts)
        qsl(j) = Q(clusts{j}, a); % local Q value
        for k = 1:length(clusts{j})
            clusts{j}{k} = cluster{i}(clusts{j}{k});
        end
        qs(j) = Q(clusts{j}, A) - oldQ; % global Q value for the submatrix
    end
    [Y, I] = max(qs);
    if (Y < eps)
        qsl = qsl .* (qs >= alpha);
        [Y, I] = max(qsl);
    end
    if (qs(I) < alpha | (qs(I) < eps & qsl(I) < beta) | length(clusts{I}) < 2) % if returned only a single cluster, continue
        i = i + 1;
        continue;
    else      
        subClusts = clusts{I};
        if (i > 1)
            newClus = [cluster(1:i-1)]; 
        else
            newClus = {};
        end
        newClus = [newClus subClusts];        
        if (i < length(cluster))
            newClus = [newClus cluster(i+1:end)];
        end
        cluster = newClus;
        n = length(cluster);
    end
end
q = Q(cluster, A);
