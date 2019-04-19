function q = Q(clusts, A)
    q = 0;
    d = sum(sum(A));
    
    for nn=1:length(clusts)
        I = clusts{nn};
        if (length(I)>0)
%            vv = ones(size(A, 1), 1);
%            vv(I) = 0;
%            J = find(vv);
%            q = q + d * sum(sum(A(I, I))) - sum(sum(A(I, J))) .^ 2;
            q = q + d * sum(sum(A(I, I))) - sum(sum(A(I, :))) .^ 2;
        end
    end
    q = q / (d^2+eps);
%    q = q / perfectQ(clusts);
    
