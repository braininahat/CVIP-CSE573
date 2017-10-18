img = imread('../data/sunflowers.jpg');
im2 = rgb2gray(img);
img = double(rgb2gray(img));

dims = size(img);


tic();


n = 10;

% threshold = 1200; %change later
response = [];

for i = 1:n
    sigma = 2 * (2^(1/4))^i;
    k = ceil(6*sigma+1);
    log = fspecial('log',k,sigma);
    log = sigma.^2 * log;
    temp = imfilter(img,log,'replicate');
    temp = temp.^2;
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

%imagesc(max_plane)

maxmap = (max_plane == response);
result = max_plane .* maxmap;
result_vals = find(result);
threshold = sqrt(mean(result_vals))+sqrt(std(result_vals));
threshmap = result > threshold;
result = result .* threshmap;

% imagesc(result(:,:,3))

indices = [];
for l = 1:n
    [r,c] = find(result(:,:,l));
    l_vect = repmat(sqrt(l^2),size(r,1),1);
    plane_indices = cat(2,r(:),c(:),l_vect(:));
    indices = cat(1,indices,plane_indices);
end

% size(indices)

show_all_circles(im2,indices(:,2),indices(:,1),indices(:,3))