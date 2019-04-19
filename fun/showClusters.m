function o = showClusters(clusts, a, j, noLine)
% showClusters(clusts, a, j, noLine) shows the reorganized adjacency matrix
% clusts - the clusters returned by Qcut
% a - the adjancency matrix
% j - the figure you want the adjacency matrix to be draw. e.g., 1.
% noLine - a flag to specify whether lines should be drawn to separate clusters

if (nargin < 4)
    noLine = 0;
end
% figure (j);
o=[];
for i=1:length(clusts)
%    c = clusts{i};
%    c = c(randperm(length(c)));
   %o = [o clusts{i}];  
     tmp = clusts{i};
     o = [o; tmp(:)];
%o = [o c];
end
% imagesc(a(o, o));
% size(a)
% o,

imagesc(a(o, o));


l = 0.5;
n=length(o) + .5;
for i=1:(length(clusts)-1)
   l = l + length(clusts{i});
   if (~noLine)
       line([0, n], [l, l], 'Color', 'w', 'LineWidth', 1);
       line([l, l], [0, n], 'Color', 'w', 'LineWidth', 1);   
%       line([0, n], [l, l], 'LineWidth', 1);
%       line([l, l], [0, n], 'LineWidth', 1);   
   end
end

