function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');
    c = zeros(8);
	% TODO Implement your code here
    for i = 1:1:size(test_imagenames,1)
        guess = guessImage(test_imagenames{i,1});
        guessed_label = find(strcmp(mapping,guess));
        actual_label = test_labels(i);
        c(actual_label,guessed_label) = c(actual_label,guessed_label) + 1;
    end
    accuracy = trace(c)/sum(c(:))
    conf = c
end