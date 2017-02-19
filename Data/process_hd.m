clear all; close all;

Y=load('data.txt')
X=Y;
%1.  A       Age           age in years
%2.  G       Gender        1 = male; 0 = female
%3.  CP      ChestPain     (typical angina,atypical angina,non-anginal pain,asymptomatic)
%4.  BP      BloodPressue  (trestbps) resting blood pressure
%5.  Chol    Cholestoral
%7.  ECG     Electrocardiograph (normal, ST-T wave abnormality, ventricular hypertrophy)
%8.  HR      HeartRate
%9.  EIA     Exercise Induced Angina (1 = yes; 0 = no)
%14. HD      HeartDisease            (1=yes; 0=no)
X=X(:,[1,2,3,4,5,7,8,9,14]);

%1.  A       Age           1:A<45, 2:45<=A<55, 3:A>55
%2.  G       Gender        1:Female, 2:Male; 
%3.  CP      Chest Pain     1:Typical Angina, 2:Atypical Angina, 3:Non-Anginal, 4:Asymptomatic)
%4.  BP      Blood Pressue  1:Low, 2:High
%5.  Chol    Cholestoral   1:Low, 2:High 
%6.  ECG     Electrocardiograph 1:Normal, 2:Abnormal
%7.  HR      Exercise Heart Rate          1:Low, 2:High 
%8.  EIA     Exercise Induced Angina 1:No, 2:Yes
%9.  HD      Heart Disease            1:No, 2:yes

X(X(:,1)<45,1)=1;
X(X(:,1)>=45 & X(:,1)<55,1)=2;
X(X(:,1)>=55,1)=3;

X(:,2)=X(:,2)+1;

X(X(:,4)<130,4)=1;
X(X(:,4)>=130,4)=2;

X(X(:,5)<200,5)=1;
X(X(:,5)>=200,5)=2;

X(:,6)=X(:,6)+1;
X(X(:,6)>=2,6)=2;

X(X(:,7)<145,7)=1;
X(X(:,7)>=145,7)=2;

X(:,8)=X(:,8)+1;

X(X(:,9)>1,9)=1;
X(:,9)=X(:,9)+1;

figure(1);
for i=1:9;
  subplot(3,3,i)
  hist(X(:,i))
  title(num2str(i))
end  

N = size(X,1);
BS = floor(N/5);
rand("seed",time);
ind = randperm(N);

for j=1:5;
    test_ind            = ind(BS*(j-1)+ [1:BS]);
    train_ind           = 1:N;
    train_ind(test_ind) = [];
    intersect(train_ind,test_ind)
    [length(train_ind),length(test_ind)]
    
    Train = X(train_ind,:);
    Test  = X(test_ind,:);
    
    figure;
    for i=1:9;
      subplot(3,3,i)
      hist(Train(:,i))
      title(num2str(i))
    end  

    figure; 
    for i=1:9;
      subplot(3,3,i)
      hist(Test(:,i))
      title(num2str(i))
    end  

    Train = uint8(X(train_ind,:));
    Test  = uint8(X(test_ind,:));

    fname=sprintf('data-train-%d.txt',j) 
    dlmwrite(fname,Train,'delimiter',',','newline','pc');
    
    fname=sprintf('data-test-%d.txt',j) 
    dlmwrite(fname,Test,'delimiter',',','newline','pc');
    
end