function [newClus, q] = QRefineCommunity2(clus, b, nIter)
%% refine communities by move nodes around or merge communities

n = length(b);
m = length(clus);
degree = sum(b, 2);
N = sum(degree);
i = 1;
q(i) = Q(clus, b);

[ft, label, edgeCounts, ct] = clusterInfo(clus, b);
D = spdiags(degree, 0, n, n);

while (i <= nIter)
oldClus{i} = clus;
    ft = ft';
    fstar = repmat(ft((0:n-1) * m + label)', 1, m);
    ft = ft';

%    edgeCountstar = repmat(edgeCounts(label)', 1, m);
%    imp = ft - fstar + (edgeCountstar - repmat(edgeCounts, n, 1) - repmat(degree, 1, m)) .* repmat(degree, 1, m) / N;
%    imp = 2 * imp / N;

    edgeCountstar = edgeCounts(label)';
    imp = ft - fstar;
    imp = imp + D * (repmat(edgeCountstar-degree, 1, m) - repmat(edgeCounts, n, 1)) / N;
    imp = 2 * imp / N;

    x = max(max(imp));

% debug    
%    x2 = max(max(imp .* (ft > 0)));
%    if (x > x2) 
%        error ('something wrong');
%    end
    
    % improvement of Q from merging clusters
    imp2 = N * ct - edgeCounts' * edgeCounts;
    imp2 = 2 * imp2 / N ^2;
    imp2 = imp2 - diag(diag(imp2));
    y = max(max(imp2));
    
    if (x <= 0 & y <= 0) % no improvement possible
        break; 
    else 
        if (x > y) % move a single node instead of merge two communities
            [I, J] = find(imp == x);
            node = I(1);
            comm = J(1);
            clus{label(node)} = setdiff(clus{label(node)}, node);
            clus{comm}(end+1) = node;
            %update edgeCounts
            edgeCounts(label(node)) = edgeCounts(label(node)) - degree(node);
            edgeCounts(comm) = edgeCounts(comm) + degree(node);
            %update ft
            friends = find(b(node, :));
            edgeWeights = b(node, friends)';
            ft(friends, label(node)) = ft(friends, label(node)) - edgeWeights;
            ft(friends, comm) = ft(friends, comm) + edgeWeights;
            
            %update ct
            affectedComms = union(label(node), find(ft(node,:)));
            for j = 1:length(affectedComms)
                ct(affectedComms(j), :) = sum(ft(clus{affectedComms(j)}, :));
            end
            
            %update label
            label(node) = comm;
            i = i + 1;
%            disp('move');
            q(i) = q(i-1) + x;    
%            q(i)        
        else
            [I, J] = find(imp2 == y);
            comm1 = I(1);
            comm2 = J(1);
            filter = setdiff(1:length(clus), comm2);
            clus{comm1} = [clus{comm1} clus{comm2}];
            clus = clus(filter);
%            [ft, label, edgeCounts, ct] = clusterInfo(clus, b);
            ft(:, comm1) = ft(:, comm1) + ft(:, comm2);
            ft = ft(:, filter);
            
            label = getMembership(clus)';
            
            edgeCounts(comm1) = edgeCounts(comm1) + edgeCounts(comm2);
            edgeCounts = edgeCounts(filter);
            
            ct(:, comm1) = ct(:, comm1) + ct(:, comm2);
            ct(comm1, :) = ct(comm1, :) + ct(comm2, :);
            ct = ct(filter, filter);
            
            m = m - 1;
            i = i + 1;
%            disp('merge');
            q(i) = q(i-1) + y;
%            q(i)         
        end
    end
end

%newClus = clus;
newClus = {};
for i = 1:length(clus)
    if (length(clus{i}) > 0)
        newClus{end+1} = clus{i};
    end
end

q = q(end);