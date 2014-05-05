blockSize = 8;
patchSize = 64;
directories = {'mac' , 'win'};

disp('Collecting features from dataset.. ')
features = CreateBagOfWords(blockSize, patchSize, directories, 0.8);

disp('Features collected, clustering.. ')
[codebook, assignments] = vl_kmeans(features', 80, 'Initialization', 'plusplus');

disp('Comparing dataset to codebook.. ')
[X Y] = CalcHistograms(codebook', blockSize, patchSize, directories, 1, 0.8);

disp('Training SVM classifier.. ')
[W B] = vl_svmtrain(X, double(Y), 0.02);

disp('Success rate on train set: ')
sum(sign(W' * X + B) == Y) / length(Y)

[CROSS_VALID_SET CROSS_VALID_LABELS] = CalcHistograms(codebook', blockSize, patchSize, directories, 0, 0.8);
disp('Success rate on cross validation set: ')
sum(sign(W' * CROSS_VALID_SET + B) == CROSS_VALID_LABELS) / length(CROSS_VALID_LABELS)
