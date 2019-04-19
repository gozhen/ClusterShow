function [clus, q, z, dq] = QcutPlusSig(a, nIter, minq, maxq, mindq)
[clus, q] = QcutPlus(a);
rq = [];
if (q <= minq)
    z = 0;
    dq = 0;
    return;
end

if (q >= maxq)
    z = inf;
    dq = 1;
    return;
end

for i=1:nIter
    %    b = simpleRewire(a);
    b = switchingRewire3(a, 10);
    [rclus, rq(i)] = QcutPlus(b);
    dq = q - mean(rq);
    if (dq < mindq)
        z = 0;
        return;
    end
end

z = dq / std(rq);
