% loading data
load('data.mat');
% taking the first 100 observations for training
F1_train=F1(1:100,:);
F1_test=F1(101:1000,:);

sd1=std(F1_train(:,1));
sd2=std(F1_train(:,2));
sd3=std(F1_train(:,3));
sd4=std(F1_train(:,4));
sd5=std(F1_train(:,5));
mean1=mean(F1_train(:,1));
mean2=mean(F1_train(:,2));
mean3=mean(F1_train(:,3));
mean4=mean(F1_train(:,4));
mean5=mean(F1_train(:,5));

c1_pred = normpdf(F1_test,mean1,sd1);
c2_pred = normpdf(F1_test,mean2,sd2);
c3_pred = normpdf(F1_test,mean3,sd3);
c4_pred = normpdf(F1_test,mean4,sd4);
c5_pred = normpdf(F1_test,mean5,sd5);

pred_prob=zeros(1,1);
pred=zeros(0,0);

for i=1:900
    for j=1:5
        pred_prob(i,j)=max([c1_pred(i,j),c2_pred(i,j),c3_pred(i,j),c4_pred(i,j),c5_pred(i,j)]);
    end 
end 

for i=1:900
    for j=1:5
        if pred_prob(i,j)==c1_pred(i,j)
            pred(i,j)=1;
        elseif pred_prob(i,j)==c2_pred(i,j)
            pred(i,j)=2;
        elseif pred_prob(i,j)==c3_pred(i,j)
            pred(i,j)=3;
        elseif pred_prob(i,j)==c4_pred(i,j)
            pred(i,j)=4;
        elseif pred_prob(i,j)==c5_pred(i,j)
            pred(i,j)=5;
        end
    end
end

accuracy=(sum(pred(:,1)==1)+sum(pred(:,2)==2)+sum(pred(:,3)==3)+sum(pred(:,4)==4)+sum(pred(:,5)==5))/4500;


% 53.00%