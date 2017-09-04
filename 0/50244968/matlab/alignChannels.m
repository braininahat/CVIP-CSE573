function [rgbResult] = alignChannels(red, green, blue)
% alignChannels - Given 3 images corresponding to different channels of a
%       color image, compute the best aligned result with minimum
%       aberrations
% Args:
%   red, green, blue - each is a matrix with H rows x W columns
%       corresponding to an H x W image
% Returns:
%   rgb_output - H x W x 3 color image output, aligned as desired

%% Write code here
%combining 3 channels to form color composite
base_image = cat(3,red,green,blue);

%finding centre and extracting row vector of lenght 10 from the centre of
%the red plane
dimensions = size(base_image);
centre = ceil(dimensions/2);
x = centre(1);
y = centre(2);
reference = imcrop(red,[x-5,y,9,0]);

%extract 2d blue and green windows 30x10
blue_mat = imcrop(blue,[x-5,y-15,9,29]);
green_mat = imcrop(green,[x-5,y-15,9,29]);

%find best correlation of blue with template (red plane row vector from centre)
corr_rb = normxcorr2(reference,blue_mat);
[y_rb,x_rb] = find(corr_rb==max(corr_rb(:)));

%find best correlation of green and ref
corr_rg = normxcorr2(reference,green_mat);
[y_rg,x_rg] = find(corr_rg==max(corr_rg(:)));

%correct by offset amount found from looking up indices of peak correlation
%row
corrected_green = circshift(green,-y_rg);
corrected_blue = circshift(blue,-y_rb);

%compositing corrected channels to rgb
rgbResult = cat(3,red,corrected_green,corrected_blue);

end
