function neighborhood_final = neighborhood(img,row,col,factor)
value = ((factor-1)*2)+1;
neighborhood = ones(value);
neighborhood_final = [];
for count = 1:size(row,1)
    for i = 1:value
        for j = 1:value
            neighborhood(i,j) = img(row(count)+i-1,col(count)+j-1);
        end
    end
    neighborhood_final = cat(1,neighborhood_final,neighborhood(:)');
end