function membership = getMembership(clus)
for i=1:length(clus)
    membership(clus{i}) = i;
end
membership = membership';