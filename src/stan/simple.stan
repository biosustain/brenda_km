data {
  int<lower=1> N;         // instantiated enz x org x sub combinations
  vector[N] y;
  vector[N] sample_size;
  vector[2] prior_log_km;
  vector[2] prior_sigma;
  int<lower=0,upper=1> likelihood;
}
parameters {
  real<lower=0> sigma;
  real mu_log_km;
  real<lower=0> tau_log_km;
  vector[N] log_km;
}
model {
  if (likelihood){y ~ normal(log_km, sigma * inv(sqrt(sample_size)));}

  log_km ~ normal(mu_log_km, tau_log_km);
  log_km ~ normal(prior_log_km[1], prior_log_km[2]);

  mu_log_km ~ normal(0, 3);
  tau_log_km ~ lognormal(0, 1);
  sigma ~ lognormal(prior_sigma[1], prior_sigma[2]);
}
generated quantities {
  vector[N] llik = rep_vector(0, N);
  for (n in 1:N){
    llik[n] = normal_lpdf(y[n] | log_km[n], sigma * inv(sqrt(sample_size[n])));
  }
}
