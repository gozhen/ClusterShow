function sizes = getClusterSizes(clus)
sizes = [];
for i=1:length(clus)
    sizes(i) = length(clus{i});
end
