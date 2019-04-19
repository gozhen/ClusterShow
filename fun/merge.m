function c = merge(clus)
  c = [];
  for i=1:length(clus)
    c = [c reshape(clus{i}, 1, [])];
  end
