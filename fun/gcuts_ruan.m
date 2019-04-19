function [clusts,qs]=gcuts_ruan(A,group_num)

%% [clusts,distortion]=gcut(A,nClusts)
%%
%% Graph partitioning using spectral clustering. 
%% Input: 
%%   A = Affinity matrix
%%   nClusts = number of clusters 
%% 
%% Output:
%%   clusts = a cell array with indices for each cluster
%%   distortion = the distortion of the final clustering 
%%
%% Algorithm steps:
%% 1. Obtain Laplacian of the affinity matrix
%% 2. Compute eigenvectors of Laplacian
%% 3. Normalize the rows of the eigenvectors
%% 4. Kmeans on the rows of the normalized eigenvectors
%%
%% Original code by Yair Weiss
%% Modified and Updated by Lihi Zelnik-Manor 
%%

group_num = sort(group_num);         %% sort the group numbers
group_num = setdiff(group_num,1);    %% do not allow for 1 group

%%%%%%%% Compute the Laplacian
npix = size(A,1);
useSparse = issparse(A);
dd = sum(A)+eps;
if(useSparse)
    D = sparse(1:npix,1:npix,dd);
else
    D = diag(dd);
end
L = D - A;

nClusts = max(group_num);

L = sparse(L);

%%%%%%% Compute eigenvectors
%if(useSparse)
    opts.issym = 1;
    opts.isreal = 1;
    opts.disp = 0;
    [V,ss] = eigs(L,D,nClusts,'sa',opts);
    %else
%    [V,ss] = eig(L, D);
%end
[Y, I] = sort(diag(ss));
V = V(:, I(1:nClusts));

% this code solves the problem of having less than nClusts meaningful eigenvectors
[i,j] = find(isnan(V));
xx = setdiff(1:nClusts, unique(j)); % index of non NaN eigvectors 
if (~isreal(V))
    [i,j] = find(imag(V));
    xx = setdiff(1:nClusts, unique(j)); % index of non complex eigvectors
warning('something is wrong!');
end

if (length(xx) < 2)
    clusts = {{1:size(A,1)}}; 
    distoration = 0;
warning('something is wrong!');
    return;
elseif (length(xx) < nClusts)
    V = V(:, xx);
    group_num = group_num(find(group_num <= length(xx)));
warning('something is wrong!');
end

for g = 1:length(group_num)
    Vcurr = V(:,1:group_num(g));
    %%%%%%% Normalize rows of V
    for i=1:size(Vcurr,1);
        Vcurr(i,:)=Vcurr(i,:)/(norm(Vcurr(i,:))+eps);
    end
    
    
    %%%%%%%%%%%%%%%%%% Kmeans
    %%%%%% Try 50 runs of k-means and save the one with minimal distortion
    
%        [clusts{g},distortion(g)] = kMeansCluster2(Vcurr, group_num(g), 50, 10);
    
%     idx = kmeans(Vcurr, group_num(g), 'Replicates', 10, 'EmptyAction', 'singleton');
%     clusts{g} = getClust(idx);
   [clusts{g},distortion] = myfkmeans(Vcurr, group_num(g), 20);
    qs(g) = Q(clusts{g}, A);
end
