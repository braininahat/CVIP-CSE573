function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here
    
    responses = extractFilterResponses(img, filterBank);
    shape = size(responses);
    single_img_response = [];
    for j = 1:1:60
            plane = responses(:,:,j);
            vect = plane(:);
            single_img_response = cat(2,single_img_response,vect);
    end
    distances = pdist2(single_img_response,dictionary);
    [~, ind] = min(transpose(distances));
    wordMap = reshape(ind,[shape(1),shape(2)]);
end
