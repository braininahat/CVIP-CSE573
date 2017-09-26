train_features = [];
h = waitbar(0);
for i = 1:1349
    waitbar(i/1349)
    train_features = cat(2,train_features,getImageFeaturesSPM(3,getVisualWords(imread(train_imagenames{i,1}),filterBank,dictionary),150));
end