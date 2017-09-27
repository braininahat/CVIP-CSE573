function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here
    L = layerNum - 1;
    split = cell((2^L)*(2^L),1);
    
    hist_fine = [];
    
    count = 1;
    
    [row,col] = size(wordMap);
    
    row_size = ceil(row/4);
    col_size = ceil(col/4);
    
    for i = 1:row_size:row
        i2 = min(i + (row_size - 1),row);
        for j = 1:col_size:col
            j2 = min(j + (col_size - 1),col);
            split{count,1} = wordMap(i:i2,j:j2); 
            count = count + 1;
        end
    end
    
    for k = 1:1:size(split,1)
        hist_fine = cat(3,hist_fine,getImageFeatures(split{k,1},dictionarySize));
    end
    
    hist_med = hist_fine(:,:,1)+hist_fine(:,:,2)+hist_fine(:,:,5)+hist_fine(:,:,6);
    hist_med = cat(3,hist_med,hist_fine(:,:,3)+hist_fine(:,:,4)+hist_fine(:,:,7)+hist_fine(:,:,8));
    hist_med = cat(3,hist_med,hist_fine(:,:,9)+hist_fine(:,:,10)+hist_fine(:,:,13)+hist_fine(:,:,14));
    hist_med = cat(3,hist_med,hist_fine(:,:,11)+hist_fine(:,:,12)+hist_fine(:,:,15)+hist_fine(:,:,15));
    hist_coarse = hist_med(:,1)+hist_med(:,2)+hist_med(:,3)+hist_med(:,4);
    
    for count = 1:size(hist_med,3)
        hist_med(:,:,count) = hist_med(:,:,count)/norm(hist_med(:,:,count),1);
    end
    
    hist_coarse(:,:,1) = hist_coarse(:,:,1)/norm(hist_coarse(:,:,1),1);
    
    h = hist_coarse;
    
    for ham = 1:1:size(hist_med,3)
        h = cat(2,h,hist_med(:,:,ham));
    end
    
    for eggs = 1:1:size(hist_fine,3)
        h = cat(2,h,hist_fine(:,:,eggs));
    end
    h = h(:);
end