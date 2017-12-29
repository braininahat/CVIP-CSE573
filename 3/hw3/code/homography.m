function [ H, inliers ] = homography( p1, p2 )
    epochs = 150;
    point_count = 4;
    thresh_dist = 10;
    thresh_inlier = .2;
    
    [match_count, ~] = size(p1);
    inlier_count = zeros(epochs,1);
    H_store = {};
    
    for i = 1 : epochs
        subsetIndices = randsample(match_count, point_count);
        p1_sel = p1(subsetIndices, :);
        p2_sel = p2(subsetIndices, :);
        model = fit_homography(p1_sel, p2_sel);
        projections = projection(model, p1, p2);
        inliers = find(projections < thresh_dist);      
        inlier_count(i) = length(inliers);
        inlier_ratio = inlier_count(i)/match_count;
        if inlier_ratio >=  thresh_inlier
            x_inliers = p1(inliers, :);
            y_inliers = p2(inliers, :);
            H_store{i} = fit_homography(x_inliers, y_inliers);
        end
    end
    iter_opt = find(inlier_count == max(inlier_count));
    iter_opt = iter_opt(1);
    H_opt = H_store{iter_opt};
    projections = projection(H_opt, p1, p2);
    inliers = find(projections < thresh_dist);
    H = H_opt;
end