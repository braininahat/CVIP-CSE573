function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

    filterBank  = createFilterBank();
    
    % TODO Implement your code here
    
    dictionary = [];
    all_responses = [];
    alpha = randperm(100);
    h = waitbar(0);
    im_count = size(imPaths,1);
    
    for i = 1:1:im_count
        waitbar(i/im_count)
        
        %read image sequentially
        tmp = imread(imPaths{i});
        
        single_img_response = [];
        %extract response for each image (60d)
        response = extractFilterResponses(tmp,filterBank);
        
        %select each plane and reshape to h.wx60 2d
        for j = 1:1:60
            plane = response(:,:,j);
            vect = plane(:);
            vect = vect(alpha);
            single_img_response = cat(2,single_img_response,vect);
        end
        all_responses = cat(1,all_responses,single_img_response);
        
    end
    close(h)
    [~, dictionary] = kmeans(all_responses,150);
%     dictionary = transpose(dictionary);
end