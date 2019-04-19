function [clus, q] = HQcut(A, clus, mz, minq, maxq, minC)

%% similar to QcutPlus, except that QcutPlus is executed recursively on each community.
%% clus - the first-level community (eg., obtained by Qcut)
%% mz and minq determine when the recursion should terminate.
%% minq - the minimum Q value for sub-communities to be accepted. default value is 0.3
%% mz - the minimum Z-score of the Q value. default value is 2
%% maxq - the maximum Q value above which the siginificance of
%% sub-community does not need to be tested. Intended to be used for very large
%% networks - to improve efficiency.

if (nargin < 2)
    clus = QcutPlus(A);
end

if (nargin < 3)
    mz = 2;
end

if (nargin < 4)
    minq = 0.2;
end

if (nargin < 5)
    maxq = .5;
end

if (nargin < 6)
    minC = 5;
end

i = 1;
while (i <= length(clus))
    if (numel(clus{i}) < minC)  % ignore small communities
        i = i + 1;
        continue;
    end
    a = A(clus{i}, clus{i});
    if (sum(sum(a)) > 0.95 * length(a) * (length(a)-1)) % ignore very dense communities
        i = i + 1;
        continue;
    end
    [sca, q, z, dq] = QcutPlusSig(a, 20, minq, maxq, 0.03);
    %    [q z dq]
    if (z > mz)
        for j=1:length(sca)
            sca{j} = clus{i}(sca{j});
        end
        clus{i} = sca;
        clus = flat(clus);
    else
        i = i + 1;
    end
end

q = Q(clus, A);
