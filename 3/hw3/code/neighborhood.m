function [descriptor] = neighborhood(img,radius,r,c)
    feature_count = length(r);
    descriptor = zeros(feature_count, (2 * radius + 1)^2);
    pad = zeros(2 * radius + 1); 
    pad(radius + 1, radius + 1) = 1;
    padded_img = imfilter(img, pad, 'replicate', 'full');
    for i = 1 : feature_count
        rows = r(i) : r(i) + 2 * radius;
        cols = c(i) : c(i) + 2 * radius;
        neighborhood = padded_img(rows, cols);
        vect_feat = neighborhood(:);
        descriptor(i,:) = vect_feat;
    end
    descriptor = zscore(descriptor')';
end

