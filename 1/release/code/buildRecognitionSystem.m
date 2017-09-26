function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');

	% TODO create train_features
    train_features = [];
    for i = 1:1349
        train_features = cat(2,train_features,getImageFeaturesSPM(3,getVisualWords(imread(train_imagenames{i,1}),filterBank,dictionary),150));
    end
	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end