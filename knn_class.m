load('dataset2.mat');

cv = cvpartition(size(finalMatrixsorted,1),'HoldOut',0.3);
idx = cv.test;

% Separate to training and test data
dataTrain = finalMatrixsorted(~idx,:);
dataTest  = finalMatrixsorted(idx,:);

result_eucledian = [];
for i = 1:20
    Mdl = fitcknn(dataTrain(:,1:2), dataTrain(:,3), 'NumNeighbors', i);
    labels_original = dataTest(:,3);
    labels_predicted = predict(Mdl, dataTest(:,1:2));
    [N,M] = size(labels_predicted);
    [c] = confusionmat(labels_original,labels_predicted);
    res = sum(labels_original == labels_predicted) / N
    result_eucledian(i) = res;
end

result_manhattan = [];
for i = 1:20
    Mdl = fitcknn(dataTrain(:,1:2), dataTrain(:,3), 'NumNeighbors', i, 'Distance', 'cityblock');
    labels_original = dataTest(:,3);
    labels_predicted = predict(Mdl, dataTest(:,1:2));
    [N,M] = size(labels_predicted);
    [c] = confusionmat(labels_original,labels_predicted);
    res = sum(labels_original == labels_predicted) / N
    result_manhattan(i) = res;
end

result_chebychev = [];
for i = 1:20
    Mdl = fitcknn(dataTrain(:,1:2), dataTrain(:,3), 'NumNeighbors', i, 'Distance', 'chebychev');
    labels_original = dataTest(:,3);
    labels_predicted = predict(Mdl, dataTest(:,1:2));
    [N,M] = size(labels_predicted);
    [c] = confusionmat(labels_original,labels_predicted);
    res = sum(labels_original == labels_predicted) / N
    result_chebychev(i) = res;
end

result_minkowski = [];
for i = 1:20
    Mdl = fitcknn(dataTrain(:,1:2), dataTrain(:,3), 'NumNeighbors', i, 'Distance', 'minkowski');
    labels_original = dataTest(:,3);
    labels_predicted = predict(Mdl, dataTest(:,1:2));
    [N,M] = size(labels_predicted);
    [c] = confusionmat(labels_original,labels_predicted);
    res = sum(labels_original == labels_predicted) / N
    result_minkowski(i) = res;
end

plot(1:20, result_eucledian)
hold on
plot(1:20, result_manhattan)
hold on
plot(1:20, result_minkowski)
hold on
plot(1:20, result_chebychev)

