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

c1_pred_z1 = normpdf(F1_test,mean1,sd1);
c2_pred_z1 = normpdf(F1_test,mean2,sd2);
c3_pred_z1 = normpdf(F1_test,mean3,sd3);
c4_pred_z1 = normpdf(F1_test,mean4,sd4);
c5_pred_z1 = normpdf(F1_test,mean5,sd5);

F2_train=F2(1:100,:);
F2_test=F2(101:1000,:);

sd1=std(F2_train(:,1));
sd2=std(F2_train(:,2));
sd3=std(F2_train(:,3));
sd4=std(F2_train(:,4));
sd5=std(F2_train(:,5));
mean1=mean(F2_train(:,1));
mean2=mean(F2_train(:,2));
mean3=mean(F2_train(:,3));
mean4=mean(F2_train(:,4));
mean5=mean(F2_train(:,5));



F2_train_reshape=[F2_train(:,1) ones(100,1);F2_train(:,2) (ones(100,1)+1);F2_train(:,3) (ones(100,1)+2);F2_train(:,4) (ones(100,1)+3);F2_train(:,5) (ones(100,1)+4)];
[x1,c1]=prob_x_given_c(F2_train_reshape,mean1,sd1,F2_train(:,1));
[x2,c2]=prob_x_given_c(F2_train_reshape,mean2,sd2,F2_train(:,2));
[x3,c3]=prob_x_given_c(F2_train_reshape,mean3,sd3,F2_train(:,3));
[x4,c4]=prob_x_given_c(F2_train_reshape,mean4,sd4,F2_train(:,4));
[x5,c5]=prob_x_given_c(F2_train_reshape,mean5,sd5,F2_train(:,5));

c1_pred_f2=zeros(1,1);
c2_pred_f2=zeros(1,1);
c3_pred_f2=zeros(1,1);
c4_pred_f2=zeros(1,1);
c5_pred_f2=zeros(1,1);

for i=1:900
    for j=1:5
       p=F2_test(i,j);
       p1=round((p-mean1)/sd1);
       prob1=prob_lookup(p1,c1,x1);
       p2=round((p-mean2)/sd2);
       prob2=prob_lookup(p2,c2,x2);
       p3=round((p-mean3)/sd3);
       prob3=prob_lookup(p3,c3,x3);
       p4=round((p-mean4)/sd4);
       prob4=prob_lookup(p4,c4,x4);
       p5=round((p-mean5)/sd5);
       prob5=prob_lookup(p5,c5,x5);
       c1_pred_f2(i,j)=prob1;
       c2_pred_f2(i,j)=prob2;
       c3_pred_f2(i,j)=prob3;
       c4_pred_f2(i,j)=prob4;
       c5_pred_f2(i,j)=prob5;
       
    end
end



c1_pred=c1_pred_f2.*c1_pred_z1;
c2_pred=c2_pred_f2.*c2_pred_z1;
c3_pred=c3_pred_f2.*c3_pred_z1;
c4_pred=c4_pred_f2.*c4_pred_z1;
c5_pred=c5_pred_f2.*c5_pred_z1;


pred_prob=zeros(1,1);

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

accuracy
% 78.67%


