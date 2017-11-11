function H = ransac(p1,p2,epochs)
rows = size(p1,1);
for loop = 1:epochs
    rand_indices = transpose(randperm(rows,4))
    p1_sel = p1(rand_indices,:);
    p2_sel = p2(rand_indices,:);
    A = [];
    for i = 1:size(p1_sel,1)
        A = cat(1,A,[-p1_sel(i,:),zeros(1,3),p2_sel(i,1)*p1_sel(i,:);zeros(1,3),-p1_sel(i,:),p2_sel(i,2)*p1_sel(i,:)]);
    end
    [u,s,v]=svd(A);
    h = v(:,size(v,2));
    A = reshape(h,[3,3]);
    A = A./A(3,3);
    H = A';
    
    projections = [];
    for point_count = 1:size(p1_sel,1)
        projected = H * [(p1_sel(point_count,:))'];
        projected = projected./projected(end,1);
        projected = [projected(1),projected(2)];
        projections = cat(1,projections,projected);
    end
    projections;
end
end