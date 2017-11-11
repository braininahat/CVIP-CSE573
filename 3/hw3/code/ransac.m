function projections = ransac(H,p1)
projections = [];
for point_count = 1:size(p1,1)
    projected = H * [(p1(point_count,:))'];
    projected = projected./projected(end,1);
    projected = [projected(1),projected(2)];
    projections = cat(1,projections,projected);
end
projections = int16(projections);
end