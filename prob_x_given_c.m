function [sd_dist_unq_cnt , F1_train_class_sd_unq_cnt] = prob_x_given_c(F1_train_reshape,mn,sd,F1_train_class)

% F1_train_reshape=[F1_train(:,1) ones(100,1);F1_train(:,2) (ones(100,1)+1);F1_train(:,3) (ones(100,1)+2);F1_train(:,4) (ones(100,1)+3);F1_train(:,5) (ones(100,1)+4)];
% mn=mean1;
% sd=sd1;
% F1_train_class;

sd_dist=zeros(length(F1_train_reshape),1);
for i = 1:length(F1_train_reshape)
    sd_dist(i)=round((F1_train_reshape(i,1)-mn)/sd);
end 
sd_dist_unq=unique(sd_dist);
sd_dist_unq_cnt=zeros(1,1);
for j = 1:length(sd_dist_unq)
    sd_dist_unq_cnt(j,1)=sum(sd_dist==sd_dist_unq(j));
end 
sd_dist_unq_cnt=[sd_dist_unq sd_dist_unq_cnt];

base=sum(sd_dist_unq_cnt(:,2));
sd_dist_unq_cnt(:,2)= sd_dist_unq_cnt(:,2)/base;

F1_train_class_sd=zeros(length(F1_train_class),1);

for k = 1:length(F1_train_class)
    F1_train_class_sd(k)=round((F1_train_class(k)-mn)/sd);
end

F1_train_class_sd_unq=unique(F1_train_class_sd);
F1_train_class_sd_unq_cnt=zeros(1,1);

for l = 1:length(F1_train_class_sd_unq)
    F1_train_class_sd_unq_cnt(l,1)=sum(F1_train_class_sd==F1_train_class_sd_unq(l));
end

F1_train_class_sd_unq_cnt=[F1_train_class_sd_unq F1_train_class_sd_unq_cnt];

base_2=sum(F1_train_class_sd_unq_cnt(:,2));
F1_train_class_sd_unq_cnt(:,2)= F1_train_class_sd_unq_cnt(:,2)/base_2;
