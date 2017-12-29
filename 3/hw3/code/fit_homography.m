function H = fit_homography(p1_hom, p2_hom)
    [match_count, ~] = size(p1_hom);
    A = [];
    for i = 1:match_count
        p1 = p1_hom(i,:);
        p2 = p2_hom(i,:);
        A_i = [ zeros(1,3),-p1,p2(2)*p1;p1,zeros(1,3),-p2(1)*p1];
        A = [A; A_i];        
    end
    [u,s,v] = svd(A);
    h = v(:,9);
    H = reshape(h, 3, 3);
    H = H ./ H(3,3);
end

