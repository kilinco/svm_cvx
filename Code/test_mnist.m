load('data.mat');
load('label.mat');
folder = '.\DataFolder\\';

imageTrain = reshape(imageTrain,784, 5000)'./255;
imageTest = reshape(imageTest,784, 500)'./255;

% Prepare for Training
idx_6 = find(labelTrain == 6);
idx_8 = find(labelTrain == 8);
imgTrain_68 = imageTrain([idx_6; idx_8], :);
lblTrain_68 = labelTrain([idx_6; idx_8]);

% Prepare for Testing
idxTest_6 = find(labelTest == 6);
idxTest_8 = find(labelTest == 8);
imgTest_68 = imageTest([idxTest_6; idxTest_8], :);
lblTest_68 = labelTest([idxTest_6; idxTest_8]);

myTrain = lblTrain_68;
myTrain(myTrain == 6) = -1;
myTrain(myTrain == 8) = 1;
hard_model = hardmargin_svm(imgTrain_68, myTrain);
soft_model = softmargin_svm(imgTrain_68, myTrain, 2e-4, 1);
nonlinear_model = nonlinear_svm(imgTrain_68, myTrain, 2e-4, 1);

myTest = lblTest_68;
myTest(myTest == 6) = 0;
myTest(myTest == 8) = 1;

main_pred = svmPredict(imgTest_68, hard_model);
accuracy_hard = mean(main_pred==(myTest));
main_pred = svmPredict(imgTest_68, soft_model);
accuracy_soft = mean(main_pred==(myTest));
main_pred = svmPredict(imgTest_68, nonlinear_model);
accuracy_nonlinear = mean(main_pred==(myTest));

%% GET SUPPORT VECTOR IMAGES for ALL MODELS

for i = 1:5
    pic = reshape(soft_model.X(i,:), 28, 28);
    pic = uint8(255*mat2gray(pic));
    figure
    imshow(imresize(pic,[56 56]), [0 255])
    baseFileName = sprintf('SVImg6_%d.jpeg', i);
    fullFileName = fullfile(folder, baseFileName);
    imwrite(full(pic), fullFileName);
end

for i = 1:5
    pic = reshape(soft_model.X(384+i,:), 28, 28);
    pic = uint8(255*mat2gray(pic));
    figure
    imshow(imresize(pic,[56 56]), [0 255])
    baseFileName = sprintf('SVImg8_%d.jpeg', i);
    fullFileName = fullfile(folder, baseFileName);
    imwrite(full(pic), fullFileName);
end

