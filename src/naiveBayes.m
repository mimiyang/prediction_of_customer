
tic;
clear variables;

data = xlsread('default of credit card clients.xls'); %[Z0,mu,sigma]=zscore(data(:,13:end-1)); %[Z1,mu1,sigma1]=zscore(data(:,2)); %[Z2,mu2,sigma2]=zscore(data(:,6)); % standardize data on 14 continous attributes

%[Z0,mu,sigma]=zscore(num(:,2:end-1)); %data =

horzcat(data(:,1),Z1,data(:,3:5),Z2,data(:,7:12),Z0,data(:,end)); % reshap the dataset. It is a mixture of standardized continous variables and categorical variables.

%data = [data(:,1) zscore(data(:,2:24)) data(:,end)]; dataSize = size(data);

random_order = randperm(dataSize(1));

alpha = 0.1;
%N1223 = 100000*ones(1,12);
 

%Ni = [100000,2,4,3,100000,12,12,12,12,12,12,N1223]; N = 1000000;

train_examples = data(random_order(1:floor(dataSize(1)*.8)),:); test_examples = data(random_order(floor(dataSize(1)*.8)+1:end),:);

train_size = size(train_examples);

totalDefaultNum_train = sum(train_examples(:,end)); totalNonDefaultNum_train = (train_size(1)-totalDefaultNum_train);

defaultCounts = java.util.HashMap; numDef = 0;

nonDefaultCounts = java.util.HashMap; numNonDef = 0;

for i = 1 : floor(dataSize(1)*.8) if train_examples(i, end)==1

for j = 1:23

feature = train_examples(i,j+1); numDef = numDef + 1;

current_count = defaultCounts.get(feature); if (isempty(current_count))

defaultCounts.put(feature,1+alpha); else

defaultCounts.put(feature,current_count+1);
end

end else
for j = 1:23

feature = train_examples(i,j+1); numNonDef = numNonDef + 1;

current_count = nonDefaultCounts.get(feature); if (isempty(current_count))

nonDefaultCounts.put(feature,1+alpha); else

nonDefaultCounts.put(feature,current_count+1);
end
end
end

end

%endData = data(:,end);

priorDefaultProbability = sum(data(:,end))/dataSize(1); priorNonDefaultProbability = 1-priorDefaultProbability;

%testing error

size_test = size(test_examples); falseCount = 0; true_positive_test = 0; false_positive_test = 0;
 

true_negative_test = 0; false_negative_test = 0; test_result = zeros(size_test(1),1); for k = 1:size_test(1)

pr_x_d = 1; pr_x_n = 1; for m = 1:23

fI = test_examples(k,m+1); pr_xi_do = defaultCounts.get(fI); if (isempty(pr_xi_do))
pr_xi_do = 0;

end

pr_xi_d = (pr_xi_do+alpha)/(numDef+N*alpha); pr_x_d = pr_x_d*pr_xi_d;

pr_xi_no = nonDefaultCounts.get(fI); if(isempty(pr_xi_no))

pr_xi_no = 0;
end

pr_xi_n = (pr_xi_no+alpha)/(numNonDef+N*alpha); pr_x_n = pr_x_n*pr_xi_n;

end prd =

pr_x_d*priorDefaultProbability/(pr_x_d*priorDefaultProbability+pr_x_n* priorNonDefaultProbability);

if prd >= 0.5 test_result(k)=1;

if test_examples(k,end)==0 falseCount = falseCount+1;

false_positive_test = false_positive_test+1; else

true_positive_test = true_positive_test+1;
end
end
if prd < 0.5

if test_examples(k,end)==1 falseCount = falseCount+1;

false_negative_test = false_negative_test+1; else

true_negative_test = true_negative_test+1;
end
end

end

test_accu = 1-falseCount/size_test(1) test_precision =

true_positive_test/(true_positive_test+false_positive_test); test_recall = true_positive_test/(true_positive_test+false_negative_test); test_fscore = 2*test_precision*test_recall/(test_precision+test_recall) %training error
 

size_train = size(train_examples); falseCount_train = 0; true_positive_train = 0; false_positive_train = 0; true_negative_train = 0; false_negative_train = 0;

for k = 1:size_train(1) pr_x_d = 1;

pr_x_n = 1; for m = 1:23

fI = train_examples(k,m+1); pr_xi_do = defaultCounts.get(fI); if (isempty(pr_xi_do))

pr_xi_do = 0;

end

pr_xi_d = (pr_xi_do+alpha)/(numDef+N*alpha); pr_x_d = pr_x_d*pr_xi_d;

pr_xi_no = nonDefaultCounts.get(fI); if(isempty(pr_xi_no))

pr_xi_no = 0;
end

pr_xi_n = (pr_xi_no+alpha)/(numNonDef+N*alpha); pr_x_n = pr_x_n*pr_xi_n;

end prd =

pr_x_d*priorDefaultProbability/(pr_x_d*priorDefaultProbability+pr_x_n* priorNonDefaultProbability);

if prd >= 0.5

if train_examples(k,end)==0 falseCount_train = falseCount_train+1;

false_positive_train = false_positive_train+1; else

true_positive_train = true_positive_train+1;
end
end
if prd < 0.5

if train_examples(k,end)==1 falseCount_train = falseCount_train+1;

false_negative_train = false_negative_train+1; else

true_negative_train = true_negative_train+1;
end

end
end

train_accu = 1-falseCount_train/size_train(1) train_precision =

true_positive_train/(true_positive_train+false_positive_train); train_recall = true_positive_train/(true_positive_train+false_negative_train); train_fscore = 2*train_precision*train_recall/(train_precision+train_recall) toc;
 
