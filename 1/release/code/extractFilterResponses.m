function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses


% TODO Implement your code here

% Coverting to pseudo RGB if grayscale

if size(img,3)==1
	img = repmat(img,[1,1,3]);
end

% Converting to Lab colorspace
lab_img = RGB2Lab(img);
filterResponses = [];

% Dynamic filterbank size
dims = size(filterBank);

% Concatenating along z axis
for i = 1:1:dims(1)
    filterResponses = cat(3,filterResponses,imfilter(lab_img,filterBank{i,1}));
end

end
