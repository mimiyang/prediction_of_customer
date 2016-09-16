
 
% Codes for logistic regression
% read files

data = csvread('default of credit card clients.csv');

%	seperate data into training and testing set randomly random_order = randperm(length(data)); 

D_tr = data(random_order(1:floor(length(data)*.8)),:); D_ts = data(random_order(floor(length(data)*.8)+1:end),:); 


%	construct x and y 

Xtr = D_tr(:, 1:end-1); y_tr = D_tr(:, end); Xts = D_ts(:, 1:end-1); y_ts = D_ts(:, end);

%normalize data X_tr = zscore(Xtr); X_ts = zscore(Xts);

%	number of samples n_tr = size(D_tr, 1); n_ts = size(D_ts, 1); 

%	add 1 as a feature 
X_tr = [ones(n_tr, 1) X_tr];

X_ts = [ones(n_ts, 1) X_ts];

% perform gradient ascent :: logistic regression
n_vars = size(X_tr, 2);	% number of variables
lr = 1e-3;	% learning rate
w = zeros(n_vars, 1);	% initialize parameter w
tolerance = 1e-4;	% tolerance for stopping criteria

iter = 0;	% iteration counter
max_iter = 1000;	% maximum iteration
while true

iter = iter + 1;	% start iteration

% calculate gradient

grad = zeros(n_vars, 1); % initialize gradient for j=1:n_vars

grad(j) = sum(X_tr(:,j).* y_tr - (X_tr(:,j).*exp(w(j) * X_tr(:,j)))./(1+exp(w(j)* X_tr(:,j)))); % compute the gradient with respect to w_j here
end

% take step
w_new = w + lr * grad	% take a step using the learning
rate
 
% stopping criteria

if abs( mean(abs(w_new)) - mean(abs(w)) ) < tolerance w = w_new;

break; else

w = w_new;

end

if iter >= max_iter ;

break;
end
end

% use w for prediction

pred = zeros(n_ts, 1);	% initialize prediction vector

for i=1:n_ts
pred(i) = round(1-1/(1+exp(X_ts(i,:)*w)));	% compute your
prediction
end

% calculate testing accuracy acc_ts=1-sum(abs(pred-y_ts))/length(y_ts)

% repeat the similar prediction procedure to get training accuracy
pred_tr = zeros(n_tr, 1);	% initialize prediction vector
for i=1:n_tr
pred_tr(i) = round(1-1/(1+exp(X_tr(i,:)*w)));	% compute your

prediction end

acc_tr=1-sum(abs(pred_tr-y_tr))/length(y_tr) % compute training accuracy
