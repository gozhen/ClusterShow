function clust = getClust(membership)
    membership = reshape(membership, 1, []);
    for i=1:max(membership)
        clust{i} = find(membership == i);
    end
%    s = getClusterSizes(clust);
%    clust = clust(find(s));