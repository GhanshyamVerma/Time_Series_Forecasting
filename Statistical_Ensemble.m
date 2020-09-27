clc;
close all;
clear all;
% Input excel file must contain 1st column as test data 
% and rest of the colums as Model forecasts

fileList = dir('*.xlsx');
counter = 1;
alpha=20;
[FSize,ColSize] = size(fileList);
while counter <= FSize

	% reading time sereis form xlsx
	DataRead=fileList(counter).name;
    [type,sheetname] = xlsfinfo(DataRead);
    [noofRow,NumOfSheets]=size(sheetname);
    
    for readSheet=1:NumOfSheets
	TimeSeriesData=xlsread(DataRead,readSheet,'A20:J200');
    ActualTestData=TimeSeriesData(:,1);
    AllModelForecasts=TimeSeriesData(:,2:end);
    
    % Simple Average of all models
    SimpleMean=mean(AllModelForecasts,2);
    
    % Trimed mean code
    [Modelrow,NumModel]=size(AllModelForecasts);
    TrimValue=ceil((NumModel*alpha)/100);
    SortedData=sort(AllModelForecasts,2);
    TrimedMean=mean(SortedData(:,(TrimValue+1:end-TrimValue)),2);
    
    % Winsorised Mean code
    for i=1:TrimValue
        SortedData(:,i)=SortedData(:,TrimValue+1);
        SortedData(:,end-i+1)=SortedData(:,end-TrimValue);
    end
    WinsorisedMean=mean(SortedData,2);
    
    % Median code
    
    if  rem(NumModel,2)
        % odd 
        MedianEnsemble=SortedData(:,(NumModel+1)/2);
    else
        % even
        MedianEnsemble1=SortedData(:,NumModel/2);
        MedianEnsemble2=SortedData(:,(NumModel/2)+1);
        MedianEnsemble=((MedianEnsemble1+MedianEnsemble2)./2);
    end
    
    
 

 % code for Simple average excel write
 filename = 'River Results all Models.xlsx';
 sheet = readSheet;
 TestDataInfo={'TestData'};
 xlTestRange='L20';
 xlswrite(filename,TestDataInfo,sheet,xlTestRange);
 xlTestRange2='L21';
 xlswrite(filename,ActualTestData,sheet,xlTestRange2);
 
 SimpleAverage={'SimpleAverage'};
 xlRangeH = 'M20';
 xlswrite(filename,SimpleAverage,sheet,xlRangeH);
 xlRangeH2 = 'M21';
 xlswrite(filename,SimpleMean,sheet,xlRangeH2);
 
 % code for Trimed Mean excel write
 TrimedMeanXL={'TrimedMean'};
 xlRangeH = 'N20';
 xlswrite(filename,TrimedMeanXL,sheet,xlRangeH);
 xlRangeH2 = 'N21';
 xlswrite(filename,TrimedMean,sheet,xlRangeH2);
 
 % code for Winsorised Mean excel write
 EnsembleTech={'WinsorisedMean'};
 xlRangeH = 'O20';
 xlswrite(filename,EnsembleTech,sheet,xlRangeH);
 xlRangeH2 = 'O21';
 xlswrite(filename,WinsorisedMean,sheet,xlRangeH2);
 
 % code for Median excel write
 EnsembleTech={'Median'};
 xlRangeH = 'P20';
 xlswrite(filename,EnsembleTech,sheet,xlRangeH);
 xlRangeH2 = 'P21';
 xlswrite(filename,MedianEnsemble,sheet,xlRangeH2);
 
% %     Headings = {DataRead};
%     sheet = counter;
%     xlRangeH = 'D2';
%     Heading1 = {DataRead};
%     xlswrite(filename,Heading1,sheet,xlRangeH);   
%  xlRange = 'D5';
%     xlswrite(filename,A,sheet,xlRange)
%     nodesANN = {'I/P Node';InputNode;'HiddNode';HiddenNode;'MinMAE';MinMAE;'MinMAPE';MinMAPE;'iter';NumItt};
%     
%     xlRange = 'E3';
%     xlswrite(filename,nodesANN,sheet,xlRange)
%     xlRange1 = 'D10';
%     xlswrite(filename,MinForecase,sheet,xlRange1);
% %     xlswrite(FILE,ARRAY,SHEET,RANGE)
    end % end for reading sheet of excel file
    counter = counter + 1;
end % end while loop    