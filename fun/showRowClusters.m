function showRowClusters(clusts, a, j, color, width, noLine)

if (nargin < 4)
    %color = 'b';
    color = 'w';
end

if (nargin < 5)
    width = 1;
end

if (nargin < 6)
    noLine = 0;
end


% figure (j);
o=[];
for i=1:length(clusts)
    % o = [o clusts{i}];  
    tmp = clusts{i};
    o = [o; tmp(:)];
end
imagesc(a(o, :));
l = 0.5;
n=length(a) + .5;
for i=1:(length(clusts)-1)
   l = l + length(clusts{i});
   if (~noLine)
   line([0, n], [l, l], 'Color', color, 'LineWidth', width);
%   line([l, l], [0, n]);   
   end
end
