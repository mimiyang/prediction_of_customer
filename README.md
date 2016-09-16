# prediction of default customers

In a mature risk management system, it is natural to use a well-developed method to analyze whether a card holder is going to default or not. Many machine learning techniques have been utilized for risk prediction. In this project, we employed naïve Bayes, logistic regression and K-nearest-neighbor classifier to predict the default of credit cards based on a data set in Taiwan.

The payment data is from an important bank (a cash and credit card issuer) in Taiwan in October 2005 The targets were credit card holders of the bank. This data set has the information of 30,000 clients including 23 attributes (features), which are a mixture of categorical (sex, marriage statues, education, ages) values and numerical values (credit limit, bill payment), for each client. A binary variable is employed to denote the default payment (Yes = 1, No = 0). 

We grouped these clients randomly into two groups, one training group and one testing group. Our goal is to learn from the training group (features and label) and predict the label of the clients in the testing group based on the clients’ features.

2. Naïve Bayes algorithm
Naïve Bayes algorithm is a widely used probabilistic classifier technique in machine learning, thanks to the well-established Bayes Theorem. 
Since the first extensively study in 1950, Naïve Bayes algorithm brings much interest in making prediction based on available features. In our project, we try to use Naïve Bayes algorithm to study the customers’ default data.
