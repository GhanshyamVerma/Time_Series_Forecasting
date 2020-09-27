function [ MSE,MAE,MAPE,RMSE,SSE,MPE] = errorfunction( testdata,fordata,test_size )
for k=1:test_size
    error=(testdata - fordata);
MSE = mse(error);
MAE = mae(error);
MAPE= ((sum(abs(error./testdata)))*100)/test_size;
RMSE=sqrt(mean((error).^2));
SSE = sse(error);
MPE= ((sum(error./testdata))*100)/test_size;

end
end