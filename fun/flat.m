function flatcluster = flat (cluster)
if (~iscell(cluster))
    flatcluster = {cluster};
else
        flatcluster = {};
        for i=1:length(cluster)
            flatcluster = [flatcluster flat(cluster{i})];
        end
end

