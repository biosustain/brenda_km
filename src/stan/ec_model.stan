data {
  int<lower=1> N;
  int<lower=1> N_ec4;
  int<lower=1> N_ec3;
  int<lower=1> N_ec2;
  int<lower=1,upper=N_ec4> ec4[N];
  int<lower=1,upper=N_ec3> ec3[N];
  int<lower=1,upper=N_ec3> ec3_to_ec4[N_ec4];
  vector[N] y;
  int<lower=0,upper=1> likelihood;
  vector[2] prior_sigma;
  vector[2] prior_tau_ec3;
  vector[2] prior_tau_ec4;
}
parameters {
  real baseline;
  real<lower=0> sigma;
  real<lower=0> tau_ec3;
  vector<lower=0>[N_ec3] tau_ec4;
  vector<multiplier=tau_ec3>[N_ec3] a_ec3;
  vector<multiplier=tau_ec4[ec3_to_ec4]>[N_ec4] a_ec4;
}
model {
  baseline ~ normal(0, 1);
  sigma ~ lognormal(prior_sigma[1], prior_sigma[2]);
  tau_ec3 ~ lognormal(prior_tau_ec3[1], prior_tau_ec3[2]);
  tau_ec4 ~ lognormal(prior_tau_ec4[1], prior_tau_ec4[2]);
  a_ec3 ~ student_t(4, 0, tau_ec3);
  a_ec4 ~ student_t(4, 0, tau_ec4[ec3_to_ec4]);
  if (likelihood){
    vector[N] yhat = baseline + a_ec3[ec3] + a_ec4[ec4];
    y ~ student_t(4, yhat, sigma);
  }
}
generated quantities {
  vector[N] llik;
  vector[N] yrep;
  {
    vector[N] yhat = baseline + a_ec3[ec3] + a_ec4[ec4];
    for (n in 1:N){
      llik[n] = student_t_lpdf(y[n] | 4, yhat[n], sigma);
      yrep[n] = student_t_rng(4, yhat[n], sigma);
    }
  }
}
