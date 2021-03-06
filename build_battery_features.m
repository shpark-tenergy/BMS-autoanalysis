function [ X ] = build_battery_features( batch )
%This function builds the possible feature set for the model

%If you add candidate features, update this number for better memory
%management
numFeat = 15;

numBat = size(batch,2);
X = zeros(numBat,numFeat);

for i = 1:numBat
    %Capacity features
    %Initial capacity
    X(i,1) = batch(i).summary.QDischarge(2);
    %Max change in capacity
    X(i,2) = max(batch(i).summary.QDischarge(1:100))...
        - batch(i).summary.QDischarge(2);
    %capacity at cycle 100
    X(i,3) = batch(i).summary.QDischarge(100);
    
    %Linear fit of Q v. N
    R3 = regress(batch(i).summary.QDischarge(2:100),[2:100;ones(1,length(2:100))]');
    X(i,4) = R3(1);
    X(i,5) = R3(2);
    
    %Linear fit of Q v. N, only last 10 cycles
    R1 = regress(batch(i).summary.QDischarge(91:100),[91:100;ones(1,length(91:100))]');
    X(i,6) = R1(1);
    X(i,7) = R1(2);
    
    %Q features
    QDiff = batch(i).cycles(100).Qdlin - batch(i).cycles(10).Qdlin;
    
    X(i,8) = log10(abs(min(QDiff)));
    X(i,9) = log10(abs(mean(QDiff)));
    X(i,10) = log10(abs(var(QDiff)));
    X(i,11) = log10(abs(skewness(QDiff)));
    X(i,12) = log10(abs(QDiff(1)));
   
    % Peter's proposed features
    
    % Sum of Qdiff
    X(i,13) = log10(sum(abs(QDiff)));
    
    % Sum of Qdiff^2
    X(i,14) = log10(sum(QDiff.^2));
    
    % Energy difference
    E10 = trapz(batch(i).cycles(10).Qdlin,batch(i).Vdlin);
    E100 = trapz(batch(i).cycles(100).Qdlin,batch(i).Vdlin);
    X(i,15) = log10(E10-E100);

end %end loop through batteries


end