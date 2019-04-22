function [new] = f_arr_to_rank(data)
% convert each feature column of data to rank 

new = zeros(size(data));
for i=1:size(data, 2)
    col = data(:, i);
    [~, ix] = sort(col, 'descend');
    [~, ix2]= sort(ix,  'descend');
    new(:, i) = ix2;
end



end