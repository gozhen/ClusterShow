function [clust, bestQ] = myfkmeans(data, nCluster, nIter)
  bestQ = inf;
  clear bestC;
  for i = 1:nIter
     [centers,mincenter,mindist,q2,quality] = fkmeans(data,nCluster, 1);
     if quality < bestQ
        bestC = mincenter;
        bestQ = quality;
     end
  end

  clear clust;
  for i=1:nCluster
    I = find(bestC == i);
    clust{i} = I';
  end
