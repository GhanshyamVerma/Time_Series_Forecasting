clc;
close all;
clear all;
filename='DirectANN_govt.xlsx';
testdata=xlsread(filename,'A9:A69');
fordata=xlsread(filename,'J9:J69');
test_size=size(fordata,1);
[ MSE,MAE,MAPE,RMSE,SSE,MPE] = errorfunction( testdata,fordata,test_size )
fprintf('Minimum MSE=%f\n',MSE);
fprintf('Minimum MAE=%f\n',MAE);
fprintf('Minimum MAPE=%f\n',MAPE);
fprintf('Minimum RMSE=%f\n',RMSE);
fprintf('Minimum SSE=%f\n',SSE);
fprintf('Minimum MPE=%f\n',MPE);
