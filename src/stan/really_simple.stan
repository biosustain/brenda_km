/* Simplest BRENDA model I can think of. */

data {
  int<lower=1> N;
  int<lower=1> N_train;
  int<lower=1> N_test;
  int<lower=1> N_biology;
  array[N_train] int<lower=1,upper=N> ix_train;
  array[N_test] int<lower=1,upper=N> ix_test;
  vector[N] y;
  int<lower=0,upper=1> likelihood;
}
parameters {
  real<lower=0> tau;
  real<lower=0> sigma;
  real<lower=2> nu;
  real mu;
}
model {
  if (likelihood){y[ix_train] ~ student_t(nu, mu, sigma * tau);}
  nu ~ gamma(2, 0.1);
  mu ~ normal(-2, 2);
  sigma ~ normal(1.5, 0.4);
  tau ~ normal(0, 1.2);
}
generated quantities {
  vector[N_test] llik;
  vector[N_test] yrep;
  vector[N_biology] log_km;
  for (n in 1:N_test){
    llik[n] = student_t_lpdf(y[ix_test[n]] | nu, mu, sigma * tau);
    yrep[n] = student_t_rng(nu, mu, sigma * tau);
  }
  for (b in 1:N_biology){
    log_km[b] = normal_rng(mu, tau);
  }
}
