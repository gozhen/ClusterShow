function [ft, label, edgeCounts, ct] = clusterInfo(clus, b)
n = length(b);
m = length(clus);
ft = sparse(n, m);
ct = sparse(m, m);
edgeCounts = [];
for i = 1:m
    label(clus{i}) = i;
    for j = 1:m
        x = b(clus{i}, clus{j});
        ft(clus{i}, j) = sum(x, 2); % number of frends in community j
        ct(i, j) = sum(sum(x)); % number of edges within community or connecting communities
    end
    edgeCounts(i) = full(sum(sum(b(clus{i}, :))));
end
