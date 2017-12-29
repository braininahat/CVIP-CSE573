img1 = imread('../data/part1/uttower/left.jpg');
img2 = imread('../data/part1/uttower/right.jpg');

[h1, w1, ~] = size(img1);
[h2, w2, ~] = size(img2);

gray1 = double(rgb2gray(img1));
gray2 = double(rgb2gray(img2));

sigma = 3;
thresh = 2000;
radius = 3;
disp = 0;
match_count = 200;
neighbor_rad = 20; 

[left_cim,r1,c1] = harris(gray1,sigma,thresh,radius,disp);
[right_cim,r2,c2] = harris(gray2,sigma,thresh,radius,disp);

descriptor1 = neighborhood(gray1, neighbor_rad, r1, c1);
descriptor2 = neighborhood(gray2, neighbor_rad, r2, c2);

distances = dist2(descriptor1,descriptor2);
[~,distance_indices] = sort(distances(:),'ascend');
matches = distance_indices(1:match_count);
[dist_r, dist_c] = ind2sub(size(distances), matches);
match_indices_1 = dist_r;
match_indices_2 = dist_c;

match_r1 = r1(match_indices_1);
match_c1 = c1(match_indices_1);
match_r2 = r2(match_indices_2);
match_c2 = c2(match_indices_2);

img1_hom = [match_c1, match_r1, ones(match_count,1)];
img2_hom = [match_c2, match_r2, ones(match_count,1)];
[H, inliers] = homography(img1_hom,img2_hom);

match_c1 = match_c1(inliers);
match_c2 = match_c2(inliers);
match_r1 = match_r1(inliers);
match_r2 = match_r2(inliers);

tform = maketform('projective', H);
img1_result = imtransform(img1, tform);

stitched = stitch(img1, img2, H);
imshow(stitched);