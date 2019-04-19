function [clust, net, k, clusts, dqn, range] = getAutoGeometricCommunity(data, range)

if (nargin < 2)
    range = 2.^(1:log2(size(data, 1)));
end
% an up-triangle dissimilar matrix
D = squareform(pdist(data));

D = D + diag(diag(D) + inf);

[Y, R] = sort(D);
[Y, R] = sort(R);
R = max(R, R');

i = 1;
for n = range
%    net = getMutualKNNnet(D, n);
n
    net = sparse(R <= n);
%     if (i == 1)
        pc = independentComponent(net);
        [clusts{i}, qn(i)] = QcutPlus(net, pc);
%     else
%         [clusts{i}, qn(i)] = QcutPlus(net, clusts{i-1});
%     end
    rnet = switchingRewire2(net, 10);
    pc = independentComponent(rnet);
    [rclust{i}, rqn(i)] = QcutPlus(rnet);    
    if (min(sum(net)) == 0)
        pq(i) = perfectQ(clusts{i}(1:end-1));
    else
        pq(i) = perfectQ(clusts{i});
    end
    if (min(sum(rnet)) == 0)
        rpq(i) = perfectQ(rclust{i}(1:end-1));
    else
        rpq(i) = perfectQ(rclust{i});    
    end
    i = i + 1;
end

% dqn = qn - rqn + (rpq - pq);
dqn = qn - rqn;
%
%semilogx(range, dqn);

[Y, I] = max(dqn);

k = range(I);

net = sparse(R <= k);
clust = clusts{I};

end
