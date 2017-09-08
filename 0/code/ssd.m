function index = ssdx(reference,window)
diff = double(window) - double(reference);
sq = diff.^2;
sq_sum = sum(sq,2);
index = find(sq_sum==min(sq_sum));
end