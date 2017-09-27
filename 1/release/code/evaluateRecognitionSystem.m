function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');

	% TODO Implement your code here
    guesses = [];
    for i = 1:1:size(test_imagenames,1)
    guesses = cat(2,guesses,guessImage(test_imagenames{i,1}));
    c = [];

end