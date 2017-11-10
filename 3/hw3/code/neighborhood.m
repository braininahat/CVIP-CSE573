function neighborhood = neighborhood(img,row,col,factor) %TODO generalize size
% neighborhood = ones(3);
% neighborhood(1,1) = img(row-1,col-1);
% neighborhood(1,2) = img(row-1,col);
% neighborhood(1,3) = img(row-1,col+1);
% neighborhood(2,1) = img(row,col-1);
% neighborhood(2,2) = img(row,col);
% neighborhood(2,3) = img(row,col+1);
% neighborhood(3,1) = img(row+1,col-1);
% neighborhood(3,2) = img(row+1,col);
% neighborhood(3,3) = img(row+1,col+1);
% neighborhood = reshape(neighborhood,[1,9]);
value = ((factor-1)*2)+1;
neighborhood = ones(value);
for i = 1:value
    for j = 1:value
        neighborhood(i,j) = img(i+factor,j+factor);
    end
end
end