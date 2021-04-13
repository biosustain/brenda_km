data {
  int<lower=1> N;
  int<lower=1> N_ec4;
  int<lower=1> N_ec3;
  int<lower=1> N_ec2;
  int<lower=1,upper=N_ec4> ec4[N];
  int<lower=1,upper=N_ec3> ec3[N];
  int<lower=1,upper=N_ec2> ec2[N];
  vector[N] y;
  int<lower=0,upper=1> likelihood;
  vector[2] prior_nu;
  matrix[K, 2] prior_b;
  vector[2] prior_sigma;
  matrix[3,2] prior_tau;
}
parameters {
  real<lower=1> nu;
  real<lower=0> sigma;
  vector<lower=0>[3] tau;
  vector<multiplier=tau[1]>[N_ec4] a_ec4;
  vector<multiplier=tau[2]>[N_ec3] a_ec3;
  vector<multiplier=tau[3]>[N_ec2] a_ec2;
}
model {
  nu ~ gamma(prior_nu[1], prior_nu[2]);
  sigma ~ lognormal(prior_sigma[1], prior_sigma[2]);
  tau ~ lognormal(prior_tau[,1], prior_tau[,2]);
  a_ec4 ~ normal(0, tau[1]);
  a_ec3 ~ normal(0, tau[2]);
  a_ec2 ~ normal(0, tau[3]);
  if (likelihood){
    vector[N] yhat = x_std * b + a_ec2[ec2] + a_ec3[ec3] + a_ec4[ec4];
    y ~ student_t(nu, yhat, sigma);
  }
}
generated quantities {
  vector[N] llik;
  vector[N] yrep;
  for (n in 1:N){
    real yhat = x_std[n] * b + a_ec2[ec2[n]] + a_ec3[ec3[n]] + a_ec4[ec4[n]];
    llik[n] = student_t_lpdf(y[n] | nu,  yhat, sigma);
    yrep[n] = student_t_rng(nu, yhat, sigma);
  }
}
