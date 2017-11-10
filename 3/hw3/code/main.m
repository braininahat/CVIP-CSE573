left = double(rgb2gray(imread('../data/part1/uttower/left.jpg')));
right = double(rgb2gray(imread('../data/part1/uttower/right.jpg')));

sigma = 3;
thresh = 1000;
radius = 3;
disp = 0;
neighborhood_factor = 11; % center pixel will be factor'th position in the square 
match_count = 200;

%harris for points of interest
[left_cim,left_r,left_c] = harris(left,sigma,thresh,radius,disp);
[right_cim,right_r,right_c] = harris(right,sigma,thresh,radius,disp);

%padding before extracting neighborhood
padded_left = padarray(left,[neighborhood_factor,neighborhood_factor],'replicate');
padded_right = padarray(right,[neighborhood_factor,neighborhood_factor],'replicate');

%extracting neighborhoods
left_descriptors = neighborhood(padded_left,left_r,left_c,neighborhood_factor);
right_descriptors = neighborhood(padded_right,right_r,right_c,neighborhood_factor);

left_ind = sub2ind(size(padded_left),padded_left);
right_ind = sub2ind(size(padded_right),padded_right);

%flattening neighborhoods to form descriptors
left_descriptors = left_descriptors(:);
right_descriptors = right_descriptors(:);

%calculating distance
distances = dist2(left_descriptors,right_descriptors); %returned row index is left index

%finding closest pairs
[val,dist_indices] = sort(distances(:),'ascend');
match_indices = dist_indices(1:match_count);

%indices of closest pairs in distance matrix
[match_r,match_c] = ind2sub(size(distances),match_indices); %padded vector indices

%looking up in descriptor vector
[left_match_r,left_match_c] = ind2sub(size(left_descriptors),match_r);
[right_match_r,right_match_c] = ind2sub(size(right_descriptors),match_c);

left_r_main = left_match_r - neighborhood_factor;
left_c_main = left_match_c - neighborhood_factor;
right_r_main = right_match_r - neighborhood_factor;
right_c_main = left_match_c - neighborhood_factor;

% creating homogenous matrices
left_hom = [left_r_main,left_c_main,ones(match_count)];
right_hom = [right_r_main,right_c_main,ones(match_count)];
