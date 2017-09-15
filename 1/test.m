[filterbank] = createFilterBank();
lab_img = RGB2Lab(img);
response = [];
for i = 1:1:20
    response = cat(3,response,imfilter(lab_img,filterbank{i,1}));
end
% size(response);
montage(response);