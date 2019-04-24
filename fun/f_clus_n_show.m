function f_clus_n_show(X, fe_label, clus_alg, dis_type, n_row_clus, n_col_clus,...
    fig_oposi)
%
if nargin < 7
    figure,
else
    figure('Position', fig_oposi)
end
% clus_alg, clustering algorithm; can be 'kmeans', 'Qcut', 'HQcut'
% dis_type, distance type; can be 'euclidean', 'cosine', 'corr'

[ clus_inst, net ] = f_do_clustering(X, clus_alg, n_row_clus, dis_type);
clus = f_clustLoc_arr_to_cell(clus_inst);
sim = corrcoef(X');

[ clus_fe, net_fe ] = f_do_clustering(X', clus_alg, n_col_clus, dis_type);
% clus_fe = f_clustLoc_arr_to_cell(clus_fe);
[~, ix_clus_fe] = sort(clus_fe);
[~, ix_clus_inst] = sort(clus_inst);


% Show clusters on the original data
% subplot(1,16,1:7);
subplot(5,16,[1:7 17:23 33:39 49:55]);
showRowClusters(clus, X(:, ix_clus_fe), 2);

xticks([1:33])
if length(fe_label) == size(X, 2)
    xticklabels(fe_label(ix_clus_fe));
end

set(gca, 'XTickLabelRotation', 90);

% Show clusters on the similarity matrix
% subplot(1,16,9:15);
subplot(5,16,[9:15 25:31 41:47 57:63]);
o = showClusters(clus, sim, 1);



end

