data {
  int<lower=1> N;         // number of measurements
  int<lower=1> N_biology;     // instantiated enz x org x sub combinations
  vector[N] y;
  array[N] int<lower=1,upper=N_biology> biology;
  vector[2] prior_log_km;
  vector[2] prior_sigma;
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
  if (likelihood){y ~ student_t(nu, log_km[biology], sigma);}
  mu_log_km ~ normal(-1, 2);
  nu ~ gamma(2, 0.1);
  tau ~ normal(0, 2);
  log_km ~ normal(mu_log_km, tau);
  sigma ~ lognormal(prior_sigma[1], prior_sigma[2]);
}
generated quantities {
  vector[N] llik;
  for (n in 1:N){
    llik[n] = student_t_lpdf(y[n] | nu, log_km[biology[n]], sigma);
  }
}
