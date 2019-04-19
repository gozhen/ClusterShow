function [X] = f_discrete_data(X)
% 
for i=1:size(X, 2)
    col = X(:, i);
    %ct = std(col);
    ct = quantile(col, .3);
    
    new = zeros(length(col), 1);
    new(col>ct) = 1;
    new(col<ct) = -1;
    
    
    size(col),
    size(new),
    
    X(:, i) = new;
    
end


end

