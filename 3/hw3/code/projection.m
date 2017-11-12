function projections = projection(H, p1_hom, p2_hom)
    projected = p1_hom * H;
    lambda_t =  projected(:,3);
    lambda_2 = p2_hom(:,3);
    p1_dist = projected(:,1) ./ lambda_t - p2_hom(:,1) ./ lambda_2;
    p2_dist = projected(:,2) ./ lambda_t - p2_hom(:,2) ./ lambda_2;
    projections = p1_dist.^2 + p2_dist.^2;
end

