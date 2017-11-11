function H = homography(p1,p2)

A = [];

for i = 1:size(p1,1)
    A = cat(1,A,[-p1(i,:),zeros(1,3),p2(i,1)*p1(i,:);zeros(1,3),-p1(i,:),p2(i,2)*p1(i,:)]);
end

[u,s,v]=svd(A);

h = v(:,size(v,2));

A = reshape(h,[3,3]);
A = A./A(3,3);
H = A';

end