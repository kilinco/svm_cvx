%% CVX SVM Library Example
clear all; close all; clc;
folder = '.\DataFolder\\';

%% Create a Basic Problem:
X = randn(500,2);
% Y = double((X(:,1)+1.0*randn(1000,1)>X(:,2)))*2-1;
Y = double((X(:,1) > X(:,2)))*2-1;
X = zscore(X);
sigma = 1;
X_test = X(201:end,:);
X = X(1:200,:);
Y_test = Y(201:end);
Y = Y(1:200);

%% Find Results with the Built-in SVM as Baseline
D = fitcsvm(X,Y);
accuracy_baseline = mean(predict(D,X_test)==Y_test);

%% HARD MARGIN
% Training
hard_model = hardmargin_svm(X,Y);
baseFileName = sprintf('HardMarginSVPlot.jpeg');
fullFileName = fullfile(folder, baseFileName);
plot_the_SVs(X, Y, hard_model, "Hard Margin Support Vectors", fullFileName, true);
% Training Plot
baseFileName = sprintf('HardMarginTrainingPredictionRandomPlot.jpeg');
fullFileName = fullfile(folder, baseFileName);
accuracy_hard = svmPredictPlot(X, Y, hard_model, "Hard Margin Training - Classification Boundary and Training Points", fullFileName, true, false);
% Testing and Test Plot with model and Data Points
baseFileName = sprintf('HardMarginTestingPredictionRandomPlot.jpeg');
fullFileName = fullfile(folder, baseFileName);
accuracy_hard = svmPredictPlot(X_test, Y_test, hard_model, "Hard Margin Testing - Classification Boundary and Testing Points", fullFileName, true, false);

%% SOFT MARGIN
soft_model = softmargin_svm(X,Y,1,1)
baseFileName = sprintf('SoftMarginSVPlot.jpeg');
fullFileName = fullfile(folder, baseFileName);
plot_the_SVs(X, Y, soft_model, "Soft Margin Support Vectors", fullFileName, true);
baseFileName = sprintf('SoftMarginTrainingPredictionRandomPlot.jpeg');
fullFileName = fullfile(folder, baseFileName);
accuracy_soft = svmPredictPlot(X, Y, soft_model, "Soft Margin Training - Classification Boundary and Training Points", fullFileName, true, false);
% Testing and Test Plot with model and Data Points
baseFileName = sprintf('SoftMarginTestingPredictionRandomPlot.jpeg');
fullFileName = fullfile(folder, baseFileName);
accuracy_soft = svmPredictPlot(X_test, Y_test, soft_model, "Soft Margin Testing - Classification Boundary and Testing Points", fullFileName, true, false);

%% NON LINEAR CLASSIFICATION WITH KERNEL TRICK
nonlinear_model = nonlinear_svm(X,Y,1,1);
baseFileName = sprintf('NonlinearSVPlot.jpeg');
fullFileName = fullfile(folder, baseFileName);
plot_the_SVs(X, Y, nonlinear_model, "Nonlinear Support Vectors", fullFileName, true);
baseFileName = sprintf('NonlinearTrainingPredictionRandomPlot.jpeg');
fullFileName = fullfile(folder, baseFileName);
accuracy_nonlinear = svmPredictPlot(X, Y, nonlinear_model, "Nonlinear Training - Classification Boundary and Training Points", fullFileName, true, false);
% Testing and Test Plot with model and Data Points
baseFileName = sprintf('NonlinearTestingPredictionRandomPlot.jpeg');
fullFileName = fullfile(folder, baseFileName);
accuracy_nonlinear = svmPredictPlot(X_test, Y_test, nonlinear_model, "Nonlinear Testing - Classification Boundary and Testing Points", fullFileName, true, false);