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
centre = size(red)./2;
y = ceil(centre(1));
x = ceil(centre(2));

reference_x = imcrop(red,[x-5,y-5,9,0]);
reference_y = imcrop(red,[x-5,y-5,0,9]);

green_window_x = imcrop(green,[x-15,y-5,9,29]);
blue_window_x = imcrop(blue,[x-15,y-5,9,29]);

green_window_y = imcrop(green,[x-5,y-15,29,9]);
blue_window_y = imcrop(blue,[x-5,y-15,29,9]);

x_rg = ssdx(reference_x,green_window_x);
x_rb = ssdx(reference_x,blue_window_x);

corrected_green = circshift(green,-x_rg);
corrected_blue = circshift(blue,-x_rb);

[rgbResult] = cat(3,red,corrected_green,corrected_blue);

end
