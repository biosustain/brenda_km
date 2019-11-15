data {
  int<lower=1> N;
  int<lower=1> E;
  int<lower=1,upper=E> enzyme[N];
  vector[N] log_km_obs;
  int<lower=0,upper=1> likelihood;
}
parameters {
  vector[E] mu_enzyme_z;
  real a;
  real<lower=0> sigma;
  real<lower=0> sigma_enzyme;
}
transformed parameters {
  vector[E] mu_enzyme = a + mu_enzyme_z * sigma_enzyme;
}
model {
  a ~ normal(-2, 1);
  mu_enzyme_z ~ normal(0, 1);
  sigma ~ normal(0, 1);
  sigma_enzyme ~ normal(0, 1);
  if (likelihood == 1){
    log_km_obs ~ normal(mu_enzyme[enzyme], sigma);
  }
}
generated quantities {
  vector[N] log_km_pred;
  vector[N] log_likelihood;
  for (n in 1:N){
    log_km_pred[n] = normal_rng(mu_enzyme[enzyme[n]], sigma);
    log_likelihood[n] = normal_lpdf(log_km_obs[n] |mu_enzyme[enzyme[n]], sigma);
  }
}
