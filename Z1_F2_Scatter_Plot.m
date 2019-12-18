load('data.mat');
% taking the first 100 observations for training
sd1=std(F1(:,1));
sd2=std(F1(:,2));
sd3=std(F1(:,3));
sd4=std(F1(:,4));
sd5=std(F1(:,5));
mean1=mean(F1(:,1));
mean2=mean(F1(:,2));
mean3=mean(F1(:,3));
mean4=mean(F1(:,4));
mean5=mean(F1(:,5));

F2_1=[F2(:,1) (ones(length(F2),1)+0)];
F2_2=[F2(:,2) (ones(length(F2),1)+1)];
F2_3=[F2(:,3) (ones(length(F2),1)+2)];
F2_4=[F2(:,4) (ones(length(F2),1)+3)];
F2_5=[F2(:,5) (ones(length(F2),1)+4)];

F2_master=[F2_1;F2_2;F2_3;F2_4;F2_5];

Z1_1=[(F1(:,1)-mean1)/sd1 (ones(length(F1),1)+0)];
Z1_2=[(F1(:,2)-mean2)/sd2 (ones(length(F1),1)+1)];
Z1_3=[(F1(:,3)-mean3)/sd3 (ones(length(F1),1)+2)];
Z1_4=[(F1(:,4)-mean4)/sd4 (ones(length(F1),1)+3)];
Z1_5=[(F1(:,5)-mean5)/sd5 (ones(length(F1),1)+4)];

Z1_master=[Z1_1;Z1_2;Z1_3;Z1_4;Z1_5];


plot_master=[Z1_master F2_master];

scatter(plot_master(1:1000,1),plot_master(1:1000,3),10,'r','filled')
hold on
scatter(plot_master(1001:2000,1),plot_master(1001:2000,3),10,'b','filled')
hold on
scatter(plot_master(2001:3000,1),plot_master(2001:3000,3),10,'g','filled')
hold on
scatter(plot_master(3001:4000,1),plot_master(3001:4000,3),10,'m','filled')
hold on
scatter(plot_master(4001:5000,1),plot_master(4001:5000,3),10,'k','filled')
legend('C1', 'C2', 'C3','C4','C5')
xlabel('Z1')
ylabel('F2')
