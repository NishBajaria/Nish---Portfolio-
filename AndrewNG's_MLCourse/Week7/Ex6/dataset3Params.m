function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

commonList = [0.01 0.03 0.1 0.3 1 3 10 30];
CList = commonList;
sigmaList = commonList;
row = 1;
len = length(commonList);
predictionError = zeros(len, len);
results = zeros(len, 3);
for i = 1:len % CList
    for j = 1:len % sigmaList
        model = svmTrain(X, y, CList(i), @(x1, x2) gaussianKernel(x1, x2, sigmaList(j)) );
        predictions = svmPredict(model, Xval);
        predictionError(i,j) = mean(double(predictions ~= yval));
        results(row,:) = [predictionError(i,j) CList(i) sigmaList(j)];
        row = row+1;      
    end
    
end
[M, I] = min(results(:,1));
C = results(I,2);
sigma = results(I,3);





% =========================================================================

end
