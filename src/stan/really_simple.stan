/* Simplest BRENDA model I can think of. */

data {
  int<lower=1> N_train;             // number of measurements
  int<lower=1> N_test;              // number of measurements
  vector[N_train] y_train;
  vector[N_test] y_test;
  int<lower=0,upper=1> likelihood;
}
parameters {
  real<lower=0> sigma;
  real<lower=1> nu;
  real mu_log_km;
}
model {
  if (likelihood){y_train ~ student_t(nu, mu_log_km, sigma);}
  nu ~ gamma(2, 0.1);
  mu_log_km ~ normal(0, 2);
  sigma ~ normal(0, 2);
}
generated quantities {
  vector[N_test] llik;
  vector[N_test] yrep;
  for (n in 1:N_test){
    llik[n] = student_t_lpdf(y_test[n] | nu, mu_log_km, sigma);
    yrep[n] = student_t_rng(nu, mu_log_km, sigma);
  }
}
