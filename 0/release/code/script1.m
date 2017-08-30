% Problem 1: Image Alignment

%% 1. Load images (all 3 channels)
red = [];  % Red channel
green = [];  % Green channel
blue = [];  % Blue channel

%% 2. Find best alignment
% Hint: Lookup the 'circshift' function
rgbResult = alignChannels(red, green, blue);

%% 3. Save result to rgb_output.jpg (IN THE "results" folder)
