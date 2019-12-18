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

F1_train_reshape=[F1_train(:,1) ones(100,1);F1_train(:,2) (ones(100,1)+1);F1_train(:,3) (ones(100,1)+2);F1_train(:,4) (ones(100,1)+3);F1_train(:,5) (ones(100,1)+4)];
[x1,c1]=prob_x_given_c(F1_train_reshape,mean1,sd1,F1_train(:,1));
[x2,c2]=prob_x_given_c(F1_train_reshape,mean2,sd2,F1_train(:,2));
[x3,c3]=prob_x_given_c(F1_train_reshape,mean3,sd3,F1_train(:,3));
[x4,c4]=prob_x_given_c(F1_train_reshape,mean4,sd4,F1_train(:,4));
[x5,c5]=prob_x_given_c(F1_train_reshape,mean5,sd5,F1_train(:,5));

pred=zeros(size(F1_test));

for i=1:900
    for j=1:5
       p=F1_test(i,j);
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
       
       if max([prob1,prob2,prob3,prob4,prob5])==prob1
           pred(i,j)=1;
       elseif max([prob1,prob2,prob3,prob4,prob5])==prob2
           pred(i,j)=2;
       elseif max([prob1,prob2,prob3,prob4,prob5])==prob3
           pred(i,j)=3;
       elseif max([prob1,prob2,prob3,prob4,prob5])==prob4
           pred(i,j)=4;
       elseif max([prob1,prob2,prob3,prob4,prob5])==prob5
           pred(i,j)=5;
       end 
         
       
    end
end


accuracy=(sum(pred(:,1)==1)+sum(pred(:,2)==2)+sum(pred(:,3)==3)+sum(pred(:,4)==4)+sum(pred(:,5)==5))/4500;
accuracy
% 52.44%

