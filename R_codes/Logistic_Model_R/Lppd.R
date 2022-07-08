
library(rstan)
library("R.matlab")
library(matrixStats)
rstan_options(auto_write = TRUE)
options(mc.cores = 1)
#setwd("C:/Users/Zanella/GitHub/CrossVal_Silva_compact/Code_R/Logistic_Model_R/")

nrep <- 1
seed <- 1
batch <- 1

SEED = seed + nrep*(batch - 1)
set.seed(SEED)
#### CODE TO GENERATE AT RANDOM
n = 100
k = 50
X <- matrix(rnorm(n*k), nrow = n, ncol =k)
beta0 <- matrix(c(2,-3,2,2,-3, rep(0, k-5)), ncol = 1)
probs = 1/(1+exp(-X*beta0[1:10,1]))
y <- rbinom(n,1,probs)


## To replicate the experiments one has just to select the desidered preprocessed data and run the code.

data = read.csv("./Preprocessed_data/Voice_preprocessed.csv")
y <- data$y
X <- data[2:length(data)]

#X[1:100, 1] = 1
n = dim(X)[1]
k = dim(X)[2]
var = 100.0
control = list(adapt_delta = 0.999,max_treedepth=15)

#stanmodel_post = stan_model(file='Logistic_Model_Stan_Intercept.stan')
stanmodel_post = stan_model(file='Logistic_Model_Stan.stan')
standata = list(n = n, k = k, X = as.matrix(X), y = c(y), scaled_var = var/k)
fit_post <- sampling(stanmodel_post, data = standata, chains = 1, iter = 1000,control = control, pars="log_lik")
log_lik_post = extract(fit_post)$log_lik
lppd_post = log(dim(log_lik_post)[1])-rowLogSumExps(-1*t(log_lik_post))

#stanmodel_mix = stan_model(file='Logistic_Model_Mixture_Intercept.stan')
stanmodel_mix = stan_model(file='Logistic_Model_Mixture.stan')
fit_mix <- sampling(stanmodel_mix, data = standata, chains = 1, iter = 1000,control = control, pars="log_lik")
log_lik_mix = extract(fit_mix)$log_lik

l_common_mix = rowLogSumExps(-1*log_lik_mix)
log_weights = -1*log_lik_mix - l_common_mix
lppd_mix = logSumExp(-l_common_mix) - rowLogSumExps(t(log_weights))


plot(lppd_post,lppd_mix)
