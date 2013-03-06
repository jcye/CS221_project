addpath('../liblinear-1.92/matlab');  % add LIBLINEAR to the path
[sparseTestMatrix, testCategory] = readMatrix('concat_test.tsv');

numTestDocs = size(sparseTestMatrix, 1);
numTokens = size(sparseTestMatrix, 2);

% Assume liblinear_train.m has just been executed, and the model trained
% by your classifier is in memory through that execution. You can also assume 
% that the columns in the test set are arranged in exactly the same way as for the
% training set (i.e., the j-th column represents the same token in the test data 
% matrix as in the original training data matrix).

% Write code below to classify each document in the test set (ie, each row
% in the current document word matrix) as 1 for SPAM and 0 for NON-SPAM.

% Note that the predict function for LIBLINEAR uses the sparse matrix 
% representation of the document word  matrix, which is stored in sparseTestMatrix.
% Additionally, it expects the labels to be dimension (numTestDocs x 1).

% Construct the (numTestDocs x 1) vector 'output' such that the i-th entry 
% of this vector is the predicted class (1/0) for the i-th  email (i-th row 
% in testMatrix) in the test set.
output = zeros(numTestDocs, 1);

%---------------
% YOUR CODE HERE
svm_category = 2.*testCategory - 1;
[prob1, prob2, prob3] = predict(svm_category', sparseTestMatrix, model, '-b 1');
% output = 0.5.*(output + 1);


%---------------
prcurve = [];
stepSize = 0.01;
thresh = 0;
while thresh < 1
    fp = 0;
    fn = 0;
    tp = 0;
    for i=1:numTestDocs
        if (testCategory(i)==1 && prob3(i,2) >= thresh)
            tp = tp + 1;
        end
        if (testCategory(i)==1 && prob3(i,2) < thresh)
            fn = fn + 1;
        end
        if (testCategory(i)==0 && prob3(i,2) >= thresh)
            fp = fp + 1;
        end
    end
    prcurve = [prcurve; [tp/(tp+fp), tp/(tp+fn)]];
    if thresh >= 0.99
        stepSize = 0.001;
    end
    if thresh >= 0.999
        stepSize = 0.0001;
    end
    if thresh >= 0.9999
        stepSize = 0.00001;
    end
    thresh = thresh + stepSize;
end

% save('prcurve_apply_score_description', 'prcurve');
plot(prcurve(:,2),prcurve(:,1),'b-o');
title('precision-recall');
xlabel('reall');
ylabel('precision');
axis([0 1 0 1]);
% legend('work-history');

% Compute the error on the test set
% error=0;
% for i=1:numTestDocs
%   if (testCategory(i) ~= output(i))
%    error=error+1;
%  end
% end

%Print out the classification error on the test set
% error/numTestDocs