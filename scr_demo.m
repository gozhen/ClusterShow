%% example 1, on a school clustering dataset
load('./demo_data/data_school.mat');
addpath('./fun/');

%%
clus_alg = 'kmeans';
dis_type = 'euclidean';
n_row_clus = 12;
n_col_clus = 5;
f_clus_n_show(X, fe_label, clus_alg, dis_type, n_row_clus, n_col_clus);

%%
%% example 2, on data planning
% https://archive.ics.uci.edu/ml/datasets/Planning+Relax

load('./demo_data/data_planning.mat');
n_row_clus = 15;
n_col_clus = 5;

X = normalize(X);
%[X] = f_discrete_data(X);

f_clus_n_show(X, '', clus_alg, dis_type, n_row_clus, n_col_clus);


%%
%% example 3, on the iris dataset
load('./demo_data/data_iris.mat');

%%
clus_alg = 'kmeans';
dis_type = 'euclidean';
n_row_clus = 3;
n_col_clus = 2;

X = normalize(X);
[X] = f_discrete_data(X);

f_clus_n_show(X, '', clus_alg, dis_type, n_row_clus, n_col_clus);


%%


%%


%%


%%


%%


%%


%%


%%


%%


%%


%%


%%


%%


%%


%%


%%


%%


%%


%%


%%


%%


%%


%%


