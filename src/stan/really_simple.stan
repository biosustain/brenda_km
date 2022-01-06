/* Simplest BRENDA model I can think of. */

data {
  int<lower=1> N;
  int<lower=1> N_train;
  int<lower=1> N_test;
  array[N_train] int<lower=1,upper=N> ix_train;
  array[N_test] int<lower=1,upper=N> ix_test;
  vector[N] y;
  int<lower=0,upper=1> likelihood;
}
parameters {
  real<lower=0> sigma;
  real<lower=1> nu;
  real mu_log_km;
}
model {
  if (likelihood){y[ix_train] ~ student_t(nu, mu_log_km, sigma);}
  nu ~ gamma(2, 0.1);
  mu_log_km ~ normal(0, 2);
  sigma ~ normal(0, 2);
}
generated quantities {
  vector[N_test] llik;
  vector[N_test] yrep;
  for (n in 1:N_test){
    llik[n] = student_t_lpdf(y[ix_test[n]] | nu, mu_log_km, sigma);
    yrep[n] = student_t_rng(nu, mu_log_km, sigma);
  }
}
