function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses


% TODO Implement your code here

% Converting to Lab colorspace
lab_img = RGB2Lab(img);
filterResponses = [];

% Dynamic filterbank size
dims = size(filterBank);

% Concatenating along z axis
for i = 1:1:dims(1)
    filterResponses = cat(3,filterResponses,imfilter(lab_img,filterbank{i,1}));
end

end
