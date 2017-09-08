function index = ssdy(reference,window)
diff = double(window) - double(reference);
sq = diff.^2;
sq_sum = sum(sq);
index = find(sq_sum==min(sq_sum));
end