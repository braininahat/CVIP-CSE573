img = imread('../data/butterfly.jpg');
im2 = rgb2gray(img);
img = double(rgb2gray(img));

dims = size(img);

tic();


n = 10;
sigma = 3;
k = ceil(6*sigma+1);
log = fspecial('log',k,sigma);
log = sigma.^2 * log;

response = [];

for i = 1:n
    temp = imfilter(imresize(img,double(1/((2^(1/4))^i)),'bicubic'),log,'replicate');
    temp = temp.^2;
    temp = imresize(temp,dims,'bicubic');
    response = cat(3,response,temp);
end


toc();


maxima = zeros(size(response));

for j = 1:n
    maxima(:,:,j) = ordfilt2(response(:,:,j),9,true(3),'symmetric');
end

local = [];

for k = 1:n
    plane = maxima(:,:,k);
    local = cat(2,local,plane(:));
end

local_max = max(local,[],2);
max_plane = reshape(local_max,dims);

maxmap = (max_plane == response);
result = max_plane .* maxmap;
result_vals = find(result);
threshold = sigma*(sqrt(mean(result_vals))+sqrt(std(result_vals)));
threshmap = result > threshold;
result = result .* threshmap;

indices = [];
for l = 1:n
    [r,c] = find(result(:,:,l));
    l_vect = repmat(sqrt(l^sigma),size(r,1),1);
    plane_indices = cat(2,r(:),c(:),l_vect(:));
    indices = cat(1,indices,plane_indices);
end

%show_all_circles(im2,indices(:,2),indices(:,1),indices(:,3))