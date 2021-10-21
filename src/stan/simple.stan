/* Somewhat simple BRENDA model */

data {
  int<lower=1> N_train;             // number of training measurements
  int<lower=1> N_test;              // number of test measurements
  int<lower=1> N_biology;           // Possible ec x org x sub combinations
  array[N_train] int<lower=1,upper=N_biology> biology_train;
  vector[N_train] y_train;
  array[N_test] int<lower=1,upper=N_biology> biology_test;
  vector[N_test] y_test;
  int<lower=0,upper=1> likelihood;
}
parameters {
  real<lower=0> sigma;
  real mu_log_km;
  real<lower=1> nu;
  real<lower=0> tau;
  vector[N_biology] log_km;
}
model {
  if (likelihood){y_train ~ student_t(nu, log_km[biology_train], sigma);}
  log_km ~ normal(mu_log_km, tau);
  mu_log_km ~ normal(-1, 2);
  nu ~ gamma(2, 0.1);
  tau ~ normal(0, 2);
  sigma ~ normal(0, 2);
}
generated quantities {
  vector[N_test] llik;
  vector[N_test] yrep;
  for (n in 1:N_test){
    llik[n] = student_t_lpdf(y_test[n] | nu, log_km[biology_test[n]], sigma);
    yrep[n] = student_t_rng(nu, log_km[biology_test[n]], sigma);
  }
}
